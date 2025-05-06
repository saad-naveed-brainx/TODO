import 'package:app/config/theme/light.dart';
import 'package:app/core/constants/app_constants.dart';
import 'package:app/core/constants/view_constants.dart';
import 'package:flutter/material.dart';
import 'package:app/viewmodels/change_notifier_provider.dart';
import 'package:provider/provider.dart';
import 'package:app/config/app_router.dart';

class ViewAllTodos extends StatefulWidget {
  const ViewAllTodos({super.key});

  @override
  State<ViewAllTodos> createState() => _ViewAllTodosState();
}

class _ViewAllTodosState extends State<ViewAllTodos> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ViewConstants.viewAllTodos)),
      body: Consumer<TodoProvider>(
        builder:
            (context, provider, child) => ListView.builder(
              itemCount: provider.todos.length,
              itemBuilder:
                  (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.gap20Px,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            AppRouter.moveToDetailedView(
                              context,
                              provider.todos[index].id,
                            );
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Card(
                              color: LightTheme.todoCardColor,
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  AppConstants.gap20Px,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      provider.todos[index].title,
                                      style: TextStyle(
                                        fontSize: AppConstants.gap24Px,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      provider.todos[index].description.trim(),
                                      style: TextStyle(
                                        fontSize: AppConstants.gap16Px,
                                      ),
                                    ),
                                    Text(
                                      provider.todos[index].dueTime.format(
                                        context,
                                      ),
                                      style: TextStyle(
                                        fontSize: AppConstants.gap24Px,
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
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Card(
                            color: LightTheme.todoCardColor,
                            child: Padding(
                              padding: const EdgeInsets.all(
                                AppConstants.gap20Px,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RotatedBox(
                                    quarterTurns: 3,
                                    child: Text(
                                      provider.todos[index].isDone
                                          ? 'Done'
                                          : 'To-Do',
                                      style: TextStyle(
                                        fontSize: AppConstants.gap24Px,
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
                  ),
            ),
      ),
    );
  }
}
