# Quiz App Flutter

A simple and modern quiz application built with Flutter. This app fetches quiz questions from the [QuizAPI.io](https://quizapi.io/) and displays them with multiple-choice answers. Users can answer questions, see their results, and enjoy a smooth, responsive UI.

---

## Features

- Fetches quiz questions from a public API
- Multiple-choice answer buttons
- Shows correct/incorrect answers with color feedback
- Tracks score and displays results
- Modern dark theme with gradient backgrounds
- Responsive design for mobile devices

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- A valid [QuizAPI.io](https://quizapi.io/) API key

### Installation

1. **Clone the repository:**
   ```sh
   git clone git@github.com:dev-prasanna-sonawane/Quiz-App-Flutter.git
   cd Quiz-App-Flutter
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Set up your API key:**
   - Create a `.env` file in the project root:
     ```
     API_KEY=your_quizapi_key_here
     ```
   - **Do not commit your `.env` file to version control.**

4. **Run the app:**
   ```sh
   flutter run
   ```

---

## Usage

- The app will load a quiz question from the API.
- Tap an answer to select it. The button color will indicate if you were correct.
- Use the "Next" button to load a new question.
- Tap "Submit" to see your results.

---

## Environment Variables

This app uses [`flutter_dotenv`](https://pub.dev/packages/flutter_dotenv) to manage the API key.  
**Never commit your API key to public repositories.**

---

## Credits

- [QuizAPI.io](https://quizapi.io/) for providing the quiz data.
- Flutter and Dart teams for the awesome framework.

---

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.
