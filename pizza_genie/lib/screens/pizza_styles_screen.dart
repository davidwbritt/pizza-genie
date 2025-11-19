import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PizzaStylesScreen extends StatelessWidget {
  const PizzaStylesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Styles'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/icon.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Pizza Family Tree',
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
              'From ancient Naples to modern America - the evolution of pizza',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            
            // Italian Origins
            _buildSection(context, 'Italian Origins', [
              _PizzaStyle(
                name: 'Napoletana',
                period: 'mid-1700s (Naples, Italy)',
                description: 'The original pizza. Thin, soft crust with charred spots ("leoparding"). San Marzano tomatoes, fresh mozzarella di bufala, fresh basil, olive oil.',
                homeTip: 'Use pizza steel at maximum oven heat. Keep toppings minimal - less is more. Fresh basil goes on after baking.',
                icon: '🇮🇹',
              ),
              _PizzaStyle(
                name: 'Margherita',
                period: '1889 (Pizzeria Brandi)',
                description: 'Created for Queen Margherita. Classic Napoletana with tomato, mozzarella, and basil representing the Italian flag.',
                homeTip: 'Use high-quality San Marzano tomatoes or similar. Buffalo mozzarella if available, otherwise whole milk mozzarella.',
                icon: '👑',
              ),
              _PizzaStyle(
                name: 'Romana',
                period: 'mid-1800s',
                description: 'Roman-style with ultra-thin, crispy crust. Rolled thin and baked until crunchy. Minimal toppings.',
                homeTip: 'Roll dough paper-thin with rolling pin. Use less yeast, longer fermentation. Bake on lowest oven rack.',
                icon: '🏛️',
              ),
              _PizzaStyle(
                name: 'Romana Al Taglio + Tonda',
                period: 'mid-1900s',
                description: 'Al Taglio: rectangular pizza sold by weight. Tonda: round Roman pizza with thicker crust than classic Romana.',
                homeTip: 'Al Taglio: use sheet pan, high hydration dough. Tonda: moderate thickness, good for beginners.',
                icon: '✂️',
              ),
              _PizzaStyle(
                name: 'Sfincione Sicilian',
                period: '1800s',
                description: 'Thick, focaccia-like crust with tomatoes, onions, anchovies, and hard cheese. Often no mozzarella.',
                homeTip: 'Use deep pan, let dough rise in pan. Top with caciocavallo or pecorino instead of mozzarella.',
                icon: '🏝️',
              ),
            ]),
            
            // American Evolution
            _buildSection(context, 'American Evolution', [
              _PizzaStyle(
                name: 'New York Style',
                period: '1905 (Lombardi\'s)',
                description: 'Large, thin crust that\'s foldable. Hand-stretched, coal oven baked. Simple tomato sauce, mozzarella.',
                homeTip: 'High-gluten bread flour, hand stretch only. Pizza steel at highest heat. Fold slice to eat properly!',
                icon: '🗽',
              ),
              _PizzaStyle(
                name: 'New Haven (Apizza)',
                period: '1925 (Frank Pepe)',
                description: 'Thin crust coal-fired pizza. Often "plain" with just sauce and cheese. Clam pizza is signature.',
                homeTip: 'Very hot steel, minimal cheese. Try white clam pizza with garlic, olive oil, and parmesan.',
                icon: '🦪',
              ),
              _PizzaStyle(
                name: 'Trenton Tomato Pie',
                period: '1910 (Joe\'s)',
                description: 'Thin crust with sauce on top of cheese. Served at room temperature. Sharp provolone common.',
                homeTip: 'Cheese first, then sauce on top. Use sharp aged cheese. Let cool before serving.',
                icon: '🍅',
              ),
              _PizzaStyle(
                name: 'Grandma',
                period: 'early 1900s',
                description: 'Sicilian-influenced, baked in sheet pan. Thinner than Sicilian, cheese directly on dough, sauce on top.',
                homeTip: 'Oil the pan well, stretch dough by hand. Cheese goes directly on dough, then sauce dollops.',
                icon: '👵',
              ),
            ]),
            
            // American Regional Styles
            _buildSection(context, 'American Regional Styles', [
              _PizzaStyle(
                name: 'Chicago Deep Dish',
                period: '1943 (Pizzeria Uno)',
                description: 'Thick crust forms a bowl. Cheese on bottom, chunky tomato sauce on top. More like a casserole.',
                homeTip: 'Use springform pan or deep dish pan. Butter in crust, part-skim mozzarella, chunky sauce on top.',
                icon: '🏙️',
              ),
              _PizzaStyle(
                name: 'St. Louis',
                period: '1940s (Melrose Cafe)',
                description: 'Ultra-thin, cracker-like crust. Provel cheese (processed blend). Sweet sauce. Cut in squares.',
                homeTip: 'Roll dough very thin, no yeast. Use provel or white American cheese blend. Square cut.',
                icon: '🥨',
              ),
              _PizzaStyle(
                name: 'Detroit',
                period: '1946 (Buddy\'s Rendezvous)',
                description: 'Rectangular, thick crust. Cheese to edges creating caramelized "frico". Sauce on top.',
                homeTip: 'Use steel rectangular pan, oil well. Cheese to very edges. Sauce ladled on top after baking.',
                icon: '🚗',
              ),
              _PizzaStyle(
                name: 'Old Forge',
                period: '1926 (Ghigiarelli\'s)',
                description: 'White pizza with sweet sauce on side. Light, airy crust. American cheese blend.',
                homeTip: 'High hydration dough, no tomato sauce on pizza. Serve sweet sauce separately for dipping.',
                icon: '⚒️',
              ),
              _PizzaStyle(
                name: 'Ohio Valley Style',
                period: 'mid-1900s',
                description: 'Thin crust, sauce, then cold cheese and toppings added after baking. Cheese doesn\'t melt.',
                homeTip: 'Bake crust with sauce only. Add cold shredded cheese immediately after removing from oven.',
                icon: '🏞️',
              ),
            ]),
            
            // Modern Styles
            _buildSection(context, 'Modern American Styles', [
              _PizzaStyle(
                name: 'California Style',
                period: '1980 (Prego & Chez Panisse)',
                description: 'Thin crust with gourmet, non-traditional toppings. Often seasonal, local ingredients.',
                homeTip: 'Focus on high-quality, fresh ingredients. Less is more - let flavors shine.',
                icon: '🌴',
              ),
              _PizzaStyle(
                name: 'Colorado Mountain Pie',
                period: '1973 (Beau Jo\'s)',
                description: 'Very thick, honey-wheat crust. Rolled edge for dipping in honey. Loaded with toppings.',
                homeTip: 'Add honey to dough recipe. Make thick, pillowy edge. Serve with honey for crust dipping.',
                icon: '🏔️',
              ),
              _PizzaStyle(
                name: 'D.C. Jumbo',
                period: '1990s (Pizza Mart)',
                description: 'Extra-large slices, thin crust. Emphasis on size over style. Late-night food culture.',
                homeTip: 'Stretch dough larger than typical. Keep simple - cheese, pepperoni, basic toppings.',
                icon: '🏛️',
              ),
              _PizzaStyle(
                name: 'Virginia Style',
                period: 'early 2000s (Benny\'s)',
                description: 'Sweet sauce, specific cheese blend. Regional variation gaining recognition.',
                homeTip: 'Add sugar to tomato sauce. Experiment with cheese blends for unique flavor profile.',
                icon: '🦅',
              ),
              _PizzaStyle(
                name: 'Americana',
                period: 'Present-day',
                description: 'Modern fusion of all styles. Creative toppings, artisanal ingredients. The evolution continues.',
                homeTip: 'Experiment! Combine techniques from different styles. Use local, seasonal ingredients.',
                icon: '🇺🇸',
              ),
            ]),
            
            const SizedBox(height: 32),
            
            // Footer note
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
                      const Icon(Icons.lightbulb, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        'Pro Tip',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Each style reflects its origin\'s available ingredients, cooking methods, and cultural preferences. Start with Napoletana or New York for authentic foundations, then explore regional variations as you master the basics.',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      height: 1.5,
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

  Widget _buildSection(BuildContext context, String title, List<_PizzaStyle> styles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        
        ...styles.map((style) => _buildStyleTile(context, style)),
        
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildStyleTile(BuildContext context, _PizzaStyle style) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                style.icon,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  style.name,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            style.period,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            style.description,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.home,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    style.homeTip,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PizzaStyle {
  final String name;
  final String period;
  final String description;
  final String homeTip;
  final String icon;

  const _PizzaStyle({
    required this.name,
    required this.period,
    required this.description,
    required this.homeTip,
    required this.icon,
  });
}