import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_departure/models/train.dart';
import 'package:train_departure/providers/septa_provider.dart';

class Departures extends StatelessWidget {
  const Departures({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SeptaProvider>(context).bloc;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Station",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          FlatButton(
              onPressed: () {
                //TODO: Settings Page
              },
              child: Text(
                'Change',
                style: TextStyle(color: Theme.of(context).accentColor),
              )),
        ],
      ),
      body: StreamBuilder<List<Train>>(
          stream: bloc.trains,
          builder: (context, snapshot) {
            // var trains = snapshot.data;
            if (snapshot.hasError) {
              return Text('Error');
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
              itemCount: snapshot.data.length + 1,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return _buildHeader(context);
                } else {
                  return _buildDeparture(context, snapshot.data[index-1]);
                }
              },
            );
          }),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 25.0),
            Text(
              'Departures',
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            SizedBox(width: 15.0),
            Expanded(
              child: Text(
                'Time',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              flex: 1,
            ),
            Expanded(
              child: Text(
                'Destination',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              flex: 3,
            ),
            Expanded(
              child: Text(
                'Track',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              flex: 1,
            ),
            Expanded(
              child: Text(
                'Status',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              flex: 1,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeparture(BuildContext context, Train train) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 15.0),
            Expanded(
              child: Text(
                formatDate(train.departTime, [h,':',nn]),
                style: Theme.of(context).textTheme.bodyText2,
              ),
              flex: 1,
            ),
            Expanded(
              child: Text(
                train.destination,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              flex: 3,
            ),
            Expanded(
              child: Text(
                train.track,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              flex: 1,
            ),
            Expanded(
              child: Text(
                train.status,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              flex: 1,
            ),
          ],
        ),
      ],
    );
  }
}
