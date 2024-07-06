/// ==============================
/// @author : mac
/// @time   : 2022/3/21 5:59 下午
/// @soft   : IntelliJ IDEA
/// @desc   : TODO
/// ================================
library;

enum BuildFlavor { dev, test, release }

class BuildEnv {
  final BuildFlavor flavor;

  BuildEnv.dev() : flavor = BuildFlavor.dev;

  BuildEnv.release() : flavor = BuildFlavor.release;

  BuildEnv.test() : flavor = BuildFlavor.test;

  isDev() => flavor == BuildFlavor.dev;

  isTest() => flavor == BuildFlavor.test;

  isRelease() => flavor == BuildFlavor.release;

  enableLog() => isDev() || isTest();
}
