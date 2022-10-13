import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locations = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(locations.appTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              locations.initialGreetings("Dario"),
              style: textTheme.headline6,
            ),
            Text(
              locations.currentDay(DateTime.now()),
              style: textTheme.bodyText2,
            ),
            const SizedBox(height: 16),
            Text(
              locations.description,
              style: textTheme.bodyText2,
            ),
            ListTile(
              title: Text(locations.productCategories("phone")),
              subtitle: Text(locations.productsCount(0)),
            ),
            ListTile(
              title: Text(locations.productCategories("watch")),
              subtitle: Text(locations.productsCount(1)),
            ),
            ListTile(
              title: Text(locations.productCategories("tablet")),
              subtitle: Text(locations.productsCount(10)),
            ),
            const Spacer(),
            Text(
              locations.money(10000),
              style: textTheme.headline6,
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
