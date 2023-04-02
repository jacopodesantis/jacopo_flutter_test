import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jacopo_flutter_test/apiary/model/apiary.dart';
import 'package:jacopo_flutter_test/general/cubit/date_and_weight_formatter_cubit.dart';
import 'package:jacopo_flutter_test/hive/model/hive.dart';

class HiveItem extends StatelessWidget {
  final Apiary apiary;
  final Hive hive;
  const HiveItem({
    Key? key,
    required this.apiary,
    required this.hive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            image: NetworkImage(hive.image),
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              Colors.black54,
              BlendMode.darken,
            ),
          ),
          border: Border.all(
            color: apiary.color,
            width: 2,
          ),
        ),
        height: MediaQuery.of(context).size.width * 0.6,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                hive.name,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                color: apiary.color,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(context
                          .read<DateAndWeightFormatterCubit>()
                          .state
                          .weight
                          .toString()),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'kg',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.read<DateAndWeightFormatterCubit>().state.date,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    hive.externalId,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
