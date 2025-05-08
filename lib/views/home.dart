import 'package:flutter/material.dart';
import 'package:app/config/theme/light.dart';
import 'package:app/core/constants/app_constants.dart';
import 'package:app/core/constants/view_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:app/config/app_router.dart';
import 'package:app/viewmodels/change_notifier_provider.dart';
import 'package:provider/provider.dart';
import 'package:app/models/todo_model.dart';

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
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          final List<TodoModel>? todayTasks = provider.getTodoForToday();
          return SafeArea(
            bottom: false,
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
                        GestureDetector(
                          onTap: () {
                            context.read<TodoProvider>().setStatus(
                              "in-progress",
                            );
                            AppRouter.moveToViewAllTodos(context);
                          },
                          child: Container(
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
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<TodoProvider>().setStatus("completed");
                            AppRouter.moveToViewAllTodos(context);
                          },
                          child: Container(
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
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.gap24Px * 3),
                    Column(
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
                                context.read<TodoProvider>().setStatus(null);
                                AppRouter.moveToViewAllTodos(context);
                              },
                              child: Text(ViewConstants.seeAllTasks),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppConstants.gap24Px),
                        if (todayTasks == null || todayTasks.isEmpty)
                          SizedBox(
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
                                    const SizedBox(
                                      height: AppConstants.gap20Px,
                                    ),
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
                        if (todayTasks != null && todayTasks.isNotEmpty)
                          ListView.builder(
                            itemCount: todayTasks.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppConstants.gap10Px,
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        String? result =
                                            await AppRouter.moveToDetailedView(
                                              context,
                                              todayTasks[index].id,
                                            );
                                        if (result == "deleted") {
                                          context
                                              .read<TodoProvider>()
                                              .notifyListeners();
                                        }
                                      },
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.7,
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.2,
                                        child: Card(
                                          color: LightTheme.todoCardColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                              AppConstants.gap20Px,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  todayTasks[index].title,
                                                  style: TextStyle(
                                                    fontSize:
                                                        AppConstants.gap24Px,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  todayTasks[index].description,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize:
                                                        AppConstants.gap16Px,
                                                  ),
                                                ),
                                                Text(
                                                  todayTasks[index].dueTime
                                                      .format(context),
                                                  style: TextStyle(
                                                    fontSize:
                                                        AppConstants.gap24Px,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.2,
                                      child: Card(
                                        color: LightTheme.todoCardColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                            AppConstants.gap20Px,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              RotatedBox(
                                                quarterTurns: 3,
                                                child: Text(
                                                  todayTasks[index].isDone
                                                      ? 'Completed'
                                                      : 'In Progress',
                                                  style: TextStyle(
                                                    fontSize:
                                                        AppConstants.gap24Px,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
