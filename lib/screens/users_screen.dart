import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/model/users_model.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/users_widget.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Users"),
        elevation: 3,
      ),
      body: FutureBuilder<List<UsersModel>>(
        future: APIHandler.getAllUsers(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            Center(
              child: Text('An error occurred ${snapshot.error}'),
            );
          } else if (snapshot.data == null) {
            const Center(
              child: Text('No users has been added yet!}'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              return ChangeNotifierProvider.value(
                value: snapshot.data![index],
                child: const UsersWidget(),
              );
            },
          );
        }),
      ),
    );
  }
}
