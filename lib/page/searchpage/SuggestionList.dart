import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//搜索补全
class SuggestionList extends StatelessWidget {
  const SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return Column(
          children: <Widget>[
            ListTile(
              leading: query.isNotEmpty
                  ? const Icon(CupertinoIcons.search)
                  : const Icon(null),
              title: RichText(
                text: TextSpan(
                  text: suggestion.substring(0, query.length),
                  style: theme.textTheme.subhead
                      .copyWith(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: suggestion.substring(query.length),
                      style: theme.textTheme.subhead,
                    ),
                  ],
                ),
              ),
              onTap: () {
                onSelected(suggestion);
              },
            ),
            Divider(
              height: 1,
              indent: 20,
            )
          ],
        );
      },
    );
  }
}
