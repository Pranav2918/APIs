import 'package:flutter/material.dart';
import 'package:searchwithapi/service/fetchApi.dart';

import '../Users API/users.dart';
import '../data/musicModel.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final AppServices _appServices = AppServices();
  List<Results> musicResults = [];
  List<Results> searchedMusics = [];
  bool _isLiked = false;

  @override
  void initState() {
    _appServices.getMusics().then((fetchedMusics) {
      setState(() {
        musicResults = fetchedMusics;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SearchField(onChanged: (query) {
                applySearch(query);
              }),
              searchedMusics.isEmpty
                  ? MusicList(
                      isLiked: _isLiked,
                      typeOfUserList: musicResults,
                      textTheme: textTheme)
                  : MusicList(
                      typeOfUserList: searchedMusics, textTheme: textTheme)
            ],
          ),
        ),
      ),
    );
  }

  void applySearch(String query) {
    setState(() {
      searchedMusics = musicResults
          .where((element) =>
              element.artistName!.toLowerCase().contains(query) ||
              element.trackName!.toLowerCase().contains(query))
          .toList();
    });
  }
}

//Music List
class MusicList extends StatefulWidget {
  final List<Results> typeOfUserList;
  final TextTheme textTheme;
  bool? isLiked;
  MusicList(
      {super.key,
      required this.typeOfUserList,
      required this.textTheme,
      this.isLiked});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.typeOfUserList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network(
                    widget.typeOfUserList[index].artworkUrl100!,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover)),
            title: Text(
              widget.typeOfUserList[index].trackName!,
              style: widget.textTheme.displaySmall!
                  .copyWith(fontSize: 13, color: Colors.black),
            ),
            subtitle: Text(
              widget.typeOfUserList[index].artistName!,
              style: widget.textTheme.displaySmall!.copyWith(fontSize: 12),
            ),
          );
        },
      ),
    );
  }
}
