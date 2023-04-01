import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/app/utils/configs/custom_scroll_behavior.dart';
import 'package:mevn_app/app/utils/constants/app_assets.dart';
import 'package:mevn_app/app/utils/extensions/load_more.dart';
import 'package:mevn_app/app/utils/route/app_route.dart';
import 'package:mevn_app/news/features/home/bloc/home_bloc.dart';
import 'package:mevn_app/news/models/post.dart';

class ListNewsScreen extends StatefulWidget {
  const ListNewsScreen({
    Key? key,
    this.category,
    this.scrollViewController,
  }) : super(key: key);

  final ScrollController? scrollViewController;
  final String? category;

  @override
  State<ListNewsScreen> createState() => _ListNewsScreenState();
}

class _ListNewsScreenState extends State<ListNewsScreen>
    with TickerProviderStateMixin {
  late HomeBloc? _homeBloc;
  late int _page = 1;
  static const int perPage = 10;
  late List<Post> _posts = [];
  int get count => _posts.length;
  List<int> list = [];
  late String _categoryId = 'all';

  late bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _homeBloc = HomeBloc(locator.get());
    _firstLoad();
  }

  Future<void> _firstLoad() async {
    final data = await _homeBloc!.getDataLoadMore(1, perPage, _categoryId);
    setState(() {
      _posts.addAll(<Post>[...?data]);
      _isLoading = false;
    });
  }

  Future<void> _refreshCategory() async {
    if (widget.category! != _categoryId) {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(const Duration(milliseconds: 2000));
      final data =
          await _homeBloc!.getDataLoadMore(1, perPage, widget.category!);
      setState(() {
        _posts = [];
        _posts.addAll(<Post>[...?data]);
        _categoryId = widget.category!;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _refreshCategory();
    return RefreshIndicator(
      onRefresh: _refresh,
      child: LoadMore(
        isFinish: count >= 60,
        onLoadMore: _loadMore,
        whenEmptyLoad: false,
        delegate: const DefaultLoadMoreDelegate(),
        textBuilder: DefaultLoadMoreTextBuilder.vietnamese,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                controller: widget.scrollViewController,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 0,
                  thickness: 12,
                  color: Colors.grey[400],
                ),
                shrinkWrap: true,
                physics: const CustomScrollBehavior().getScrollPhysics(context),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
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
                        Navigator.of(context).pushNamed(
                          AppRoute.routeDetailNews,
                          arguments: _posts[index],
                        );
                      },
                      child: IgnorePointer(
                        child: Column(
                          children: [
                            FadeInImage(
                              image: NetworkImage('${_posts[index].thumbnail}'),
                              placeholder: const AssetImage(
                                AppAssets.loadingImage,
                              ),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  AppAssets.noImage,
                                  fit: BoxFit.fitWidth,
                                );
                              },
                              fit: BoxFit.fitWidth,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_posts[index].postTitle}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '${_posts[index].postExcerpt}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, bottom: 24),
                                child: Text(
                                  '${_posts[index].postDate}',
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
                },
                itemCount: count,
              ),
      ),
    );
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    final data = await _homeBloc!.getDataLoadMore(_page, perPage, _categoryId);

    setState(() {
      _posts.addAll(<Post>[...?data]);
      _page++;
      _isLoading = false;
    });
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    final data = await _homeBloc!.getDataLoadMore(1, perPage, _categoryId);

    setState(() {
      _posts.addAll(<Post>[...?data]);
      _isLoading = false;
    });
  }
}
