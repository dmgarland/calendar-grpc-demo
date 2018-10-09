require 'sinatra'

set :events, []

configure do
  set :logging, nil
end

post '/events' do
  settings.events << JSON.parse(request.body.string)
  200
end