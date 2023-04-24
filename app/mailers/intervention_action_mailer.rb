class InterventionActionMailer < ActionMailer::Base
  def add_general
      @doubtfire_host = Doubtfire::Application.config.institution[:host]
      @doubtfire_product_name = Doubtfire::Application.config.institution[:product_name]
      # Removed unsubscribe option
    end

  def email_action(project, email_subject, email_header, email_template)
      add_general

      @student = project.student
      @project = project
      @email_header = email_header
      @email_template = email_template

      email_with_name = %("#{@student.name}" <#{@student.email}>)
      # TODO: Get the user's email address(?)
      mail(to: email_with_name, from: tutor_email, subject: email_subject)
  end
end
