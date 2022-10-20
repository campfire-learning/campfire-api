require "json"

# Universities are from this github repo:
#   https://github.com/Hipo/university-domains-list
# To run this script, first download the following json file:
#   "world_universities_and_domains.json".

schools = JSON.parse(File.read("./world_universities_and_domains.json"))

schools.each do |school|
  puts school
  institution = Institution.create({
    name: school['name'],
    institution_type: Institution.institution_types[:university],
    home_url: school['web_pages'][0],
    country: school['country']
  })
  school['domains'].each do |domain|
    Domain.create({
      domain: domain,
      institution_id: institution.id
    })
  end
end
