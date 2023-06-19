import 'package:flutter/material.dart';

import '../data/userModel.dart';
import '../service/fetchApi.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<Users> users = [];
  List<Users> searchedUsers = [];
  final AppServices _appServices = AppServices();
  @override
  void initState() {
    _appServices.getUsers().then((fetchedUsers) {
      setState(() {
        users = fetchedUsers;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Users (${users.length})",
            style: textTheme.displaySmall!
                .copyWith(color: Colors.blueAccent, fontSize: 16)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchField(
              onChanged: (val) {
                applySearch(val);
              },
            ),
          ),

          //Default List
          searchedUsers.isEmpty
              ? UserList(typeOfUserList: users, textTheme: textTheme)
              : UserList(typeOfUserList: searchedUsers, textTheme: textTheme)
        ],
      ),
    );
  }

  void applySearch(String query) {
    setState(() {
      searchedUsers = users
          .where((element) =>
              element.name!.toLowerCase().contains(query) ||
              element.address!.street!.toLowerCase().contains(query) ||
              element.address!.city!.toLowerCase().contains(query))
          .toList();
    });
  }
}

class SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: 'Search',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
    );
  }
}

class UserList extends StatelessWidget {
  final List<Users> typeOfUserList;
  final TextTheme textTheme;
  const UserList(
      {super.key, required this.typeOfUserList, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: typeOfUserList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              typeOfUserList[index].name!,
              style: textTheme.displaySmall!
                  .copyWith(fontSize: 13, color: Colors.black),
            ),
            subtitle: Text(
              '${typeOfUserList[index].address!.street!}, ${typeOfUserList[index].address!.city!}',
              style: textTheme.displaySmall!.copyWith(fontSize: 12),
            ),
          );
        },
      ),
    );
  }
}
