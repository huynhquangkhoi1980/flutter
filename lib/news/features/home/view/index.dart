import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/app/utils/configs/custom_scroll_behavior.dart';
import 'package:mevn_app/news/features/home/bloc/home_bloc.dart';
import 'package:mevn_app/news/features/home/bloc/home_state.dart';

class ListNewsScreen extends StatefulWidget {
  const ListNewsScreen({Key? key}) : super(key: key);
  @override
  State<ListNewsScreen> createState() => _ListNewsScreenState();
}

class _ListNewsScreenState extends State<ListNewsScreen> {
  late HomeBloc? _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(locator.get());
  }

  @override
  Widget build(BuildContext context) {
    // return ListView.separated(
    //   shrinkWrap: true,
    //   physics: const CustomScrollBehavior().getScrollPhysics(context),
    //   itemCount: 10,
    //   separatorBuilder: (BuildContext context, int index) => Divider(
    //     height: 0,
    //     thickness: 12,
    //     color: Colors.grey[400],
    //   ),
    //   itemBuilder: (_, index) => Card(
    //     color: Colors.transparent,
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(4),
    //       ),
    //     ),
    //     elevation: 0,
    //     margin: EdgeInsets.zero,
    //     clipBehavior: Clip.antiAlias,
    //     child: InkWell(
    //       onTap: () {
    //         if (kDebugMode) {
    //           print('tapped');
    //         }
    //       },
    //       child: Column(
    //         children: [
    //           Image.asset(
    //             'assets/images/lead/2020-10-08.jpg',
    //           ),
    //           const SizedBox(
    //             height: 8,
    //           ),
    //           ListTile(
    //             title: const Text(
    //               'Giới thiệu công ty MarketEnterprise Việt Nam',
    //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    //             ),
    //             subtitle: Padding(
    //               padding: const EdgeInsets.only(top: 16, bottom: 24),
    //               child: Text(
    //                 '2020-10-08',
    //                 style: TextStyle(
    //                   color: Colors.black.withOpacity(0.6),
    //                   fontSize: 13,
    //                 ),
    //               ),
    //             ),
    //             contentPadding: const EdgeInsets.symmetric(
    //               horizontal: 16,
    //             ),
    //             minLeadingWidth: 10,
    //             horizontalTitleGap: 3,
    //             onTap: () => {},
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return BlocProvider(
      create: (_) => _homeBloc!..init(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (_, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (state is HomeLoadedState) {
              final data = state.data.posts;
              return ListView.separated(
                shrinkWrap: true,
                physics: const CustomScrollBehavior().getScrollPhysics(context),
                itemCount: data!.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 0,
                  thickness: 12,
                  color: Colors.grey[400],
                ),
                itemBuilder: (_, index) => Card(
                  color: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print('tapped');
                      }
                    },
                    child: Column(
                      children: [
                        Image.network('${data[index].guid}'),
                        const SizedBox(
                          height: 8,
                        ),
                        ListTile(
                          title: Text(
                            '${data[index].postTitle}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 24),
                            child: Text(
                              '2020-10-08',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          minLeadingWidth: 10,
                          horizontalTitleGap: 3,
                          onTap: () => {},
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is ErrorHomeState) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              );
            } else {
              return Container();
            }
          }
        },
      ),
    );
  }
}
