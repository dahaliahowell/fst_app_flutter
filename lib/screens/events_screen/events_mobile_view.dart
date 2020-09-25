import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:photo_view/photo_view.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:fst_app_flutter/screens/events_screen/event_functions.dart';
//import 'package:device_calendar/device_calendar.dart';s
//import 'package:event_tool/event_tool.dart';


class EventsMobileView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListEventWidget();
  }
}

class ListEventWidget extends State<EventsMobileView> {
  EventFunctions event_functions = new EventFunctions();
  List  events = [];
  final _saved = Set<dynamic>();
  bool isSearching = false;
  List filteredEvents = [];
  final _calendarEvents = Set<dynamic>();
  bool isDark;

  //Calendar Variables
  bool deleted = false;
  bool calendarSelected = false;
  String calendarButtonText = 'Select Calendar to Add Events';
  String _currentCalendarID = '';

  final String base ="http://fst-app-2.herokuapp.com";
  final String url = "http://fst-app-2.herokuapp.com/events/";

  getEvents() async {
    var response = await Dio().get(url);
    return response.data;
  }

  void initState() {
    getEvents().then( (data) {
      setState(() {
        events = filteredEvents = data;
      });
      
    });
    super.initState();
  }
  
  void _filteredEvents(value) {
    setState(() {
      filteredEvents = events
        .where((event) => 
          event_functions.name(event).toLowerCase().contains(value.toLowerCase()))
        .toList();
    });  
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context){
          isDark = Provider.of<ThemeModel>(context).isDark;
          final cards = _saved.map(
            (dynamic event) {
              return Container(
                  padding: EdgeInsets.all(10),
                  child: Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      padding: EdgeInsets.all(20),
                      alignment: AlignmentDirectional.centerEnd,
                      color: Colors.red,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        _saved.remove(event);
                      });
                    },
                    direction: DismissDirection.endToStart,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return Scaffold(
                                appBar: AppBar(
                                  title: Text(event_functions.name(event)),
                                ),
                                body: Center(
                                  child: PhotoView(
                                    imageProvider: NetworkImage(
                                                    event_functions.posterImage(event),
                                                    
                                    ),
                                )),
                              );
                            }
                          )
                        );
                      },
                      child: Card(
                        elevation: 3,
                        child: Container(
                          height: 242.0,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 130.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    boxShadow: [
                                                  BoxShadow(
                                                      color: isDark ? Colors.black : Colors.grey,
                                                      blurRadius: 1.0,
                                                      spreadRadius: 0.0,
                                                  )
                                              ],
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            event_functions.posterImage(event),
                                            
                                        ),

                                    )
                                ),
                              ),
                              const SizedBox(height: 7),
                              ListTile(
                                title: Text(
                                          event_functions.name(event),
                                          style: TextStyle(
                                                    fontSize: 15,
                                          )
                                        ),
                                  
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget> [
                                    const SizedBox(height: 5),
                                    (event_functions.startDate(event) == event_functions.endDate(event))
                                    ? Text(
                                      'Date: ' + event_functions.startDate(event),
                                    )
                                    : Text('Start Date: ' + event_functions.startDate(event) + '\n' +
                                    'End Date: ' + event_functions.endDate(event),
                                    ),
                                    
                                    Text(
                                      'Time: ' + event_functions.startTime(event) + ' - ' + event_functions.endTime(event),
                                    ),
                                    Text(
                                      'Location: ' + event_functions.location(event),
                                    ),
                                  ]
                                ),
                                /*trailing: IconButton(
                                  icon: Icon(
                                    Icons.calendar_today, 
                                    color: isDark ? Colors.white24 : null,
                                  ), 
                                  onPressed: () {
                                      setState(() {
                                        DateTime starttime = DateTime.parse(event['start_date_time']);
                                        starttime = DateTime.utc(starttime.year, starttime.month, starttime.day, starttime.hour + 5);
                                        DateTime endtime = DateTime.parse(event['end_date_time']);
                                        endtime = DateTime.utc(endtime.year, endtime.month, endtime.day, endtime.hour + 5);
                                        Event evnt = Event(
                                              title: event_functions.name(event),
                                              startDate: starttime,
                                              endDate: endtime,
                                              location: _location(event),
                                              alarmBefore: 5

                                        );
                                        
                                        EventTool.addEvent(evnt);
                                        //Add2Calendar.addEvent2Cal(evnt);
                                      });
                                },),*/
                                
                              )
                              
                            ],
                          ),
                  )))));
        },);
    

          final divided = ListTile.divideTiles(
            context: context,
            tiles: cards
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Events'),
              
            ),
            
            body: ListView(children: divided),
          );
        }
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    isDark = Provider.of<ThemeModel>(context).isDark;
    return Scaffold(
        appBar: AppBar(
          title: !isSearching 
              ? Text('Events') 
              : TextField(
                  onChanged: (value) {
                    _filteredEvents(value);
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search Event Here',
                    hintStyle: TextStyle(
                      color: Colors.white30
                    )
                  ),
                ),
          actions: isSearching ? <Widget>[
               IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.white30
                  ), 
                onPressed: () {
                  setState(() {
                    this.isSearching = false;
                    filteredEvents = events;
                  });
                })]
            : <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ), 
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  }),
                IconButton(
                  icon: Icon(
                    Icons.bookmark,
                    color: Colors.white,
                  ),
                  onPressed: _pushSaved,
                )
            ],
        ),
        body: Center(child: _buildEvents()));
  }

  Widget _buildEvents() {
    return Container(
      padding: EdgeInsets.all(10),
        child: filteredEvents.length > 0 ? ListView.builder(
              // ignore: missing_return
              itemBuilder: (context, i) {
                if (i.isOdd) return Divider();

                int index = i ~/2 ;
                if (index < filteredEvents.length) {
        
                    final alreadySaved = _saved.contains(filteredEvents[index]);
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return Scaffold(
                                appBar: AppBar(
                                  title: Text(event_functions.name(filteredEvents[index]),
                                    style: TextStyle(
                                      fontSize: 20
                                    )
                                  ),
                                ),
                                body: Center(
                                  child: PhotoView(
                                    imageProvider: NetworkImage(
                                                    event_functions.posterImage(filteredEvents[index]),
                                                    
                                                ),
                                )),
                              );
                            }
                          )
                        );},
                      child: Card(
                        elevation: 3,
                        child: Container(
                          height: (event_functions.name(filteredEvents[index]).length > 28) ? 270.0 : 240.0,
                          child: Column(
                            children: <Widget>[
                              Container(
                                
                                height: 130.0,
                                //width: 70.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    boxShadow: [
                                                  BoxShadow(
                                                      color: isDark ? Colors.black12 : Colors.grey,
                                                      blurRadius: 1.0,
                                                      spreadRadius: 0.0,
                                                  )
                                              ],
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            event_functions.posterImage(filteredEvents[index]),
                                            
                                        ),

                                    )
                                ),
                              ),
                              const SizedBox(height: 7),
                              ListTile(
                                
                                title: Text(
                                          
                                          event_functions.name(filteredEvents[index]),
                                          style: TextStyle(
                                                    fontSize: 15,
                                                    color: isDark ? Colors.white : Colors.black,
                                                    //fontWeight: FontWeight.bold
                                          )
                                        ),
                                trailing: IconButton(
                                            icon: Icon(
                                              alreadySaved ? Icons.bookmark : Icons.bookmark_border),
                                              color: alreadySaved ? Color(0xffffd700) : (isDark ? Colors.white24 : null),
                                              onPressed: () {
                                                setState(() {
                                                  if (alreadySaved) {
                                                    _saved.remove(filteredEvents[index]);
                                                  } else {
                                                    _saved.add(filteredEvents[index]);
                                                  }
                                                });
                                              },),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget> [
                                    const SizedBox(height: 5),
                                    (event_functions.startDate(filteredEvents[index]) == event_functions.endDate(filteredEvents[index])) 
                                    ? Text(
                                        'Date: ' + event_functions.startDate(filteredEvents[index]),
                                    )
                                    : Text('Start Date: ' + event_functions.startDate(filteredEvents[index]) + '\n' +
                                    'End Date: ' + event_functions.endDate(filteredEvents[index]),
                                    ),
                                    //const SizedBox(height: 5),
                                    //Spacer(),
                                    Text(
                                      'Time: ' + event_functions.startTime(filteredEvents[index]) + ' - ' + event_functions.endTime(filteredEvents[index]),
                                    ),
                                    Text(
                                      'Location: ' + event_functions.location(filteredEvents[index]),
                                    ),
                                  ]
                                ),
                                //dense: true
                                
                              )
                              
                            ],
                          ),
                        ),
                      ),);
                  
      
    }}) : CircularProgressIndicator());
  }

}