require 'net/http'

BERKELEY_ID = Institution.where(name: 'University of California, Berkeley').first.id
# Berkeley's faculty catalog has 101 pages in total
MAX_PAGE_NUM = 101

def get_dom_doc(url)
  sleep 1
  response = Net::HTTP.get_response(URI.parse(url))
  Nokogiri::HTML(response.body)
end

##
# Scrape courses and persist into database
def scrape_berkeley_courses()
  domain = 'https://guide.berkeley.edu'
  starting_url = "#{domain}/courses/"

  dom_doc = get_dom_doc(starting_url)
  dom_doc.css('#atozindex').css('a').each do |dept|
    next unless dept.attribute('href')&.value&.include? 'courses'

    dept_doc = get_dom_doc("#{domain}#{dept.attribute('href').value}")
    dept_doc.css('.courseblock').each do |course|
      paragraphs = course.css('.descshow').first.content.strip.split("\n")
      desc = paragraphs.size >= 0 ? paragraphs[1] : ''
      Course.create(
        creator_id: User.marshmallow.id,
        owner_id: User.marshmallow.id,
        institution_id: BERKELEY_ID,
        title: course.css('.title').first.content.strip,
        code: course.css('.code').first.content.strip,
        description: desc,
        department: dept.content,
        year: 2023,
        term: Course.terms[:spring]
      )
    end
  end
end

##
# Scrape instructors and persist into database
def scrape_berkeley_instructors
  domain = 'https://vcresearch.berkeley.edu'
  base_url = "#{domain}/faculty-expertise?page="
  collected = Set.new

  # Berkeley's faculty catalog has 101 pages in total
  MAX_PAGE_NUM.times do |index|
    dom_doc = get_dom_doc(base_url + index.to_s)
    dom_doc.css('.field--name-field-photo').css('a').each do |instructor|
      next unless instructor.attribute('href')&.value&.include? '/faculty/'

      url = "#{domain}#{instructor.attribute('href').value}"
      next if collected.include? url.split('/').last

      collected << url.split('/').last
      doc = get_dom_doc(url)
      full_name = get_full_name(doc)
      User.create(
        email: get_email(doc),
        password: 'password',
        password_confirmation: 'password',
        first_name: full_name.split.first || 'Unknown',
        last_name: full_name.split.last || 'Unknown',
        time_zone: "America/Los_Angeles",
        profile_url: url,
        institution_id: BERKELEY_ID,
        user_type: User.user_types[:instructor]
      )
    end
  end
end

def get_full_name(doc)
  doc.css('h1').css('.node__title').first&.content&.strip || ''
end

def get_email(doc)
  email_link = doc.css('a').to_a.find do |anchor|
    anchor.attribute('href')&.content&.start_with? 'mailto:'
  end
  email_link&.content
end

############################################################
############################################################

scrape_berkeley_courses
scrape_berkeley_instructors
