import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/bloc/firebase/firebase_bloc.dart';

import '../../res/app_strings/app_strings.dart';
import '../local_storage_screen/local_storage_view.dart';

class FirebaseView extends StatefulWidget {
  const FirebaseView({super.key});

  @override
  State<FirebaseView> createState() => _FirebaseViewState();
}

class _FirebaseViewState extends State<FirebaseView> {
  buildTextData() {
    return BlocBuilder<FirebaseBloc, FirebaseState>(
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            itemCount: state.documents.length,
            itemBuilder: (context, index) {
              final document = state.documents[index].data();
              return Column(
                children: [
                  ListTile(
                    title: state.documents[index]
                            .data()['text']
                            .toString()
                            .isEmpty
                        ? const Text(
                            AppStrings.emptyFieldText,
                            style: TextStyle(color: Colors.white),
                          )
                        : Text(
                            state.documents[index].data()['text'].toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                  ),
                  const Divider(
                    color: Colors.white70,
                    height: 1,
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    getDataFromFirebase();
    super.initState();
  }

  getDataFromFirebase() async {
    context.read<FirebaseBloc>().add(GetUserDataEvent());
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: BlocBuilder<FirebaseBloc, FirebaseState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  onChanged: (value) => context
                      .read<FirebaseBloc>()
                      .add(TextChangedEventOfFirebase(value)),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration:
                      textFieldDecoration(AppStrings.firebaseFieldHintText),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.emptyFieldText;
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.orange)),
                  onPressed: state.status == FirebaseStatus.loading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            context
                                .read<FirebaseBloc>()
                                .add(ButtonPressedEvent());
                          }
                        },
                  child: state.status == FirebaseStatus.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : const Text(
                          AppStrings.addTextButtonText,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
              buildTextData()
            ],
          );
        },
      ),
    );
  }
}
