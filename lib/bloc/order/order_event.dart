part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class FetchOrders extends OrderEvent {
  final String? customerId;

  FetchOrders({this.customerId});
}
