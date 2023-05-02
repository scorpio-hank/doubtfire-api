class EmailStudentAction < Action
  validates    :email_subject, :email_template, presence: true

  def perform_action(project)
    InterventionActionMailer.intervention_action_email(project, email_subject, email_header, email_template).deliver_now
  end
end
