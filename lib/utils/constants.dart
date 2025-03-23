String greetingText() {
  DateTime hour = DateTime.now();
  if (hour.hour < 12) {
    return 'Good Morning,';
  } else if (hour.hour < 17) {
    return 'Good Afternoon,';
  }
  return 'Good Evening,';
}

// untuk category
final List<String> categories = [
  'Work',
  'Personal',
  'Shopping',
  'Travel',
  'Food',
  'Grocery',
  'Entertainment',
  'Meeting',
  'Study',
  'Health',
  'Others',
];
