import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/ultil/firebaseAuth.dart';
import 'package:collection/collection.dart';
import '../../providers/provider_college_list.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

class AppointmentDB {
  final String id;
  final int index;
  final String type;
  final String details;
  final String subject;
  final Timestamp startTime;
  final Timestamp endTime;
  static late List<Appointment> appointments;

  static final appointmentVisual = {
    "sat": {
      "color": Color.fromRGBO(4, 153, 222, 1),
      "image": 'collegeboard.png',
    },
    "mentoria": {"color": Colors.red.shade600, "image": 'logo.png'},
    "english_lesson": {
      "color": Colors.red.shade600, // not dynamic
      "image": 'logo.png' // not dynamic
    },
    "harvard_deadline": {
      "color":
          Color.fromRGBO(148, 24, 43, 1), // chnage later to a colleges list
      "image": "harvard.png"
    },
    "princeton_deadline": {
      "color": Color.fromRGBO(255, 96, 0, 1), // change later to a colleges list
      "image": 'princeton.png'
    },
    "personalized": {"color": Colors.amber.shade500, "image": 'logo.png'}
  };

  AppointmentDB({
    required this.id,
    required this.index,
    required this.type,
    required this.details,
    required this.subject,
    required this.startTime,
    required this.endTime,
  });

  static CollectionReference appointmentsCollection =
      FirebaseFirestore.instance.collection('user');

  static Future<List<Appointment>?> getAppointments(String userId) async {
    final userRef = FirebaseFirestore.instance.collection('user').doc(userId);
    final userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      final List<dynamic>? appointmentIds = userSnapshot.data()?['appointments'];
      print('APPOINTMENT IDS: $appointmentIds');
      // print('APPOINTMENTS: $appointmentIds');
      if (appointmentIds != null) {
        appointments = [];
        // print('APPOINTMENTS: $appointmentIds');
        for (final appointmentId in appointmentIds) {
          // print('APPOINTMENTS: $appointmentId');
          final DocumentSnapshot appointmentDoc = await appointmentsCollection.doc(appointmentId["id"]).get();
          print('APPOINTMENTS DOC: $appointmentDoc');
          if (appointmentDoc.exists) {
            var test = appointmentId['index'];
            print('OVOOOS');
            print("APPOINTMENT DOC $test");
            final Map<String, dynamic> appointmentData =
                appointmentDoc.data() as Map<String, dynamic>;
            appointments.add(
              Appointment(
                id: appointmentId['index'],
                // index: appointmentDoc.index,
                location: appointmentVisual[appointmentData['type'] as String]!["image"] as String,
                subject: appointmentData['subject'] as String,
                startTime: DateTime.fromMillisecondsSinceEpoch(
                  appointmentData['startTime'].seconds * 1000 +
                      appointmentData['startTime'].nanoseconds ~/ 1000000),
                endTime: DateTime.fromMillisecondsSinceEpoch(
                  appointmentData['endTime'].seconds * 1000 +
                      appointmentData['endTime'].nanoseconds ~/ 1000000),
                notes: appointmentData['details'] as String,
                color: appointmentVisual[appointmentData['type'] as String]!["color"] as Color,
              ),
            );
          }
        }
        // print('TEST: ');
        // print(appointments);
        return appointments;
      }
    }
    return null;
  }

  static Future<void> addAppointment(AppointmentDB appointment) async {
    await appointmentsCollection.add({
      'subject': appointment.subject,
      // 'index':
      'startTime': appointment.startTime,
      'endTime': appointment.endTime,
      'details': appointment.details,
      'type': appointment.type,
    });
  }

  static Future<void> updateAppointment(AppointmentDB appointment) async {
    await appointmentsCollection.doc(appointment.id).update({
      'subject': appointment.subject,
      'startTime': appointment.startTime,
      'endTime': appointment.endTime,
      'details': appointment.details,
      'type': appointment.type,
    });
  }



  static Future<void> deleteAppointment(int appointmentValue) async {
    final user = await AuthServiceCadasto().getUserId();
    if (user == null) {
      return;
    }
    print('USER ID: $user');
    // final userRef = FirebaseFirestore.instance.collection('user').doc("0zBcxmwQiHN08btojOS5rO2Fole2");
    final userRef = FirebaseFirestore.instance.collection('user').doc(user);
    final userDoc = await userRef.get();

    final appointmentsMatrix = userDoc.data()?['appointments'] as List<dynamic>?;
    print('APPOINTMENT MATRIX: $appointmentsMatrix');
    if (appointmentsMatrix == null) {
      return;
    }

    for (int i = 0; i < appointmentsMatrix.length; i++) {
      final appointmentRow = [appointmentsMatrix[i]];
      final appointmentIndex = appointmentRow.indexWhere((appointment) => appointment['index'] == appointmentValue || appointment == appointmentValue);
      if (appointmentIndex >= 0) {
        appointmentRow.removeAt(appointmentIndex);
        if (appointmentRow.isEmpty) {
          appointmentsMatrix.removeAt(i);
        }
        break;
      }
    }

    await userRef.update({'appointments': appointmentsMatrix});
  }

  // static Future<List<String>> getAllNames() async {
  static Future<dynamic> getAllNames() async {
    List<List> names = [];
    try {
      QuerySnapshot querySnapshot = await appointmentsCollection.get();
      print("RATOOO: ${querySnapshot.size}");
      if (querySnapshot.size > 0) {
        for (QueryDocumentSnapshot user in querySnapshot.docs) {
          print("DOCUMENTO: ${user.data()}");
          Map<String, dynamic> data = user.data() as Map<String, dynamic>;
          String email = data["email"] ?? "";
          String name = data['primeiro_nome'] ?? "";
          String lastName = data['segundo_nome'] ?? "";
          String id = data['userId'] ?? "";
          String isMentor = data['mentor'] ?? "false";

          print("Mentor niggga: $email");

          if (isMentor == "false") {
            //  names.add('$name $lastName $id');
             names.add(['$name $lastName', id]);
          }
        }
      } else {
        print('No documents found in the "user" collection.');
      }
    } catch (e) {
      print('Error fetching documents: $e');
    }

    return names;
  }

}

