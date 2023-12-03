class AddTablesForIntervention < ActiveRecord::Migration[7.0]
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
      t.references :project, null: false
      t.datetime   :date, null: false
      t.references :rule, null: false
    end

    create_table :conditions do |t|
      t.string     :type, null: false
      t.boolean    :global_condition, null: false
      t.references :rule, null: false
      # Name Condition Variables - to be deleted
      t.string     :starting_letter_first_name
      # Comparison Condition Variables
      t.integer    :required_count
      t.integer    :comparison_operator
      # Task Status Count Condition
      t.integer     :task_status_checked
      t.integer     :task_target_grade_checked
      t.integer     :weeks_since_task_started
      t.integer     :weeks_since_task_was_targeted_to_complete
      t.integer     :weeks_since_task_was_due
      # Has Never Logged In Condition
      t.boolean     :has_run_first_time_setup_check
      # Has Rule Been Previously Applied Condition
      t.integer     :rule_id_check
      t.datetime    :date_from_which_rule_has_been_applied_checked
      # Tutorial Enrolment Condition
      t.integer     :tutorial_id_check
    end

    create_table :actions do |t|
      t.string      :name # optionally give the action a name - may not be required
      t.string      :type, null: false
      t.references  :action_scope, polymorphic: true
      t.string      :email_subject
      t.string      :email_header
      t.string      :email_template
    end
  end
end
