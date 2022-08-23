// part of '../../../chatbook.dart';

// class AudioRecorderWidget extends StatefulWidget {
//   const AudioRecorderWidget({Key? key}) : super(key: key);

//   @override
//   State<AudioRecorderWidget> createState() => _AudioRecorderWidgetState();
// }

// class _AudioRecorderWidgetState extends State<AudioRecorderWidget> {
//   final _recorderHelper = RecorderHelper();

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ValueListenableBuilder(
//           valueListenable: _recorderHelper.recordStateNotifier,
//           builder: (_, value, __) {
          
//             switch (value) {
//               case RecordState.pause:

//                 break;
//               default:

//             }
//           }),
//     );
//   }

//   Widget _buildTimer() {
//     return ValueListenableBuilder(
//       valueListenable: _recorderHelper.timerNotifier,
//       builder: (_, value, __) {
//         value as int;
//         final String minutes = _formatNumber(value ~/ 60);
//         final String seconds = _formatNumber(value % 60);
//         return Text(
//           '$minutes : $seconds',
//           style: const TextStyle(color: Colors.red),
//         );
//       },
//     );
//   }

//   String _formatNumber(int number) {
//     String numberStr = number.toString();
//     if (number < 10) {
//       numberStr = '0$numberStr';
//     }

//     return numberStr;
//   }
// }
