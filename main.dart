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

// Print inside function, returning Future
Future<void> printSmallData() async {
  return Future.delayed(
    const Duration(seconds: 2),
    () => print("Small data here")
  );
}

// Print inside function, returning Future
Future<void> printBigData() async {
  return Future.delayed(
    const Duration(seconds: 4),
    () => print("Big data here")
  );
}

// Print inside function, returning nothing
void printDataReturnVoid() async {
  return Future.delayed(
    const Duration(seconds: 3),
    () => print("Some data here")
  );
}

// Return String in nested function/Future
Future<String> getNestedData() async {
  Future<String> _getInternalData() async {
    return Future.delayed(
      const Duration(seconds: 3),
      () => "Nested data here"
    );
  }
  return Future.delayed(
    const Duration(seconds: 1),
    _getInternalData,
  );
}

// ---

// Wait 2s, print small, wait 4s, print big
void baselineTest() async {
  print('Baseline test begin');
  countSeconds(6);
  print(await getSmallData());
  print(await getBigData());
  print('Baseline test end');
}

// Wait 6s, print both
void awaitVarsTest() async {
  print('Await vars test begin');
  countSeconds(6);
  String s = await getSmallData();
  String b = await getBigData();
  print(s);
  print(b);
  print('Await vars test end');
}

// Print small after 2s and big after 4s total
// (print begin and end happen instantly)
void printTest() async {
  print('Print test begin');
  countSeconds(4);
  printSmallData();
  printBigData();
  print('Print test end');
}

// Wait 2s, print small, wait 4s, print big
// (despite functions returning Future<void>)
void awaitPrintTest() async {
  print('Await print test begin');
  countSeconds(6);
  var s = await printSmallData();
  var b = await printBigData();
  print('Await print test end');
}

// Wait 2s, print small, wait 4s, print big
void nakedAwaitTest() async {
  print('Naked await test begin');
  countSeconds(6);
  await printSmallData();
  await printBigData();
  print('Naked await test end');
}

// Wait 3s, print
// (print begin and end happen instantly)
void voidPrintTest() async {
  print('Void print test begin');
  countSeconds(3);
  printDataReturnVoid();
  print('Void print test end');
}

// Compile error:
// "Error: This expression has type 'void' and can't be used."
void awaitVoidPrintTest() async {
  //var d = await printDataReturnVoid();
}

// Wait 4s, print
void nestedDataTest() async {
  countSeconds(4);
  print(await getNestedData());
}

// ---

// Visualize delay time
void countSeconds(int s) {
  for (var i = 1; i <= s; i++) {
    Future.delayed(Duration(seconds: i), () => print(i));
  }
}

/// Main function
void main() {
  //baselineTest();
  //awaitVarsTest();
  //printTest();
  //awaitPrintTest();
  //nakedAwaitTest();
  //voidPrintTest();
  nestedDataTest();
}

// What happens with async function that returns void? Not Future<void>?
