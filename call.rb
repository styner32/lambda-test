require 'rubygems'
require 'aws-sdk'
require 'json'
require 'base64'

fns = %w(Sunjin-Test sunjin-todo-create)
cli = Aws::Lambda::Client.new(region: 'ap-southeast-1')

context = {}

fns.each do |fn|
  resp = cli.invoke({
    function_name: fn, # required
    invocation_type: "RequestResponse", # accepts Event, RequestResponse, DryRun
    log_type: "Tail", # accepts None, Tail
    client_context: Base64.encode64(JSON.dump(context))
  })

  puts Base64.decode64(resp.log_result)
  p JSON.load(resp.payload.read)
end

