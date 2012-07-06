require 'rackproxy'

class TestServer
  
  def initialize(layout)
    @layout = layout
  end
  
  def call(env)
    if env["PATH_INFO"] == '/'
      return Rack::Proxy.new('http://blog.pcch.org').call(env)
    else
      path = File.join('.', env["PATH_INFO"])
      available = begin
        File.file?(path) && File.readable?(path)
      rescue SystemCallError
        false
      end
      body = available ? File.read(path) : File.read(@layout).gsub!("http://media.pcch.org/github/pcch/tumblr/master", '')
    end
    
    [200, {'Content-Type'=>'text/html'}, [body]]
  end
  
end

run TestServer.new('layout.html')