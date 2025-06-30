import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/child/presentation/child.presentation.dart';
import 'package:myapp/app/library/child/presentation/childwithpages.presentation.dart';
import 'package:myapp/app/library/child/providers/child.providers.dart';
import 'package:myapp/app/library/child/repositories/child.repositories.dart';
import 'package:myapp/app/library/home/providers/child.menu.providers.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';
import 'package:myapp/app/library/miracle/presentation/miracle.page.presentation.dart';
import 'package:myapp/core/utils/endpoint.utils.dart';
import 'package:myapp/core/utils/fontAwesomeMapping.utils.dart';
import 'package:page_transition/page_transition.dart';

class DetailMenuHomePage extends StatefulHookConsumerWidget {
  const DetailMenuHomePage({
    super.key,
    required this.parrentid,
    required this.labelparent,
    required this.data,
    required this.parentIcon,
    required this.type,
    required this.user,
  });

  final String type;
  final String parrentid;
  final String labelparent;
  final String parentIcon;
  final List<MenuResponse> data;
  final Map<String, dynamic> user;

  @override
  ConsumerState<DetailMenuHomePage> createState() => _DetailMenuHomePageState();
}

class _DetailMenuHomePageState extends ConsumerState<DetailMenuHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(childMenuProviders.notifier).get(
            widget.user['token'],
            widget.user['username'].toLowerCase(),
            widget.user['directory'].toUpperCase(),
            widget.parrentid,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final menuData = widget.type == 'Lainnya'
        ? widget.data
        : ref.watch(
                childMenuProviders.select((map) => map[widget.parrentid])) ??
            [];

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          _buildMenuList(menuData),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      title: Text(
        widget.labelparent,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
      foregroundColor: Colors.white,
      expandedHeight: 150,
      pinned: true,
      elevation: 8,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: const EdgeInsets.only(bottom: 20),
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(20, 30, 48, 1),
                Color.fromRGBO(63, 76, 107, 1),
              ],
            ),
          ),
          child: FaIcon(
            getIconData(widget.parentIcon) ?? FontAwesomeIcons.question,
            size: 50,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuList(List<MenuResponse> menuData) {
    if (menuData.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: const Center(child: Text("Nothing to show here")),
      );
    }

    return SliverList.separated(
      itemBuilder: (_, index) => _buildMenuCard(menuData[index]),
      itemCount: menuData.length,
      separatorBuilder: (_, __) => const SizedBox(height: 0),
    );
  }

  Widget _buildMenuCard(MenuResponse item) {
    final lbl = _parseLabel(item.label ?? '');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: () => item.label!.contains("MIRACLE 5.0")
            ? _navigateToMiracle(item)
            : _handleMenuTap(item),
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 22,
          child: FaIcon(
            getIconData(item.iconFlt ?? '') ?? FontAwesomeIcons.question,
            color: lbl == "City Gas at a Glance" ? Colors.amber : Colors.white,
          ),
        ),
        title: Text(
          lbl,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: lbl == "City Gas at a Glance" ? Colors.amber : Colors.black,
          ),
        ),
        trailing: item.haschild == true
            ? const Icon(Icons.arrow_forward_ios_rounded, size: 16)
            : null,
      ),
    );
  }

  void _handleMenuTap(MenuResponse item) async {
    if (item.haschild != true) {
      final storageService = ref.read(childStorageServiceProvider);
      final cookie = await storageService.getCookieData();

      if (cookie == null) {
        print("cookie not found");
        final res = await ref.read(childProvider.notifier).get();
        if (!mounted) return;
        res.fold(
          (l) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Cannot Open Menu, Please contact your apps administrator.",
              ),
            ),
          ),
          (r) async {
            await storageService.setCookieData(r);
            if (!mounted) return;
            _navigateToChild(item, r.data!);
          },
        );
      } else {
        print("cookie found!");
        _navigateToChild(item, cookie.data!);
      }
    } else {
      final res = await ref.read(childMenuProviders.notifier).get(
            widget.user['token'],
            widget.user['username'].toLowerCase(),
            widget.user['directory'].toUpperCase(),
            item.menuid!,
          );
      if (!mounted) return;

      res.fold(
        (l) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cannot fetch child menus."),
          ),
        ),
        (r) => Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: DetailMenuHomePage(
              parrentid: item.menuid!,
              labelparent: item.label ?? '',
              data: r,
              parentIcon: item.iconFlt ?? '',
              type: item.label ?? '',
              user: widget.user,
            ),
          ),
        ),
      );
    }
  }

  void _navigateToChild(MenuResponse item, String cookieData) {
    final isPages = item.url == "pages";
    final url = '$generalUrl/${item.url}${isPages ? "/default.aspx" : ""}';

    final destination = isPages
        ? ChildWithPagesPresentation(
            cookieData: cookieData,
            title: item.label?.toUpperCase(),
            contenttype: item.contenttype,
            url: url,
            querystring: item.querystring,
            contentstring: item.contentstring,
          )
        : ChildPresentation(
            cookieData: cookieData,
            title: item.label?.toUpperCase(),
            contenttype: item.contenttype,
            url: url,
            querystring: item.querystring,
            contentstring: item.contentstring,
          );

    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.bottomToTop,
        fullscreenDialog: true,
        isIos: Platform.isIOS ? true : false,
        opaque: true,
        child: destination,
      ),
    );
  }

  void _navigateToMiracle(MenuResponse item) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.bottomToTop,
        isIos: Platform.isIOS ? true : false,
        opaque: true,
        child: MiraclePagePresentation(
          title: item.label!,
          parentMenuId: "0",
        ),
      ),
    );
  }

  String _parseLabel(String label) {
    if (label.contains("<br/>")) {
      return label.replaceAll("<br/>", "\n");
    } else if (label.contains("<span")) {
      return "City Gas at a Glance";
    }
    return label;
  }
}
