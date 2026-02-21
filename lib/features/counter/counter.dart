/// Counter feature module
/// Exports all public APIs for this feature
library counter;

// Domain
export 'domain/entities/counter.dart';
export 'domain/repositories/counter_repository.dart';
export 'domain/usecases/increment_counter.dart';
export 'domain/usecases/decrement_counter.dart';

// Presentation
export 'presentation/bloc/counter_bloc.dart';
export 'presentation/bloc/counter_event.dart';
export 'presentation/bloc/counter_state.dart';
export 'presentation/pages/counter_page.dart';