class NewCalendar extends StatefulWidget {
  // const NewCalendar({super.key});
  const NewCalendar({Key? key}) : super(key: key);
  
  @override
  State<NewCalendar> createState() => _NewCalendarState();
}

class _NewCalendarState extends State<NewCalendar> {
  late MeetingDataSource events;
  bool mentor = true;
  // late List<Appointment>? _shiftCollection = await AppointmentDB.getAppointments('9');
  bool applicationDeadlines = true;
  bool testDeadlines = true;
  bool mentoria = true;
  late List<Appointment> _shiftCollection;
  ProviderCollegeList collegeProvider = ProviderCollegeList();
  List<List> alunos = [];
  // final CalendarDataSource dataSource = CalendarDataSource(events, primaryKey: 'id');

  void removeAppointmentFromEvents(Appointment appointment) { // REMOVE APPOINTMENT FUNCTION (FIX)
    print("APPOINTMENT TO REMOVE: $appointment");
    var id = appointment.id as int;
    events.appointments!.remove(appointment);

    print("TESTE2: $id");

    List<Appointment> newList = <Appointment>[
      Appointment(
        id: 123,
        // index: appointmentDoc.index,
        location: "Caltech.png",
        subject: "Teste",
        startTime: DateTime(2023, 5, 27, 9, 30),
        endTime: DateTime(2023, 5, 27, 10, 30),
        notes: "Funcionando",
        color: Colors.green.shade300,
      ),
    ];

    List<Appointment> shift = _shiftCollection;

    for (var i = 0; i < shift.length; i++) {
      if (id == shift[i].id) {
        shift.remove(shift[i]);
        break;
      }
    }

    setState(() {
      events = MeetingDataSource(shift);
    });

    print("EVENTS UPDATED DDDD: $events");
    AppointmentDB.deleteAppointment(id);
    return;
  }

  void loadAppointments() async {
    _shiftCollection = <Appointment>[];
    events = MeetingDataSource(_shiftCollection);
    final AuthServiceCadasto authService = AuthServiceCadasto();
    final String? userId = await authService.getUserId();
    List<Appointment>? appointments =
        await AppointmentDB.getAppointments(userId as String);
        // await AppointmentDB.getAppointments("0zBcxmwQiHN08btojOS5rO2Fole2");
    // print('APPOINTMENT: ${appointments}');

    // var teste = await AppointmentDB.getAllNames() ?? [];

    var ovos = await AppointmentDB.getAllNames();

    List<String> teste = [];

    setState(() {
      alunos = ovos;
    });

    print("ALUNOS negrsss: $alunos");
    print("ALUNOS GAYS: $ovos");

    var number = appointments!.length;
    var test = appointments[number - 1].id;
    for (var i = 0; i < collegeProvider.colleges.length; i++) {
      var note = collegeProvider.colleges[i]["name"];
      final Appointment newAppointment = Appointment(
        location: collegeProvider.colleges[i]["logo"],
        id: i, // random id
        subject: collegeProvider.colleges[i]["alias"],
        notes: 'Deadline for $note',
        color: collegeProvider.colleges[i]["color"],
        startTime: DateTime(2023, 04, 13 + ((i * 2) - 1) , 9, 0, 0),
        endTime: DateTime(2023, 04, 13 + ((i * 2) - 1), 10, 0, 0),
       
      );
      appointments?.add(newAppointment);
    }
    print("COLLEGE PROVIDER: $test");
    if (appointments != null) {
      setState(() {
        _shiftCollection = appointments ?? <Appointment>[];
        events = MeetingDataSource(_shiftCollection);
        // _shiftCollection = appointments;
      });
      // print('SHIFT COLLECTION: ${_shiftCollection}');
      // print('EVENTS: $events}');
    }
  }

