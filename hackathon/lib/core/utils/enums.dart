

//lesson plan status enums
enum LessonPlanStatus {
  viewAll("View All", slug: 'view_all'),
  newEntries("New Enteries", slug: 'new_lesson_plans'),
  live("Live Lesson Plans", slug: 'live_lesson_plans'),
  approved("Approved Lesson Plans", slug: 'approved_lesson_plans');

  const LessonPlanStatus(
    this.value, {
    required this.slug,
  });
  final String value;
  final String slug;
}
