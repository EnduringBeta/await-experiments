// This file contains many method variations of how futures, async, await, and
// returns work.

// Good implementation; should be called with await and used
Future<String> getSmallData() async {
  return Future.delayed(
    const Duration(seconds: 2),
    () => "Small data here",
  );
}

// Good implementation; should be called with await and used
Future<String> getBigData() async {
  return Future.delayed(
    const Duration(seconds: 4),
    () => "Big data here",
  );
}

// Return Future using await inside
// ~~~ Probably bad implementation ~~~
Future<String> getDataReturnAndAwait() async {
  return await Future.delayed(
    const Duration(seconds: 3),
    () => "Some data here",
  );
}

// Print inside function, returning Future
Future<void> printSmallData() async {
  return Future.delayed(
    const Duration(seconds: 2),
    () => print("Small data here"),
  );
}

// Print inside function, returning Future
Future<void> printBigData() async {
  return Future.delayed(
    const Duration(seconds: 4),
    () => print("Big data here"),
  );
}

// Print inside function, returning Future using await inside
// ~~~ Probably bad implementation ~~~
Future<void> printDataReturnAndAwait() async {
  return await Future.delayed(
    const Duration(seconds: 3),
    () => print("Some data here"),
  );
}

// Print inside function, attempting to return Future, but function returns
// void
// ~~~ Probably bad implementation ~~~
void printDataReturnVoid() async {
  return Future.delayed(
    const Duration(seconds: 3),
    () => print("Some data here"),
  );
}

// Print inside function, returning nothing!
// ~~~ Probably bad implementation ~~~
Future<void> printDataDontReturn() async {
  Future.delayed(
    const Duration(seconds: 3),
    () => print("Some data here"),
  );
}

// Return String in nested function/Future
Future<String> getNestedData() async {
  Future<String> _getInternalData() async {
    return Future.delayed(
      const Duration(seconds: 3),
      () => "Nested data here",
    );
  }
  return Future.delayed(
    const Duration(seconds: 1),
    _getInternalData,
  );
}

// Print in nested function/Future
Future<void> printNestedData() async {
  Future<void> _getInternalData() async {
    return Future.delayed(
      const Duration(seconds: 3),
      () => print("Nested data here"),
    );
  }
  return Future.delayed(
    const Duration(seconds: 1),
    _getInternalData,
  );
}

// Print in nested function/Future, returning nothing!
// ~~~ Probably bad implementation ~~~
Future<void> printNestedDataDontReturn() async {
  Future<void> _getInternalData() async {
    return Future.delayed(
      const Duration(seconds: 3),
      () => print("Nested data here"),
    );
  }
  Future.delayed(
    const Duration(seconds: 1),
    _getInternalData,
  );
}

// --------------------------------------------------
// --------------------------------------------------
// --------------------------------------------------

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

// Wait 3s, print data, wait 2s, print small, wait 3s, print data
// This demonstrates that `return await` is the same as `return`.
void returnAndAwaitAwaitTest() async {
  print('Return and await await test begin');
  countSeconds(8);
  print(await getDataReturnAndAwait());
  print(await getSmallData());
  print(await getDataReturnAndAwait());
  print('Return and await await test end');
}

// Print small after 2s and data after 3s total, but execution continued
// (print begin and end happen instantly)
// This demonstrates that `return await` doesn't affect the calling function,
// including when it's not awaiting.
void returnAndAwaitTest() async {
  print('Return and await test begin');
  countSeconds(3);
  printDataReturnAndAwait();
  printSmallData();
  printDataReturnAndAwait();
  print('Return and await test end');
}

// Print small after 2s and big after 4s total, but execution continued
// (print begin and end happen instantly)
void printTest() async {
  print('Print test begin');
  countSeconds(4);
  printSmallData();
  printBigData();
  print('Print test end');
}

// Wait 2s, print small, wait 4s, print big
// (despite functions returning Future<void>, which was a bit unintuitive to
// me)
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

// Wait 3s, print, but execution continued
// (print begin and end happen instantly)
void voidPrintTest() async {
  print('Void print test begin');
  countSeconds(3);
  printDataReturnVoid();
  print('Void print test end');
}

// Wait 3s, print, but execution continued
// (print begin and end happen instantly)
// ~~~ This is the problem I've been encountering! ~~~
void dontReturnPrintTest() async {
  print('Don\'t return print test begin');
  countSeconds(3);
  await printDataDontReturn();
  print('Don\'t return print test end');
}

// Compile error:
// "Error: This expression has type 'void' and can't be used."
void awaitVoidPrintTest() async {
  //var d = await printDataReturnVoid();
}

// Wait 4s, print
void nestedDataTest() async {
  print('Nested data test begin');
  countSeconds(4);
  print(await getNestedData());
  print('Nested data test end');
}

// Wait 4s, print, but execution continued
// (print begin and end happen instantly)
// ~~~ This is the problem I've been encountering! ~~~
void dontReturnNestedDataTest() async {
  print('Don\'t return nested data test begin');
  countSeconds(4);
  await printNestedDataDontReturn();
  print('Don\'t return nested data test end');
}

// --------------------------------------------------
// --------------------------------------------------
// --------------------------------------------------

// Visualize delay time
void countSeconds(int s) {
  for (var i = 1; i <= s; i++) {
    Future.delayed(Duration(seconds: i), () => print(i));
  }
}

/// Main function
void main() {
  baselineTest();
  //awaitVarsTest();
  //returnAndAwaitAwaitTest();
  //returnAndAwaitTest();
  //printTest();
  //awaitPrintTest();
  //nakedAwaitTest();
  //voidPrintTest();
  //dontReturnPrintTest();
  //nestedDataTest();
  //badlyNestedDataTest();
  //dontReturnNestedDataTest();
}
