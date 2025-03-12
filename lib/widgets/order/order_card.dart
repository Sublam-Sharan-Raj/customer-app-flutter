import 'package:flutter/material.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/models/order.dart';
import 'package:insta_closet/screens/order_details.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.orderDetails});

  final Order orderDetails;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(orderDetails.createdAt.toString());
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          // Set the corner radius
        ),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), // Ensure rounded corners
            border: Border.all(color: AppColors.darkGrey),
            color: Colors.white, // Set border color and width to 1
          ),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order No: 1",
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
                height: 18,
              ),
              Row(
                children: [
                  Text(
                    "Tracking number:",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColors.darkGrey),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "IW3475453455",
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Quantity:",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: AppColors.darkGrey),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        orderDetails.items![0].quantity.toString(),
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Total Amount:",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: AppColors.darkGrey),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '\u{20B9} ${orderDetails.items![0].totalPrice.toString()}',
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  OrderDetails(data: orderDetails)),
                        );
                      },
                      child: Text("Details",
                          style: Theme.of(context).textTheme.labelMedium)),
                  Text(
                    "Delivered",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColors.success),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
