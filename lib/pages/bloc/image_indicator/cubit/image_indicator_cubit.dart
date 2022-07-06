import 'package:bloc/bloc.dart';

part 'image_indicator_state.dart';

class ImageIndicatorCubit extends Cubit<ImageIndicatorState> {
  ImageIndicatorCubit() : super(ImageIndicatorState(0));

  imageChanged(int index) {
    print("emit $index");
    emit(ImageIndicatorState(index));
  }
}
