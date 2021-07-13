import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connectingaaaa }

class SocketServices with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connectingaaaa;

  SocketServices() {
    this._initConfig();
  }

  get serverStatus => this._serverStatus;

  void _initConfig() {
    // Dart client
    IO.Socket socket = IO.io('http://172.19.1.108:3000', {
      'transports': ['websocket'],
      'autoConnect': true
    });

    socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    /*socket.on('event', (data) => print(data));
    socket.on('fromServer', (_) => print(_));*/
  }
}
