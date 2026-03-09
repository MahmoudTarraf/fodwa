import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_messages_usecase.dart';
import 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final GetMessagesUseCase getMessagesUseCase;

  MessagesCubit(this.getMessagesUseCase) : super(MessagesInitial());

  Future<void> loadMessages() async {
    emit(MessagesLoading());
    try {
      final messages = await getMessagesUseCase.call();
      if (messages.isEmpty) {
        emit(MessagesEmpty());
      } else {
        emit(MessagesLoaded(messages));
      }
    } catch (e) {
      emit(MessagesError(e.toString()));
    }
  }
}
