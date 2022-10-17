require 'net/http'

STARTING_URL = 'https://explorecourses.stanford.edu/'.freeze

def get_dom_doc(url)
  response = Net::HTTP.get_response(URI.parse(url))
  Nokogiri::HTML(response.body)
end

##
# Scrape courses and instructors and persist into database
#
def scrape_stanford(starting_url)
  dom_doc = get_dom_doc(starting_url)

  # these are schools within the university
  schools = dom_doc.css('.departmentsContainer').children
  schools.to_a.take(4).each do |elem|
    next unless elem.is_a? Nokogiri::XML::Element

    elem.css('li').css('a').each do |anchor|
      puts anchor.attribute('href').value
      puts anchor.content
      scrape_link(anchor.attribute('href').value, anchor.content)
    end
  end
end

def scrape_link(link, dept)
  uri = URI.parse(STARTING_URL + link)
  response = Net::HTTP.get_response(uri)
  domdoc = Nokogiri::HTML(response.body)
  domdoc.css('.courseInfo').each do |course|
    Course.create(
      {
        creator_id: 1,
        owner_id: 1,
        title: course.css('.courseTitle').content,
        code: course.css('.courseNumber').content.chomp(':'),
        description: course.css('.courseDescription').content,
        units: units(course),
      }
    )
  end
end

def units(course)
  course.css('.courseAttributes').each do |attributes|
    next unless attributes.content.include? 'Units'

    idx = attributes.index('Units:')
    num = attributes[(idx + 6)..].strip.to_i
    return num.positive? ? num : nil
  end
end

def create_instructors(course)
  course.css('.courseAttributes').each do |attributes|
    next unless attributes.content.include? 'Instructors'

    attributes.css('.instructorLink').each do |instructor|
      url = instructor.attribute('href').value
      next unless User.where(profile_url: url).empty?

      full_name = get_full_name(url)
      User.create({
        email: get_email(url),
        first_name: full_name.split.first,
        last_name: full_name.split.last,
        time_zone: "America/Los_Angeles",
        profile_url: url,
      })
    end
  end
end

# "name_str" is in the format of <last name>, <first name>
def get_first_name(name_str)
  name_str.split(',')[1].strip
end

# "name_str" is in the format of <last name>, <first name>
def get_last_name(name_str)
  name_str.split(',')[0].strip
end

def get_full_name(instructor_url)
  dom_doc = get_dom_doc(instructor_url)
  dom_doc.css('.searchTerm').first.content
end

def get_email(instructor_url)
  "#{instructor_url.split('/').last}@stanford.edu"
end

puts get_name('https://explorecourses.stanford.edu/instructor/wascott')
puts get_email('https://explorecourses.stanford.edu/instructor/wascott')
# scrape_stanford(STARTING_URL)
