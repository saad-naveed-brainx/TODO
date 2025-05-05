import 'package:flutter/material.dart';
import 'package:app/config/theme/light.dart';
import 'package:app/core/constants/app_constants.dart';
import 'package:app/core/constants/view_constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.appBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Todo App',
          style: TextStyle(fontSize: AppConstants.font14Px * 2),
        ),
        backgroundColor: LightTheme.appBackgroundColor,
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppConstants.gap24Px * 2,
            left: AppConstants.gap20Px,
            right: AppConstants.gap20Px,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ViewConstants.heyThere,
                style: TextStyle(
                  fontSize: AppConstants.font20Px,
                  color: LightTheme.appLightTextColor,
                ),
              ),
              const SizedBox(height: AppConstants.gap10Px),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: ViewConstants.addTaskMessage + " ",
                      style: TextStyle(
                        fontSize: AppConstants.font24Px,
                        color: LightTheme.normalTextColor,
                      ),
                    ),
                    TextSpan(
                      text: ViewConstants.addTaskButton,
                      style: TextStyle(
                        fontSize: AppConstants.font22Px,
                        color: LightTheme.yellowText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                softWrap: true,
              ),
              const SizedBox(height: AppConstants.gap24Px),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 1. To-do
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConstants.gap14Px),
                      color: LightTheme.appLightTextColor,
                    ),
                    padding: const EdgeInsets.all(AppConstants.gap10Px),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.checklist_rounded),
                        const SizedBox(height: AppConstants.gap10Px),
                        Text('To-do'),
                      ],
                    ),
                  ),

                  // 2. In Progress
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConstants.gap14Px),
                      color: LightTheme.appLightTextColor,
                    ),
                    padding: const EdgeInsets.all(AppConstants.gap10Px),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.timelapse_rounded),
                        const SizedBox(height: AppConstants.gap10Px),
                        Text('In Progress'),
                      ],
                    ),
                  ),

                  // 3. Completed
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConstants.gap14Px),
                      color: LightTheme.appLightTextColor,
                    ),
                    padding: const EdgeInsets.all(AppConstants.gap10Px),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.check_circle_outline),
                        const SizedBox(height: AppConstants.gap10Px),
                        Text('Completed'),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppConstants.gap24Px),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ViewConstants.todayTasks,
                        style: TextStyle(
                          fontSize: AppConstants.font24Px,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(ViewConstants.seeAllTasks),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: LightTheme.yellowLightCardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstants.gap20Px),
                        child: Column(
                          children: [
                            Text(
                              'You dont have any task for today!',
                              style: TextStyle(fontSize: AppConstants.font20Px),
                            ),
                            const SizedBox(height: AppConstants.gap20Px),
                            Text(
                              'Click Here to Create one',
                              style: TextStyle(fontSize: AppConstants.font18Px),
                            ),
                          ],
                        ),
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
