import 'service_provider_base.dart';

abstract class ServiceBase {
  ServiceProviderBase provider;

  ServiceBase(this.provider) {
    provider.init();
  }
}