  @override
  void initState() {
    // addAppointments();
    loadAppointments();
    // print('SHIFT COLLECTION: ${_shiftCollection}');
    // print('EVENTS: $events}');
    // events = MeetingDataSource(_shiftCollection);
    // print('EVENTS: ${_shiftCollection}'); 
    // final test = AppointmentDB.getAppointments('xHEsLHdqqQTSA3HaNSXlW7kNMtg1');
    // AppointmentDB.getAppointments('9');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: mentor,
        child: FloatingActionButton(
          child: Icon(CupertinoIcons.plus),
          onPressed: () {
            popUpCreateAppointment(context);
            print('SHIFT COLLECTION: ${events}');
          },
        ),
      ),
      appBar: AppBar(
        title: const Text('CALENDÁRIO'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset('logo.png'),
                    ),
                  ),
                  const Text(
                    'Filtrar',
                    textAlign: TextAlign.left,
                    textScaleFactor: 1.3,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                activeColor: Colors.amber.shade500,
                                value: applicationDeadlines,
                                onChanged: ((value) => {
                                    setState(() {
                                      applicationDeadlines = value!;
                                    })
                                })),
                            Text('Datas de Application')
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: testDeadlines,
                                activeColor: Colors.red.shade600,
                                onChanged: ((value) => {
                                  setState(() {
                                    testDeadlines = value!;
                                  })
                                })),
                            Text('Datas de Testes')
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: TextButton(
                        child: Ink(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            color: appointmentVisual["sat"]!["color"] as Color,
                            constraints: BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Selecionar Data de SAT",
                              style: TextStyle(color: Colors.white),
                            )
                          )
                        ),
                        onPressed: () => {
                          popupSelectTestDays(context)
                        },
                      ),
                    )
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: SfCalendar(
              onTap: (CalendarTapDetails details) {
                if (details.appointments!.isNotEmpty) {
                  if (details.targetElement == CalendarElement.calendarCell) {
                    var cellAppointments = details.appointments;
                    popUpAppointmentDetails(context, cellAppointments);
                  }
                }
              },
              // monthCellBuilder: monthCellBuilder,
              allowDragAndDrop: true,
              // cellBorderColor: Colors.white,
              allowAppointmentResize: true,
              // appointmentBuilder: (BuildContext context, CalendarAppointmentDetails details) {
              //   return customAppointmentBuilder(context, details, events);
              // },
              appointmentBuilder: appointmentBuilder,
              view: CalendarView.month,
              monthViewSettings: const MonthViewSettings(
                  showAgenda: true,
                  agendaViewHeight: 100,
                  // agendaItemHeight: 80
                  appointmentDisplayCount: 2,
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment),
              timeSlotViewSettings:
                  const TimeSlotViewSettings(startHour: 9, endHour: 18),
              dataSource: events,
              onDragEnd: dragEnd,
            ),
          ),
        ],
      ),
    );
  }

  void dragEnd(AppointmentDragEndDetails appointmentDragEndDetails) { // WRONG TIME WHEN APPOINTMENT DRAG AND DROP
    final dynamic draggedAppointment = appointmentDragEndDetails.appointment!;
    final DateTime? newStartTime = appointmentDragEndDetails.droppingTime;

    print("DROPPING TIME: $draggedAppointment");

    var test = events.appointments;

    print("DATA TYPE: $test");

    if (newStartTime != null) {
      final List<Appointment> updatedAppointments = List.from(events.appointments!);
      final int draggedIndex = updatedAppointments.indexOf(draggedAppointment);

      if (draggedIndex >= 0) {
        final Appointment updatedAppointment = draggedAppointment.copyWith(startTime: newStartTime);
        updatedAppointments[draggedIndex] = updatedAppointment;
        updateDataSource(updatedAppointments);
      }
    }
    
    // if (newStartTime != null) {
    //   final List<dynamic> updatedAppointments = events.appointments!;
      
    //   // Find the dragged appointment in the list
    //   final int draggedIndex = updatedAppointments.indexWhere((element) => element.id == appointment.id);
    //   if (draggedIndex >= 0) {
    //     // Create a copy of the appointment and update its start time
    //     final Appointment draggedAppointment = updatedAppointments[draggedIndex].copyWith(startTime: newStartTime);
        
    //     // Remove the dragged appointment from the list
    //     updatedAppointments.removeAt(draggedIndex);
        
    //     // Find the index to insert the dragged appointment based on the new start time
    //     final int insertIndex = updatedAppointments.indexWhere((element) => element.startTime.isAfter(newStartTime));
        
    //     // Insert the dragged appointment at the appropriate position
    //     if (insertIndex >= 0) {
    //       updatedAppointments.insert(insertIndex, draggedAppointment);
    //     } else {
    //       updatedAppointments.add(draggedAppointment);
    //     }
        
    //     // Update the data source
    //     updateDataSource(updatedAppointments);
    //   }
    // }
  }

  void updateDataSource(List<dynamic> updatedAppointments) {
    setState(() {
      events.appointments = updatedAppointments;
      // events = MeetingDataSource(updatedAppointments.cast<Appointment>());
    });
  }

  List<Map<String, Object>> userAppointments = [
    {
      "id":
          0, // id of appoitment => create table that connects appointment IDs to User's id
      "type": "sat",
      "date": "2023/02/24",
      "duration": 1, // in hours
      "label":
          "SAT", // SAT: ${"Lucas Kaspary"} should show for instructor based on student ID and NAME
      "details":
          "SAT test day", // add SAT test day for ${student_name} in details
    },
    {
      "id":
          1, // id of appoitment => create table that connects appointment IDs to User's id
      "type": "mentoria",
      "date": "2023/02/24",
      "duration": 1, // in hours
      "label":
          "Mentoria Gabriel", // SAT: ${"Lucas Kaspary"} should show for instructor based on student ID and NAME
      "details":
          "Gabriel da a bunda", // add SAT test day for ${student_name} in details
    },
    {
      "id":
          2, // id of appoitment => create table that connects appointment IDs to User's id
      "type": "english_lesson",
      "date": "2023/02/24",
      "duration": 1, // in hours
      "label":
          "Aula de Inglês", // SAT: ${"Lucas Kaspary"} should show for instructor based on student ID and NAME
      "details":
          "Aula de inglês semanal com meu pau", // add SAT test day for ${student_name} in details
    },
    {
      "id":
          3, // id of appoitment => create table that connects appointment IDs to User's id
      "type": "harvard_deadline",
      "date": "2023/02/24",
      "duration": 1, // in hours
      "label":
          "Harvard", // SAT: ${"Lucas Kaspary"} should show for instructor based on student ID and NAME
      "details":
          "Application deadline for Harvard University", // add SAT test day for ${student_name} in details
    },
    {
      "id":
          4, // id of appoitment => create table that connects appointment IDs to User's id
      "type": "princeton_deadline",
      "date": "2023/02/24",
      "duration": 1, // in hours
      "label":
          "Princeton", // SAT: ${"Lucas Kaspary"} should show for instructor based on student ID and NAME
      "details":
          "Application deadline for Princeton University", // add SAT test day for ${student_name} in details
    },
    {
      "id":
          5, // id of appoitment => create table that connects appointment IDs to User's id
      "type": "personalized",
      "date": "2023/02/24",
      "duration": 1, // in hours
      "label":
          "Study for SAT", // SAT: ${"Lucas Kaspary"} should show for instructor based on student ID and NAME
      "details":
          "Study for SAT", // add SAT test day for ${student_name} in details
    }
  ];

  var appointmentVisual = {
    "sat": {
      "color": Color.fromRGBO(4, 153, 222, 1),
      "image": 'collegeboard.png',
    },
    "mentoria": {"color": Colors.red.shade600, "image": 'logo.png'},
    "english_lesson": {
      "color": Colors.red.shade600, // not dynamic
      "image": 'logo.png' // not dynamic
    },
    "harvard_deadline": {
      "color":
          Color.fromRGBO(148, 24, 43, 1), // chnage later to a colleges list
      "image": "harvard.png"
    },
    "princeton_deadline": {
      "color": Color.fromRGBO(255, 96, 0, 1), // change later to a colleges list
      "image": 'princeton.png'
    },
    "personalized": {"color": Colors.amber.shade500, "image": 'logo.png'}
  };

  var appointmentTypes = {
    "college_deadline": [
      {
        'name': 'Harvard University',
        'image':
            'harvard.png', // no need to store image string in firebase => connect to other object
        'color': Color.fromRGBO(148, 24, 43, 1),
        'details': 'Application deadline for Harvard University',
        'start_time': DateTime(2023, 02, 24, 8, 0, 0),
        'end_time': DateTime(2023, 02, 24, 9, 0, 0),
      },
      {
        'name': 'Princeton University',
        'image': 'princeton.png',
        'color': Color.fromRGBO(255, 96, 0, 1),
        'details': 'Application deadline for Princeton University',
        'start_time': DateTime(2023, 02, 24, 8, 0, 0),
        'end_time': DateTime(2023, 02, 24, 9, 0, 0),
      }
    ],
    'test_days': [
      {
        'name': 'SAT',
        'image': 'collegeboard.png',
        'color': Color.fromRGBO(4, 153, 222, 1),
        'start_time': DateTime(2023, 02, 24, 8, 0, 0),
        'end_time': DateTime(2023, 02, 24, 9, 0, 0),
      }
    ],
    'class_days': [
      {
        'name': 'Mentoria Gabriel gay',
        'image': 'conquistando a bunda',
        'color': Colors.red.shade600,
        'start_time': DateTime(2023, 02, 24, 8, 0, 0),
        'end_time': DateTime(2023, 02, 24, 9, 0, 0),
      }
    ]
  };

  Future popupSelectTestDays(context) => showDialog(
    context: context, 
    builder: (context) => 
      TestDaysDialog(
        events: events,
        appointmentVisual: appointmentVisual
      )
  );

  Future popUpAppointmentDetails(context, cellAppointments) =>
    showDialog(
    context: context,
    builder: (context) =>
        // showCellAppointments(context, events, cellAppointments),
        AppointmentDetailsDialog(
          cellAppointments: cellAppointments, 
          removeAppointmentFromEvents: removeAppointmentFromEvents,
          events: events,
          mentor: mentor
        )
    );

  Future popUpCreateAppointment(context) => showDialog(
      context: context,
      builder: (context) => 
          // createAppointment(context, events, appointmentVisual)
      AppointmentDialog(
        events: events,
        appointmentVisual: appointmentVisual,
        alunos: alunos
      )
  );
}


