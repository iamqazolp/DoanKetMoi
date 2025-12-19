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
      child: MaterialApp(
        title: 'Sorting Visualizer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          textTheme: GoogleFonts.robotoMonoTextTheme(),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
