class UnitEnrolmentWeekCondition < Condition
    validates    :unit_enrolment_week_check, :unit_enrolment_week_operator, presence: true

    enum unit_enrolment_week_operator: {
        before_week: 0,
        before_or_on_week: 1,
        on_week: 2,
        on_or_after_week: 3,
        after_week: 4
      }

    def match(project)
        enrolment_week = project.unit.week_number(project.created_at)
        case unit_enrolment_week_operator
            when "before_week"
                return enrolment_week < unit_enrolment_week_check
            when "before_or_on_week"
                return enrolment_week <= unit_enrolment_week_check
            when "on_week"
                return enrolment_week == unit_enrolment_week_check
            when "on_or_after_week"
                return enrolment_week >= unit_enrolment_week_check
            when "after_week"
                return enrolment_week > unit_enrolment_week_check
            else
                return false
        end
    end 
  end