class DateCalculator {
  int daysAgo(String createdAt) {
    final currentDate = DateTime.now();
    final createdAtDate = DateTime.parse(createdAt);
    final dateDiff = currentDate.difference(createdAtDate);
    return dateDiff.inDays;
  }
}
