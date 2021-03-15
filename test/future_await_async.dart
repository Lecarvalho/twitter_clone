import 'package:test/test.dart';

void main() {
  test("testing async await and future", () async {
    // var futureAwaitAsync = FutureAwaitAsync();

    print("starting mainMethod");

    // futureAwaitAsync.futureMethod();
    // futureAwaitAsync.asyncMethod();
    // futureAwaitAsync.syncMethod();

    // await futureAwaitAsync.futureMethod();
    // await futureAwaitAsync.asyncMethod();

    print("finished mainMethod");
  });
}

class FutureAwaitAsync {
  Future<void> futureMethod() async {
    print(">> starting futureMethod");
    await Future.delayed(Duration(seconds: 5));
    print(">> finished futureMethod after 5s");
  }

  void asyncMethod() async {
    print(">> starting asyncMethod");
    await Future.delayed(Duration(seconds: 5));
    print(">> finished asyncMethod after 5s");
  }

  void asyncOrFutureDontDoThis() async {
    print(">> starting asyncOrFutureDontDoThis");
    Future.delayed(Duration(seconds: 5));
    print(">> finished asyncOrFutureDontDoThis");
  }

  void syncMethod() {
    print(">> starting syncMethod");
    Future.delayed(Duration(seconds: 5));
    print(">> finishing syncMethod");
  }
}
