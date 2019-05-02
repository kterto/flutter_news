import 'package:flutter/material.dart';
import 'dart:async';
import '../blocs/stories_provider.dart';
import '../widgets/new_list_tile.dart';

class NewsList extends StatelessWidget {
  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }
}

Widget buildList(StoriesBloc bloc) {
  return StreamBuilder(
    stream: bloc.topIds,
    builder: (context, AsyncSnapshot<List<int>> snapshot) {
      if(!snapshot.hasData) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return ListView.builder(
        itemCount: 1000,
        itemBuilder: (context, int index) {
          return NewsListTile(itemId: snapshot.data[index],);
        },  
      );
    },
  );
}