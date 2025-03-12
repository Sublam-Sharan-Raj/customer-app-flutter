import 'package:flutter/material.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/screens/login.dart';
import 'package:insta_closet/widgets/custom_back_button.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  String? selectedGender;
  String? selectedAgeRange;

  final List<String> ageRanges = ["10 to 20", "21 to 30", "31 to 40"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: CustomBackButton(
          handleNavigation: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Image(image: AssetImage(Constants.groupShoppingIcon)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedGender == "Men"
                          ? AppColors.secondary
                          : AppColors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedGender = "Men";
                      });
                    },
                    child: Text(
                      "Men",
                      style: TextStyle(
                          color: selectedGender == "Men"
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedGender == "Women"
                          ? AppColors.secondary
                          : AppColors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedGender = "Women";
                      });
                    },
                    child: Text(
                      "Women",
                      style: TextStyle(
                          color: selectedGender == "Women"
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Select Age Range",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            for (var age in ageRanges)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedAgeRange == age
                          ? AppColors.secondary
                          : AppColors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedAgeRange = age;
                      });
                    },
                    child: Text(
                      age,
                      style: TextStyle(
                        color: selectedAgeRange == age
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                ),
                onPressed: () {
                  // Handle finish action
                },
                child: const Text(
                  "Finish",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
