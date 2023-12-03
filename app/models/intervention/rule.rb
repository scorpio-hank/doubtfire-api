class Rule < ApplicationRecord
  belongs_to :insight
  has_many   :actions, as: :action_scope
  has_many   :conditions

  validates    :name, :order, :operator, presence: true

  enum operator: {
    match_all: 0,
    match_any: 1
  }

  # ...
  # @param [Project] the project to test
  # @param [Boolean] whether to perform the action if the rule matches
  # @return [Boolean] true if the rule matches the project
  def match(project, with_action)
    return false if conditions.empty?

    # Assume this is not a match...
    result = operator == 'match_all'

    # Test each condition
    conditions.each do |c|

      # Exit the loop when:
      # - 'match_all' and !c.match(project)
      # - 'match_any' and c.match(project)
      # Check if the project matches the condition
      if c.match(project)
        if operator == 'match_any'
          result = true
          break
        end
      else
        if operator == 'match_all'
          result = false
          break
        end
      end
    end



    # If it matches... now what? do we run?
    if result && with_action
      # Run the action
      actions.each do |a|
        a.perform_action(project)
      end

      # Create an insight action to log this action
      InsightActionLog.create!(project: project, rule: self, date: Time.now.to_datetime)
      # have the above visible to Tutor and Unit Chair as a log through front end
    end

    # Return the result
    return result
  end

end
