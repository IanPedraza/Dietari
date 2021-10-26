import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/components/LinkComponent.dart';
import 'package:dietari/data/domain/Tip.dart';
import 'package:dietari/data/domain/Url.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class TipPage extends StatefulWidget {
  TipPage({Key? key}) : super(key: key);

  @override
  _TipPageState createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  late Tip? _tip;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getArguments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        textAppBar: tip_title,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: _tip == null
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : _component(_tip!),
    );
  }

  Widget _component(Tip tip) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 30),
          alignment: Alignment.center,
          child: Text(
            tip.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w900,
              fontSize: 25,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 30),
          alignment: Alignment.center,
          child: Text(
            tip.body,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: colorTextBlack,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tip.links.length,
              itemExtent: 80,
              itemBuilder: (BuildContext context, int index) {
                if (tip.links[index].type == Url.URL_TYPE_LINK) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 10, top: 10, right: 10, bottom: 10),
                    child: LinkComponent(
                      onPressed: () {
                        _openLink(tip.links[index].url);
                      },
                      textLink: tip.links[index].url,
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 15, top: 10, right: 15, bottom: 10),
                    child: Image.network(
                      tip.links[index].url,
                      fit: BoxFit.cover,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  void _getArguments() {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    if (args.isEmpty) {
      Navigator.pop(context);
      return;
    }
    setState(() {
      _tip = args[tip_args];
    });
  }

  void _openLink(link) async {
    if (await canLaunch(link)) await launch(link);
  }



}
