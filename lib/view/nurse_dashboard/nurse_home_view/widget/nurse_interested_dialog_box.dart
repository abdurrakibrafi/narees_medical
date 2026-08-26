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
      title: const Text('Interested in This Appointment?'),
      content: const Text(
        'We’ll let the patient know you’re available. If they select you as their provider, the appointment will be added to your schedule.',
      ),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Go, Back'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: onConfirmed,
          child: Text(
            'Yes, I’m Interested',
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
