//1. Palindrome Checker: Develop a Dart function to check if a given string or number is a palindrome, ignoring spaces, punctuation, and case sensitivity.

bool isPalindrome(dynamic input) {
  // Convert input to string and handle null case
  if (input == null) return false;
  String str = input.toString();

  // Clean the string: remove spaces, punctuation, and convert to lowercase
  String cleanStr = str
      .toLowerCase()
      .replaceAll(RegExp(r'[^\w\s]'), '') // Remove punctuation
      .replaceAll(RegExp(r'\s'), ''); // Remove whitespace

  // Handle empty string case
  if (cleanStr.isEmpty) return false;

  // Compare string with its reverse
  return cleanStr == cleanStr.split('').reversed.join('');
}

// Test cases to demonstrate functionality
void main() {
  // Simple palindromes
  print(isPalindrome("radar")); // true
  print(isPalindrome("level")); // true

  // Sentences with spaces and punctuation
  print(isPalindrome("A man, a plan, a canal: Panama!")); // true
  print(isPalindrome("Race a car")); // false

  // Numbers
  print(isPalindrome(12321)); // true
  print(isPalindrome(12345)); // false

  // Mixed case
  print(isPalindrome("RaCeCaR")); // true

  // Edge cases
  print(isPalindrome("")); // false
  print(isPalindrome(null)); // false
  print(isPalindrome(" ")); // false

  // Special characters
  print(isPalindrome("©radar©")); // true
  print(isPalindrome("!@#\$%")); // false
}
