import 'package:flutter/material.dart';

typedef FetchFunction<G> = Future<List<G>> Function();
typedef WidgetBuilder<W> = Widget Function(W dataObject);

class FutureListWidget<T> extends StatelessWidget {
  final FetchFunction<T> fetch;
  final WidgetBuilder<T> widgetBuilder;
  final EdgeInsets padding;

  const FutureListWidget({
    Key? key,
    required this.fetch,
    required this.widgetBuilder,
    this.padding = const EdgeInsets.only(top: 40, bottom: 60),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: fetch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return processIndicator();
        } else if (snapshot.hasData) {
          var widgets = snapshot.data!
              .map((dataObject) => widgetBuilder(dataObject))
              .toList();
          return ListView(children: widgets, padding: padding);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return processIndicator();
      },
    );
  }

  Widget processIndicator() => const Center(
        child: SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(color: Colors.grey),
        ),
      );
}
