import 'dart:math';

import 'package:custom_seek_bar/widgets/rounded_seekbar.dart';
import 'package:flutter/material.dart';
import 'widgets/advanced_seekbar.dart';
import 'widgets/range_seekbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double value = 40;
  RangeValues range = const RangeValues(20, 80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom SeekBar Demo")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Rounded SeekBar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              RoundedSeekBar(
                value: value,
                onChanged: (v) => setState(() => value = v),
              ),
              SizedBox(height: 20),

              // AdvancedSeekBar(
              //   value: value,
              //   onChanged: (v) => setState(() => value = v),
              //   showBubble: false,
              //   // thumbIcon: Icons.emoji_emotions,
              //   thumbSize: 30,
              //   // height: 14,
              //   // divisions: 5,
              //   // divisionColor: Colors.red,
              //   // thumbColor: Colors.pink,
              //   orientation: SeekBarOrientation.horizontal,
              //   gradient: SweepGradient(colors: [Colors.red, Colors.orange]),
              // ),
              Text(
                'Vertical SeekBar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),

              AdvancedSeekBar(
                value: value,
                onChanged: (v) => setState(() => value = v),
                orientation: SeekBarOrientation.vertical,
                showBubble: false,
              ),
              const SizedBox(height: 20),
              Text(
                'Icon SeekBar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              AdvancedSeekBar(
                value: value,
                onChanged: (v) => setState(() => value = v),
                thumbSize: 30,
                thumbIcon: Icons.emoji_emotions_outlined,
                thumbColor: Colors.black,
                showBubble: false,

                // bubbleEmojis: [
                //   "😢",
                //   "😟",
                //   "😐",
                //   "🙂",
                //   "😄",
                // ],
              ),
              SizedBox(height: 20),
              Text(
                'Range SeekBar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              RangeSeekBar(
                values: range,
                onChanged: (r) => setState(() => range = r),
                showBubble: true,
                activeColor: Colors.blue,
              ),
              SizedBox(height: 20),
              Text(
                'Emoji SeekBar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              AdvancedSeekBar(
                value: value,
                onChanged: (v) => setState(() => value = v),
                showBubble: true,
                activeColor: Colors.red,
                thumbColor: Colors.red,
                bubbleEmojis: ["😢", "😟", "😐", "🙂", "😄"],
              ),
              SizedBox(height: 20),
              Text(
                'Tick Mark SeekBar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              AdvancedSeekBar(
                value: value,
                onChanged: (v) => setState(() => value = v),
                showBubble: true,
                activeColor: Colors.red,
                divisions: 5,
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
