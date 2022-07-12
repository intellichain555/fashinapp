import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'view_type_enum.dart';

part 'layout_view_type_event.dart';
part 'layout_view_type_state.dart';

class LayoutViewTypeBloc
    extends Bloc<LayoutViewTypeEvent, LayoutViewTypeState> {
  LayoutViewTypeBloc() : super(LayoutViewTypeState(viewType: LayoutView.grid)) {
    on<LayoutViewTypeEvent>((event, emit) {
      emit(LayoutViewTypeState(viewType: event.viewType));
    });
  }
}
