import 'package:bloc/bloc.dart';


part 'tab_index_state.dart';

class TabIndexCubit extends Cubit<TabIndexState> {
  TabIndexCubit() : super(TabIndexState(index: 0));

  changeTab(int index) => emit(TabIndexState(index: index));
}
