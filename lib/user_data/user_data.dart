class UserData {
  static int coins = 0;
  static int xp = 0;

  static void addCoins(int amount) {
    coins += amount;
  }

  static void removeCoins(int amount) {
    coins -= amount;
    if (coins < 0) {
      coins = 0;
    }
  }

  static void addXP(int amount) {
    xp += amount;
  }
}