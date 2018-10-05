# Calender GRPC Demo

What I did:

```
gem install grpc-tools
mkdir lib
mkdir proto
grpc_tools_ruby_protoc -Iproto calendar.proto --ruby_out=lib --grpc_out=lib

```