// part of 'import.dart';

// class RamayanaMyActivityTask extends StatefulWidget {
//   const RamayanaMyActivityTask({
//     super.key, 
//     this.projectId, 
//     this.projectDesc, 
//     this.taskId,
//     this.taskDesc
//     });
//   final String? projectId;
//   final String? projectDesc;
//   final String? taskId;
//   final String? taskDesc;
//   @override
//   State<RamayanaMyActivityTask> createState() => _RamayanaMyActivityTaskState();
// }

// class _RamayanaMyActivityTaskState extends State<RamayanaMyActivityTask> {
//  late MyActivityCubit myactivityCubit;
//  @override
//  void initState() {
//    super.initState();
//    myactivityCubit = context.read<MyActivityCubit>();
//    myactivityCubit.getTaskById(widget.projectId!);
//  }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context, MaterialPageRoute(builder: (context) 
//                 => DefaultBottomBarController(child: RamayanaMyActivityProject()),), 
//                 (Route<dynamic> route) => false);
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//               size: 23,
//               color: Colors.white,
//             ),
//           ),
//           centerTitle: true,
//           title: Text('List Task',
//               style: GoogleFonts.plusJakartaSans(
//                   fontSize: 23, color: Colors.white)),
//           backgroundColor: baseColors.primaryColor,
//           elevation: 5,
//           toolbarHeight: 80,
//         ),
//       body: Stack(
//         children: [
//            Container(
//             child: BlocBuilder<MyActivityCubit, MyActivityState>(builder: (context, state) {
//             if (state is MyActivityLoading) {
//               return SpinKitThreeBounce(
//                 color: Color.fromARGB(255, 230, 0, 0),
//                 size: 50.0,
//               );
//             }
//             if (state is MyActivitySuccessTask) {
//               return 
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: state.response.data!.length,
//               itemBuilder: (BuildContext context, int index) {
//               return
//                  Container(
//             margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
//             height: 100,
//             decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [BoxShadow(
//               offset: Offset(2, 4),
//               color: Colors.grey,
//               blurRadius: 5
//             )]
//             ),
//             child: MaterialButton(
//               onPressed: (){
//                 Navigator.pushAndRemoveUntil(
//                 context, MaterialPageRoute(builder: (context) 
//                 => DefaultBottomBarController(child: RamayanaMyActivity
//                 (
//                   projectId: '${widget.projectId}',
//                   projectDesc: '${widget.projectDesc}',
//                   taskId: '${state.response.data?[index].taskId}',
//                   taskDesc: '${state.response.data?[index].taskDesc}',
//                   status: '${state.response.data?[index].taskStatus}',
//                 )),), 
//                 (Route<dynamic> route) => false);
//               },
//               child: Container(
//                 padding: const EdgeInsets.only(
//                   left: 20
//                 ),
//                 height: 100,
//                 width: MediaQuery.of(context).size.width / 1,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('${state.response.data?[index].taskId}',
//                         style: GoogleFonts.plusJakartaSans(
//                           fontSize: 18, 
//                           color: baseColors.primaryColor)
//                         ),
//                         Container(
                      
//                       height: 35, 
//                       width: 100, 
//                       decoration: BoxDecoration(
//                         color: getColor('${state.response.data?[index].taskStatus}'),
//                         borderRadius: BorderRadius.circular(20)
//                       ),
//                       child: Center(
//                         child: Text('${state.response.data?[index].taskStatus}',
//                           style: GoogleFonts.plusJakartaSans(
//                             fontSize: 15, 
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white)
//                           ),
//                       ),
//                     )
//                       ],
//                     ),
//                     Text('${state.response.data?[index].taskDesc}',
//                     maxLines: 5, 
//                     overflow: TextOverflow.ellipsis,
//                     style: GoogleFonts.plusJakartaSans(
//                   fontSize: 20, 
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500
//                   )
//                     ),
//                   ]),
//               ),
//             ),
//           );
//               }
              
//             );
//             }
//             return Container();
//           }),
//           ),
         
//         ],
//       ),
//     );
//   }
// }
// Color getColor(String type) { // untuk warna container
//   switch (type) {
//     case 'Open':
//       return Colors.blue;
//     case 'Progress':
//       return Colors.green;
//     case 'Verification':
//       return Colors.cyan;
//     default:
//       return Colors.grey; // Warna default jika type tidak sesuai
//   }
// }