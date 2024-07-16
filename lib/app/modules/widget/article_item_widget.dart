import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/init/init_core.dart';
import 'package:flutter_wan_android/core/init/themes.dart';

class ArticleItemWidget extends StatelessWidget {
  final ArticleModel articleModel;

  const ArticleItemWidget(this.articleModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      /// 卡片的圆角，和水波纹匹配

      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: InkWell(
        /// 点击水波纹的圆角
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        onTap: () => Routes.to(Routes.articleDetail, args: articleModel),

        child: Row(
          children: [
            buildImage(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  children: [
                    /// 标题
                    buildTitleText(),

                    /// 描述
                    buildDescText(),
                    Row(
                      children: [
                        Expanded(
                            child: Wrap(
                          children: [
                            ///  标签
                            buildTagText(),

                            ///  作者或者分享人
                            buildAuthorText(),

                            /// 分类
                            buildChapterText(),
                          ],
                        )),

                        ///  时间
                        buildTimeText()
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 左侧图片
  Widget buildImage() {
    final imgUrl = articleModel.envelopePic;

    if (isNotNullOrBlank(imgUrl)) {
      return CachedNetworkImage(
        width: 100,
        height: 200,
        imageUrl: imgUrl!,
        fit: BoxFit.fill,
      );
    }
    return const SizedBox.shrink();
  }

  /// 标题
  buildTitleText() {
    return paddingText(
        const EdgeInsets.only(bottom: 8), "${articleModel.title}",
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis),
        maxLines: 2);
  }

  /// 描述
  buildDescText() {
    final desc = articleModel.desc;

    if (isNotNullOrBlank(desc)) {
      return paddingText(
          const EdgeInsets.only(bottom: 12), "${articleModel.desc}",
          style: const TextStyle(
              overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500),
          maxLines: 5);
    }
    return const SizedBox.shrink();
  }

  ///  标签
  Widget buildTagText() {
    final tags = articleModel.tags;
    if (tags != null && tags.isNotEmpty) {
      return paddingText(const EdgeInsets.only(right: 12), "${tags[0].name}",
          style: TextStyle(color: AppTheme.getThemeColorScheme().primary));
    }
    return const SizedBox.shrink();
  }

  ///  作者
  Widget buildAuthorText() {
    if (isNotNullOrBlank(articleModel.author)) {
      return paddingText(
          const EdgeInsets.only(right: 12), "${articleModel.author}");
    } else if (isNotNullOrBlank(articleModel.shareUser)) {
      return paddingText(
          const EdgeInsets.only(right: 12), "${articleModel.shareUser}");
    }

    return const SizedBox.shrink();
  }

  /// 分类
  buildChapterText() {
    if (isNotNullOrBlank(articleModel.superChapterName) &&
        isNotNullOrBlank(articleModel.chapterName)) {
      return paddingText(const EdgeInsets.only(right: 12),
          "${articleModel.superChapterName} / ${articleModel.chapterName}");
    }
    return const SizedBox.shrink();
  }

  /// 发布时间
  buildTimeText() {
    final date = articleModel.niceShareDate;
    if (isNotNullOrBlank(date)) {
      return paddingText(const EdgeInsets.only(left: 12), date!.split(" ")[0]);
    }
    return const SizedBox.shrink();
  }

  Widget paddingText(EdgeInsetsGeometry padding, String data,
      {TextStyle? style, int? maxLines}) {
    return Padding(
        padding: padding,
        child: Text(
          data,
          style: style,
          maxLines: maxLines,
        ));
  }
}
