import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mevn_app/app/utils/constants/app_assets.dart';
import 'package:mevn_app/app/utils/constants/app_colors.dart';
import 'package:mevn_app/app/utils/constants/app_constants.dart';
import 'package:mevn_app/app/utils/extensions/app_extensions.dart';
import 'package:mevn_app/news/models/post.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailNewsScreen extends StatefulWidget {
  const DetailNewsScreen({Key? key}) : super(key: key);
  @override
  State<DetailNewsScreen> createState() => _DetailNewsScreenState();
}

class _DetailNewsScreenState extends State<DetailNewsScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: cast_nullable_to_non_nullable
    final _post = ModalRoute.of(context)!.settings.arguments as Post;

    return Scaffold(
      backgroundColor: AppColors.orangeMainColor,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.orangeMainColor,
              floating: true,
              snap: true,
              titleSpacing: 0,
              elevation: 0,
              centerTitle: false,
              title: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(AppAssets.meLogoAppbar),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        AppConstants.appBarTitleUp,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppConstants.appBarTitleDown,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Positioned.fill(
                      child: FadeInImage(
                        image: NetworkImage('${_post.thumbnail}'),
                        placeholder: const AssetImage(
                          AppAssets.loadingImage,
                        ),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppAssets.noImage,
                            fit: BoxFit.fitHeight,
                          );
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_post.postDate}',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '${_post.postAuthorName}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Text(
                        '${_post.postTitle}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Text(
                        '${_post.postExcerpt}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Html(
                        data: '${_post.postContent}',
                        style: {
                          '#': Style(
                            fontSize: FontSize.rem(1.15),
                            lineHeight: LineHeight.rem(1.3),
                          ),
                          'h1': Style(
                            fontWeight: FontWeight.bold,
                          ),
                          'h2': Style(
                            backgroundColor: HexColor.fromHex('#f0e8da'),
                            fontSize: FontSize.rem(1.3),
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 8,
                              right: 8,
                              bottom: 8,
                            ),
                            border: Border(
                              left: BorderSide(
                                width: 6,
                                color: HexColor.fromHex('#f79646'),
                              ),
                            ),
                          ),
                          'table': Style(
                            backgroundColor:
                                const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                          ),
                          'tr': Style(
                            border: const Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                          'th': Style(
                            padding: const EdgeInsets.all(6),
                            backgroundColor: Colors.grey,
                          ),
                          'td': Style(
                            padding: const EdgeInsets.all(6),
                            alignment: Alignment.topLeft,
                          ),
                          'h5': Style(
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          'p': Style(
                            margin: const EdgeInsets.only(bottom: 16),
                            fontSize: FontSize.rem(1.15),
                            lineHeight: LineHeight.rem(1.3),
                          ),
                          'span': Style(
                            margin: const EdgeInsets.only(bottom: 16),
                            fontSize: FontSize.rem(1.15),
                            lineHeight: LineHeight.rem(1.3),
                          ),
                          'figure': Style(
                            margin: const EdgeInsets.only(bottom: 16),
                          ),
                          'figcaption': Style(
                            margin: const EdgeInsets.only(top: 8),
                            textAlign: TextAlign.center,
                          ),
                          '.embed-responsive': Style(
                            margin: const EdgeInsets.only(bottom: 50),
                            textAlign: TextAlign.center,
                          ),
                          'iframe': Style(),
                        },
                        onLinkTap: (url, _, __, ___) {
                          launchUrl(Uri.parse(url!));
                        },
                        onImageTap: (src, _, __, ___) {},
                        onImageError: (exception, stackTrace) {},
                        onCssParseError: (css, messages) {
                          return null;
                        },
                      ),
                    ),
                    // Text('${_post.postContent}'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
