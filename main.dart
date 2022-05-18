// This file contains many method variations of how futures, async, await, and returns work.

// Good implementation; should be called with await and used
Future<String> getSmallData() async {
  return Future.delayed(
    const Duration(seconds: 2),
    () => "Small data here"
  );
}

// Good implementation; should be called with await and used
Future<String> getBigData() async {
  return Future.delayed(
    const Duration(seconds: 4),
    () => "Big data here"
  );
}

// .
Future<void> printSmallData() async {
  return Future.delayed(
    const Duration(seconds: 2),
    () => print("Small data here")
  );
}

// .
Future<void> printBigData() async {
  return Future.delayed(
    const Duration(seconds: 4),
    () => print("Big data here")
  );
}

// .
void printDataReturnVoid() async {
  return Future.delayed(
    const Duration(seconds: 3),
    () => print("Some data here")
  );
}

// Wait 2s, print small, wait 4s, print big
void baselineTest() async {
  countSeconds(6);
  print(await getSmallData());
  print(await getBigData());
}

// Visualize delay time
void countSeconds(int s) {
  for (var i = 1; i <= s; i++) {
    Future.delayed(Duration(seconds: i), () => print(i));
  }
}

/// Main function
void main() {
  baselineTest();
}

// What happens with async function that returns void? Not Future<void>?
