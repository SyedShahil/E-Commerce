import 'package:flutter/material.dart';
import 'package:ecom/components/dot_indicators.dart';
import 'package:ecom/constants.dart';
import 'package:ecom/route/route_constants.dart';

import 'components/onbording_content.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  // Ensure proper order of images and titles.
  final List<Onbord> _onbordData = [
    Onbord(
      image: "assets/images/cartpic.png",
      title: "Find the item you’ve \nbeen looking for",
      description:
      "Here you’ll see rich varieties of goods, carefully classified for seamless browsing experience.",
    ),
    Onbord(
      image: "assets/images/addtocart.png",
      title: "Get those shopping \nbags filled",
      description:
      "Add any item you want to your cart, or save it on your wishlist, so you don’t miss it in your future purchases.",
    ),
    Onbord(
      image: "assets/images/payments.png",
      title: "Fast & secure \npayment",
      description: "There are many payment options available for your ease.",
    ),
    Onbord(
      image: "assets/images/tracking.png",
      title: "Package tracking",
      description:
      "In particular, Shoplon can pack your orders, and help you seamlessly manage your shipments.",
    ),
    Onbord(
      image: "assets/images/store.png",
      title: "Nearby stores",
      description:
      "Easily track nearby shops, browse through their items and get information about their products.",
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, logInScreenRoute);
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color),

                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onbordData.length,
                  onPageChanged: (value) {
                    setState(() {
                      _pageIndex = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    // Debugging output to verify data flow
                    print(
                        'Rendering page index: $index, Title: ${_onbordData[index].title}');
                    return OnbordingContent(
                      title: _onbordData[index].title,
                      description: _onbordData[index].description,
                      image: _onbordData[index].image,
                      isTextOnTop: index.isOdd,
                    );
                  },
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    _onbordData.length,
                        (index) => Padding(
                      padding: const EdgeInsets.only(right: defaultPadding / 4),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_pageIndex < _onbordData.length - 1) {
                          _pageController.nextPage(
                            curve: Curves.ease,
                            duration: defaultDuration,
                          );
                        } else {
                          Navigator.pushNamed(context, logInScreenRoute);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      child: Icon(
                        Icons.arrow_circle_right_rounded,
                        color: Colors.white,
                        size: 30.0,
                      )
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}

class Onbord {
  final String image, title, description;

  Onbord({
    required this.image,
    required this.title,
    this.description = "",
  });
}

class OnbordingContent extends StatelessWidget {
  final String title, description, image;
  final bool isTextOnTop;

  const OnbordingContent({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    this.isTextOnTop = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isTextOnTop)
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: defaultPadding),
        Image.asset(
          image,
          height: 300,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: defaultPadding),
        if (!isTextOnTop)
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: defaultPadding / 2),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
