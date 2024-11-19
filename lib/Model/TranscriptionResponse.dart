class TranscriptionResponse {
  final String transcription;
  final double accuracy;
  final List<DetailedResult> detailedResult;
  final int index;

  TranscriptionResponse({
    required this.transcription,
    required this.accuracy,
    required this.detailedResult,
    required this.index,
  });

  factory TranscriptionResponse.fromJson(Map<String, dynamic> json) {
    return TranscriptionResponse(
      transcription: json['transcription'],
      accuracy: double.tryParse(json['accuracy'].toString()) ?? 0.0,
      detailedResult: List<DetailedResult>.from(
        json['detailedResult'].map((x) => DetailedResult.fromJson(x)),
      ),
      index: json['index'],
    );
  }
}

class DetailedResult {
  final String word;
  final bool correct;

  DetailedResult({
    required this.word,
    required this.correct,
  });

  factory DetailedResult.fromJson(Map<String, dynamic> json) {
    return DetailedResult(
      word: json['word'],
      correct: json['correct'],
    );
  }
}
