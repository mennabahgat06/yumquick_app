/// Greeting + meal message by the time of day.
class GreetingHelper {
  static String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 18) return 'Good Afternoon';
    return 'Good Evening';
  }

  static String mealMessage() {
    final hour = DateTime.now().hour;
    if (hour < 11) return "Rise And Shine! It's Breakfast Time";
    if (hour < 17) return "Hungry? It's Lunch Time";
    return "Relax! It's Dinner Time";
  }
}
