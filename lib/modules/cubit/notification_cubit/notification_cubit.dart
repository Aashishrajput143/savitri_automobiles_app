import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class NotificationState {
  final List<Map<String, dynamic>> notification;

  NotificationState({
    required this.notification,
  });
}

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit()
      : super(
          NotificationState(
            notification: [
              {
                'name': 'Kate Young',
                'avatar': AppImages.swaraj735FE,
                'action': 'Commented on your photo',
                'message':
                    'Great Shot Adam! Really enjoying the composition on this piece.',
                'time': '5 mins ago',
              },
              {
                'name': 'Brandon Newman',
                'avatar': AppImages.swaraj735XT,
                'action': 'Liked your album: UI/UX Inspo',
                'message': '',
                'time': '21 mins ago',
              },
              {
                'name': 'Dave Wood',
                'avatar': AppImages.tractor735FEePS,
                'action': 'Liked your photo: Daily UI Challenge 049',
                'message': '',
                'time': '2 hrs ago',
              },
              {
                'name': 'Kate Young',
                'avatar': AppImages.tractor,
                'action': 'Liked your photo: Daily UI Challenge 049',
                'message': '',
                'time': '3 hrs ago',
              },
              {
                'name': 'Anna Lee',
                'avatar': AppImages.swaraj735XT,
                'action': 'Commented on your photo',
                'message': 'Woah! Loving these colours! Keep it up',
                'time': '1 day ago',
              },
            ],
          ),
        );
}
