/// Formats a [DateTime] as a relative label for activity-style lists:
/// "Today", "Yesterday", or "MMM d" (e.g. "Oct 24").
String formatRelativeDate(DateTime date, {DateTime? now}) {
  final today = now ?? DateTime.now();
  final normalizedToday = DateTime(today.year, today.month, today.day);
  final normalizedDate = DateTime(date.year, date.month, date.day);
  final difference = normalizedToday.difference(normalizedDate).inDays;

  if (difference == 0) return 'Today';
  if (difference == 1) return 'Yesterday';

  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${months[date.month - 1]} ${date.day}';
}

/// Formats a [DateTime] for a date picker field: "Today, Oct 24" for
/// today, otherwise "Oct 20".
String formatDateLabel(DateTime date, {DateTime? now}) {
  final relative = formatRelativeDate(date, now: now);
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final monthDay = '${months[date.month - 1]} ${date.day}';
  return relative == 'Today' ? '$relative, $monthDay' : monthDay;
}
