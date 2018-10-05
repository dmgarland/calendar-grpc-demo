require 'grpc'
require 'calendar_services_pb'
require 'calendar_pb'

stub = Calendar::Stub.new('localhost:8080', :this_channel_is_insecure)
response = stub.add_event(Event.new(name: 'Ruby Unconference', date: '2018-10-06'))
puts response.added