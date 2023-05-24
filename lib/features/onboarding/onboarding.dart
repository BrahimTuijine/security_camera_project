import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_camera_project/core/Model/onboarding_model.dart';
import 'package:security_camera_project/features/auth/login_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  void changeCurrentPage(int value) {
    setState(() {
      currentPage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.h),
        child: Column(
          children: [
            SizedBox(
              height: 500.h,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (value) => changeCurrentPage(value),
                controller: _controller,
                itemCount: onboardingList.length,
                itemBuilder: (context, index) {
                  final o = onboardingList[index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 350.h,
                        child: Image.asset(
                          fit: BoxFit.fill,
                          "assets/images/${o.image}",
                        ),
                      ),
                      SizedBox(height: 29.h),
                      Text(
                        o.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        o.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      // SizedBox(height: 43.h),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) {
                          return Container(
                            margin: EdgeInsets.only(left: 3.h),
                            width: 20.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                              color: index == currentPage
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.secondary,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    SizedBox(
                      height: 53.h,
                      width: 337.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder()),
                        onPressed: () {
                          if (currentPage == 2) {
                            // context.go('/auth');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          }

                          if (currentPage < 2) {
                            _controller.jumpToPage(currentPage + 1);
                          }
                        },
                        child: const Text(
                          "Next",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    Visibility(
                      visible: currentPage < 2,
                      child: SizedBox(
                        height: 53.h,
                        width: 337.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder()),
                          onPressed: () {
                            _controller.jumpToPage(2);
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
