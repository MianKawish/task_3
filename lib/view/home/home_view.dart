import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/bloc/home/home_bloc.dart';
import 'package:task_3/res/app_strings/app_strings.dart';
import 'package:task_3/view/api_screen/api_view.dart';
import 'package:task_3/view/firebase_screen/firebase_view.dart';

import '../local_storage_screen/local_storage_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.orange,
            centerTitle: true,
            title: state.currentIndex == 0
                ? const Text(
                    AppStrings.firebaseFieldHintText,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  )
                : state.currentIndex == 1
                    ? const Text(
                        AppStrings.apiScreenText,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      )
                    : const Text(
                        AppStrings.localDbScreenText,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
          ),
          body: IndexedStack(
            index: state.currentIndex,
            children: const [FirebaseView(), ApiView(), LocalStorageView()],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: state.currentIndex,
            onDestinationSelected: (value) =>
                context.read<HomeBloc>().add(BarItemIndexEvent(value)),
            backgroundColor: Colors.orange,
            indicatorColor: Colors.black,
            destinations: const [
              NavigationDestination(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: AppStrings.firebaseLabelText),
              NavigationDestination(
                  icon: Icon(Icons.person, color: Colors.white),
                  label: AppStrings.apiLabelText),
              NavigationDestination(
                  icon: Icon(Icons.person, color: Colors.white),
                  label: AppStrings.localDbLabelText),
            ],
          ),
        );
      },
    );
  }
}
