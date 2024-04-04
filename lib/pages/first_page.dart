import 'package:flutter/material.dart';
import 'package:quotes_app/pages/quotes_page.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.brown,
      body: Column(
        children: [
          const SizedBox(height: 300,),
          const Center(child: Text('Welcome To Quotes App',style: TextStyle(color: Colors.white,fontSize: 25),)),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const QuotesPage()));
          }, child: const Text('Click Here',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }
}
