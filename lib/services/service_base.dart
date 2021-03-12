import 'providers/service_provider_base.dart';

abstract class ServiceBase<P extends ServiceProviderBase> {
  P provider;
  ServiceBase(this.provider);
}
