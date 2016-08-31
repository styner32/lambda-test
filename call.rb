require 'rubygems'
require 'aws-sdk'
require 'json'
require 'base64'

cli = Aws::Lambda::Client.new(region: 'ap-southeast-1')

start = Time.now()
context = {
  from: 'ruby-sdk',
  input: 'hello',
}

resp = cli.invoke({
  function_name: "Sunjin-Test", # required
  invocation_type: "RequestResponse", # accepts Event, RequestResponse, DryRun
  log_type: "Tail", # accepts None, Tail
  client_context: Base64.encode64(JSON.dump(context))
})

puts "took: #{Time.now() - start}"
puts Base64.decode64(resp.log_result)
p JSON.load(resp.payload.read)
