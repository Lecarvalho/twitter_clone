abstract class AsInterfaceOrInheritance {
  void method();
  void methodWithImplementation(){
    print("yes it is");
  }
}


class ConcreteClass implements AsInterfaceOrInheritance {
  @override
  void method() {
  }

  @override
  void methodWithImplementation() {
  }
}