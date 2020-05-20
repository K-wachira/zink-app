//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';
//
//
//
//class FeedFragment extends StatefulWidget {
//  @override
//  _FeedFragmentState createState() => _FeedFragmentState();
//}
//
//class _FeedFragmentState extends State<FeedFragment> {
//  List<Job> _jobList;
//  Job job;
//  final _database = FirebaseDatabase.instance.reference().child("jobs");
//  //acces files
//  Query _jobsQuery = FirebaseDatabase.instance
//      .reference()
//      .child("jobs")
//      .orderByChild("datePosted");
//  //listeners
//  StreamSubscription<Event> _onJobAddedSubscription;
//  StreamSubscription<Event> _onJobChangedSubscription;
//
////init state
//  @override
//  void initState() {
//    super.initState();
//    _jobList = List();
//    _onJobAddedSubscription = _database.onChildAdded.listen(_onJobAdded);
//    _onJobChangedSubscription = _database.onChildChanged.listen(_onJobUpdated);
//  }
//
//  @override
//  void dispose() {
//    _onJobAddedSubscription.cancel();
//    _onJobChangedSubscription.cancel();
//    super.dispose();
//  }
//
//  static const List<String> languages = <String>[
//    "secretary",
//    "IT",
//    "Freelancer",
//    "Lawyer",
//    "Catering",
//    "Doctor",
//    "Chemist",
//    "Teachers",
//    "Nursing",
//  ];
//  String _selectedMaterial = '';
//  FirebaseUtils firebaseUtils;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: CustomScrollView(slivers: <Widget>[
//        SliverAppBar(
//          expandedHeight: 50,
//          leading: Tab(icon: Image.asset("assets/puffin.png", height: 40)),
//          backgroundColor: Colors.white,
//          floating: true,
//          snap: false,
//          pinned: true,
//          shape:
//          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
//          title: GestureDetector(
//            onTap: () {
//              // Navigator.pushNamed(context, '/search');
//            },
//            child: Text(
//              "search jobapp",
//              style: TextStyle(color: Colors.grey),
//            ),
//          ),
//          elevation: 2.0,
//          actions: <Widget>[
//            Tab(
//              icon: IconButton(
//                icon: Icon(
//                  Icons.person_outline,
//                  size: 30,
//                  color: Colors.blue,
//                ),
//                onPressed: () {
//                  Navigator.pushNamed(context, '/profile');
//                },
//              ),
//            ),
//            Tab(
//              icon: IconButton(
//                icon: Icon(
//                  Icons.search,
//                  color: Colors.blue,
//                  size: 30,
//                ),
//                onPressed: () {
//                  Navigator.pushNamed(context, '/profile');
//                },
//              ),
//            ),
//          ],
//        ),
//
//        //list
//
//        /*   StreamBuilder(
//            stream: firebaseUtils.getJobsDb().onValue,
//            builder: (context, snap) {
//              if (snap.hasData && !snap.hasError && snap.data.value != null) {
//                DataSnapshot snapshot = snap.data.snapshot;
//*/
//        SliverList(
//          delegate: SliverChildBuilderDelegate(
//                (context, index) => Card(
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(20)),
//              child: Container(
//                color: Colors.white,
//                padding: EdgeInsets.all(8),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  children: <Widget>[
//                    Text(
//                      '${_jobList[index].jobTitle}',
//                      style: TextStyle(
//                          fontStyle: FontStyle.normal,
//                          fontWeight: FontWeight.bold),
//                    ),
//                    FlatButton.icon(
//
//                      icon: Icon(Icons.location_on, color: Colors.blue),
//                      label: Text("${_jobList[index].location}"),
//                    ),
//                    FlatButton.icon(
//                      icon: Icon(Icons.exposure, color: Colors.blue),
//                      label: Text("${_jobList[index].experience}"),
//                    ),
//                    FlatButton.icon(
//                      icon: Icon(Icons.attach_money, color: Colors.blue),
//                      label: Text("${_jobList[index].salary}"),
//                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        SizedBox(
//                          height: 18,
//                          width: 100,
//                          child: Text("${_jobList[index].postedby}"),
//                        ),
//                        SizedBox(
//                          height: 20,
//                          width: 100,
//                          child: Text("${_jobList[index].datePosted}"),
//                        ),
//                        RaisedButton(
//                          elevation: 1.0,
//                          color: Colors.white,
//                          highlightColor: Colors.blueAccent,
//                          shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(30)),
//                          // icon: Icon(Icons.send, color: Colors.blue),
//                          child: Text(
//                            "apply",
//                            style: TextStyle(color: Colors.blue),
//                          ),
//                          onPressed: () {
//                            _viewJob(context, job);
//                            // _bottomsheet(context);
//                          },
//                        ),
//                      ],
//                    )
//                  ],
//                ),
//              ),
//            ),
//            // Builds 1000 ListTiles
//            childCount: _jobList.length,
//          ),
//        )
//      ]),
//      floatingActionButton: FloatingActionButton.extended(
//          icon: Icon(
//            Icons.add_circle_outline,
//            color: Colors.white,
//          ),
//          label: Text(
//            "new job",
//          ),
//          onPressed: () {
//            Navigator.pushNamed(context, '/addjob');
//          }),
//    );
//  }
//
////job added
////listeners
//  void _onJobAdded(Event event) {
//    setState(() {
//      _jobList.add(new Job.fromSnapshot(event.snapshot));
//    });
//  }
//
//  void _onJobUpdated(Event event) {
//    var oldJob = _jobList.singleWhere((job) => job.jobId == event.snapshot.key);
//    setState(() {
//      _jobList[_jobList.indexOf(oldJob)] = Job.fromSnapshot(event.snapshot);
//    });
//  }
//
//  void _deleteJob(BuildContext context, Job job, int position) async {
//    await _database.child(job.id).remove().then((_) {
//      setState(() {
//        _jobList.removeAt(position);
//      });
//    });
//  }
//
//  void _viewJob(BuildContext context, Job job) async {
//    await Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => JobScreen(job)),
//    );
//  }
//
//  _bottomsheet(context) {
//    showModalBottomSheet(
//        backgroundColor: Colors.white,
//        context: context,
//        isScrollControlled: true,
//        shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
//        builder: (BuildContext bc) {
//          return SingleChildScrollView(
//            child: Container(
//              padding: EdgeInsets.all(8),
//              height: MediaQuery.of(context).size.height * .75,
//              child: Column(
//                  children: <Widget>[
//                  Text("verify details before submiting application"),
//              TextField(
//                autofocus: true,
//                decoration: InputDecoration(labelText: "username"),
//              ),
//              TextField(
//                decoration: InputDecoration(labelText: "phone number"),
//              ),
//              TextField(
//                maxLines: 4,
//                decoration: InputDecoration(
//                    labelText: "description", hintMaxLines: 5),
//              ),
//              FlatButton(
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(30)),
//
//                child: Text(
//                'submit application',
//                style: TextStyle(color: Colors.white),
//              ),
//              onPressed: () {},
//              color: Colors.lightBlue,
//            ),
////mre jobs
//            /*   Text("view related jobs"),
//                SingleChildScrollView(
//                  //scrollDirection: Axis.horizontal,
//                  child: Wrap(
//                    spacing: 4.0,
//                    children: languages
//                        .map((language) => ChoiceChip(
//                              selected: _selectedMaterial == language,
//                              backgroundColor: Utils.strToColor(language),
//                              label: Text(language.toString(),
//                                  style: TextStyle(
//                                      color: Colors.white,
//                                      fontWeight: FontWeight.bold)),
//                              avatar: _selectedMaterial == language
//                                  ? Icon(
//                                      Icons.done,
//                                      color: Colors.white,
//                                    )
//                                  : null,
//                              selectedColor: Utils.strToColor(language),
//                              onSelected: (bool isCheck) {
//                                setState(() {
//                                  _selectedMaterial = isCheck ? language : "";
//                                });
//                              },
//                            ))
//                        .toList(),
//                  ),
//                )*/
//            ],
//          ),
//          ));
//        });
//  }
//}
//
//
//class Job {
//  String jobId,
//      category,
//      jobTitle,
//      jobType,
//      experience,
//      location,
//      salary,
//      datePosted,
//      postedby,
//      description;
//
//  Job(
//      this.category,
//      this.jobId,
//      this.jobTitle,
//      this.jobType,
//      this.experience,
//      this.postedby,
//      this.location,
//      this.salary,
//      this.description,
//      this.datePosted);
//
//  Job.map(dynamic obj) {
//    this.jobId = obj['id'];
//    this.category = obj['category'];
//    this.datePosted = obj['datePosted'];
//    this.description = obj['description'];
//    this.experience = obj['experience'];
//    this.jobTitle = obj['jobTitle'];
//    this.jobType = obj['jobType'];
//    this.postedby = obj['postedby'];
//    this.location=obj['location'];
//    this.salary = obj['salary'];
//  }
//
//  String get id => jobId;
//  String get cat => category;
//  String get postdate => datePosted;
//  String get desc => description;
//  String get expe => experience;
//  String get title => jobTitle;
//  String get type => jobType;
//  String get postOwner => postedby;
//  String get sal => salary;
//  String get loc=>location;
//
//  Job.fromSnapshot(DataSnapshot snapshot)
//      : jobId = snapshot.key,
//        category = snapshot.value["category"],
//        datePosted = snapshot.value["datePosted"],
//        description = snapshot.value["description"],
//        experience = snapshot.value["experience"],
//        jobTitle = snapshot.value["jobTitle"],
//        jobType = snapshot.value["jobType"],
//        postedby = snapshot.value["postedby"],
//        location=snapshot.value["location"],
//        salary = snapshot.value["salary"];
//  toJson(){
//    return{
//      "category":category,
//      "datePosted":datePosted,
//      "description":description,
//      "experience":experience,
//      "jobTitle":jobTitle,
//      "jobType":jobType,
//      "postedby":postedby,
//      "location":location,
//      "salary":salary,
//    };
//  }
//}