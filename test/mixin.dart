class Class1 {
  int a = 100;

  void printA(){
    print(a);
  }
}

mixin Class2 {
  int b = 200;

  void printB(){
    print(b);
  }
}

class ClassC extends Class1 with Class2 {

  void printAB(){
    printA();
    printB();
  }

}

