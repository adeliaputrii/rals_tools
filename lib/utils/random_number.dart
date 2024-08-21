import 'dart:math';

class RandomNumber {
  int getRandomNumber(int min, int max) {
    return min + Random().nextInt(max - min);
  }
}
