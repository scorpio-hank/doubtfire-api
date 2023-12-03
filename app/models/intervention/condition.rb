class Condition < ApplicationRecord
  # self.abstract_class = true

  belongs_to   :rule

  def match(project)
  end
end
