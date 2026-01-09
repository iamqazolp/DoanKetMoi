import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'viewmodels/sorting_viewmodel.dart';
import 'views/home_page.dart';

void main() {
  runApp(const SortingApp());
}

class SortingApp extends StatelessWidget {
  const SortingApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SortingViewModel()),
      ],
      child: Consumer<SortingViewModel>(
        builder: (context, vm, child) {
          return MaterialApp(
            title: 'Sorting Visualizer',
            debugShowCheckedModeBanner: false,
            // Light Theme
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blueGrey,
              scaffoldBackgroundColor: const Color(0xFFF5F5F5),
              textTheme: GoogleFonts.robotoMonoTextTheme(),
              useMaterial3: true,
            ),
            // Dark Theme
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blueGrey,
              scaffoldBackgroundColor: const Color(0xFF1E1E1E),
              textTheme: GoogleFonts.robotoMonoTextTheme(ThemeData.dark().textTheme),
              useMaterial3: true,
            ),
            // Dynamic Theme Mode
            themeMode: vm.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

