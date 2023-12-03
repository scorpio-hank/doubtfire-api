class NameCondition < Condition
  validates    :starting_letter_first_name, presence: true

  def match(project)
      return project.student.name.start_with?(starting_letter_first_name)
  end
end
