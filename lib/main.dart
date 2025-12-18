import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:radio_umsu/common/bloc/connectivity_bloc.dart';
import 'package:radio_umsu/common/bloc/connectivity_state.dart';
import 'package:radio_umsu/common/routes/pages.dart';
import 'package:radio_umsu/common/widgets/flutter_toast.dart';
import 'package:radio_umsu/services/theme.dart';
import 'package:radio_umsu/services/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ConnectivityBloc()),
        ...AppPages.allBlocProviders(context),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          builder: (context, child) {
            return BlocListener<ConnectivityBloc, ConnectivityState>(
              listener: (context, state) {
                if (state is ConnectivityFailure) {
                  toastInfo(msg: "No internet connection");
                } else if (state is ConnectivitySuccess) {
                  if (state.connectionTypes.contains(ConnectivityResult.wifi)) {
                    toastInfo(msg: "Connected to Wi-Fi");
                  } else if (state.connectionTypes.contains(
                    ConnectivityResult.mobile,
                  )) {
                    toastInfo(msg: "Connected to Mobile Network");
                  } else {
                    toastInfo(
                      msg:
                          "Connected to network: ${state.connectionTypes.join(', ')}",
                    );
                  }
                }
              },
              child: EasyLoading.init()(context, child),
            );
          },

          supportedLocales: const [Locale('en'), Locale('id')],
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.currentTheme,
          onGenerateRoute: AppPages.generateRouteSettings,
        ),
      ),
    );
  }
}
