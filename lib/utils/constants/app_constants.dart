enum DeviceType {
  browser,
  advicer,
}

enum ActionType {
  attack,
  defend,
  escape,
}

enum TurnResult {
  beats,
  beaten,
  draw,
}

enum GameResult {
  won,
  lost,
}

class AppConstants {
  static String loginRoute = "/login";
  static String appName = "ElCards";
}
