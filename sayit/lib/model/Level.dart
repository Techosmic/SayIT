class Level {
    int levelNumber;
    int difficulty;

    Level({
        this.levelNumber,
    });

    factory Level.fromJson(Map<String, dynamic> json) => Level(
        levelNumber: json["levelNumber"],
    );

    Map<String, dynamic> toJson() => {
        "levelNumber": levelNumber,
    };
}
