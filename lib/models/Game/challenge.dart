import 'package:flutter/material.dart';

class Challenge {
  final String id;
  final String name;
  final String description;
  final int duration; //Number of things to do
  int progress; //Number of things you have done
  final int
      rewardedCoins; //Number of coins you receive after completing the task
  bool isCompleted;
  bool closed = false;
  DateTime? completeUntil;
  Image? image;
  String? category;
  String? difficulty;

  Challenge({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.rewardedCoins,
    this.completeUntil,
    this.image,
    this.category,
    this.difficulty,
    this.progress = 0,
    this.isCompleted = false,
  });

  void nextStep() {
    if (isCompleted) return;
    progress++;
    if (progress == duration) {
      isCompleted = true;
    }
  }

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      difficulty: json['difficulty'],
      duration: json['duration'],
      rewardedCoins: json['rewardedCoins'],
      completeUntil: json['completeUntil'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'image': image,
      'category': category,
      'difficulty': difficulty,
      'duration': duration,
    };
  }
}
