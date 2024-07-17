import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/page/user/login_controller.dart';
import 'package:flutter_wan_android/core/page/base/base_page.dart';

class LoginPage extends BasePage<LoginController> {
  const LoginPage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                leading: const BackButton(),
                pinned: true,
                expandedHeight: 240,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    "assets/images/vector-1.png",
                    fit: BoxFit.cover,
                  ),
                ),
                forceElevated: innerBoxIsScrolled,
              ),
            ),
          ];
        },
        body: Builder(builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(48),
            child: CustomScrollView(
              slivers: [
                SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context)),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Wrap(
                      children: [
                        buildLoginText("登录"),
                        buildTextField(controller.accountController, "账号"),
                        buildTextField(controller.passController, "密码"),
                        buildLoginButton("登录"),
                        buildToRegisterText(),
                      ],
                    ),
                  ]),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// 输入框
  buildTextField(TextEditingController controller, String labelText) {
    return Padding(
        padding: const EdgeInsets.only(top: 18),
        child: TextField(
          controller: controller,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            labelText: labelText,
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(width: 1)),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(width: 1),
            ),
          ),
        ));
  }

  /// 登录注册按钮
  buildLoginButton(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => controller.toLogin(),
          child: Text(text,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }

  /// 去注册文字
  buildToRegisterText() {
    return Row(
      children: [
        const Text(
          '还没有账号?',
          style: TextStyle(
            fontSize: 13,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        InkWell(
          onTap: () {},
          child: const Text(
            '注册',
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  /// 登录注册文字大标题
  buildLoginText(String text) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(text,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)));
  }
}
