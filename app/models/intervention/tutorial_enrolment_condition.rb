class TutorialEnrolmentCondition < Condition
    validates    :tutorial_id_check, presence: true

    def match(project)
        # Check if the project is enrolled in the tutorial
        return project.tutorial_enrolments.first.id == tutorial_id_check
    end 
  end