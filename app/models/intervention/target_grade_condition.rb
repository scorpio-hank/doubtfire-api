class TargetGradeCondition < ComparisonCondition
    # The 'required count' is the target grade, and is picked up from the comparison condition

    def match(project)
      super.comparison_matches(project.target_grade)
    end
  end
