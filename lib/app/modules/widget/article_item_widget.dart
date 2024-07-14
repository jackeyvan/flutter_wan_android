import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/theme/themes.dart';
import 'package:flutter_wan_android/core/utils/utils.dart';

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitleText(),
                    buildDescText(),
                    Row(
                      children: [
                        ///  标签
                        buildTagText(),

                        ///  作者或者分享人
                        buildAuthorText(),

                        /// 分类
                        buildChapterText(),

                        const Spacer(),

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

  ///  标签
  Widget buildTagText() {
    final tags = articleModel.tags;
    if (tags != null && tags.isNotEmpty) {
      return Row(children: [
        Text("${tags[0].name}",
            style: TextStyle(color: AppTheme.getThemeColorScheme().primary)),
        const SizedBox(width: 12)
      ]);
    }
    return const SizedBox.shrink();
  }

  ///  作者
  Widget buildAuthorText() {
    if (isNotNullOrBlank(articleModel.author)) {
      return Row(children: [
        Text("${articleModel.author}"),
        const SizedBox(width: 12)
      ]);
    } else if (isNotNullOrBlank(articleModel.shareUser)) {
      return Row(children: [
        Text("${articleModel.shareUser}"),
        const SizedBox(width: 12)
      ]);
    }

    return const SizedBox.shrink();
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

  /// 描述
  buildDescText() {
    final desc = articleModel.desc;

    if (isNotNullOrBlank(desc)) {
      return Column(children: [
        Text(
          "${articleModel.desc}",
          maxLines: 5,
        ),
        const SizedBox(height: 8),
      ]);
    }
    return const SizedBox.shrink();
  }

  /// 标题
  buildTitleText() {
    return Column(
      children: [
        Text(
          "${articleModel.title}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          maxLines: 2,
        ),
        const SizedBox(height: 8)
      ],
    );
  }

  /// 分类
  buildChapterText() {
    if (isNotNullOrBlank(articleModel.superChapterName) &&
        isNotNullOrBlank(articleModel.chapterName)) {
      return Row(children: [
        Text("${articleModel.superChapterName} / ${articleModel.chapterName}"),
        const SizedBox(width: 12)
      ]);
    }
    return const SizedBox.shrink();
  }

  /// 发布时间
  buildTimeText() {
    final date = articleModel.niceShareDate;
    if (isNotNullOrBlank(date)) {
      return Text(date!.split(" ")[0]);
    }
    return const SizedBox.shrink();
  }
}
