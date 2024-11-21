import 'dart:async';

import 'package:flutter/material.dart';

class CustomNotification extends StatefulWidget {
  final String message;
  final Duration duration;
  final VoidCallback? onComplete;
  final Color? color;

  const CustomNotification({
    super.key,
    required this.message,
    this.color,
    this.duration = const Duration(seconds: 5),
    this.onComplete,
  });

  @override
  State<CustomNotification> createState() => _CustomNotificationState();
}

class _CustomNotificationState extends State<CustomNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late int _elapsedTime;

  @override
  void initState() {
    super.initState();
    _elapsedTime = 0;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Animação de entrada/saída
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0), // Começa fora da tela (à direita)
      end: Offset.zero, // Termina na posição normal
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    // Inicia a animação de entrada
    _animationController.forward();

    // Timer de controle
    _startNotificationTimer();
  }

  void _startNotificationTimer() {
    const interval = 30; // Intervalo de atualização em milissegundos
    final totalMilliseconds = widget.duration.inMilliseconds;

    Timer.periodic(Duration(milliseconds: interval), (timer) {
      // Verifica se a widget ainda está montada antes de chamar setState
      if (!mounted) {
        timer.cancel(); // Cancela o timer se a widget foi desmontada
        return;
      }

      // Atualiza o tempo decorrido
      setState(() {
        _elapsedTime += interval;
      });

      // Quando o tempo total for atingido, para o timer e esconde a notificação
      if (_elapsedTime >= totalMilliseconds) {
        timer.cancel();
        _hideNotification();
      }
    });
  }

  void _hideNotification() {
    _animationController.reverse().whenComplete(() {
      if (widget.onComplete != null) {
        widget.onComplete!();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapNotification() => _hideNotification();

  @override
  Widget build(BuildContext context) {
    final progress = 1.0 - (_elapsedTime / widget.duration.inMilliseconds);

    return GestureDetector(
      onTap: _onTapNotification,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          widget.message,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: widget.color,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Progress Bar Decrescente
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        child: RotatedBox(
                          quarterTurns: 2,
                          child: LinearProgressIndicator(
                            value: progress,
                            color: widget.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
