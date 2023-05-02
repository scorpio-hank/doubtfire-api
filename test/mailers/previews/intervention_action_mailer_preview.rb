class InterventionActionMailerPreview < ActionMailer::Preview
  def intervention_action_email
    sample_email_template =
    <<-MARKDOWN
    *Italic intervention* and **bold intervention**

    - You're doing something good or bad
    - This too

    1. Reason 1
    2. Reason 2

    [Link to HelpHub](https://www.example.com)

    ```ruby
    # Code block in Ruby
    def try_this_code
      puts 'Hello, world!'
    end
    ```
    <p style="font-family: Arial; font-size: 20px; color: blue;">Styled paragraph</p>
    MARKDOWN
    InterventionActionMailer.intervention_action_email(Project.first, 'Test Subject', 'Test Header', sample_email_template)
  end
end
