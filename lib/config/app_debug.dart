import 'dart:core' as core;

@core.override
void print(core.String message) {
  core.print(core.DateTime.now().toString() + " - " + message);
}
