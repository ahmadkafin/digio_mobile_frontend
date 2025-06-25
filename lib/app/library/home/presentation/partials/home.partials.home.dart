import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/home/presentation/widget/childmenu.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/header.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/horizontalgrid.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/menu.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/imageCarousel.widget.home.dart';
import 'package:myapp/app/library/home/providers/child.menu.providers.dart';
import 'package:myapp/app/library/home/providers/home.providers.dart';
import 'package:myapp/app/library/home/providers/panjangpipa.providers.dart';
import 'package:myapp/app/library/home/providers/products.providers.dart';
import 'package:myapp/app/library/home/providers/root.menu.providers.dart';
import 'package:myapp/app/library/home/repositories/products.repositories.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';
import 'package:myapp/core/utils/shimmer.utils.dart';
import 'package:myapp/core/utils/styleText.utils.dart';

class HomePartialsHome extends StatefulHookConsumerWidget {
  const HomePartialsHome({super.key});

  @override
  ConsumerState<HomePartialsHome> createState() => _HomePartialsHomeState();
}

class _HomePartialsHomeState extends ConsumerState<HomePartialsHome> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;
  int currentIndex = 0;
  String? labelParent, iconFltParent, parentId;
  bool _isUserReady = false;

  Map<String, dynamic>? _user;
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _setSystemUIStyle();
    _getStorageData();
  }

  void _setSystemUIStyle() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
  }

  Future<void> _getStorageData() async {
    final jsonStr = await _storage.read(key: 'authUserKey');
    if (jsonStr != null) {
      try {
        final jsonMap = jsonDecode(jsonStr);
        setState(() {
          _user = jsonMap;
          _isUserReady = true;
        });
        await _initializeData();
      } catch (e) {
        debugPrint("Failed to decode user JSON: $e");
      }
    } else {
      debugPrint("authUserKey not found");
    }
  }

  Future<void> _initializeData() async {
    final token = _user?['token'] ?? '';
    final username = _user?['username']?.toLowerCase() ?? '';
    final directory = _user?['directory']?.toUpperCase() ?? '';

    final rootMenuResult = await ref
        .read(rootMenuProviders.notifier)
        .get(token, username, directory);

    rootMenuResult.fold((l) => null, (r) {
      if (r.isNotEmpty) {
        final item = r.first;
        setState(() {
          labelParent = item.label;
          iconFltParent = item.iconFlt;
          parentId = item.menuid;
        });
        ref.read(childMenuProviders.notifier).get(
              token,
              username,
              directory,
              item.menuid!,
            );
      }
    });

    ref.read(homeProviders.notifier).get(token);
    ref.read(productsProviders.notifier).get(token);
    ref.read(panjangPipaProviders.notifier).get(token);
  }

  void stateIndex(int index) => setState(() => _current = index);

  void setActive(int index, String parrentid, String labelParam,
      String iconParam, String parentIdParam) {
    final token = _user?['token'] ?? '';
    final username = _user?['username']?.toLowerCase() ?? '';
    final directory = _user?['directory']?.toUpperCase() ?? '';

    setState(() {
      currentIndex = index;
      labelParent = labelParam;
      iconFltParent = iconParam;
      parentId = parentIdParam;
    });

    ref.read(childMenuProviders.notifier).get(
          token,
          username,
          directory,
          parrentid,
        );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    if (!_isUserReady || _user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final childMenu =
        ref.watch(childMenuProviders.select((map) => map[parentId]));
    final colorsHeader = [const Color.fromRGBO(75, 75, 75, 1), Colors.black];

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
        body: CustomScrollView(
          slivers: [
            _buildHeader(deviceSize, colorsHeader),
            _buildMainContent(deviceSize, childMenu),
            _buildWhatsInDigioSection(deviceSize),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Size deviceSize, List<Color> colorsHeader) {
    final panjangPipaAsync = ref.watch(panjangPipaProviders);
    return panjangPipaAsync.when(
      error: (error, _) => SliverToBoxAdapter(
        child: Center(child: Text(error.toString())),
      ),
      loading: () => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: headerShimmer(deviceSize),
        ),
      ),
      data: (data) => HeaderWidgetHome(
        deviceSize: deviceSize,
        colorsHeader: colorsHeader,
        controller: _controller,
        curr: _current,
        stateIndex: stateIndex,
        panjangPipa: data,
      ),
    );
  }

  Widget _buildMainContent(Size deviceSize, List<MenuResponse>? childMenu) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        width: deviceSize.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white,
              Color.fromRGBO(242, 226, 190, 1)
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            _buildHomeSection(deviceSize),
            _menuLoad(deviceSize, setActive, currentIndex),
            if (childMenu == null)
              const Center(child: Text(""))
            else
              ChildMenuWidgetHome(
                menuResponse: childMenu,
                deviceSize: deviceSize,
                iconParent: iconFltParent ?? "",
                labelParent: labelParent ?? "",
                parentId: parentId ?? "",
                user: _user!,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeSection(Size deviceSize) {
    final homeAsync = ref.watch(homeProviders);
    final token = _user?['token'] ?? '';

    return homeAsync.when(
      loading: () => horizontalGrid(),
      error: (e, _) => Center(
        child: Text("$e",
            style: TextStyle(fontFamily: fontFamily, color: Colors.black)),
      ),
      data: (data) {
        if (data.isEmpty) {
          return Center(
            child: Text("No Data Found",
                style: TextStyle(fontFamily: fontFamily, color: Colors.black)),
          );
        } else {
          return HorizontalGridHeaderWidgetHome(
            deviceSize: deviceSize,
            data: data,
            token: token,
          );
        }
      },
    );
  }

  Widget _buildWhatsInDigioSection(Size deviceSize) {
    return SliverToBoxAdapter(
      child: Container(
        width: deviceSize.width,
        padding: const EdgeInsets.only(bottom: 20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("#WhatsInDigio"),
            _buildProductsCarousel(deviceSize),
            _buildSectionTitle("PGN #SeputarOMM"),
            ImageCarouselWidgetHome(deviceSize: deviceSize, products: const []),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 10),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: fontFamily,
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildProductsCarousel(Size deviceSize) {
    return ref.watch(getProductsProvider).when(
          loading: () => SizedBox(
            width: deviceSize.width,
            height: 200,
            child: const Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => SizedBox(
            width: deviceSize.width,
            height: 200,
            child: Center(child: Text("Error: $error")),
          ),
          data: (products) => products.isEmpty
              ? SizedBox(
                  width: deviceSize.width,
                  height: 200,
                  child: const Center(
                    child: Text(
                      "No products available",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                )
              : ImageCarouselWidgetHome(
                  deviceSize: deviceSize, products: products),
        );
  }

  Widget _menuLoad(Size deviceSize, Function setActive, int curIndex) {
    final menusAsync = ref.watch(rootMenuProviders);

    return menusAsync.when(
      loading: () => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: chipsShimer(),
      ),
      error: (error, _) => Center(child: Text("Error: $error")),
      data: (menus) {
        if (menus.isEmpty) {
          return const Center(child: Text("Empty data"));
        }
        return MenuWidgetHome(
          deviceSize: deviceSize,
          data: menus,
          curIndex: curIndex,
          setActive: setActive,
        );
      },
    );
  }
}
