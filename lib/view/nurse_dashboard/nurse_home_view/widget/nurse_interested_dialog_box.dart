import 'package:flutter/cupertino.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

Future<void> showInterestConfirmationDialog({
  required BuildContext context,
  required Future<void> Function() onConfirmed,
}) async {
  final confirmed = await showCupertinoDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => CupertinoAlertDialog(
      title: const Text('Confirm Interest'),
      content: const Text(
        'If the patient accepts your interest, an appointment will be created.',
      ),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: onConfirmed,
          child: Text(
            'OK',
            style: TextStyle(color: AppColors.mainColor),
          ),
        ),
      ],
    ),
  );

  if (confirmed == true) {
    await onConfirmed();
  }
}
