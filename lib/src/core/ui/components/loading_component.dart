import 'package:flutter/material.dart';

class LoadingWithTypingEffect extends StatefulWidget {
  final String imagePath;
  final double imageSize;

  const LoadingWithTypingEffect({
    super.key,
    required this.imagePath,
    this.imageSize = 100.0,
  });

  @override
  State<LoadingWithTypingEffect> createState() =>
      _LoadingWithTypingEffectState();
}

class _LoadingWithTypingEffectState extends State<LoadingWithTypingEffect>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _typingController;
  String _typingText = ''; // Inicializando a variável corretamente
  int _currentLength = 0;

  @override
  void initState() {
    super.initState();

    // Controle da animação de Fade (transparência)
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Controle da animação de digitação
    _typingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _typingController.addListener(() {
      setState(() {
        _currentLength = (_typingController.value * 3).toInt();
        _typingText = "Carregando${"." * _currentLength}";
      });
    });

    _typingController.repeat();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _typingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Imagem com animação de bounce
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: child,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              transform: Matrix4.translationValues(
                  0, (_fadeAnimation.value - 0.5) * 10, 0),
              child: Image.asset(
                widget.imagePath,
                height: widget.imageSize,
                width: widget.imageSize,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Texto com efeito de digitação
          Material(
            color: Colors.transparent,
            child: Text(
              _typingText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
