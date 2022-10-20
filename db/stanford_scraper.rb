require 'net/http'

STARTING_URL = 'https://explorecourses.stanford.edu/'.freeze

def get_dom_doc(url)
  sleep 1
  response = Net::HTTP.get_response(URI.parse(url))
  Nokogiri::HTML(response.body)
end

##
# Scrape courses and instructors and persist into database
#
def scrape_stanford(starting_url)
  dom_doc = get_dom_doc(starting_url)

  # these are schools within the university
  departments = dom_doc.css('.departmentsContainer').children
  departments.each do |dept|
    next unless dept.is_a? Nokogiri::XML::Element

    dept.css('li').css('a').each do |anchor|
      scrape_link(anchor.attribute('href').value, anchor.content.strip)
    end
  end
end

def scrape_link(link, department)
  return if link.downcase.include? 'javascript'

  stanford_id = Institution.where(name: 'Stanford University').first.id
  dom_doc = get_dom_doc(STARTING_URL + link)
  dom_doc.css('.courseInfo').each do |course|
    Course.create({
      creator_id: User.marshmallow.id,
      institution_id: stanford_id,
      title: course.css('.courseTitle').first.content.strip,
      code: course.css('.courseNumber').first.content.strip.chomp(':'),
      description: course.css('.courseDescription').first.content.strip,
      department:,
      year: 2023,
      term: Course.terms[:winter]
    })
    create_instructors(course)
  end
end

##
# How will we integrate this data with the web app sign-up flow?
def create_instructors(course)
  course.css('.courseAttributes').each do |attributes|
    next unless attributes.content.include? 'Instructors'

    attributes.css('.instructorLink').each do |instructor|
      url = instructor.attribute('href').value
      next unless User.where(profile_url: url).empty?

      full_name = get_full_name(url)
      User.create({
        email: get_email(url),
        password: 'password',
        password_confirmation: 'password',
        first_name: full_name.split.first || 'Unknown',
        last_name: full_name.split.last || 'Unknown',
        time_zone: "America/Los_Angeles",
        profile_url: url,
        user_type: User.user_types[:instructor]
      })
    end
  end
end

def get_full_name(instructor_url)
  dom_doc = get_dom_doc(instructor_url)
  dom_doc.css('.searchTerm').first&.content&.strip || ''
end

def get_email(instructor_url)
  "#{instructor_url.split('/').last}@stanford.edu"
end

scrape_stanford(STARTING_URL)
