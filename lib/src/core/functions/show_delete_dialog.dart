import 'package:flutter/material.dart';

import '../configs/app_configs.dart';
import '../constants/constraints/constraints.dart';

/// {@template showDeleteDialog}
/// This funtion will call a delete dialog
/// and will return a [bool]
///
/// {@params}
/// It takes 3 parameters
///
/// `context` the buildcontext
///
/// `title` title for the dialog
///
/// `body` description
///
/// {@endparams}
///
/// {@endtemplate}
Future<bool> showDeleteDialog(
  BuildContext context,
  String title,
  String body,
) async {
  bool dialog = false;
  await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.22,
            child: Padding(
              padding: const EdgeInsets.all(AppConstraints.mediumSpace),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.headline5,
                    ),
                    const SizedBox(
                      height: AppConstraints.smallSpace,
                    ),
                    Text(body),
                    const SizedBox(
                      height: AppConstraints.largeSpace,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          child: Text(localization.yes),
                          onPressed: () {
                            dialog = true;
                            navigator.popRoute();
                          },
                        ),
                        MaterialButton(
                          child: Text(localization.no),
                          onPressed: () {
                            dialog = false;
                            navigator.popRoute();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });

  return dialog;
}
