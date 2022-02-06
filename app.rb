require 'sinatra'
configure { set :server, :puma }

get '/' do
  "This simple app was created to flush out a bazel build toolchain!"
end
