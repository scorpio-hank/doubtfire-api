class TaskStatusCondition < ComparisonCondition

  # The 'required count' is the number of tasks that meet the set criteria, and is picked up from the comparison condition

  ## Not working properly, need to fix this!

    def match(project)
      data = project
            .unit
            .task_definitions
            .joins("LEFT JOIN tasks ON tasks.task_definition_id = task_definitions.id AND (tasks.id IS NULL OR tasks.project_id = #{project.id})")
            .select(
                :task_status_id,
                :target_grade,
                :start_date,
                :target_date,
                :due_date
            )
        data = data.where(task_status_id: task_status_checked) if task_status_checked.present?
        data = data.where(target_grade: task_target_grade_checked) if task_target_grade_checked.present? # should we be checking for the target grade and lower?
        data = data.select{|t| project.unit.week_number(Time.now) - project.unit.week_number(start_date) >= weeks_since_task_started} if weeks_since_task_started.present?
        data = data.select{|t| project.unit.week_number(Time.now) - project.unit.week_number(target_date) >= weeks_since_task_was_targeted_to_complete} if weeks_since_task_was_targeted_to_complete.present?
        data = data.select{|t| project.unit.week_number(Time.now) - project.unit.week_number(due_date) >= weeks_since_task_was_due} if weeks_since_task_was_due.present?

        super.comparison_matches(data.count(:all))
    end
end
