import 'dart:async';
import 'package:flutter/material.dart';
import '../../widget/navigation_drawer.dart';
import 'package:geolocator/geolocator.dart';


class LocationPage extends StatelessWidget {

  static const String routeName = '/location';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Location"),
            ),
        drawer: new NavigationDrawer(),
        body: new LocationStreamWidget(),
    );
  }
}

class LocationStreamWidget extends StatefulWidget {
  @override
  State<LocationStreamWidget> createState() => LocationStreamState();  
}


class LocationStreamState extends State<LocationStreamWidget> {
  StreamSubscription<Position> _positionStreamSubscription;
  List<Position> _positions = <Position>[];

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final LocationOptions locationOptions = const LocationOptions(
          accuracy: LocationAccuracy.best, distanceFilter: 100);
      final Stream<Position> positionStream =
          Geolocator().getPositionStream(locationOptions);
      _positionStreamSubscription = positionStream
          .listen((position) => setState(() => _positions.add(position)));
      _positionStreamSubscription.pause();
    }

    setState(() {
      if (_positionStreamSubscription.isPaused) {
        _positionStreamSubscription.resume();
      } else {
        _positionStreamSubscription.pause();
      }
    });
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription.cancel();
      _positionStreamSubscription = null;
    }
    super.dispose();
  }

   Widget _showDialog(String title, String msg1, String msg2) {
    // flutter defined function
        return AlertDialog(
          title: new Text(title),
          content: Column (children: [new Text(msg1), new Text(msg2)]),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Geolocator().checkGeolocationPermissionStatus(),
        builder:
            (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.data == GeolocationStatus.denied) {
            return _showDialog("Location", "Location services disabled", "Enable location services!");                
          }

          return _buildListView();
        });
  }


Widget _actionChip()
{
  return ActionChip(
        avatar: _isListening() ? new Icon(Icons.location_off) : new Icon(Icons.location_on),
        backgroundColor: _determineButtonColor(),
        label: _buildButtonText(),
        onPressed: () {
          setState(() {
            _toggleListening();
          });
        },
      );
}

  Widget _buildListView() {
    bool selected = true;
    String name = "abce=" + selected.toString();

    List<Widget> listItems = <Widget>[
      ListTile(
        //title: RaisedButton(
        //  child: _buildButtonText(),
        //  color: _determineButtonColor(),
        //  padding: EdgeInsets.all(8.0),
        //  onPressed: _toggleListening,
        title: _actionChip(),
        ),
      
    ];

    listItems.addAll(
        _positions.map((position) => PositionListItem(position)).toList());

    return ListView(
      children: listItems,
    );
  }

  bool _isListening() => !(_positionStreamSubscription == null ||
      _positionStreamSubscription.isPaused);

  Widget _buildButtonText() {
    return Text(_isListening() ? "Stop listening" : "Start listening");
  }

  Color _determineButtonColor() {
    return _isListening() ? Colors.red : Colors.green;
  }
}

class PositionListItem extends StatefulWidget {
  PositionListItem(this._position);

  final Position _position;

  @override
  State<PositionListItem> createState() => PositionListItemState(_position);
}

class PositionListItemState extends State<PositionListItem> {

  final Position _position;
  Position _first;
  String _address = "";

  PositionListItemState(this._position){
    if (_first == null) {
      _first = _position;
    }
  }

  @override
  Widget build(BuildContext context) {
    Row row = Row(
      children: <Widget>[
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Lat: ${_position.latitude}",
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
              Text(
                "Lon: ${_position.longitude}",
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ]),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  _position.timestamp.toLocal().toString(),
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                )
              ]),
        ),
      ],
    );
    _onTap();
    return ListTile(
      //onTap: _onTap,
      title: row,
      subtitle: Row (children: [Text(_address)]),
    );
  }

  void _onTap() async {
    String address = "unknown";
    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(_position.latitude, _position.longitude);

    if (placemarks != null && placemarks.length > 0) {
      address = _buildAddressString(placemarks.first);
    }

    setState(() {
      _address = "$address";
    });
  }

  static String _buildAddressString(Placemark placemark) {
    String name = placemark.name ?? "";
    String city = placemark.locality ?? "";
    String state = placemark.administrativeArea ?? "";
    String country = placemark.country ?? "";

    return "$name, $city, $state, $country";
  }

  void _onCalculatePressed(String la1, String lo1, String la2, String lo2) async {
    var startLatitude = double.parse(la1);
    var startLongitude = double.parse(lo1);
    var endLatitude = double.parse(la2);
    var endLongitude = double.parse(lo2);

    double distance = await Geolocator().distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);

    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).primaryColorDark,
      content: new Text("The distance is: $distance"),
    ));
  }

}

