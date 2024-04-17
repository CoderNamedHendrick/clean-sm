import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'home_page.dart';
import 'view_model.dart';

T locator<T extends Object>({
  dynamic param1,
  dynamic param2,
  String? instanceName,
  Type? type,
}) =>
    GetIt.I.get(
      param1: param1,
      param2: param2,
      instanceName: instanceName,
      type: type,
    );

void main() {
  _setupViewModels();
  runApp(const MyApp());
}

void _setupViewModels() {
  GetIt.I.registerSingleton(CounterReactiveViewModel());
}
