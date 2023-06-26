import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smoke/screens/result_screen.dart';
import './Screens/signupscr.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './providers/operator.dart';
import './screens/search_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(MyApp()),
  );
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, Operator>(
            create: (context) => Operator("", ""),
            update: (context, value, previous) =>
                Operator(value.userId, value.token))
      ],
      child: Consumer<Auth>(
        builder: (context, value, _) => MaterialApp(
          home: value.isAuth
              ? Consumer<Operator>(
                  builder: (context, value1, _) => const Search())
              : FutureBuilder(
                  future: value.tryAutoLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Scaffold()
                          : SignUpScr()),
          theme: ThemeData(
            primaryColorDark: Colors.black,
            primaryColorLight: const Color.fromARGB(255, 12, 12, 12),
            scaffoldBackgroundColor: const Color.fromARGB(255, 250, 250, 255),
            appBarTheme: const AppBarTheme(
                color: Colors.green,
                titleTextStyle: TextStyle(color: Colors.white)),
          ),
          routes: {
            Search.route: (context) => const Search(),
          },
        ),
      ),
    );
  }
}
