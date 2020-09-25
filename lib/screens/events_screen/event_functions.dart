class EventFunctions {

  final String base ="http://fst-app-2.herokuapp.com";

  String _dateConversion(String date) {

      List<int> numMonths = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
      List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July',
                            'August', 'September', 'October', 'November', 'December'];
      String year = date.substring(0, 4);
      String day = date.substring(8, 10);
      int pos = numMonths.indexOf(int.parse(date.substring(5,7)));
      String month = months[pos];

      return month + ' ' + day + ', ' + year;

    }

    String _timeConversion(String time) {

      List<String> afternoonTimes = ['12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'];
      List<String> convertedTimes = ['12', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11'];

      String hour = time.substring(0,2);
      String minute = time.substring(3, 5);
      String convertedHour;

      if (afternoonTimes.contains(hour)) {
        int pos = afternoonTimes.indexOf(hour);
        convertedHour = convertedTimes[pos];
        return convertedHour + ':' + minute + ' PM';
      }

      if (hour == '00') {
        return '12:' + minute + ' AM';
      }

      return hour + ':' + minute + ' AM';
    }

    String name(dynamic event) {
      return event['name'];
    }

    String startDate(dynamic event) {
      return _dateConversion(event['start_date_time'].substring(0, 10));
    }

    String startTime(dynamic event) {
      return _timeConversion(event['start_date_time'].substring(11,16));
    }

    String endDate(dynamic event) {
      return _dateConversion(event['end_date_time'].substring(0, 10));
    }

    String endTime(dynamic event) {
      return _timeConversion(event['end_date_time'].substring(11,16));
    }

    String location(dynamic event) {
      return event['location'];
    }

    String posterImage(dynamic event) {
      return base + event['poster_image'];
    }
}