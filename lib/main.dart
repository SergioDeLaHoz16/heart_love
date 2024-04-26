import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulsing Heart Button',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(background: const Color.fromARGB(255, 249, 249, 249)),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<String> phrases = [
    "Te amo",
    "Feliz 2 meses",
    "Eres mi vida",
    "Eres mi corazon de melon",
    "Te amo mucho mi Sarai",
    "Deseo estar contigo toda la vida",
    "Animo mi vida",
    "Nunca te olvides que siempre estaras en mi corazon",
    "Mi Solecito bello",
    "Mi nena hermosa",
    "Gracias por estar conmigo todo la vida",
    "Prometo amarte y quererte",
    "Prometo siempre estar a tu lado",
    "Eres mi principio",
    "Eres todo lo que deseo",
    "Eres la princesa de mi vida",
    "La vida es un regalo, porque estas en ella",
    "La belleza está en todas partes, por ejemplo en tus ojos",
    "Te amo más de lo que las palabras pueden expresar",
    "Eres mi paz en un mundo caótico.",
    "Eres mi One piece",
    "Checo siempre amara a Espaguetty",
    "Eres la luz de mi vida",
    "Casate conmigo :3",
    "Espero tengas un excelente dia",
    "Animo, algun dia estaremos juntos",
    "Deseo estar abrazado contigo, dandote cariñito y pechichee",
    "Deseo pasar el resto de mi vida, siempre a tu lado",
    "Cuando sientas que estas perdida, buscame. Siempre estare para ti",
    "Sin importar que suceda, siempre estare para ti. Eres mi vida",
    "Hola, esposa mia. Te amo, siempre que tengas un mal dia, recuerda que estoy a tu lado",
    "Recuerda, un dia sin risas es un dia perdido. Lo curioso es que cada que sonries me pierdo en tu sonrisa",
    "Te amo de nuevo y te hare toda la vida."
  ];

  late AudioCache audioCache;
  late AudioPlayer audioPlayer;
  bool _isHeartPulsing = false;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    audioCache = AudioCache();
    audioPlayer = AudioPlayer();
  }

  void playSound() {
    audioPlayer = AudioPlayer();
    audioPlayer.play(AssetSource('sounds/olas_mar_ballenas.mp3'));
  }

  void stopSound() {
    audioPlayer.stop();
  }

  void showRandomPhrase() async {
    String phrase = phrases[Random().nextInt(phrases.length)];
    setState(() {
      _isHeartPulsing = true;
    });

    _animationController.forward(from: 0.0);

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _isHeartPulsing = false;
      });
      _animationController.reverse(from: 1.0);
    });

    playSound();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Love 💜',
            style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(209, 43, 1, 82),
                fontWeight: FontWeight.bold),
          ),
          content: Text(
            phrase,
            style: const TextStyle(
                color: Color.fromARGB(209, 54, 1, 104),
                fontWeight: FontWeight.bold),
          ),
          shadowColor: const Color.fromARGB(255, 247, 247, 247),
          iconColor: const Color.fromARGB(255, 83, 6, 96),
          backgroundColor: const Color.fromARGB(248, 253, 223, 253),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
                stopSound();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phrases Love App',
          style: TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 247, 246, 247),
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromARGB(255, 63, 3, 69),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: showRandomPhrase,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(248, 219, 153, 251),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 115, 2, 135)
                          .withOpacity(0.5), // Color de la sombra
                      spreadRadius: 5, // Radio de propagación de la sombra
                      blurRadius: 7, // Radio de desenfoque de la sombra
                      offset: const Offset(0,
                          3), // Desplazamiento de la sombra (horizontal, vertical)
                    ),
                  ],
                ),
                child: Center(
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 1.2).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      size: 100,
                      color: Color.fromARGB(255, 83, 6, 96),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '\n\nPresiona el Corazon',
              style: TextStyle(
                  fontSize: 23,
                  color: Color.fromARGB(255, 79, 60, 80),
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
