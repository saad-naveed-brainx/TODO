import 'package:flutter/material.dart';
import 'package:app/config/theme/light.dart';
import 'package:app/core/constants/app_constants.dart';
import 'package:app/core/constants/view_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:app/config/app_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.appBackgroundColor,
      appBar: AppBar(
        title: const Text(
          ViewConstants.appTitle,
          style: TextStyle(fontSize: AppConstants.font14Px * 2),
        ),
        backgroundColor: LightTheme.appBackgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    fontSize: AppConstants.font24Px,
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
                          fontSize: AppConstants.font16Px * 2,
                          color: LightTheme.normalTextColor,
                        ),
                      ),
                      TextSpan(
                        text: ViewConstants.addTaskButton,
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                AppRouter.moveToCreateNewTodo(context);
                              },
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
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(
                    //       AppConstants.gap14Px,
                    //     ),
                    //     color: LightTheme.lightGreyColor,
                    //   ),
                    //   padding: const EdgeInsets.all(AppConstants.gap10Px),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Icon(
                    //         Icons.checklist_rounded,
                    //         size: AppConstants.font24Px * 3,
                    //       ),
                    //       const SizedBox(height: AppConstants.gap10Px),
                    //       Text(ViewConstants.todo),
                    //     ],
                    //   ),
                    // ),

                    // 2. In Progress
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppConstants.gap14Px,
                        ),
                        color: LightTheme.appLightTextColor,
                      ),
                      padding: const EdgeInsets.all(AppConstants.gap10Px),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.timelapse_rounded,
                            size: AppConstants.font24Px * 3,
                          ),
                          const SizedBox(height: AppConstants.gap10Px),
                          Text(ViewConstants.inProgress),
                        ],
                      ),
                    ),

                    // 3. Completed
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppConstants.gap14Px,
                        ),
                        color: LightTheme.appLightTextColor,
                      ),
                      padding: const EdgeInsets.all(AppConstants.gap10Px),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: AppConstants.font24Px * 3,
                          ),
                          const SizedBox(height: AppConstants.gap10Px),
                          Text(ViewConstants.completed),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppConstants.gap24Px * 3),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          TextButton(
                            onPressed: () {
                              AppRouter.moveToViewAllTodos(context);
                            },
                            child: Text(ViewConstants.seeAllTasks),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.gap24Px),
                      SizedBox(
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            color: LightTheme.yellowLightCardColor,
                            child: Padding(
                              padding: const EdgeInsets.all(
                                AppConstants.gap24Px * 3,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ViewConstants.addTaskMessage,
                                    style: TextStyle(
                                      fontSize: AppConstants.font20Px,
                                    ),
                                  ),
                                  const SizedBox(height: AppConstants.gap20Px),
                                  GestureDetector(
                                    onTap: () {
                                      AppRouter.moveToCreateNewTodo(context);
                                    },
                                    child: Text(
                                      ViewConstants.addTaskButton,
                                      style: TextStyle(
                                        fontSize: AppConstants.font18Px,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
