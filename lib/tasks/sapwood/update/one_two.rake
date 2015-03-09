namespace :sapwood do
  namespace :update do
    task :one_two => :environment do
      # save pages
      Page.all.each(&:save!)

      # convert images to local file storage
      bucket = SapwoodSetting.aws.bucket
      Document.all.each do |file|
        begin
          original_url = "https://s3.amazonaws.com/#{bucket}/#{file.document_uid}"
          file.document_url = original_url
          file.save!
        rescue
          puts "Could't save #{file.document_name}"
        end
      end
    end
  end
end
