require 'socket'

# Start a server on port 9234
server = TCPServer.new('0.0.0.0', 9234)

# Wait for incoming connections
while io = server.accept
  io << "HTTP/1.1 200 OK\r\n\r\nHello world!"
  io.close
end

# Visit http://localhost:9234/ in your browser.
