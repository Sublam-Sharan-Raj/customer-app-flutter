import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/navigation_menu.dart';
import 'package:insta_closet/widgets/header.dart';

class OrderCompletion extends StatelessWidget {
  const OrderCompletion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Header(
              onLocationPressed: () {},
              showProfile: false,
              showAppLogo: true,
              showLocation: false,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Delivery",
                style: GoogleFonts.lunasima(
                    fontSize: 24,
                    color: AppColors.lightGrey,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 100,
              ),
              const Image(
                image: AssetImage(Constants.deliveryIcon),
                width: 200,
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "you'r order will be delivered soon as possible",
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                  "Your order is on the way, and you will receive all updates via notifications.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      textStyle: GoogleFonts.lunasima(
                          fontSize: 18, fontWeight: FontWeight.w700),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 18,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const NavigationMenu()),
                      );
                    },
                    child: Text(
                      "Continue Shopping",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
