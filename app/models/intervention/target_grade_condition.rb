class TargetGradeCondition < Condition
    validates    :target_grade_checked, :target_grade_operator, presence: true

    enum target_grade_operator: {
        match_target_grade: 0,
        lower_target_grade: 1,
        higher_target_grade: 2,
        higher_target_grade_or_equal_to: 3,
        lower_target_grade_or_equal_to: 4
      }

    def match(project)
        case target_grade_operator
            when "match_target_grade"
                return project.target_grade == target_grade_checked
            when "lower_target_grade"
                return project.target_grade < target_grade_checked
            when "higher_target_grade"
                return project.target_grade > target_grade_checked
            when "higher_target_grade_or_equal_to"
                return project.target_grade >= target_grade_checked
            when "lower_target_grade_or_equal_to"
                return project.target_grade <= target_grade_checked
            else
                return false
        end
    end 
  end