require_dependency 'microsoft_teams_webhook'

class MessageStudentAction < Action
  # validates    :email_subject, :email_template, presence: true

  def perform_action(project)
    webhook_url = 'REPLACE WITH URL FOR WEBHOOK' # Replace with your actual webhook URL

    teams_webhook = MicrosoftTeamsWebhook.new(webhook_url)
    response = teams_webhook.send_message(project)

    if response.code == 200
      puts 'Message sent successfully'
    else
      puts "Failed to send message. Error code: #{response.code}"
    end
  end
end
