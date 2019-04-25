import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/public.dart';

Set<String> _materials = <String>{};

Color _nameToColor(String name) {
  assert(name.length > 1);
  final int hash = name.hashCode & 0xff37;
  final double hue = (360.0 * hash / (1 << 15)) % 360.0;
  return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
}

String _capitalize(String name) {
  assert(name != null && name.isNotEmpty);
  return name.substring(0, 1).toUpperCase() + name.substring(1);
}

String _selectedMaterial = '';

class ChipsTile extends StatefulWidget {
  final List<String> defaultMaterials;

  const ChipsTile({Key key, this.defaultMaterials}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChipsTile();
  }
}

class _ChipsTile extends State<ChipsTile> {
  List<Widget> children;

  // Wraps a list of chips into a ListTile for display as a section in the demo.
  @override
  Widget build(BuildContext context) {
    _materials.clear();
    _materials.addAll(widget.defaultMaterials);
    List<Widget> choiceChips = _materials.map<Widget>((String name) {
      if(name.isNotEmpty){
        return ChoiceChip(
          key: ValueKey<String>(name),
          backgroundColor: _nameToColor(name),
          label: Text(
            _capitalize(name),
            style: TextStyle(color: Colors.white, fontSize: ScreenUtil.getInstance().setSp(12)),
          ),
          selected: _selectedMaterial == name,
          onSelected: (bool value) {
            NavigatorUtils.gotoBookByTagsPage(context, name);
            setState(() {
              _selectedMaterial = value ? name : '';
            });
          },
        );
      }
    }).toList();

    children = choiceChips;

    final List<Widget> cardChildren = <Widget>[
      Container(),
    ];
    if (children.isNotEmpty) {
      cardChildren.add(Wrap(
          children: children.map<Widget>((Widget chip) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: chip,
        );
      }).toList()));
    } else {
      final TextStyle textStyle = Theme.of(context)
          .textTheme
          .caption
          .copyWith(fontStyle: FontStyle.italic);
      cardChildren.add(Semantics(
        container: true,
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
          padding: const EdgeInsets.all(8.0),
          child: Text('None', style: textStyle),
        ),
      ));
    }

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: cardChildren,
      ),
    );
  }
}
