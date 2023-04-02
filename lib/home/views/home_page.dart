import 'package:flutter/material.dart';
import 'package:jacopo_flutter_test/apiary/bloc/apiaries_bloc.dart';
import 'package:jacopo_flutter_test/apiary/cubit/apiaries_counter_cubit.dart';
import 'package:jacopo_flutter_test/hive/bloc/hives_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jacopo_flutter_test/hive/widgets/hives_list.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<ApiariesBloc>().add(FetchApiaries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ApiariesBloc, ApiariesState>(
        listener: (context, state) {
          if (state is ApiariesLoaded && state.apiaries.isNotEmpty) {
            context
                .read<ApiariesCounterCubit>()
                .initApiariesCounter(apiariesLenght: state.apiaries.length);
            context.read<HivesBloc>().add(
                  FetchHives(
                    apiaryId: state.apiaries[0].id,
                    isLoadMore: false,
                  ),
                );
          }
        },
        listenWhen: (previous, current) => previous is ApiariesLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocBuilder<ApiariesBloc, ApiariesState>(
              builder: (context, apiariesState) {
                if (apiariesState is ApiariesLoaded) {
                  return BlocBuilder<HivesBloc, HivesState>(
                    builder: (context, hivesState) {
                      if (hivesState is HivesLoaded) {
                        return HivesList(
                          apiaries: apiariesState.apiaries,
                          hives: hivesState.hives,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  );
                } else if (apiariesState is ApiariesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
