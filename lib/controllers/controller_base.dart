import 'package:flutter/foundation.dart';
import 'package:twitter_clone/services/service_base.dart';

abstract class ControllerBase<Service extends ServiceBase>  {
  Service service;
  ControllerBase({@required this.service});
}
