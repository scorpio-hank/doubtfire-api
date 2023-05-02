require 'httparty'

class MicrosoftTeamsWebhook
  include HTTParty

  def initialize(webhook_url)
    @webhook_url = webhook_url
  end

  def send_message(project)
    payload = {
      "@type": "MessageCard",
      "@context": "http://schema.org/extensions",
      "themeColor": "0076D7",
      "summary": "Intervention Message",
      "sections": [
        {
          "activityTitle": "Intervention Message",
          "text": "Dear " + project.student.first_name + ". This is a message from Deakin."
        }
      ]
    }
    self.class.post(@webhook_url, body: payload.to_json, headers: { 'Content-Type' => 'application/json' })
  end
end
