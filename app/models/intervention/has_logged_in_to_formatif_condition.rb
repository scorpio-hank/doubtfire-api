class HasLoggedInToFormatifCondition < Condition
  validates    :has_run_first_time_setup_check, presence: true

  def match(project)
      return project.user.has_run_first_time_setup == has_run_first_time_setup_check
  end
end
