import 'package:flutter/material.dart';

abstract class LocationEvent {}

class FetchLocation extends LocationEvent {
  final BuildContext? context;
  FetchLocation({this.context});
}
