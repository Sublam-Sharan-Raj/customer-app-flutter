import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insta_closet/models/order.dart';
import 'package:insta_closet/services/order_service.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderState.reset()) {
    final OrderService orderService = OrderService();
    on<OrderEvent>((event, emit) async {
      if (event is FetchOrders) {
        emit(OrderState(orderListLoading: true, isError: false));
        try {
          final params = {"customer_id": event.customerId};
          final response = await orderService.fetchOrders(params);
          final orderMap = response as List<dynamic>;
          final data = orderMap.map((e) {
            return Order.fromJson(e);
          }).toList();
          emit(OrderState(
              orderList: data, orderListLoading: false, isError: false));
        } catch (e) {
          emit(OrderState(orderListLoading: false, isError: true));
        }
      }
    });
  }
}
