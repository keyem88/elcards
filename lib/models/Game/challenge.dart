import 'package:cloud_firestore/cloud_firestore.dart';

enum ChallengeDifficulty { easy, medium, hard, other }

enum ChallengeCategory { starter, special, normal }

enum TaskType {
  playGames,
  startGames,
  winGames,
  earnCoins,
  spendCoins,
  sumCards,
}

class Challenge {
  final String id; //Firebase - Id of the challenge
  final String name; //Name of the challenge
  final String description; //Description of the challenge shown to the user
  final String
      internalDescription; //Description of the challenge shown to the admin
  int progress; //Number of things you have done
  bool isCompleted; //If the challenge is personally completed
  final Timestamp created; //Date when the challenge was created
  final int number; //Number of things to do
  final int
      rewardedCoins; //Number of coins you receive after completing the task
  bool closed; //If the challenge is closed
  final Duration duration; //Duration of the challenge
  final int imageIndex; //Index of the image in the image list (-1 if no image)
  ChallengeCategory category; //Category of the challenge
  ChallengeDifficulty difficulty; //Difficulty of the challenge
  TaskType taskType; //Type of the task

  Challenge({
    required this.id,
    required this.name,
    required this.description,
    required this.internalDescription,
    required this.progress,
    required this.isCompleted,
    required this.created,
    required this.number,
    required this.rewardedCoins,
    required this.closed,
    required this.duration,
    required this.imageIndex,
    required this.category,
    required this.difficulty,
    required this.taskType,
  });

  void nextStep() {
    if (isCompleted) return;
    progress++;
    if (progress == duration) {
      isCompleted = true;
    }
  }

  DateTime get completeUntil => created.toDate().add(duration);

  factory Challenge.fromJson(
      String id, Map<String, dynamic> json, int progress, bool iscompleted) {
    return Challenge(
      id: id,
      name: json['name'],
      description: json['description'],
      internalDescription: json['internalDescription'],
      created: json['created'],
      closed: json['closed'],
      duration: Duration(milliseconds: json['duration']),
      imageIndex: json['imageIndex'],
      category: ChallengeCategory.values[json['category']],
      difficulty: ChallengeDifficulty.values[json['difficulty']],
      number: json['number'],
      rewardedCoins: json['rewardedCoins'],
      taskType: TaskType.values[json['taskType']],
      progress: progress,
      isCompleted: iscompleted,
    );
  }
}
