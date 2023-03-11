String convertDateToString(DateTime date) {
  String day = date.day.toString();
  if(day.length == 1) {
    day = '0$day';
  }

  String month = date.month.toString();
  if(month.length == 1) {
    month = '0$month';
  }

  String year = date.year.toString();

  return '$year$month$day';

}