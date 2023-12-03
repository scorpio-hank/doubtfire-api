class InterventionActionMailer < ActionMailer::Base
  helper :intervention_email
  default from: 'no-reply@example.com'

  def add_general
    @doubtfire_host = Doubtfire::Application.config.institution[:host]
    @doubtfire_product_name = Doubtfire::Application.config.institution[:product_name]
    # Removed unsubscribe option

    # TODO: Amend the FROM to change to tutor's email"
  end

  def intervention_action_email(project, email_subject, email_header, email_template)
    add_general

    @student = project.student
    @project = project
    @email_header = email_header
    @email_template = email_template
    email_with_name = %("#{@student.name}" <#{@student.email}>)

    mail(to: email_with_name, subject: email_subject)
  end
end
