task :clear_cache => :environment do
  Rails.cache.clear
end
