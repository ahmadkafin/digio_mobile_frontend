import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/child/presentation/child.presentation.dart';
import 'package:myapp/app/library/child/providers/child.providers.dart';
import 'package:myapp/app/library/home/providers/child.menu.providers.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          widget.type == 'Lainnya'
              ? _buildMenuList(widget.data)
              : _buildMenuList(ref.watch(childMenuProviders
                      .select((map) => map[widget.parrentid])) ??
                  []),
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
      itemBuilder: (BuildContext _, int index) {
        final item = menuData[index];
        final lbl = _parseLabel(item.label!);

        return _buildMenuCard(item, lbl);
      },
      itemCount: menuData.length,
      separatorBuilder: (context, index) => const SizedBox(height: 0),
    );
  }

  Widget _buildMenuCard(MenuResponse item, String lbl) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: () => _handleMenuTap(item),
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 22,
          child: FaIcon(
            getIconData(item.iconFlt!) ?? FontAwesomeIcons.question,
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
        trailing: item.haschild!
            ? const Icon(Icons.arrow_forward_ios_rounded, size: 16)
            : null,
      ),
    );
  }

  void _handleMenuTap(MenuResponse item) {
    if (!item.haschild!) {
      ref.read(childProvider.notifier).get().then(
            (res) => res.fold(
              (l) => SnackBar(
                  content: Container(
                color: Colors.black,
                child: Text(
                  "Cannot Open Menu, Please contact your apps administrator.",
                ),
              )),
              (r) => Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: ChildPresentation(
                    cookieData: r.data,
                    title: item.label!.toUpperCase(),
                    contenttype: item.contenttype,
                    url: 'http://10.129.10.138/digio/${item.url}',
                    querystring: item.querystring,
                    contentstring: item.contentstring,
                  ),
                ),
              ),
              // (r) => Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.rightToLeft,
              //     child: CustomBrowserPresentation(
              //       url: 'http://10.129.10.138/digio/${item.url}',
              //       cookieSession: r.data,
              //       title: item.label!.toUpperCase(),
              //     ),
              //   ),
              // ),
            ),
          );
    } else {
      ref
          .read(childMenuProviders.notifier)
          .get(
            widget.user['token'],
            widget.user['username'].toLowerCase(),
            widget.user['directory'].toUpperCase(),
            item.menuid!,
          )
          .then((res) => res.fold(
                (l) => [],
                (r) => Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: DetailMenuHomePage(
                      parrentid: item.menuid!,
                      labelparent: item.label!,
                      data: r,
                      parentIcon: item.iconFlt!,
                      type: item.label!,
                      user: widget.user,
                    ),
                  ),
                ),
              ));
    }
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
