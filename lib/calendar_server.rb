require 'grpc'
require 'calendar_services_pb'
require 'calendar_pb'
require 'pry'
require 'date'

class Event
  def actual_date
    @actual_date ||= Date.parse date
  end
end

class CalendarServer < Calendar::Service

  def initialize
    @events = []
  end

  def add_event(event, _call)
    @events << event

    return EventAdded.new(added: true)
  end

  def show_events(request, _call)
    from = Date.parse(request.from)
    to = Date.parse(request.to)

    Enumerator.new do |y|
      @events.select {|event| event.actual_date <= to && event.actual_date >= from }.each do |event|
        y << event
        while event.recurring && event.actual_date < to
          # assume monthly its only a demo :)
          event = Event.new(name: event.name, date: (event.actual_date >> 1).to_s, recurring: true)
          y << event
        end
      end
    end
  end

end

addr = "0.0.0.0:8080"
s = GRPC::RpcServer.new
s.add_http2_port(addr, :this_port_is_insecure)
puts("... running insecurely on #{addr}")
s.handle(CalendarServer.new)
s.run_till_terminated
