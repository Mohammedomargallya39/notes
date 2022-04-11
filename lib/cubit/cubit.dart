import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  Database? database;
  List<Map> notes = [];

  void createDB()
  {
     openDatabase(
        'notes.db',
        version: 1,
        onCreate: (database, version)
        {
          /// id integer
          /// title String
          /// note String
          /// date String
          /// time String
          /// status String

          debugPrint('DB Created');
          database.execute(
              'CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, note TEXT, date TEXT, time TEXT, status TEXT)'
          ).then((value)
          {
            debugPrint('Table created');
          }
          ).catchError((error)
          {
            debugPrint(error.toString());
          });
        },
        onOpen: (database)
        {
          getNotesFromDB(database).then((value)
          {
            notes = value;
            emit(AppGetDBState());
            debugPrint(notes.length.toString());
            debugPrint(notes.toString());
          });
          debugPrint('DB Opened');
        }
    ).then((value)
    {
      database = value;
      emit(AppCreateDBState());
    });
  }

  void insertToDB({
    required String title,
    required String note,
    required String date,
    required String time
  }) async
  {
     await database!.transaction((txn)
    {
      return txn.rawInsert(
          'INSERT INTO notes(title, note, date, time, status) VALUES("$title","$note","$date","$time","new")'
      ).then((value)
      {
        debugPrint('$value inserted successfully');
        emit(AppInsertDBState());
        getNotesFromDB(database).then((value)
        {
          notes = value;
          emit(AppGetDBState());
          debugPrint(notes.length.toString());
          debugPrint(notes.toString());
        });
        debugPrint('DB Opened');
      }).catchError((error)
      {
        debugPrint(error.toString());
      });
    });
  }

  Future<List<Map>> getNotesFromDB(database) async
  {
    return await database!.rawQuery('SELECT * FROM notes');
  }

  void deleteFromDB(
  {
    required int id,
  })async
  {
    database!.rawDelete(
        'DELETE FROM notes WHERE id = ?',[id]
    ).then((value)
    {
      getNotesFromDB(database);
      emit(AppDeleteDBState());
      getNotesFromDB(database);
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheet(
  {
  required bool isShow,
  required IconData icon,
})
  {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}




