class HasRuleBeenPreviouslyAppliedCondition < Condition
    validates    :rule_id_check, :date_from_which_rule_has_been_applied_checked, presence: true

    def match(project)
        # Check if the rule has been applied to the project. 
        # If it has, then check if the date is after the date_from_which_rule_has_been_applied_checked
        if InsightActionLog.where(project_id: project.id, rule_id: rule_id_check).any?
            InsightActionLog.where(project_id: project.id, rule_id: rule_id_check).each do |log|
                if log.date >= date_from_which_rule_has_been_applied_checked
                    return true
                end
            end
        end
        return false   
    end 
  end