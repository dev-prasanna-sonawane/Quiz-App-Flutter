import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  const ResultPage({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    bool isPassed;
    if (correctAnswers <= 1) {
      isPassed = false;
    } else {
      isPassed = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Result',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pushNamed(context, '/quiz_app');
          },
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [const Color.fromARGB(255, 12, 53, 86), Colors.deepPurple],
          ),
        ),
        child:
            isPassed
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.network(
                        'https://www.bing.com/th/id/OIP.QTYWJcxE3wf4GmIOrHZkaAHaJk?w=160&h=211&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
                        height: 300,
                        width: 300,
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Congratulations',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: Text(
                        'You Scored $correctAnswers/$totalQuestions',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.network(
                        'https://th.bing.com/th/id/OIP.P_Vn9D5hkFpKa4EM7VhpWwHaG2?cb=iwc2&rs=1&pid=ImgDetMain',
                        height: 300,
                        width: 300,
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You Failed the Quiz,',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' Please Retry!!',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: Text(
                        'You Scored $correctAnswers/$totalQuestions',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
