require 'development_mail_interceptor'

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "railscasts.com",
  :user_name            => "riff.ranter",
  :password             => "riffyranter",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = Rails.env.development? ? "localhost:3000" : "riff.nibbleandbytesoftware.com"
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development? 