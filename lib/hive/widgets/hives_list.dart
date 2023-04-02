import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jacopo_flutter_test/apiary/cubit/apiaries_counter_cubit.dart';
import 'package:jacopo_flutter_test/apiary/model/apiary.dart';
import 'package:jacopo_flutter_test/general/cubit/date_and_weight_formatter_cubit.dart';
import 'package:jacopo_flutter_test/hive/bloc/hives_bloc.dart';
import 'package:jacopo_flutter_test/hive/model/hive.dart';
import 'package:jacopo_flutter_test/hive/widgets/hive_item.dart';

class HivesList extends StatelessWidget {
  final List<Apiary> apiaries;
  final List<Hive> hives;
  const HivesList({
    Key? key,
    required this.apiaries,
    required this.hives,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocConsumer<ApiariesCounterCubit, ApiariesCounterState>(
          listener: (context, state) {
            context.read<HivesBloc>().add(FetchHives(
                  apiaryId: apiaries[state.currentApiary].id,
                  isLoadMore: true,
                ));
          },
          listenWhen: (previous, current) => previous is ApiaryIsChanging,
          builder: (context, apiariesCounterState) {
            return SizedBox(
              height: MediaQuery.of(context).size.width - 40,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: PageController(
                  viewportFraction: 1,
                  initialPage: 0,
                ),
                itemCount: apiariesCounterState.areThereOtherApiaries
                    ? hives.length + 1
                    : hives.length,
                onPageChanged: (value) {
                  if (value >= hives.length &&
                      apiariesCounterState.areThereOtherApiaries) {
                    context.read<ApiariesCounterCubit>().changeApiary(value);
                  }
                },
                itemBuilder: (context, index) {
                  if (index >= hives.length) {
                    if (apiariesCounterState.areThereOtherApiaries) {
                      return const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  } else {
                    return BlocProvider(
                      create: (context) => DateAndWeightFormatterCubit()
                        ..loadDateAndWeight(
                            hives[index].id,
                            apiaries
                                .firstWhere((element) =>
                                    element.id == hives[index].apiaryId)
                                .weights),
                      child: HiveItem(
                        apiary: apiaries.firstWhere(
                            (element) => element.id == hives[index].apiaryId),
                        hive: hives[index],
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
