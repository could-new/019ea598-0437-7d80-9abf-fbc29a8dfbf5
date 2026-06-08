import 'package:flutter/material.dart';

class SlideData {
  final String title;
  final String content;
  final IconData icon;
  final Color backgroundColor;

  const SlideData({
    required this.title,
    required this.content,
    required this.icon,
    required this.backgroundColor,
  });
}

final List<SlideData> presentationSlides = [
  const SlideData(
    title: 'Diversity in the Living World',
    content: 'Welcome to Grade 6 Science!\n\nToday we will explore the amazing variety of life on Earth. From the tiniest bacteria to the largest whales, our planet is full of fascinating living organisms.',
    icon: Icons.public,
    backgroundColor: Colors.teal,
  ),
  const SlideData(
    title: 'What is Biodiversity?',
    content: 'Biodiversity refers to the incredible variety of life forms found on Earth.\n\nIt includes everything from plants and animals to fungi and microscopic organisms. Each plays a unique role in our ecosystem!',
    icon: Icons.eco,
    backgroundColor: Colors.green,
  ),
  const SlideData(
    title: 'Different Habitats',
    content: 'Living things are found everywhere! A habitat is a place where an organism makes its home.\n\n• Forests: Trees and woodland creatures.\n• Deserts: Cacti and camels.\n• Oceans: Corals and fish.\n• Mountains: Pine trees and snow leopards.',
    icon: Icons.landscape,
    backgroundColor: Colors.brown,
  ),
  const SlideData(
    title: 'Why Do We Classify?',
    content: 'There are millions of species! To study them easily, scientists group them based on similarities and differences.\n\nClassification helps us understand how different living things are related to each other.',
    icon: Icons.account_tree,
    backgroundColor: Colors.indigo,
  ),
  const SlideData(
    title: 'The Plant Kingdom',
    content: 'Plants can be grouped by their size and stems:\n\n• Herbs: Short plants with green, tender stems.\n• Shrubs: Medium-sized with hard, woody stems.\n• Trees: Tall with thick, brown trunks.\n• Climbers & Creepers: Plants with weak stems that climb or spread.',
    icon: Icons.local_florist,
    backgroundColor: Colors.lightGreen,
  ),
  const SlideData(
    title: 'The Animal Kingdom',
    content: 'Animals are often divided into two main groups:\n\n• Vertebrates: Animals with a backbone (e.g., humans, dogs, fish, birds).\n• Invertebrates: Animals without a backbone (e.g., insects, worms, jellyfish).',
    icon: Icons.pets,
    backgroundColor: Colors.deepOrange,
  ),
  const SlideData(
    title: 'Adaptation',
    content: 'Living things change to survive in their habitats. This is called adaptation.\n\nFor example, polar bears have thick fur to stay warm, and fish have gills to breathe underwater. Every creature is built for its home!',
    icon: Icons.transform,
    backgroundColor: Colors.blueAccent,
  ),
  const SlideData(
    title: 'Summary',
    content: '• Our world is diverse.\n• Organisms live in different habitats.\n• We classify them to study them better.\n• Both plants and animals have amazing adaptations!\n\nKeep exploring the wonders of nature!',
    icon: Icons.lightbulb,
    backgroundColor: Colors.purple,
  ),
];

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _nextSlide() {
    if (_currentIndex < presentationSlides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousSlide() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: presentationSlides.length,
            itemBuilder: (context, index) {
              final slide = presentationSlides[index];
              return _buildSlide(slide, context);
            },
          ),
          
          // Navigation controls
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Previous Button
                    IconButton(
                      onPressed: _currentIndex > 0 ? _previousSlide : null,
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      tooltip: 'Previous',
                    ),
                    
                    // Slide Indicator
                    Row(
                      children: List.generate(
                        presentationSlides.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentIndex == index ? 12 : 8,
                          height: _currentIndex == index ? 12 : 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    
                    // Next Button
                    IconButton(
                      onPressed: _currentIndex < presentationSlides.length - 1
                          ? _nextSlide
                          : null,
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                      tooltip: 'Next',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide(SlideData slide, BuildContext context) {
    return Container(
      color: slide.backgroundColor,
      padding: const EdgeInsets.all(32.0),
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  slide.icon,
                  size: 120,
                  color: Colors.white.withOpacity(0.9),
                ),
                const SizedBox(height: 40),
                Text(
                  slide.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      slide.content,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                            height: 1.5,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 60), // Space for bottom controls
              ],
            ),
          ),
        ),
      ),
    );
  }
}
