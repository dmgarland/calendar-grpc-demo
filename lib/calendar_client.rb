require 'grpc'
require 'calendar_services_pb'
require 'calendar_pb'

stub = Calendar::Stub.new('localhost:8080', :this_channel_is_insecure)
response = stub.add_event(Event.new(name: 'Ruby Unconference', date: '2018-10-06'))
puts response.added

response = stub.add_event(Event.new(name: 'LRUG', date: '2018-05-09', recurring: true))
puts response.added


events = stub.show_events(EventRange.new(from: '2018-01-1', to: '2018-12-31'))
events.each do |event|
  puts "#{event.name} is happening on #{event.date}"
end