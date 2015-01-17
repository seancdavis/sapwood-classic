class FormsMailerPreview < ActionMailer::Preview

  def new_submission
    FormsMailer.new_submission(FormSubmission.last, ['test@example.com'])
  end

end
