import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageData> _pages = [
    OnboardingPageData(
      title: "Stay Connected, Always",
      subtitle: "Top up your phone or any number in seconds. Fast, reliable, and available anytime.",
      image: 'assets/images/screen1_image.png',
      backgroundColor: Colors.white,
      textColor: Colors.black,
      subheading: '“Buy Data & Airtime Instantly”',
    ),
    OnboardingPageData(
      title: "Pay Bills, Simplified",
      subtitle: "Settle your electricity, cable TV, and internet bills with just a tap — stress-free and secure.",
      image: 'assets/images/screen2_image.png',
      backgroundColor: Colors.blue.shade100,
      textColor: Colors.black,
      subheading: '“Never Miss a Payment”',
    ),
    OnboardingPageData(
      title: "More Than VTU",
      subtitle: "From SMM services to secure Virtual Cards, FlexPay gives you everything you need to spend, save, and grow smarter.",
      image: 'assets/images/screen3_image.png',
      backgroundColor: Colors.blue.shade300,
      textColor: Colors.white,
      subheading: '“Do More with FlexPay”',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onGetStartedPressed() {
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _OnboardingScreen(
                data: _pages[index],
                onGetStarted: index == _pages.length - 1 ? _onGetStartedPressed : null,
              );
            },
          ),
          Positioned(
            bottom: 30.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 8.0,
                  width: _currentPage == index ? 24.0 : 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? _pages[index].textColor
                        : _pages[index].textColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingScreen extends StatelessWidget {
  final OnboardingPageData data;
  final VoidCallback? onGetStarted;

  const _OnboardingScreen({required this.data, this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: data.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            data.image,
            height: 250,
            width: 250,
          ),
          const SizedBox(height: 40.0),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: data.textColor,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            data.subheading,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: data.textColor,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            data.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              height: 1.5,
              color: data.textColor,
            ),
          ),
          const Spacer(),
          if (onGetStarted != null)
            ElevatedButton(
              onPressed: onGetStarted,
              style: ElevatedButton.styleFrom(
                backgroundColor: data.textColor,
                foregroundColor: data.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class OnboardingPageData {
  final String title;
  final String subheading;
  final String subtitle;
  final String image;
  final Color backgroundColor;
  final Color textColor;

  OnboardingPageData({
    required this.title,
    required this.subheading,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.textColor,
  });
}
