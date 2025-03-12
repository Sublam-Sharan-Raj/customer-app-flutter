// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

class OrderState {
  final List<Order>? orderList;
  final bool? orderListLoading;
  final bool? isError;

  OrderState(
      {this.orderListLoading = false,
      this.orderList = const [],
      this.isError = false});
  factory OrderState.reset() => OrderState();
  OrderState copyWith(
      {List<Order>? orderList, bool? orderListLoading, bool? isError}) {
    return OrderState(
        orderList: orderList ?? this.orderList,
        orderListLoading: orderListLoading ?? orderListLoading,
        isError: isError ?? this.isError);
  }
}
