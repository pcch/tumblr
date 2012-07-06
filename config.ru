require 'rackproxy'

map '/' do
  run Rack::Proxy.new('http://blog.pcch.org')
end
run lambda { |env| [200, {'Content-Type'=>'text/html'}, [File.read('layout.html')]] }