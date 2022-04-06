import 'package:flutter/material.dart';

typedef FetchFunction<G> = Future<List<G>> Function();
typedef WidgetBuilder<W> = Widget Function(W dataObject);

class FutureListWidget<T> extends StatelessWidget {
  final FetchFunction<T> fetch;
  final WidgetBuilder<T> widgetBuilder;
  final String? heading;

  const FutureListWidget({
    Key? key,
    required this.fetch,
    required this.widgetBuilder,
    this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: fetch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          var widgets = snapshot.data!
              .map((dataObject) => widgetBuilder(dataObject))
              .toList();
          return ListView(
            children: [
              buildHeadingWidget(),
              ...widgets,
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildHeadingWidget() {
    if (heading == null) return Container();

    return Center(
      child: Text(
        heading!,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