class TestDaysDialog extends StatefulWidget {
  final MeetingDataSource events;
  final Map appointmentVisual;

  const TestDaysDialog({super.key, required this.events, required this.appointmentVisual});

  @override
  State<TestDaysDialog> createState() => _TestDaysDialogState();
}

class _TestDaysDialogState extends State<TestDaysDialog> {
 
  List<List<DateTime>> datesSAT = [ // TEST DAY, DEADLINE
    [DateTime(2023, 6, 3), DateTime(2023, 5, 19)]
  ];

  Map<DateTime, List<dynamic>> satDatesMap = {
    DateTime(2023, 6, 3): [
      false,
      DateTime(2023, 5, 19)
    ]
  };

  String getDate(DateTime date) {
    int year = date.year;
    // String month = DateFormat("MMMM").format(date);
    int month = date.month;
    int day = date.day;

    String testDate = "DATE: $day/$month/$year";

    return testDate;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Escolher as datas de prova',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < datesSAT.length; i++)
            CheckboxListTile(
              title: Text(getDate(datesSAT[i][0])),
              value: satDatesMap[datesSAT[i][0]]![0],
              onChanged: (value) {
                setState(() {
                  satDatesMap[datesSAT[i][0]]![0] = value!;
                });
              },
            ), 
          Container(
            margin: EdgeInsets.only(top: 20),
            child: TextButton(
              onPressed: () async {
                 Navigator.of(context).pop(); 
                if (satDatesMap[datesSAT[0][0]]![0] == true) { // TODO
                  int randomId = Random().nextInt(100000);
                  final Appointment newAppointment = Appointment(
                    location: widget.appointmentVisual["sat"]["image"],
                    id: randomId, // random id
                    subject: 'SAT',
                    notes: "Dia de SAT",
                    color: widget.appointmentVisual["sat"]["color"],
                    startTime: DateTime(2023, 6, 3, 8),
                    endTime: DateTime(2023, 6 , 3, 8 + 5),
                    startTimeZone: '',
                    endTimeZone: '',
                  );
                  final AuthServiceCadasto authService = AuthServiceCadasto();
                  final String? userId = await authService.getUserId();
                  final userRef = FirebaseFirestore.instance.collection('user').doc(userId);
                  final userDoc = await userRef.get();
                  final appointmentsMatrix = userDoc.data()?['appointments'] as List<dynamic>?;
                  var length = appointmentsMatrix?.length;
                  print('APPOINTMENT MATRIX: $length');
                  if (appointmentsMatrix == null) {
                    return;
                  }
                  final newAppointmentRef = AppointmentDB.appointmentsCollection.doc();

                  print("NEW APPOINTMENT CU $newAppointmentRef");
                  final Map<String, dynamic> newAppointmentData = {
                    'id': newAppointmentRef.id,
                    'index': appointmentsMatrix.isNotEmpty ? appointmentsMatrix.length + 1 : 1, 
                    'subject': 'SAT',
                    'startTime': newAppointment.startTime,
                    'endTime': newAppointment.endTime,
                    'details': newAppointment.notes,
                    'type': "sat",
                  };
                  await userRef.update({
                    'appointments': FieldValue.arrayUnion([newAppointmentData]),
                  });
                  await newAppointmentRef.set({
                    'userId': userId,
                    ...newAppointmentData,
                  });
                  // print('New appointment created.');
                  if (newAppointment.subject.isNotEmpty) {
                    widget.events.appointments!.add(newAppointment);
                    widget.events.notifyListeners(
                        CalendarDataSourceAction.add, <Appointment>[newAppointment]);
                    // print('TYPE: $type');            
                  }
                }
              },
              child:Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  color: Color.fromRGBO(4, 153, 222, 1),
                  constraints: BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Confirmar',
                    textAlign: TextAlign.center,
                     style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )           
        ],
      )
    );
  }
}


