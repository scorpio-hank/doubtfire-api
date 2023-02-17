class Insight < ApplicationRecord
    belongs_to :unit
    has_many   :active_projects, through: :unit
    has_many   :rules
    has_many   :actions, as: :action_scope # this allows us to link for unclassified students

    validates :name, presence: true 

    # ...
    # @param with_action [Boolean] indicates whether to run the action, or just to return the resulting projects
    # @return [Hash] of rules to array of projects that match that rule
    def run(with_action)
      classified = {}
      unclassified = {}

      # create a dictionary of rules to empty arrays
      # the rule 'r' is the hash key used to access the associated value
      rules.each do |r|
        classified[r] = []
      end

      # add a nil rule for all students that do not match any of the rules
      classified[nil] = []

      # classify each project, by checking against all rules in order
      active_projects.each do |project|
        has_rule_been_assigned = false
        
        # check all the rules, order is important as we classify with the first matching rule
        rules.order(:order).each do |r|
          # If we match this rule... then we are done :)
          if r.match(project, with_action)
            classified[r] << project
            has_rule_been_assigned = true
            # dont check any more rules...
            break
          end
        end

        # Is we didn't find a rule, it is unclassified... so run our actions (if with_action)
        unless has_rule_been_assigned
          # indicate this is not classified by a rule...
          classified[nil] << project

          # run if we need to...
          if with_action
            actions.each do |a|
              a.perform_action(project) 
            end
          end
        end
      end        
      
      # does not appear to be printing in order?
      # classified.each do |rule, projects|
      #   puts "#{rule.name unless rule.nil?} matches: #{projects.length.to_s} projects => #{projects.map{|p| p.student.name}.join(", ")}"
      # end

      return classified # just to make the output simpler in the short term
    end   

end

# Insight.last.run(true).map {|rule, projects| "#{rule.name unless rule.nil?} matches: #{projects.length.to_s} projects => #{projects.map{|p| p.student.name}.join(", ")}"}
  