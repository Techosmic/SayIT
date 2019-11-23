class Level {
    int levelNumber;
    List<String> words;
    bool unlocked;
    String difficulty;

    Level({
        this.levelNumber,
        this.words,
        this.unlocked,
    });

    factory Level.fromJson(Map<String, dynamic> json) => Level(
        levelNumber: json["levelNumber"],
        words: List<String>.from(json["words"].map((x) => x)),
        unlocked: json["unlocked"],
    );

    Map<String, dynamic> toJson() => {
        "levelNumber": levelNumber,
        "words": List<dynamic>.from(words.map((x) => x)),
        "unlocked": unlocked,
    };
}