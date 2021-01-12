import 'package:rxdart/subjects.dart';
import 'package:train_departure/models/train.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SeptaBloc {
  final _trains = BehaviorSubject<List<Train>>();

  SeptaBloc() {
    loadStation('Suburban Station');
  }

  // getters
  Stream<List<Train>> get trains => _trains.stream;

  // setters
  Function(List<Train>) get changeTrains => _trains.sink.add;

  void dispose() {
    _trains.close();
  }

  void loadStation(String station) async {
    var response =
        await http.get('http://www3.septa.org/hackathon/Arrivals/$station/10/');

    //Replace Dynamic Key and Decode
    var json = convert.jsonDecode('{ "Departures" : ' +
        response.body.substring(response.body.indexOf('['))); 


    // Build a Train List
    var trains = List<Train>();

    try {
      // Get the train json for north and south bound
      var north = json['Departures'][0]['Northbound'];
      var south = json['Departures'][1]['Southbound'];

      // Loop to get each train, turn it into an object and 
      // add it in trains List
      north.forEach((train) => trains.add(Train.fromJson(train)));
      south.forEach((train) => trains.add(Train.fromJson(train)));
    } catch (error) {
      print(error);
    }

    // Sort each train according to departure time
    trains.sort((a, b) => a.departTime.compareTo(b.departTime));

    // Add each train in the trains
    changeTrains(trains);
  }
}
