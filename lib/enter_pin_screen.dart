// enter_pin_screen.dart

import 'package:flutter/material.dart';

class EnterPinScreen extends StatelessWidget {
  const EnterPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Transaction PIN'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Spacer(flex: 1),
            const Icon(
              Icons.fingerprint,
              size: 100,
              color: Color(0xFF1A73E8),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tap to confirm OR Pay with PIN',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            _buildPinBoxes(),
            const SizedBox(height: 40),
            _buildNumpad(context),
            const Spacer(flex: 2),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Forgot Transaction PIN?',
                style: TextStyle(
                  color: Color(0xFF1A73E8),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinBoxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              '', // This will be filled by a controller in a stateful widget
              style: TextStyle(fontSize: 24),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNumpad(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.5,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        if (index < 9) {
          return _buildNumpadButton(
              '${index + 1}', context, () => Navigator.pushNamed(context, '/success'));
        } else if (index == 9) {
          return const SizedBox.shrink();
        } else if (index == 10) {
          return _buildNumpadButton('0', context, () {});
        } else {
          return _buildNumpadButton('Del', context, () {});
        }
      },
    );
  }

  Widget _buildNumpadButton(String text, BuildContext context, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Center(
        child: text == 'Del'
            ? const Icon(Icons.backspace_outlined, color: Colors.black, size: 28)
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}