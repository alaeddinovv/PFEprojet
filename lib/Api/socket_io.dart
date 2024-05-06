import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  static IO.Socket? socket;
  void initSocket() {
    socket = IO.io(
        'http://192.168.95.68:3000',
        OptionBuilder().setTransports(['websocket']).setExtraHeaders(
            {'foo': 'bar'}).build());
    socket!.connect();
    socket!.onConnect((_) {
      print('Connected to WebSocket Server');
    });
    socket!.on('some room', (data) => print('ggggggggggggggggggg'));

    // socket.onError((data) {
    //   print("Socket.io Error: $data");
    // });
    // socket.onConnectError((data) {
    //   print("Connection Error: $data");
    // });
    // socket.onDisconnect((_) {
    //   print("Disconnected from WebSocket Server");
    // });
  }
}
