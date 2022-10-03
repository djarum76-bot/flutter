import 'package:bloc_login/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  static Route<void> route(){
    return MaterialPageRoute(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(
              builder: (context){
                final userID = context.select((AuthenticationBloc bloc) => bloc.state.user.id);
                return Text('User ID : $userID');
              },
            ),
            ElevatedButton(
                onPressed: (){
                  context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
                },
                child: const Text("Log Out")
            )
          ],
        ),
      ),
    );
  }
}