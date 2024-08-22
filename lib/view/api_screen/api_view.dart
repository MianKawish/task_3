import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/bloc/api/api_bloc.dart';

import '../../res/app_strings/app_strings.dart';
import '../local_storage_screen/local_storage_view.dart';

class ApiView extends StatefulWidget {
  const ApiView({super.key});

  @override
  State<ApiView> createState() => _ApiViewState();
}

class _ApiViewState extends State<ApiView> {
  @override
  void initState() {
    context.read<ApiBloc>().add(GetDataOfApiEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              TextFormField(
                onChanged: (value) =>
                    context.read<ApiBloc>().add(TextChangedEventOApi(value)),
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: textFieldDecoration(AppStrings.searchUserHintText),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Expanded(
                  child: state.newsModel != null
                      ? ListView.builder(
                          itemCount: state.newsModel!.articles!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    state.newsModel!.articles![index].author
                                        .toString(),
                                    style:
                                        const TextStyle(color: Colors.white70),
                                  ),
                                  leading: const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 40,
                                  ),
                                ),
                                const Divider()
                              ],
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ))
            ],
          );
        },
      ),
    );
  }
}
