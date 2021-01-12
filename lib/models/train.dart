class Train {
  final String direction;
  final String destination;
  final String status;
  final DateTime departTime;
  final String track;

  Train(
      {this.direction,
      this.destination,
      this.status,
      this.departTime,
      this.track});

  Train.fromJson(Map<dynamic, dynamic> data)
      : direction = data['direction'],
        destination = data['destination'],
        status = data['status'],
        departTime = DateTime.parse(data['depart_time']),
        track = data['track'];
}
