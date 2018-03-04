Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'],
           {
               name: 'google',
               scope: 'email, profile, plus.me, http://gdata.youtube.com',
               prompt: 'select_account',
               image_aspect_ratio: 'square',
               image_size: 50
           }
  OmniAuth.config.full_host = Rails.env.production? ? 'https://stock-tracer.herokuapp.com' : 'http://localhost:3000'
  end