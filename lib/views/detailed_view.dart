import 'package:app/core/constants/app_constants.dart';
import 'package:app/core/constants/view_constants.dart';
import 'package:flutter/material.dart';
import 'package:app/viewmodels/change_notifier_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:app/config/theme/light.dart';

class DetailedView extends StatelessWidget {
  final String id;
  const DetailedView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ViewConstants.detailedView)),
      body: Consumer<TodoProvider>(
        builder:
            (context, provider, child) => Padding(
              padding: const EdgeInsets.all(AppConstants.gap20Px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.getTodoById(id).title,
                    style: TextStyle(
                      fontSize: AppConstants.gap24Px * 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.gap20Px),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: LightTheme.calenderIconColor,
                          ),
                          const SizedBox(width: AppConstants.gap10Px),
                          Text(
                            DateFormat(
                              'dd/MM/yyyy',
                            ).format(provider.getTodoById(id).dateOfCompletion),
                            style: TextStyle(fontSize: AppConstants.gap22Px),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: LightTheme.calenderIconColor,
                          ),
                          const SizedBox(width: AppConstants.gap10Px),
                          Text(
                            provider.getTodoById(id).dueTime.format(context),
                            style: TextStyle(fontSize: AppConstants.gap22Px),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.gap20Px),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.checklist_rtl_outlined,
                            color: LightTheme.calenderIconColor,
                          ),
                          const SizedBox(width: AppConstants.gap10Px),
                          Text(
                            provider.getTodoById(id).isDone
                                ? 'Done'
                                : 'In Progress',
                            style: TextStyle(fontSize: AppConstants.gap22Px),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.share_outlined,
                            color: LightTheme.calenderIconColor,
                          ),
                          const SizedBox(width: AppConstants.gap10Px),
                          Text(
                            'share',
                            style: TextStyle(fontSize: AppConstants.gap22Px),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.gap20Px),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: AppConstants.gap22Px,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppConstants.gap24Px),
                      Text(provider.getTodoById(id).description),
                    ],
                  ),
                  const SizedBox(height: AppConstants.gap24Px * 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: LightTheme.doneCardGreenColor,
                          ),
                          child: Text(
                            ViewConstants.doneTask,
                            style: TextStyle(fontSize: AppConstants.gap22Px),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: LightTheme.deleteButtonRedColor,
                          ),
                          child: Text(
                            ViewConstants.deleteTask,
                            style: TextStyle(fontSize: AppConstants.gap22Px),
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
