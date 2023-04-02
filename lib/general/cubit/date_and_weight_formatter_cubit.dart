import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateAndWeightFormatterState extends Equatable {
  final String date;
  final num weight;
  const DateAndWeightFormatterState({
    this.date = '',
    this.weight = 0,
  });

  @override
  List<Object> get props => [date, weight];

  DateAndWeightFormatterState copyWith({String? date, num? weight}) {
    return DateAndWeightFormatterState(
      date: date ?? this.date,
      weight: weight ?? this.weight,
    );
  }
}

class DateAndWeightFormatterCubit extends Cubit<DateAndWeightFormatterState> {
  DateAndWeightFormatterCubit() : super(const DateAndWeightFormatterState());

  void loadDateAndWeight(int hiveId, Map<String, dynamic> weights) {
    initializeDateFormatting();
    if (weights[hiveId.toString()] is Map<String, dynamic>) {
      List<String> timestamps = weights[hiveId.toString()].keys.toList();
      List<int> convertedTimestamps =
          timestamps.map((e) => int.parse(e)).toList();
      convertedTimestamps.sort((a, b) => b.compareTo(a));
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(convertedTimestamps[0] * 1000);
      String formattedDate = DateFormat('d MMM', 'it').format(date);

      final weight = double.parse((weights[hiveId.toString()]
              [convertedTimestamps[0].toString()])
          .toStringAsFixed(2));
      emit(state.copyWith(
        date: formattedDate,
        weight: weight,
      ));
    }
  }
}
