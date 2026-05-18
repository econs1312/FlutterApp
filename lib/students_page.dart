import 'package:flutter/material.dart';
import 'students.dart';

class StudentsPage extends StatefulWidget {
 const StudentsPage({super.key});

 @override
 State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
 int _sortColumnIndex = 0;
 bool _isAscending = true;
 late List<Student> _sortedStudents;

 @override
 void initState() {
   super.initState();
   _sortedStudents = List.of(students);
 }

 void _sort<T>(
   Comparable<T> Function(Student student) getField,
   int columnIndex,
 ) {
   setState(() {
     _isAscending = (_sortColumnIndex == columnIndex) ? !_isAscending : true;
     _sortColumnIndex = columnIndex;

     _sortedStudents.sort((a, b) {
       final aValue = getField(a);
       final bValue = getField(b);
       return _isAscending
           ? Comparable.compare(aValue, bValue)
           : Comparable.compare(bValue, aValue);
     });
   });
 }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('Student Table'),
       backgroundColor: Colors.deepPurple.shade200,
     ),
     body: SingleChildScrollView(
       scrollDirection: Axis.vertical,
       child: SingleChildScrollView(
         scrollDirection: Axis.horizontal,
         child: DataTable(
           sortColumnIndex: _sortColumnIndex,
           sortAscending: _isAscending,
           columns: [
             DataColumn(
               label: const Text('Nome'),
               onSort: (index, _) => _sort((student) => student.name, index),
             ),
             DataColumn(
               label: const Text('Idade'),
               numeric: true,
               onSort: (index, _) => _sort((student) => student.age, index),
             ),
             DataColumn(
               label: const Text('Nota'),
               numeric: true,
               onSort: (index, _) => _sort((student) => student.grade, index),
             ),
           ],
           rows:
               _sortedStudents
                   .map(
                     (student) => DataRow(
                       cells: [
                         DataCell(Text(student.name)),
                         DataCell(Text(student.age.toString())),
                         DataCell(Text(student.grade.toStringAsFixed(1))),
                       ],
                     ),
                   )
                   .toList(),
         ),
       ),
     ),
   );
 }
}
