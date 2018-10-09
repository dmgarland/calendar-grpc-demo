require 'grpc'
require 'calendar_services_pb'
require 'calendar_pb'
require 'benchmark'

puts Benchmark.measure {
  stub = Calendar::Stub.new('localhost:8080', :this_channel_is_insecure)

  1.times do
    response = stub.add_event(Event.new(name: 'Ruby Unconference', date: '2018-10-06'))
  end

  events = stub.show_events(EventRange.new(from: '2018-01-1', to: '2018-12-31'))
}