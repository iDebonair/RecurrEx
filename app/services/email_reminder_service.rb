require 'net/http'

class EmailReminderService
  def initialize(subscription)
    @subscription = subscription
  end

  def send_reminder
    message = "Hello, your subscription for #{@subscription.name} expires tomorrow!"
    recipient = @subscription.user.email
    api_key = '08ce5da9720592b9b3f77bf586206f54-324e0bb2-bcee280a'
    mailgun_domain = 'sandboxab8ef21068ec4729a062ca9dc248e2cd.mailgun.org'
    
    url = URI.parse("https://api.mailgun.net/v3/#{mailgun_domain}/messages")
    request = Net::HTTP::Post.new(url.path)
    request.basic_auth('api', api_key)
    request.set_form_data({
      'from' => 'RecurrEx <renew@recurrex.com>',
      'to' => recipient,
      'subject' => "Subscription Renewal Reminder - #{@subscription.name}",
      'text' => message
    })

    response = Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.code.to_i == 200
      puts "Email reminder sent successfully."
    else
      puts "Email reminder sending failed. HTTP Status: #{response.code}, Response Body: #{response.body}"
    end
  end
end