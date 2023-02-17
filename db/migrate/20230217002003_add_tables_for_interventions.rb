class AddTablesForInterventions < ActiveRecord::Migration[7.0]
  def change
    create_table :insights do |t|
      t.string     :name, null: false
      t.references :unit, null: false

      # create separate 'schedule' class? Then we don't need to apply week / day to each intervention
      t.integer    :week
      t.integer    :day
      
    end

    create_table :rules do |t|
      t.string     :name, null: false
      t.integer    :order, null: false
      t.references :insight, null: false
      t.boolean    :global_rule, null: false # whether the rule is unit level(?)
      t.integer    :operator, null: false 

      # stop processing more rules

    end


    create_table :insight_action_logs do |t|
      t.string     :student_name, null: false
      t.datetime   :date, null: false
      t.references :rule, null: false
    end

    create_table :conditions do |t|
      t.string     :type, null: false
      t.boolean    :global_condition, null: false
      t.references :rule, null: false
      
      t.string     :starting_letter_first_name  
      
      t.integer     :target_grade_checked
      t.integer     :target_grade_operator
    end

    create_table :actions do |t|
      t.string     :name # optionally give the action a name - may not be required 
      t.string     :type, null: false
      # t.bigint     :action_scope
      # t.string     :action_scope_type
      t.references  :action_scope, polymorphic: true
      t.string      :email_template
    end
  end
end
