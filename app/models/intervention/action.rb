class Action < ApplicationRecord
  # The action scope is either a rule or an insight.
  # rule is used for actions on students that match that rule's classification
  # insight is for actions on students not classified by any rules
  belongs_to :action_scope, polymorphic: true 

  def perform_action(project)
  end
end
  