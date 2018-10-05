# Calender GRPC Demo

What I did:

```
bundle
mkdir lib
mkdir proto
grpc_tools_ruby_protoc -Iproto calendar.proto --ruby_out=lib --grpc_out=lib

ruby -Ilib lib/calendar_server.rb
ruby -Ilib lib/calendar_client.rb
```