class UpdateProjectWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Site.find_by_id(project_id)
    unless project.nil?
      TaprootProject.new(project).pull_site
    end
  end
end
