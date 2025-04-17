import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_neo/domain/entities/user.dart';
import 'package:project_neo/presentation/blocs/supabase/bloc/auth_bloc.dart';

User getUser(BuildContext context) => context.read<AuthBloc>().user;
