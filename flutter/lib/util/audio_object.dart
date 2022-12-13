class AudioObject {
  final String title;
  final String subtitle;
  final String img;

  const AudioObject(this.title, this.subtitle, this.img);
}

double valueFromPercentageInRange({
  required double min,
  required double max,
  required double percentage,
}) {
  return percentage * (max - min) + min;
}

double percentageFromValueInRange({
  required double min,
  required double max,
  required double value,
}) {
  return (value - min) / (max - min);
}
