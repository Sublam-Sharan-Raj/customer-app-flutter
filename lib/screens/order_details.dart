import 'package:flutter/material.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/models/order.dart';
import 'package:insta_closet/widgets/header.dart';
import 'package:insta_closet/widgets/order/order_items_card.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.data});
  final Order data;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(data.createdAt.toString());
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    double itemHeight = 114; // Assuming each item has a height of 100 pixels
    double separatorHeight = 10; // Height of each separator
    double totalHeight = (itemHeight * 3) + (separatorHeight * (4 - 1));
    return Scaffold(
      appBar: AppBar(
        title: Header(
          onLocationPressed: () {},
          showProfile: true,
          showAppLogo: true,
          showLocation: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          clipBehavior: Clip.none,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 50),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Order Details",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontSize: 44, fontWeight: FontWeight.w700),
                  ),
                  const Icon(Icons.search)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order No: 1947044",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    formattedDate,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColors.darkGrey),
                  )
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Tracking number:",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: AppColors.darkGrey),
                        ),
                        const WidgetSpan(
                            child: SizedBox(
                          width: 5,
                        )),
                        TextSpan(
                          text: "IW4475454455",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Delivered",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColors.success),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${data.items!.length} Items',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                height: totalHeight,
                child: ListView.separated(
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.items!.length,
                  itemBuilder: (context, index) {
                    return OrderItemCard(item: data.items![index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10); // or any custom widget
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  "Order information",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(), // Ensures the first column width is based on its content
                  1: FlexColumnWidth(), // Allows the second column to take remaining space
                },
                children: [
                  _buildTableRow(
                      label: "Shipping address:",
                      value:
                          "${data.address!.line!}, ${data.address!.landmark}, ${data.address!.pincode}",
                      context: context),
                  _buildTableRow(
                      label: "Payment method:",
                      value: "**** **** **** 4947",
                      context: context),
                  _buildTableRow(
                      label: "Discount:",
                      value: "10%, Personal promo code",
                      context: context),
                  _buildTableRow(
                      label: "Total amount:",
                      value: '\u{20B9}${data.items![0].totalPrice}',
                      context: context),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "Reorder",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 8), // Adds some space between the buttons
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Leave Feedback",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TableRow _buildTableRow(
    {required String label,
    required String value,
    required BuildContext context}) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 14.0),
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: AppColors.darkGrey),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 14.0),
        child: Text(
          value,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    ],
  );
}
