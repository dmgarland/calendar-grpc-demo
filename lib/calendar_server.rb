require 'grpc'
require 'calendar_services_pb'
require 'calendar_pb'
require 'pry'

class CalendarServer < Calendar::Service

  def initialize
    @events = []
  end

  def add_event(event, _call)
    @events << event

    return EventAdded.new(added: true)
  end

end

addr = "0.0.0.0:8080"
s = GRPC::RpcServer.new
s.add_http2_port(addr, :this_port_is_insecure)
puts("... running insecurely on #{addr}")
s.handle(CalendarServer.new)
s.run_till_terminated
