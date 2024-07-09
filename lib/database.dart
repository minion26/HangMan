import 'dart:io';
import 'dart:convert';

class Database {
  Future<void> writeScore(DateTime date, int score) async {
    print(
        'writeScore called with date: $date, score: $score'); // Print when method is called

    // final file = File('scores.txt');
    final file = File('C:/Users/jitca/Desktop/3.2/TPPM/hangman/lib/scores.txt');
    final scoreMap = {
      'date': date.toIso8601String(),
      'score': score,
    };
    final scoreJson = jsonEncode(scoreMap);

    print('Writing data: $scoreJson'); // Print data being written

    try {
      await file.writeAsString('$scoreJson\n', mode: FileMode.append);
    } catch (e) {
      print('Error writing score: $e');
    }
  }

  Future<List<Map<String, dynamic>>> readScores() async {
    try {
      final file =
          File('C:/Users/jitca/Desktop/3.2/TPPM/hangman/lib/scores.txt');
      final lines = await file.readAsLines();
      // final lines = contents.split('\n');
      final scores = lines
          .where((line) => line.isNotEmpty)
          .map((line) => jsonDecode(line) as Map<String, dynamic>)
          .toList();
      scores.sort((a, b) => b['score'].compareTo(a['score']));
      return scores;
    } catch (e) {
      print('Error reading scores: $e');
      return [];
    }
  }
}
