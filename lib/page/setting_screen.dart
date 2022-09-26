import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/provider/preferences_provider.dart';
import 'package:restaurant_app_1/data/provider/scheduling_provider.dart';
import 'package:restaurant_app_1/widget/custom_dialog.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: const Text('Scheduling Restaurants'),
            trailing: Consumer2<SchedulingProvider, PreferencesProvider>(
              builder: (context, scheduled, pref, child) {
                return Switch.adaptive(
                  value: scheduled.isScheduled,
                  // value: pref.isScheduledRestaurant,
                  onChanged: (value) async {
                    pref.toggleScheduledRestaurant(value);
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      scheduled.scheduleRestaurants(value);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
