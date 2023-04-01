import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/app/utils/configs/custom_scroll_behavior.dart';
import 'package:mevn_app/app/utils/constants/app_colors.dart';
import 'package:mevn_app/news/features/home/bloc/category_bloc.dart';
import 'package:mevn_app/news/features/home/bloc/category_state.dart';

class DrawerMenuWidget extends StatefulWidget {
  const DrawerMenuWidget({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final void Function(String) onTap;

  @override
  State<DrawerMenuWidget> createState() => _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends State<DrawerMenuWidget> {
  late CategoryBloc? _categoryBloc;
  late String categoryId = 'all';

  @override
  void initState() {
    super.initState();
    _categoryBloc = CategoryBloc(locator.get());
  }

  @override
  Widget build(BuildContext context) {
    var _crossFadeState = false;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        backgroundColor: AppColors.orangeMainColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 16,
                right: 16,
              ),
              child: TextFormField(
                enableInteractiveSelection: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Search',
                  filled: true,
                  labelStyle: const TextStyle(
                    fontSize: 0,
                    color: Colors.redAccent,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              // controller: widget.scrollViewController,
              child: BlocProvider(
                create: (_) => _categoryBloc!..init(),
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (_, state) {
                    if (state is LoadingState) {
                      return AnimatedContainer(
                        height: _crossFadeState
                            ? MediaQuery.of(context).size.height - 120
                            : MediaQuery.of(context).size.height * 0.2,
                        duration: const Duration(seconds: 8),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                    if (state is CategoryLoadedState) {
                      _crossFadeState = true;
                      final data = state.data.categories;
                      return AnimatedContainer(
                        height: _crossFadeState
                            ? MediaQuery.of(context).size.height - 120
                            : MediaQuery.of(context).size.height * 0.2,
                        duration: const Duration(milliseconds: 220),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const CustomScrollBehavior()
                              .getScrollPhysics(context),
                          itemCount: data!.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                            height: 0,
                            thickness: 0.5,
                            color: Colors.grey[300],
                          ),
                          itemBuilder: (_, index) => ListTile(
                            horizontalTitleGap: 0,
                            textColor: categoryId == '${data[index].catID}'
                                ? const Color(0xFFE31A1A)
                                : const Color(0xFFFFFFFF),
                            iconColor: const Color(0xFFFFFFFF),
                            leading: const Icon(
                              Icons.navigate_next,
                            ),
                            title: Text('${data[index].name}'),
                            onTap: () {
                              widget.onTap('${data[index].catID}');
                              setState(
                                () => categoryId = '${data[index].catID}',
                              );
                              Navigator.pop(context, '${data[index].catID}');
                            },
                          ),
                        ),
                      );
                    } else if (state is ErrorCategoryState) {
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
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
