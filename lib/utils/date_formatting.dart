import 'package:intl/intl.dart';

class DateFormatting {
  static String showDayOnly(DateTime date) {
    return DateFormat.d().format(date);
  }

  static String showMonthOnly(DateTime date) {
    return DateFormat.MMM().format(date);
  }

  static String mmmmddyyyy(DateTime date) {
    //July 10, 1996
    return DateFormat.yMMMMd('en_US').format(date);
  }

  static String mmmddyyyy(DateTime date) {
    //Jul 10, 1996
    return DateFormat.yMMMd('en_US').format(date);
  }

  static String dateAndTime(DateTime date) {
    //21 mar 2022, 9:00 Am
    return DateFormat('dd MMM yyyy, hh:mm a', 'en_US').format(date);
  }

  static String timeOnly(DateTime date) {
    //10:00 AM
    return DateFormat('hh:mm a').format(date);
  }

  static String timeAgo(String? dateTime) {
    try {
      if (dateTime == null || dateTime == '') return '';
      final date = DateTime.parse(dateTime);
      final dateNow = DateTime.now();
      final finalTime = date.toLocal();
      final difference = dateNow.difference(finalTime);

      if (difference.inDays > 22) {
        return '${(difference.inDays / 7).floor()}w';
      } else if ((difference.inDays / 7).floor() >= 1) {
        return '1w';
      } else if ((difference.inDays / 7).floor() >= 2) {
        return '2w';
      } else if ((difference.inDays / 7).floor() >= 3) {
        return '3w';
      } else if (difference.inDays >= 2) {
        return '${difference.inDays}d';
      } else if (difference.inDays >= 1) {
        return '1d';
      } else if (difference.inHours >= 2) {
        return '${difference.inHours}h';
      } else if (difference.inHours >= 1) {
        return '1h';
      } else if (difference.inMinutes >= 2) {
        return '${difference.inMinutes}m';
      } else if (difference.inMinutes >= 1) {
        return '1m';
      } else if (difference.inSeconds >= 3) {
        return '${difference.inSeconds}s';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return '';
    }
  }
}
