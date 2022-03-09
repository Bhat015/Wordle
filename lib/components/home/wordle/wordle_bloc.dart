import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/config.dart';
import 'package:collection/equality.dart';
import 'package:wordle/utils/textfield_utils.dart';

//Event
abstract class WordleEvent {}

class OnLoadWordle extends WordleEvent {}

class OnRowFilled extends WordleEvent {
  final int rowIndex;
  final List<String> rowWord;
  OnRowFilled({
    required this.rowIndex,
    required this.rowWord,
  });
}

//State
abstract class WordleState {}

class WordleLoading extends WordleState {}

class WordleLoaded extends WordleState {
  final String currentWord;
  final List<String> currentWordList;
  final List<int> greenColor;
  final List<int> yellowColor;
  final bool isFieldEnabled;
  final bool isFailed;
  WordleLoaded(this.currentWord, this.currentWordList,
      {this.greenColor = const [],
      this.yellowColor = const [],
      this.isFailed = false,
      this.isFieldEnabled = true});
}

//Bloc

class WordleBloc extends Bloc<WordleEvent, WordleState> {
  late String currentWord;
  late List<String> currentWordList;
  late List<int> yellowColor;
  late List<int> greenColor;
  WordleBloc() : super(WordleLoading()) {
    on<OnLoadWordle>((event, emit) {
      TextFieldUtils.instance.resetControllers();
      //get word
      yellowColor = [];
      greenColor = [];
      currentWordList = [];
      final data = Config.getWords();
      final List<String>? wordsList = data["newWord"];
      currentWord = (wordsList![Random().nextInt(68)]).toUpperCase();
      for (int i = 0; i < currentWord.length; i++) {
        currentWordList.add(currentWord[i]);
      }
      emit(WordleLoaded(currentWord, currentWordList));
    });

    on<OnRowFilled>((event, emit) {
      final rowIndex = event.rowIndex;
      final rowWord = event.rowWord;

      //get colors
      List<int> tempYellowColor = [];

      for (int i = 0; i < 5; i++) {
        if (currentWordList.contains(rowWord[i])) {
          tempYellowColor.add(rowIndex - (4 - i));
        }

        if (currentWord[i] == rowWord[i]) {
          greenColor.add(rowIndex - (4 - i));
        }
      }

      for (var element in tempYellowColor) {
        if (!greenColor.contains(element)) {
          yellowColor.add(element);
        }
      }

      if (IterableEquality().equals(rowWord, currentWordList)) {
        emit(WordleLoaded(currentWord, currentWordList,
            greenColor: greenColor,
            yellowColor: yellowColor,
            isFieldEnabled: false));
        return;
      }

      if (rowIndex == 29) {
        emit(WordleLoaded(currentWord, currentWordList,
            greenColor: greenColor,
            yellowColor: yellowColor,
            isFailed: true,
            isFieldEnabled: false));
        return;
      }

      emit(WordleLoaded(currentWord, currentWordList,
          greenColor: greenColor, yellowColor: yellowColor));
    });
  }
}
