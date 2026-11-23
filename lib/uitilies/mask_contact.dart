/// Masks an email or phone number for display, e.g. on the OTP screen.
///
///   maskContact('mike@gmail.com')  -> 'm••••@gmail.com'
///   maskContact('+8801712345678')  -> '+88•••••••••78'
String maskContact(String? value) {
  final v = (value ?? '').trim();
  if (v.isEmpty) return 'your email';

  final at = v.indexOf('@');
  if (at > 0) {
    // Fixed 4 dots so the mask doesn't reveal the name length.
    return '${v[0]}••••${v.substring(at)}';
  }

  // Phone or other identifier: keep the first 3 and last 2 characters.
  if (v.length <= 5) return '${v[0]}${'•' * (v.length - 1)}';
  return '${v.substring(0, 3)}${'•' * (v.length - 5)}${v.substring(v.length - 2)}';
}