Widget monthCellBuilder(BuildContext context, MonthCellDetails details) {
  var test = details.appointments;
  // print("DETAILS: $test.");
  if (details.appointments.isNotEmpty) {
    return InkWell(
      onTap: () {
        print('object');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          details.date.day.toString(),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  return Container(
    // color: Colors.black12,
    // child: Text(
    //   "cu"
    // ),
  );

}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> shiftCollection) {
    appointments = shiftCollection;
  }
}

Widget appointmentBuilder(BuildContext context,
    CalendarAppointmentDetails calendarAppointmentDetails) {
  final Appointment appointment = calendarAppointmentDetails.appointments.first;
  // final int index = events.appointments!.indexOf(appointment);
  // final Key uniqueKey = ValueKey('${appointment.id}_$index');

  // CREATE A NEW APPOINTMENT CLASS TO ADD MORE PARAMETERS TO IT.
  // CREATE FUNCTIONLITY TO CHECK APPOINTMENT IF COMPLETED

  // int index = appointment.id as int;

  print("NEW TEST APP: $appointment");

  return GestureDetector(
    key: UniqueKey(),
    onTap: () {
      // final Appointment removeAppointment = events.appointments![index];
      print('test');
    },
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7), color: appointment.color),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.only(right: 5),
                  child: Image.asset(
                    (appointment.location)
                        .toString(), // find a way of assing this to the appointment variable
                  ),
                ),
                Container(
                  // padding: EdgeInsets.only(left: 4),
                  child: Text(
                    appointment.subject,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget customAppointmentBuilder(BuildContext context,
    CalendarAppointmentDetails details, MeetingDataSource events) {
  final Appointment appointment = details.appointments.first;

  // CREATE A NEW APPOINTMENT CLASS TO ADD MORE PARAMETERS TO IT.
  // CREATE FUNCTIONLITY TO CHECK APPOINTMENT IF COMPLETED

  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7), color: appointment.color),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.only(right: 5),
                child: Image.asset(
                  (appointment.location)
                      .toString(), // find a way of assing this to the appointment variable
                ),
              ),
              Container(
                // padding: EdgeInsets.only(left: 4),
                child: Text(
                  appointment.subject,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Cretae appointment popup 
class AppointmentDialog extends StatefulWidget {
  final MeetingDataSource events;
  final Map appointmentVisual;
  final List<List> alunos;

  AppointmentDialog({required this.events, required this.appointmentVisual, required this.alunos});

  @override
  _AppointmentDialogState createState() => _AppointmentDialogState();
}

class _AppointmentDialogState extends State<AppointmentDialog> {
  String subject = '';
  String details = '';
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  String type = 'mentoria';
  bool isRepeated = false;
  // List<bool> repeatDays = List<bool>.filled(7, false);
  Map<String, bool> repeatedDays = {
    "monday": false,
    "tuesday": false,
    "wednesday": false,
    "thursday": false,
    "friday": false,
    "saturday": false,
    "sunday": false
  };
  String selectedClass = "select";
  Map<String, List> classToStudent = { // Get selected student by id from firebase and add appointment based on the id fetched
    "a": [
      "Burro",
      "Viado",
      "Puto",
    ],
    "b": [
      "Gay",
      "Bixa",
      "Homo",
    ],
    "c": [
      "Imbecil",
      "Doente",
      "Pobre",
    ],
  };
  String selectedStudentID = 'null';

  Future<void> selectStartTime() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          startTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> selectEndTime() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          endTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Adicionar um evento',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: type,
            onChanged: (value) => setState(() {
              type = value!;
            }),
            items: const
            <DropdownMenuItem<String>>[
              // DropdownMenuItem(
              //   value: 'sat',
              //   child: Text('SAT'),
              // ),
              DropdownMenuItem(
                value: 'mentoria',
                child: Text('Mentoria'),
              ),
              DropdownMenuItem(
                value: 'personalized',
                child: Text('Personalized'),
              ),
            ],
          ),
          Visibility(
            visible: type != 'sat',
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Subject',
              ),
              onChanged: (value) => setState(() {
                subject = value;
              }),
            ),
          ),
          Visibility(
            visible: type != 'sat',
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Details',
              ),
              onChanged: (value) => setState(() {
                details = value;
              }),
            ),
          ),
          Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Start Time',
                    ),
                    readOnly: true,
                    onTap: selectStartTime,
                    controller: TextEditingController(
                    text: startTime?.toString() ?? '',
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'End Time',
                  ),
                  readOnly: true,
                  onTap: selectEndTime,
                  controller: TextEditingController(
                    text: endTime?.toString() ?? '',
                  ),
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 8),
          //   child: DropdownButtonFormField<String>(
          //     value: selectedClass,
          //     onChanged: (value) => setState(() {
          //       selectedClass = value!;
          //       selectedStudentID = "null";
          //     }),
          //     items: const <DropdownMenuItem<String>>[
          //       DropdownMenuItem(
          //         enabled: false,
          //         value: "select",
          //         child: Text("Selecionar Turma")
          //       ),
          //       DropdownMenuItem(
          //         value: 'a',
          //         child: Text('Turma A'),
          //       ),
          //       DropdownMenuItem(
          //         value: 'b',
          //         child: Text('Turma B'),
          //       ),
          //       DropdownMenuItem(
          //         value: 'c',
          //         child: Text('Turma C'),
          //       ),
          //     ],
          //   ),
          // ),
          // Visibility(
          //   visible: selectedClass != "select",
          //   child: DropdownButtonFormField<String>(
          //     value: selectedStudentID,
          //     onChanged: (value) => setState(() {
          //       selectedStudentID = value!;
          //     }),
          //     items: [
          //       DropdownMenuItem(
          //         enabled: false,
          //         value: "null",
          //         child: Text('Selecionar Aluno'),
          //       ),
          //       if (selectedClass != "select")
          //       ...classToStudent[selectedClass]!.map<DropdownMenuItem<String>>((value) {
          //         return DropdownMenuItem(
          //           value: value,
          //           child: Text(value)
          //         );
          //       }).toList()
          //     ]
          //   )
          // ),
          DropdownButtonFormField<String>(
            value: selectedStudentID,
            onChanged: (value) => setState(() {
              selectedStudentID = value!;
              print("SELECTED ID: $value");
            }),
            items: [
              const DropdownMenuItem(
                enabled: false,
                value: "null",
                child: Text("Selecionar Aluno")
              ),
              ...widget.alunos.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem(
                    value: value[1],
                    child: Text(value[0])
                  );
                }).toList()
            ],
          ),
          // Visibility(
          //   visible: type != "sat",
          //   child: 
          //     Row(
          //       children: [
          //         Text('Repetir evento'),
          //         Checkbox(
          //           value: isRepeated,
          //           onChanged: (value) {
          //             setState(() {
          //               isRepeated = value!;
          //             });
          //           },
          //         ),
          //       ],
          //     ),
          // ),
          Visibility(
            visible: isRepeated,
            child: Column(
            children: [
              CheckboxListTile(
                title: Text('Monday'),
                // value: repeatDays[DateTime.monday - 1],
                value: repeatedDays["monday"],
                onChanged: (value) {
                  setState(() {
                    // repeatDays[DateTime.monday - 1] = value!;
                    repeatedDays["monday"] = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Tuesday'),
                value: repeatedDays["tuesday"],
                onChanged: (value) {
                  setState(() {
                    repeatedDays["tuesday"] = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Wednesday'),
                value: repeatedDays["wednesday"],
                onChanged: (value) {
                  setState(() {
                    repeatedDays["wednesday"] = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Thursday'),
                value: repeatedDays["thursday"],
                onChanged: (value) {
                  setState(() {
                    repeatedDays["thursday"] = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Friday'),
                value: repeatedDays["friday"],
                onChanged: (value) {
                  setState(() {
                    repeatedDays["friday"] = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Saturday'),
                value: repeatedDays["saturday"],
                onChanged: (value) {
                  setState(() {
                    repeatedDays["saturday"] = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Sunday'),
                value: repeatedDays["sunday"],
                onChanged: (value) {
                  setState(() {
                    repeatedDays["sunday"] = value!;
                  });
                  print("REPEAT: $repeatedDays");
                },
              ),
            ],
          ),
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () async {
          print("SELECTED BUNDA: $selectedStudentID");
          Navigator.of(context).pop();
          print('Subject: $subject');
          print('Details: $details');
          print('Start Time: $startTime');
          print('End Time: $endTime');
          int randomId = Random().nextInt(100000);
          final Appointment newAppointment = Appointment(
            location: widget.appointmentVisual[type]["image"],
            id: randomId, // random id
            subject: type == 'sat' ? 'SAT' : subject,
            notes: details,
            color: widget.appointmentVisual[type]["color"],
            startTime: startTime,
            endTime: endTime,
            startTimeZone: '',
            endTimeZone: '',
          );
          final AuthServiceCadasto authService = AuthServiceCadasto();
          final String? userId = await authService.getUserId();

          print("USER IDCU: $userId");

          final userRef = FirebaseFirestore.instance.collection('user').doc(selectedStudentID); // in place of userId
          final userDoc = await userRef.get();
          final appointmentsMatrix = userDoc.data()?['appointments'] as List<dynamic>?;
          var length = appointmentsMatrix?.length;
          print('APPOINTMENT MATRIX: $length');
          if (appointmentsMatrix == null) {
            return;
          }
          final newAppointmentRef = AppointmentDB.appointmentsCollection.doc();
          print("NEW APPOINTMENT CU $newAppointmentRef");
          final Map<String, dynamic> newAppointmentData = {
            'id': newAppointmentRef.id,
            'index': appointmentsMatrix.isNotEmpty ? appointmentsMatrix.length + 1 : 1, 
            'subject': type == 'sat' ? 'SAT' : newAppointment.subject,
            'startTime': newAppointment.startTime,
            'endTime': newAppointment.endTime,
            'details': newAppointment.notes,
            'type': type,
          };
          await userRef.update({
            'appointments': FieldValue.arrayUnion([newAppointmentData]),
          });
          await newAppointmentRef.set({
            'userId': userId, // userId
            ...newAppointmentData,
          });
          // print('New appointment created.');
          if (newAppointment.subject.isNotEmpty) {
            widget.events.appointments!.add(newAppointment);
            widget.events.notifyListeners(
                CalendarDataSourceAction.add, <Appointment>[newAppointment]);
            print('TYPE: $type');            
          }


          final userRefAluno = FirebaseFirestore.instance.collection('user').doc(selectedStudentID);
          final userDocAluno = await userRefAluno.get();
          final appointmentsMatrixAluno = userDocAluno.data()?['appointments'] as List<dynamic>?;
          var lengthAluno = appointmentsMatrixAluno?.length;
          print('APPOINTMENT MATRIX: $lengthAluno');
          if (appointmentsMatrixAluno == null) {
            return;
          }
          final newAppointmentRefAluno = AppointmentDB.appointmentsCollection.doc();
          print("NEW APPOINTMENT CU $newAppointmentRefAluno");
          final Map<String, dynamic> newAppointmentDataAluno = {
            'id': newAppointmentRefAluno.id,
            'index': appointmentsMatrixAluno.isNotEmpty ? appointmentsMatrixAluno.length + 1 : 1, 
            'subject': type == 'sat' ? 'SAT' : newAppointment.subject,
            'startTime': newAppointment.startTime,
            'endTime': newAppointment.endTime,
            'details': newAppointment.notes,
            'type': type,
          };
          await userRefAluno.update({
            'appointments': FieldValue.arrayUnion([newAppointmentDataAluno]),
          });
          await newAppointmentRefAluno.set({
            'userId': selectedStudentID,
            ...newAppointmentData,
          });
          // print('New appointment created.');
          // if (newAppointment.subject.isNotEmpty) {
          //   widget.events.appointments!.add(newAppointment);
          //   widget.events.notifyListeners(
          //       CalendarDataSourceAction.add, <Appointment>[newAppointment]);
          //   print('TYPE: $type');            
          // }

          // events.appointments.remove();
        },
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            color: Colors.red.shade600,
            constraints: BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              'Adicionar',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      )
    ],
  );}
}

// Widget removeAppointment() // create a widegt to dincamically display the appointments in a cell

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('bunda'),
    );
  }
}



Widget showCellAppointments(
    BuildContext context, MeetingDataSource events, dynamic cellApointments) {
  String appointment = cellApointments[0].subject;
  List<String> appointmentSubjects = [];

  for (var cellAppointment in cellApointments) {
    appointmentSubjects.add(cellAppointment.subject);
  }

  return AlertDialog(
    title: Text(
      'Appointment Details',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.green.shade700,
          fontWeight: FontWeight.bold,
          fontSize: 28),
    ),
    actions: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < appointmentSubjects.length; i++) 
          GestureDetector(
            child: Text(
              appointmentSubjects[i],
              textAlign: TextAlign.center,
            ),
            onTap: () {
              events.appointments!.remove(cellApointments[0]);
              events.notifyListeners(CalendarDataSourceAction.remove, <Appointment>[cellApointments[0]]);
              appointmentSubjects.remove(appointmentSubjects[i]);
              // AppointmentDB.deleteAppointment();
            },
          )
        ],
      ),
      TextButton(
        onPressed: () async {
          Navigator.of(context).pop();
          var test = events.appointments![0];
          print('REMOVEEEEEEEEEEEEEEEEEEEEEE THE EVENTS: $test.');
        },
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade700,
                  Colors.green.shade700,
                  Colors.green.shade700
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            color: Colors.green.shade700,
            constraints: BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              'Ok',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      )
    ],
  );
}

// Vizualize appointment list and remove appointment widget
class AppointmentDetailsDialog extends StatefulWidget {
  final dynamic cellAppointments;
  final MeetingDataSource events;
  final Function(Appointment) removeAppointmentFromEvents;
  final bool mentor;

  AppointmentDetailsDialog({
    required this.cellAppointments,
    required this.events,
    required this.removeAppointmentFromEvents,
    required this.mentor
  });

  @override
  _AppointmentDetailsDialogState createState() =>
      _AppointmentDetailsDialogState();
}

class _AppointmentDetailsDialogState extends State<AppointmentDetailsDialog> {
  late String appointment;
  late List<String> appointmentSubjects;
  // bool isExpanded = false;
  late Map<int, bool> appointmentExpand;

  String convertDateTime(DateTime time) {
    String formattedTime = DateFormat('HH:mm').format(time);
    return "Horário: $formattedTime";
  }

  String getDuration(DateTime startTime, DateTime endTime) {
    Duration duration = endTime.difference(startTime);
    int hours = duration.inHours;
    int minutes = duration.inMinutes;
    minutes = minutes - (60 * hours);
    String formattedDuration;

    if (minutes == 0) {
      formattedDuration = "Duração: $hours h";
    } else if (hours == 0) {
      formattedDuration = "Duração: $minutes min";
    } else {
      formattedDuration = "Duração: $hours h $minutes min";
    }

    return formattedDuration;
  }

  @override
  void initState() {
    super.initState();
    appointment = widget.cellAppointments[0].subject;
    appointmentSubjects = [];
    appointmentExpand = {};
    for (var cellAppointment in widget.cellAppointments) {
      appointmentSubjects.add(cellAppointment.subject);
      appointmentExpand[cellAppointment.id] = false;
    }
    var data = widget.cellAppointments[0].id;
    print("EXPANDED rego: $data");
  }

  @override
  Widget build(BuildContext context,) {

  void removeEvents(Appointment appointment) {
    widget.removeAppointmentFromEvents(appointment);
  }

    return AlertDialog(
    title: Text(
      'Appointment Details',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.red.shade600,
          fontWeight: FontWeight.bold,
          fontSize: 28),
    ),
    actions: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        for (int i = 0; i < appointmentSubjects.length; i++) 
          Center(
            key: ValueKey(i),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: widget.cellAppointments[i].color,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 30,
                            margin: EdgeInsets.only(right: 20),
                            child: Image.asset(widget.cellAppointments[i].location)
                          ),
                          Text(
                            appointmentSubjects[i],
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),                          
                        ],
                      ),
                      GestureDetector(
                        child: Icon(
                          color: Colors.white,
                          appointmentExpand[widget.cellAppointments[i].id] ?? false ? Icons.expand_less : Icons.expand_more,
                        ),
                        onTap: () {
                          setState(() {
                            appointmentExpand[widget.cellAppointments[i].id] = !appointmentExpand[widget.cellAppointments[i].id]!;
                          });
                        },
                      ),
                      Visibility(
                        visible: widget.mentor,
                        child: GestureDetector(
                          child: const Icon(
                            color: Colors.white,
                            CupertinoIcons.xmark,
                            size: 20,
                            ),
                            onTap: () {
                              var apps = widget.cellAppointments;
                              var test = widget.cellAppointments[0];
                              print('APPOINTMENT UNDA [$i]: $test');
                      
                              print("WIDGET APPS [$i]: $apps");
                              // widget.events.removeAppointmentFromEvents(widget.cellAppointments[i]);
                              // widget.events.appointments!.remove(widget.cellAppointments[i]);
                              removeEvents(widget.cellAppointments[i]);
                              setState(() {
                                // widget.cellAppointments.removeAt(i);
                                // widget.events.appointments?.remove(widget.cellAppointments[i]);
                                widget.cellAppointments.removeAt(i);
                                appointmentSubjects.removeAt(i);
                              });
                              // events.notifyListeners(CalendarDataSourceAction.remove, <Appointment>[cellApointments[0]]);
                              // appointmentSubjects.remove(appointmentSubjects[i]);
                              var test1 = widget.cellAppointments[i].id;
                              print("CARALHO: $test1");
                              AppointmentDB.deleteAppointment(widget.cellAppointments[i].id);
                            },
                        ),
                      )
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: appointmentExpand[widget.cellAppointments[i].id] ?? false ? 80 : 0,
                  // padding: EdgeInsets.all(10),
                  child: appointmentExpand[widget.cellAppointments[i].id] ?? false ? Column(
                    children: [
                      Text(
                        widget.cellAppointments[i].notes,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        // widget.cellAppointments[i].startTime.toString(),
                        convertDateTime(widget.cellAppointments[i].startTime),
                        textAlign: TextAlign.left,
                      ),
                      Text( // NO DURATION IF APPOINTMENT TYPE IS COLLEGE DEADLINE
                        getDuration(widget.cellAppointments[i].startTime, widget.cellAppointments[i].endTime),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ) : null,
                )
              ],
            ),
            // onTap: () {
            //   var apps = widget.cellAppointments;
            //   var test = widget.cellAppointments[0];
            //   print('APPOINTMENT UNDA [$i]: $test');

            //   print("WIDGET APPS [$i]: $apps");
            //   // widget.events.removeAppointmentFromEvents(widget.cellAppointments[i]);
            //   // widget.events.appointments!.remove(widget.cellAppointments[i]);
            //   removeEvents(widget.cellAppointments[i]);
            //   setState(() {
            //     // widget.cellAppointments.removeAt(i);
            //     // widget.events.appointments?.remove(widget.cellAppointments[i]);
            //     widget.cellAppointments.removeAt(i);
            //     appointmentSubjects.removeAt(i);
            //   });
            //   // events.notifyListeners(CalendarDataSourceAction.remove, <Appointment>[cellApointments[0]]);
            //   // appointmentSubjects.remove(appointmentSubjects[i]);
            //   var test1 = widget.cellAppointments[i].id;
            //   print("CARALHO: $test1");
            //   AppointmentDB.deleteAppointment(widget.cellAppointments[i].id);
            // },
          )
        ],
      ),
      TextButton(
        onPressed: () async {
          Navigator.of(context).pop();
          var test = widget.events;
          print('REMOVE THE EVENTS: $test');
        },
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            color: Colors.red.shade600,
            constraints: BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              'Ok',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      )
    ],
  );
}
}
