import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class VSGame {
  late String id;
  final List<String> players;
  final int beginner;
  final DateTime createdAt;
  final int pin;
  final bool isHost;
  int turn = 0;

  VSGame(this.id, this.players, this.beginner, this.createdAt,
      this.pin,
      {this.isHost = true}) {
    id = '$createdAt$pin';
  }

  void nextTurn() {
    turn++;
  }

  void addPlayer(String player) {
    if (players.length >= 2) {
      return;
    }
    if (players.contains(player)) {
      return;
    }
    players.add(player);
  }

  factory VSGame.asHost(String id, List<String> players, int beginner,
      Position location, DateTime createdAt, int pin) {
    return VSGame(id, players, beginner, createdAt, pin,
        isHost: true);
  }

  VSGame.fromSnapshot(DocumentSnapshot snapshot, SnapshotOptions? options)
      : this(
          snapshot['id'],
          snapshot['players'],
          snapshot['beginner'],
          DateTime.parse(snapshot['createdAt']),
          snapshot['pin'],
        );
  
  //to JSON


  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'players': players,
      'beginner': beginner,
      'createdAt': createdAt.toIso8601String(),
      'pin': pin,
      'turn': turn,
    };
  }
}
