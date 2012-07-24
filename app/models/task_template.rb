class TaskTemplate < ActiveRecord::Base
	attr_accessible :project_template_id, :description, :name, :recommended_completion_date, :required, :weighting

	# Model associations
	belongs_to :project_template		# Foreign key

	has_many :tasks
end
