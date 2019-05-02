import 'package:flutter/material.dart';
import 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({Key key, Widget child})
    : bloc = StoriesBloc(),
      super(key: key, child: child);
  
  // when we don't care about the argument of the function we represent it with a underscore
  bool updateShouldNotify(_) => true;

  static StoriesBloc of(BuildContext context) {
      return (context.inheritFromWidgetOfExactType(StoriesProvider) as StoriesProvider).bloc;
  }

}