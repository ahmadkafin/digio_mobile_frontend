import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/home/providers/child.menu.providers.dart';
import 'package:myapp/app/library/home/repositories/child.menu.repositories.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';
import 'package:myapp/core/utils/fontAwesomeMapping.utils.dart';
import 'package:page_transition/page_transition.dart';

class DetailMenuHomePage extends HookConsumerWidget {
  const DetailMenuHomePage({
    super.key,
    required this.parrentid,
    required this.labelparent,
    required this.data,
    required this.parentIcon,
  });
  final String parrentid;
  final String labelparent;
  final String parentIcon;
  final List<MenuResponse> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              labelparent,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Color.fromRGBO(30, 30, 30, 1),
            foregroundColor: Colors.white,
            stretch: false,
            expandedHeight: 150,
            snap: false,
            floating: false,
            pinned: true,
            elevation: 8,
            primary: true,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(20, 30, 48, 1),
                      Color.fromRGBO(63, 76, 107, 1),
                    ],
                  ),
                ),
                child: FaIcon(
                  getIconData(parentIcon) ?? FontAwesomeIcons.question,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          data.isEmpty
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text("Nothing to show here"),
                  ),
                )
              : SliverList.separated(
                  itemBuilder: (BuildContext _, int index) {
                    String? lbl = data[index].label!.contains("<br/>")
                        ? data[index].label!.replaceAll("<br/>", "\n")
                        : data[index].label!.contains("<span class=")
                            ? data[index].label!.replaceAll(
                                data[index].label!, "City Gas at a Glance")
                            : data[index].label;
                    return ListTile(
                      onTap: () => data[index].haschild!
                          ? ref
                              .read(childMenuProviders.notifier)
                              .get("ABC", data[index].menuid!)
                              .then(
                                (res) => res.fold(
                                  (l) => [],
                                  (r) => Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: DetailMenuHomePage(
                                        parrentid: data[index].menuid!,
                                        labelparent: data[index].label!,
                                        data: r,
                                        parentIcon: data[index].iconFlt!,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          : {},
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: FaIcon(
                          getIconData(data[index].iconFlt!) ??
                              FontAwesomeIcons.question,
                          color: lbl == "City Gas at a Glance"
                              ? Colors.amber
                              : Colors.white,
                        ),
                      ),
                      title: Text(
                        lbl!,
                        style: TextStyle(
                          color: lbl == "City Gas at a Glance"
                              ? Colors.amber
                              : Colors.black,
                        ),
                      ),
                      trailing: data[index].haschild!
                          ? Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 15,
                            )
                          : null,
                    );
                  },
                  itemCount: data.length,
                  separatorBuilder: (context, index) => Divider(),
                ),
        ],
      ),
    );
  }
}
