import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/auth/auth_bloc.dart';
import 'package:insta_closet/bloc/order/order_bloc.dart';
import 'package:insta_closet/widgets/header.dart';
import 'package:insta_closet/widgets/order/order_card.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    final userId = context.read<AuthBloc>().state.auth!.user!.id;
    BlocProvider.of<OrderBloc>(context).add(FetchOrders(customerId: userId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(
          onLocationPressed: () {},
          showProfile: true,
          showAppLogo: true,
          showLocation: false,
        ),
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "My Orders",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 34, fontWeight: FontWeight.w700),
                      ),
                      const Icon(Icons.search)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  renderTabs(context, state)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

renderTabs(context, OrderState state) {
  return DefaultTabController(
    length: 3,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.all(5),
            indicator: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            dividerColor: Colors.white,
            labelColor: Colors.white, // Color for the selected tab
            unselectedLabelColor: Colors.black,
            tabs: [
              Text("Delivered", style: TextStyle(fontSize: 14)),
              Text("Processing",
                  style: TextStyle(
                    fontSize: 14,
                  )),
              Text("Cancelled", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 580,
          child: TabBarView(
            children: [
              state.orderList!.isEmpty
                  ? Center(child: Text("No orders"))
                  : ListView.separated(
                      itemCount: state.orderList!.length,
                      itemBuilder: (context, index) {
                        return OrderCard(orderDetails: state.orderList![index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                    ),
              state.orderList!.isEmpty
                  ? Center(child: Text("No orders"))
                  : ListView.separated(
                      itemCount: state.orderList!.length,
                      itemBuilder: (context, index) {
                        return OrderCard(orderDetails: state.orderList![index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                            height: 10); // or any custom widget
                      },
                    ),
              state.orderList!.isEmpty
                  ? Center(child: Text("No orders"))
                  : ListView.separated(
                      itemCount: state.orderList!.length,
                      itemBuilder: (context, index) {
                        return OrderCard(orderDetails: state.orderList![index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                            height: 10); // or any custom widget
                      },
                    ),
            ],
          ),
        ),
      ],
    ),
  );
}
