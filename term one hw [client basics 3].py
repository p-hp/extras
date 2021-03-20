# socket_client UDP
 
import socket
 
client_socket_UDP = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
srv = '127.0.0.1'
msg = "Beautiful weather, huh?"
data = msg.encode()
client_socket_UDP.sendto(data,(srv,20001))
 
while True:
    data, sender_address = client_socket_UDP.recvfrom(1024)
    if data.decode() == 'Q': break
    print('Received {}'.format(data.decode()))
    
client_socket_UDP.close()
 
# socket_server UDP
 
import socket
 
quotes = [['To be, or not to be..','that is the question'],
         ['The greatest glory in living lies not in never falling, but in rising every time we fall.',
          'You must be the change you wish to see in the world.']]
 
udp_server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
udp_server.bind(("0.0.0.0",20001))
 
data, client_address = udp_server.recvfrom(1024)
print('Received: {}'.format(data.decode()))
for i in range(2):
    for j in range(2):
        msg = quotes[i][j]
        print('Sending {}'.format(msg))
        data = msg.encode()
        udp_server.sendto(data, client_address)
        
data = 'Q'.encode()
udp_server.sendto(data, client_address)
udp_server.close()
