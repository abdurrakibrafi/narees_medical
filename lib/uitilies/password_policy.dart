/// Password rules used by every screen that sets a password
/// (sign up, create new password, change password).
class PasswordRule {
  const PasswordRule(this.label, this.test);

  final String label;
  final bool Function(String) test;
}

class PasswordPolicy {
  PasswordPolicy._();

  static const int minLength = 8;
  static const int recommendedLength = 12;

  static final List<PasswordRule> rules = [
    PasswordRule('At least $minLength characters', (p) => p.length >= minLength),
    PasswordRule('One uppercase letter (A–Z)', (p) => RegExp(r'[A-Z]').hasMatch(p)),
    PasswordRule('One lowercase letter (a–z)', (p) => RegExp(r'[a-z]').hasMatch(p)),
    PasswordRule('One number (0–9)', (p) => RegExp(r'[0-9]').hasMatch(p)),
    PasswordRule('One special character (!@#\$…)',
        (p) => RegExp(r'[^A-Za-z0-9\s]').hasMatch(p)),
  ];

  static bool isValid(String password) => rules.every((r) => r.test(password));

  /// Message for the first unmet rule, or null when the password is valid.
  static String? validate(String password) {
    for (final rule in rules) {
      if (!rule.test(password)) {
        final l = rule.label;
        return 'Password needs ${l[0].toLowerCase()}${l.substring(1)}';
      }
    }
    return null;
  }
}
