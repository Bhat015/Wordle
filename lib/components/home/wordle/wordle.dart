import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/components/home/wordle/wordle_bloc.dart';
import 'package:wordle/utils/textfield_utils.dart';
import 'package:wordle/utils/utils.dart';

class Wordle extends StatelessWidget {
  static late WordleBloc _bloc;
  const Wordle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WordleBloc()..add(OnLoadWordle()),
      child: BlocConsumer<WordleBloc, WordleState>(
        listener: (context, state) {
          if (state is WordleLoaded) {
            if (!state.isFieldEnabled) {
              _showDialog(context, state.currentWord, "Congratulations!");
            }
            if (state.isFailed) {
              _showDialog(context, state.currentWord, "Opps! Try again!");
            }
          }
        },
        builder: (context, state) {
          _bloc = BlocProvider.of<WordleBloc>(context);
          if (state is WordleLoaded) {
            final isEnabled = state.isFieldEnabled;
            final greenColorsList = state.greenColor;
            final yellowColorsList = state.yellowColor;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5),
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        TextEditingController controller =
                            TextFieldUtils.instance.getController(index);
                        FocusNode focusNode =
                            TextFieldUtils.instance.getFocusNode(index);
                        return Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: greenColorsList.contains(index)
                                ? const Color.fromARGB(255, 22, 133, 25)
                                : yellowColorsList.contains(index)
                                    ? const Color.fromARGB(255, 238, 218, 41)
                                    : Colors.black12,
                            border: Border.all(
                              color: const Color.fromARGB(179, 184, 174, 174),
                              width: 1,
                            ),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: TextField(
                            enabled: isEnabled,
                            textAlign: TextAlign.center,
                            focusNode: focusNode,
                            textCapitalization: TextCapitalization.characters,
                            style: const TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            controller: controller,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                            ],
                            showCursor: false,
                            onChanged: (value) async {
                              if (Utils.isFocusShift(index, value)) {
                                if (index == 29) {
                                  FocusScope.of(context).requestFocus(
                                      TextFieldUtils.instance.getFocusNode(0));
                                } else {
                                  FocusScope.of(context).requestFocus(
                                      TextFieldUtils.instance
                                          .getFocusNode(index + 1));
                                }
                              }
                              if (Utils.isRowCompleted(index, value)) {
                                final list = Utils.getWordList(index);

                                FocusScope.of(context).requestFocus(
                                    TextFieldUtils.instance
                                        .getFocusNode(index + 1));
                                await Future.delayed(
                                    const Duration(milliseconds: 200));
                                _bloc.add(OnRowFilled(
                                    rowIndex: index, rowWord: list));
                              }
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _showDialog(BuildContext context, String word, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text('$word is the wordle word'),
          actions: [
            TextButton(
              child: const Text('Play Again'),
              onPressed: () {
                _bloc.add(OnLoadWordle());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
