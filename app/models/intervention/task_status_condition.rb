class TaskStatusCondition < Condition
    validates    :count_of_tasks, :task_comparison_operator, presence: true
     
    enum task_comparison_operator: {
        match_task_comparison: 0,
        lower_task_comparison: 1,
        higher_task_comparison: 2,
        higher_task_comparison_or_equal_to: 3,
        lower_task_comparison_or_equal_to: 4
      }

    def match(project)
      tasks = project.tasks.all
      tasks = tasks.where(task_status_id: task_status_checked) if task_status_checked.present?
      tasks = tasks.where(grade: task_grade_checked) if task_grade_checked.present?
      tasks = tasks.select{|t| project.unit.week_number(Time.now) - t.task_definition.due_week >= weeks_since_task_was_due} if weeks_since_task_was_due.present?
      

      case task_comparison_operator
        when "match_task_comparison"
            return tasks.count == count_of_tasks
        when "lower_task_comparison"
            return tasks.count < count_of_tasks
        when "higher_task_comparison"
            return tasks.count > count_of_tasks
        when "higher_task_comparison_or_equal_to"
            return tasks.count >= count_of_tasks
        when "lower_task_comparison_or_equal_to"
            return tasks.count <= count_of_tasks
        else
            return false
      end
    end

end