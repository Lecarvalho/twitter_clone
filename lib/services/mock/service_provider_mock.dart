import 'package:twitter_clone/services/providers/service_provider_base.dart';

class ServiceProviderMock implements ServiceProviderBase {
  @override
  Future<void> init() async {
    await Future.delayed(Duration(seconds: 1));
  }
}