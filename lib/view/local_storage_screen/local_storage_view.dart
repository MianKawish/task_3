import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/res/app_strings/app_strings.dart';

import '../../bloc/hive/hive_bloc.dart';

class LocalStorageView extends StatefulWidget {
  const LocalStorageView({super.key});

  @override
  State<LocalStorageView> createState() => _LocalStorageViewState();
}

class _LocalStorageViewState extends State<LocalStorageView> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<HiveBloc>().add(GetUserDataForHiveEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: BlocBuilder<HiveBloc, HiveState>(
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
                      .read<HiveBloc>()
                      .add(TextChangedEventOfHive(value)),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration:
                      textFieldDecoration(AppStrings.localStorageFieldHintText),
                  validator: (value) {
                    if (value!.length < 1 || value.isEmpty) {
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
                  onPressed: state.status == HiveDataStatus.loading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            context.read<HiveBloc>().add(AddDataToHive());
                          }
                        },
                  child: state.status == HiveDataStatus.loading
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
              Expanded(
                  child: state.hiveDataList.isEmpty
                      ? const Center(
                          child: Text(AppStrings.hiveNoDataText),
                        )
                      : ListView.builder(
                          itemCount: state.hiveDataList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.person_3_outlined),
                                  title: Text(
                                    state.hiveDataList[index].toString(),
                                    style: const TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  color: Colors.white54,
                                )
                              ],
                            );
                          },
                        ))
            ],
          );
        },
      ),
    );
  }
}

InputDecoration textFieldDecoration(String title) {
  return InputDecoration(
    hintStyle: const TextStyle(color: Colors.white),
    hintText: title,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.orange, width: 1.5)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.orange, width: 1.5)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.orange, width: 1.5)),
  );
}
