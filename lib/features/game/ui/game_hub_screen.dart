import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/random_pick_controller.dart';

class GameHubScreen extends ConsumerWidget {
  const GameHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(randomPickControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('게임 & 내기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _GameCard(
              title: '🎲 랜덤 메뉴 추천',
              description: '결정장애 해결! 주변 식당 중 하나를 랜덤으로 골라드려요.',
              onTap: () {
                controller.pickRandomRestaurant();
                _showResultDialog(context, ref);
              },
            ),
            const SizedBox(height: 16),
            _GameCard(
              title: '🪜 사다리 타기 (준비중)',
              description: '밥값 내기, 커피 내기는 사다리로!',
              color: Colors.grey.shade200,
              onTap: () {
                // TODO: Implement Ladder Game
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('사다리 타기 기능은 다음 업데이트에 추가됩니다!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showResultDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => Consumer(
        builder: (context, ref, _) {
          final picked = ref.watch(randomPickProvider);
          if (picked == null) return const SizedBox();

          return AlertDialog(
            title: const Text('🎉 오늘의 추천 메뉴'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.restaurant, size: 48, color: Colors.blue),
                const SizedBox(height: 16),
                Text(picked.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text(picked.category, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Text(picked.address),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('닫기'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(randomPickControllerProvider).pickRandomRestaurant();
                },
                child: const Text('다시 뽑기'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  final Color? color;

  const _GameCard({
    required this.title,
    required this.description,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color ?? Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
