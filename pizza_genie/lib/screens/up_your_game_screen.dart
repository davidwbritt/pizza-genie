import 'package:flutter/material.dart';

class UpYourGameScreen extends StatelessWidget {
  const UpYourGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Up Your Game'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.emoji_events,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Pro Pizza Tips',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            _buildTipSection(
              context,
              icon: Icons.grass,
              title: 'Flour: The Foundation',
              content: 'Use "00" flour (doppio zero) for authentic Neapolitan pizza. This finely ground Italian flour creates a silky dough that\'s easier to stretch and produces a tender, chewy crust. Regular bread flour works too, but 00 flour is the secret to professional results.',
            ),
            
            _buildTipSection(
              context,
              icon: Icons.cookie,
              title: 'Sugar: The Browning Secret',
              content: 'Add 1-2% sugar by flour weight for beautiful browning. Sugar feeds the yeast and caramelizes during baking, creating that golden, spotted "leoparding" on authentic pizza crusts. Honey or malt extract work even better for complex flavors.',
            ),
            
            _buildTipSection(
              context,
              icon: Icons.access_time,
              title: 'Cold Fermentation',
              content: 'Let your dough slow-ferment in the fridge for 24-72 hours. This develops complex flavors and makes the dough more digestible. The longer fermentation breaks down proteins and creates the signature tangy taste of great pizza.',
            ),
            
            _buildTipSection(
              context,
              icon: Icons.thermostat,
              title: 'Temperature Matters',
              content: 'Use room temperature water (around 70°F) to control yeast activity. For faster rises, use slightly warmer water. For overnight dough, use cooler water. Always check your flour temperature too - cold flour slows fermentation.',
            ),
            
            _buildTipSection(
              context,
              icon: Icons.scale,
              title: 'Hydration Control',
              content: 'Higher hydration (70-80%) creates an open, airy crumb but requires practice to handle. Start with 60-65% hydration and work your way up as your technique improves. Wetter doughs need gentle handling and good flour.',
            ),
            
            _buildTipSection(
              context,
              icon: Icons.local_fire_department,
              title: 'Heat is Everything',
              content: 'Pizza needs extreme heat - 800°F+ for Neapolitan style. Home ovens max out around 500°F, so use a pizza steel preheated for at least 45 minutes. Steel conducts heat better than stone, won\'t crack, and gives consistently excellent results.',
            ),
            
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.lightbulb,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Master\'s Secret',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'The best pizza makers taste their dough. It should be slightly sweet, pleasantly tangy (if fermented), and have a clean, yeasty aroma. Trust your senses - they\'ll tell you when your dough is ready.',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipSection(BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}