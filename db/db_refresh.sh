rails db:drop
rails db:create

rails db:migrate
RAILS_ENV=test rails db:migrate

rails db:seed
RAILS_ENV=test rails db:seed

rails runner db/dev_data_seeds.rb
RAILS_ENV=test rails runner db/dev_data_seeds.rb
