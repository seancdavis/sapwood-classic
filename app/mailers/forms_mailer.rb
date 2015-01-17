class FormsMailer < ActionMailer::Base
  default :from => TaprootSetting.mailer.default_from

  if Rails.env.production? && TaprootSetting.mailer.sendgrid.to_bool == true
    include SendGrid
  end

  def new_submission(submission, emails)
    @submission = submission
    @form = @submission.form
    @site = @form.site
    mail(
      :to => emails, 
      :subject => "[#{@site.title}] New #{@form.title} Submission"
    )
  end

end
