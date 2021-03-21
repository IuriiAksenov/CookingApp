class Helpers {
  static String formatDurationString(String duration) {
    var result = '';
    final parts = duration.split(':');
    var hours = parts[0];
    var minutes = parts[1];

    if (hours[0] != '0' || hours[1] != '0') {
      if (hours[0] == '0') {
        hours = hours.substring(1);
      }
      result = hours + 'h ';
    }

    if (minutes[0] != '0' || minutes[1] != '0') {
      if (minutes[0] == '0') {
        minutes = minutes.substring(1);
      }

      result += minutes + 'min';
    }

    if (result == '') {
      result = '0 min';
    }

    return result;
  }
}
