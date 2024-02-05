import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateTimeUtils {
  /// Initialize untuk mendapatkan format tanggal lokal
  static Future initialize() async {
    await initializeDateFormatting();
  }

  /// mengembalikan dateformat berdasarkan local date format
  /// isi [tanggal] dengan DateTime atau TimeStamp
  /// [format] default =  dd MMMM yyyy , hasil : 12 Juni 2002
  static String dateFormat(dynamic tanggal,
      {String format = 'dd MMMM yyyy', String locale = 'id'}) {
    String hasil = '';
    if (tanggal is DateTime) {
      hasil = DateFormat(format, locale).format(tanggal).toString();
    } else if (tanggal is Timestamp) {
      hasil = DateFormat(format, locale)
          .format(Timestamp(tanggal.seconds, tanggal.nanoseconds).toDate())
          .toString();
    } else {}
    return hasil;
  }

  static String? newDateFormat(dynamic tanggal,
      {String format = 'dd MMMM yyyy', String locale = 'id'}) {
    String? hasil;
    if (tanggal is DateTime) {
      hasil = DateFormat(format, locale).format(tanggal).toString();
    } else if (tanggal is Timestamp) {
      hasil = DateFormat(format, locale)
          .format(Timestamp(tanggal.seconds, tanggal.nanoseconds).toDate())
          .toString();
    } else {}
    return hasil;
  }

  static String? dateLogFormat(dynamic tanggal,
      {String format = 'dd/MM/yyyy', String locale = 'id'}) {
    String? hasil;
    DateTime now = DateTime.now();
    if (tanggal is DateTime) {
      if (dateFormat(tanggal) == dateFormat(now)) {
        hasil = 'common.today'.tr();
      } else if (dateFormat(now.add(const Duration(days: -1))) ==
          dateFormat(tanggal)) {
        hasil = 'common.yesterday'.tr();
      } else {
        hasil = dateFormat(tanggal, format: format, locale: locale);
      }
    } else if (tanggal is Timestamp) {
      DateTime date = Timestamp(tanggal.seconds, tanggal.nanoseconds).toDate();

      if (dateFormat(date) == dateFormat(now)) {
        hasil = 'common.today'.tr();
      } else if (dateFormat(now.add(const Duration(days: -1))) ==
          dateFormat(date)) {
        hasil = 'common.yesterday'.tr();
      } else {
        hasil = dateFormat(date, format: format, locale: locale);
      }
    } else {}
    return hasil;
  }

  /// mengembalikan nilai DateTime dari TimeStamp [timeStamp]
  static DateTime timestampToDateTime({required Timestamp timeStamp}) {
    return DateTime.fromMillisecondsSinceEpoch(
        timeStamp.millisecondsSinceEpoch);
  }

  static DateTime? newTimestampToDateTime({required Timestamp? timeStamp}) {
    if (timeStamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(
          timeStamp.millisecondsSinceEpoch);
    } else {
      return null;
    }
  }

  /// Mengembalikan Durasi perbandingan antara [tanggala] dan [tanggalb]
  /// Isi [tanggala] maupun [tanggalb] dengan DateTime ataupun TimeStamp
  static Duration differenceTime(dynamic tanggalAwal, dynamic tanggalAkhir) {
    DateTime awal, akhir;

    if (tanggalAwal is DateTime) {
      awal = tanggalAwal;
    } else if (tanggalAwal is Timestamp) {
      awal = Timestamp(tanggalAwal.seconds, tanggalAwal.nanoseconds).toDate();
    } else {
      return const Duration(milliseconds: 0);
    }

    if (tanggalAkhir is DateTime) {
      akhir = tanggalAkhir;
    } else if (tanggalAkhir is Timestamp) {
      akhir =
          Timestamp(tanggalAkhir.seconds, tanggalAkhir.nanoseconds).toDate();
    } else {
      return const Duration(milliseconds: 0);
    }

    Duration duration = akhir.difference(awal);
    return duration;
  }

  static DateTime? toDateTime(dynamic tanggal) {
    if (tanggal is Timestamp) {
      // print('timestamp : ${timestampToDateTime(tanggal)}');
      return timestampToDateTime(timeStamp: tanggal);
    }
    if (tanggal is String) {
      return DateTime.tryParse(tanggal);
    }
    if (tanggal is DateTime) {
      return tanggal;
    }
    return null;
  }
}
