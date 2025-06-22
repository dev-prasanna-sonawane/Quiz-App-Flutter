import 'dart:convert';
import 'result_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Quiz_Application extends StatelessWidget {
  const Quiz_Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Application',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      routes: {'/quiz_app': (context) => Quiz_Application()},
      home: Quiz_ApplicationStateful(),
    );
  }
}

class Quiz_ApplicationStateful extends StatefulWidget {
  const Quiz_ApplicationStateful({super.key});

  @override
  State<StatefulWidget> createState() {
    return Quiz_ApplicationStatefulState();
  }
}

class Quiz_ApplicationStatefulState extends State {
  var fontFamily = 'BalooBhai2';
  String apiKey = dotenv.env['API_KEY'] ?? '';
  String? question, correctAnswer;
  Map<String, dynamic> answers = {};
  Map<String, dynamic> correctAnswers = {};
  int correctAnswerCount = 0;
  int _currentQuestion = 1;

  Color buttonColor = Colors.black87;
  // Color buttonColor = const Color.fromARGB(255, 70, 76, 150);
  Color correctColor = const Color.fromARGB(255, 20, 86, 22);
  Color incorrectColor = const Color.fromARGB(255, 214, 39, 27);
  late String selectedAnswer;
  bool isAnswered = false;

  @override
  void initState() {
    super.initState();
    fetchQuiz();
  }

  Future<void> fetchQuiz() async {
    final response = await http.get(
      Uri.parse("https://quizapi.io/api/v1/questions"),
      headers: {'Content-Type': 'application/json', 'X-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.isNotEmpty) {
        Map<String, dynamic> quiz = jsonData[0];
        // print(quiz);
        setState(() {
          question = quiz['question'];
          answers = quiz['answers'];
          correctAnswers = quiz['correct_answers'];
        });
      } else {
        setState(() {
          question = 'No Questions Available.';
          answers = {};
          correctAnswers = {};
        });
      }
    } else {
      setState(() {
        question = 'Failed to load data(${response.statusCode})';
        answers = {};
        correctAnswers = {};
      });
    }
  }

  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz App',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
                MediaQuery.of(context).size.height -
                kToolbarHeight -
                MediaQuery.of(context).padding.top,
          ),
          child: Container(
            // decoration: BoxDecoration(color: Color.fromARGB(255, 18, 18, 18)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color.fromARGB(255, 12, 53, 86),
                  Colors.deepPurple,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 15, left: 15),
              child:
                  (question == null || answers.isEmpty)
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                        // spacing: 10,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // spacing: 5,
                            children: [
                              Text(
                                'Question: ',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: fontFamily,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '$_currentQuestion',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: fontFamily,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          Center(
                            child: Text(
                              question ?? 'Loading...',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                fontFamily: fontFamily,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 20),
                          Column(
                            children: [
                              for (var key in [
                                'answer_a',
                                'answer_b',
                                'answer_c',
                                'answer_d',
                              ])
                                if (answers[key] != null)
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        elevation: WidgetStatePropertyAll(2.0),
                                        backgroundColor: WidgetStatePropertyAll(
                                          isAnswered && selectedAnswer == key
                                              ? (correctAnswers['${key}_correct'] ==
                                                      'true'
                                                  ? correctColor
                                                  : incorrectColor)
                                              : buttonColor,
                                        ),
                                      ),
                                      onPressed:
                                          isAnswered
                                              ? null
                                              : () {
                                                setState(() {
                                                  isAnswered = true;
                                                  selectedAnswer = key;
                                                  if (correctAnswers['${key}_correct'] ==
                                                      'true') {
                                                    correctAnswerCount++;
                                                  }
                                                });
                                              },
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          answers[key] ?? '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: fontFamily,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ],
                      ),
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'nextBtn',
            backgroundColor: buttonColor,
            onPressed: () {
              setState(() {
                isAnswered = false;
                selectedAnswer = '';
                _currentQuestion++;
              });
              fetchQuiz();
            },
            child: Icon(Icons.forward_rounded),
          ),
          SizedBox(width: 10),

          FloatingActionButton.extended(
            heroTag: 'submitBtn',
            backgroundColor: buttonColor,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return ResultPage(
                      correctAnswers: correctAnswerCount,
                      totalQuestions: _currentQuestion,
                    );
                  },
                ),
              );
            },
            label: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
