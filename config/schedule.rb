every 1.day, :at => '3:00 am' do
  rake "sitemap:refresh"
end
# Load project schedules
Dir.glob("#{Rails.root}/projects/*/utilities/schedule.rb").each |file|
  require file
end