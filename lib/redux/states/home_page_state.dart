import 'package:meta/meta.dart';
import 'package:photo_share/models/loading_status.dart';

class HomePageState {
  final LoadingStatus loadingStatus;

  HomePageState({
    @required this.loadingStatus,
  });

  factory HomePageState.initial() {
    return new HomePageState(
      loadingStatus: LoadingStatus.success,
    );
  }

  HomePageState copyWith({
    LoadingStatus loadingStatus,
  }) {
    return new HomePageState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
