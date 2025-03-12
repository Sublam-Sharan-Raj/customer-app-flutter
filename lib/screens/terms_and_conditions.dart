import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms and Conditions",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Privacy Policy",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 8),
            Text(
              "This is a dummy privacy policy text. Here you can add the details of your privacy policy. "
              "Your privacy is important to us, and we are committed to protecting your personal information.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Terms and Conditions",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 8),
            Text(
              "This is a dummy terms and conditions text. Here you can add the terms under which your app operates. "
              "By using this service, you agree to the following terms and conditions...",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigate back or close the screen
                Navigator.pop(context);
              },
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
