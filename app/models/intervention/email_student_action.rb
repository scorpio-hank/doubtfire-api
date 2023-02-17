class EmailStudentAction < Action
  validates    :email_template, presence: true

  def perform_action(project)
    puts project.student.name
    puts "Emailing " + project.student.email + ": " + email_template
  end
end
  