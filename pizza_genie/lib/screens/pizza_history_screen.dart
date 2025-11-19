import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PizzaHistoryScreen extends StatelessWidget {
  const PizzaHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pizza History')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.history_edu,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'From Naples to the World',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'The delicious journey of humanity\'s favorite flatbread',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),

            _buildSection(
              context,
              icon: '🇮🇹',
              title: 'Humble Beginnings (1700s)',
              content:
                  'Pizza was born in the working-class neighborhoods of Naples, Italy. Street vendors sold simple flatbreads topped with oil, garlic, and tomatoes to hungry laborers. The tomato - once feared as poisonous by the wealthy - became the foundation of the world\'s most beloved food.',
            ),

            _buildSection(
              context,
              icon: '👑',
              title: 'Royal Approval (1889)',
              content:
                  'When Queen Margherita visited Naples, pizzaiolo Raffaele Esposito created a special pizza with tomato, mozzarella, and basil - the colors of the Italian flag. This "Pizza Margherita" elevated pizza from peasant food to culinary art.',
            ),

            _buildSection(
              context,
              icon: '🚢',
              title: 'Journey to America (1900s)',
              content:
                  'Italian immigrants brought pizza to America, where it transformed in fascinating ways. Coal ovens, local ingredients, and American ingenuity created New York, Chicago, and countless regional styles. Pizza became a symbol of the American dream.',
            ),

            _buildSection(
              context,
              icon: '🌍',
              title: 'Pizza the Universal Language',
              content:
                  'From Tokyo to São Paulo, from Mumbai to Stockholm - pizza speaks every language. Each culture has made it their own: Japanese mayonnaise, Brazilian hearts of palm, Indian paneer. It\'s proof that food is humanity\'s universal language of friendship and good will.',
            ),

            // const SizedBox(height: 24),

            // // Fun Facts Section
            // Container(
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
            //     borderRadius: BorderRadius.circular(12),
            //     border: Border.all(
            //       color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            //     ),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         children: [
            //           const Icon(Icons.lightbulb),
            //           const SizedBox(width: 8),
            //           Text(
            //             'Fun Pizza Facts',
            //             style: GoogleFonts.playfairDisplay(
            //               fontSize: 18,
            //               fontWeight: FontWeight.bold,
            //               color: Theme.of(context).colorScheme.primary,
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: 12),
            //       _buildFactItem('🍕 Americans eat 3 billion pizzas per year'),
            //       _buildFactItem('📞 The first pizza delivery was in 1889 - to Queen Margherita!'),
            //       _buildFactItem('🧀 Mozzarella is the world\'s most popular pizza cheese'),
            //       _buildFactItem('🍄 Pepperoni dominates in America, but mushrooms rule globally'),
            //       _buildFactItem('🌙 Saturday night is the most popular time for pizza worldwide'),
            //       _buildFactItem('❄️ Frozen pizza was invented in 1957 by Rose Totino'),
            //     ],
            //   ),
            // ),

            // const SizedBox(height: 24),

            // // Most Popular Toppings
            // Container(
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).colorScheme.primary,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         children: [
            //           const Icon(Icons.favorite, color: Colors.white),
            //           const SizedBox(width: 8),
            //           Text(
            //             'World\'s Favorite Toppings',
            //             style: GoogleFonts.playfairDisplay(
            //               fontSize: 18,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.white,
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: 12),
            //       Text(
            //         '1. Pepperoni (USA)\n2. Mushrooms (Europe)\n3. Extra Cheese (Universal)\n4. Sausage (Italy)\n5. Ham & Pineapple (Australia/Canada)\n6. Vegetables (Health-conscious everywhere)',
            //         style: GoogleFonts.inter(
            //           color: Colors.white,
            //           height: 1.5,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String icon,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFactItem(String fact) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(fact, style: const TextStyle(fontSize: 14, height: 1.4)),
    );
  }
}
