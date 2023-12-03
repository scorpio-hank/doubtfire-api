class UnitEnrolmentWeekCondition < ComparisonCondition
  # The 'required count' is the enrolment week, and is picked up from the comparison condition
  def match(project)
    super.comparison_matches(project.unit.week_number(project.created_at))
  end
end
