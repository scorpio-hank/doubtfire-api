class UnitActivitySet < ActiveRecord::Base
  belongs_to :unit
  belongs_to :activity_type

  validates :activity_type, presence: true
  validates :unit_id, presence: true
end
