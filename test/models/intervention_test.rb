require "test_helper"

class InterventionTest < ActiveSupport::TestCase

  def test_can_check_target_grade
    unit = FactoryBot.create(:unit)

    insight = Insight.create!(
      name: "Test target grade",
      unit: unit,
      week: nil,
      day: nil
    )

    rule = Rule.create!(
      name: "Target Grade is HD",
      order: 3,
      insight: insight,
      global_rule: false,
      operator: :match_any
    )

    action = EmailStudentAction.create!(
      name: "Email HD students",
      action_scope: rule,
      email_template: "You're doing great!"
    )

    condition = TargetGradeCondition.create!(
      global_condition: false,
      rule: rule,
      target_grade_checked: GradeHelper.hd_value,
      target_grade_operator: :match_target_grade
    )

    result = insight.run(false)

    result.each do |rule, projects|
      puts "#{rule.name unless rule.nil?} matches: #{projects.length.to_s} projects => #{projects.map{|p| p.student.name}.join(", ")}"
    end

    hd_count = unit.active_projects.where("projects.target_grade = :hd", hd: GradeHelper.hd_value).count

    assert_equal hd_count, result[rule].count, "Check HD count"

    unit.destroy
  end

end
