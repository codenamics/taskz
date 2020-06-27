import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:tazks/provider/Task.dart';
import 'package:tazks/provider/Tasks.dart';
import 'package:tazks/screens/Form.dart';
import 'package:tazks/screens/MainTasksScreen.dart';
import 'package:tazks/screens/AuthScreen.dart';
import 'package:tazks/screens/TaskDetails.dart';
import 'package:permission_handler/permission_handler.dart';



final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  PermissionStatus _status;
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.notification)
        .then(_updateStatus);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      PermissionHandler()
          .checkPermissionStatus(PermissionGroup.notification)
          .then(_updateStatus);
      print('resumed');
    }
    if (state == AppLifecycleState.detached) {
      print('detached');
    }
    if (state == AppLifecycleState.inactive) {
      print('inactive');
    }
    if (state == AppLifecycleState.paused) {
      print('paused');
    }
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      setState(() {
        _status = status;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Tasks(),
        ),
        ChangeNotifierProvider.value(
          value: Task(),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home:  AuthScreen(),
        supportedLocales: [
          const Locale('en'),
          const Locale('pl'),
        ],
        routes: {
          MainTasksScreen.routeName: (ctx) => MainTasksScreen(),
          EditTaskScreen.routeName: (ctx) => EditTaskScreen(),
          TaskDetails.routeName: (ctx) => TaskDetails(_status)
        },
      ),
    );
  }

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) {
    final status = statuses[PermissionGroup.notification];
    if (status != PermissionStatus.granted) {
      // On iOS if "deny" is pressed, open App Settings
      PermissionHandler().openAppSettings();
    } else {
      _updateStatus(status);
    }
  }

  void _askPermission() {
    PermissionHandler().requestPermissions(
        [PermissionGroup.notification]).then(_onStatusRequested);
  }

}
