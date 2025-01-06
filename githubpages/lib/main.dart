// main.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'video-semantic-segmentation.dart';

void main() {
  runApp(const WasteSenseApp());
}

class WasteSenseApp extends StatelessWidget {
  const WasteSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WasteSenseAI',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      // home: const TrainingCodeSection(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Create a ScrollController
  final ScrollController _scrollController = ScrollController();

  // Create a GlobalKey for the features section
  final GlobalKey featuresKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Method to handle scrolling to features section
  void _scrollToFeatures() {
    final RenderBox featuresBox =
        featuresKey.currentContext?.findRenderObject() as RenderBox;
    final double dy = featuresBox.localToGlobal(Offset.zero).dy;

    _scrollController.animateTo(
      dy,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController, // Add the scroll controller here
        child: Column(
          children: [
            HeroSection(onLearnMorePressed: _scrollToFeatures),
            FeaturesSection(key: featuresKey), // Add the key here
            const VideoShowcaseSection(),
            const CodeShowcaseSection(),
            const ModelMetricsSection(),
            const StatsSection(),
            const GitHubSection(),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}

// Modify HeroSection to accept the callback
class HeroSection extends StatelessWidget {
  final VoidCallback onLearnMorePressed;

  const HeroSection({
    super.key,
    required this.onLearnMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage('assets/images/2merged.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WasteSenseAI',
              style: GoogleFonts.inter(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Revolutionizing waste sorting with AI and robotics',
              style: GoogleFonts.inter(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onLearnMorePressed, // Use the callback here
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Learn More'),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () async {
                    final url = Uri.parse(
                      'https://github.com/codemotozu/WasteSenseAI',
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('View on GitHub'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      child: Column(
        children: [
          Text(
            'Key Features',
            style: GoogleFonts.inter(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    FeatureCard(
                      icon: FontAwesomeIcons.brain,
                      title: 'YOLOv8 Technology',
                      description:
                          'Advanced object detection and instance segmentation',
                    ),
                    FeatureCard(
                      icon: FontAwesomeIcons.chartLine,
                      title: '1600+ Training Images',
                      description:
                          'Comprehensive dataset for accurate classification',
                    ),
                    FeatureCard(
                      icon: FontAwesomeIcons.recycle,
                      title: 'Real-time Processing',
                      description:
                          'Efficient waste detection and sorting capabilities',
                    ),
                  ],
                );
              } else {
                return Column(
                  children: const [
                    FeatureCard(
                      icon: FontAwesomeIcons.brain,
                      title: 'YOLOv8 Technology',
                      description:
                          'Advanced object detection and instance segmentation',
                    ),
                    SizedBox(height: 40),
                    FeatureCard(
                      icon: FontAwesomeIcons.chartLine,
                      title: '1600+ Training Images',
                      description:
                          'Comprehensive dataset for accurate classification',
                    ),
                    SizedBox(height: 40),
                    FeatureCard(
                      icon: FontAwesomeIcons.recycle,
                      title: 'Real-time Processing',
                      description:
                          'Efficient waste detection and sorting capabilities',
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          FaIcon(icon, size: 48, color: Colors.blue),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      color: Colors.black,
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    StatCard(number: '90.6%', label: 'Average Precision'),
                    StatCard(number: '3.8k+', label: 'Total Images'),
                    StatCard(number: '10', label: 'Waste Categories'),
                  ],
                );
              } else {
                return Column(
                  children: const [
                    StatCard(number: '90.6%', label: 'Average Precision'),
                    SizedBox(height: 40),
                    StatCard(number: '3.8k+', label: 'Total Images'),
                    SizedBox(height: 40),
                    StatCard(number: '10', label: 'Waste Categories'),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String number;
  final String label;

  const StatCard({
    super.key,
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.inter(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 20,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class GitHubSection extends StatelessWidget {
  const GitHubSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      child: Column(
        children: [
          const FaIcon(FontAwesomeIcons.github, size: 64),
          const SizedBox(height: 32),
          Text(
            'Open Source Project',
            style: GoogleFonts.inter(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Join us in making waste sorting smarter and more efficient.',
            style: GoogleFonts.inter(
              fontSize: 20,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () async {
              final url = Uri.parse(
                'https://github.com/codemotozu/WasteSenseAI',
              );
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            },
            icon: const FaIcon(FontAwesomeIcons.github),
            label: const Text('View Repository'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoShowcaseSection extends StatelessWidget {
  const VideoShowcaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100),
      color: Colors.grey[100],
      child: Column(
        children: [
          Text(
            'See It In Action',
            style: GoogleFonts.inter(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Watch how WasteSenseAI identifies and classifies waste in real-time',
            style: GoogleFonts.inter(
              fontSize: 20,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              double videoWidth = constraints.maxWidth > 1200
                  ? 1024
                  : constraints.maxWidth > 800
                      ? constraints.maxWidth * 0.8
                      : constraints.maxWidth * 0.9;

              return Container(
                width: videoWidth,
                height: videoWidth * 9 / 16, // 16:9 aspect ratio
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: const CustomVideoPlayer(
                  videoUrl: 'assets/video/WasteSenseAI.mp4',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CodeShowcaseSection extends StatelessWidget {
  const CodeShowcaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1A1A), Colors.black],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      child: Column(
        children: [
          Text(
            'Training Pipeline',
            style: GoogleFonts.inter(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'Powered by YOLOv8 and CUDA Acceleration',
            style: GoogleFonts.inter(
              fontSize: 20,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              double codeWidth = constraints.maxWidth > 1200
                  ? 1024
                  : constraints.maxWidth > 800
                      ? constraints.maxWidth * 0.8
                      : constraints.maxWidth * 0.9;

              return Container(
                width: codeWidth,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              16.0), // ?Adjust the radius as needed
                          child: Image.asset(
                            'assets/images/carbon.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 80),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    CodeFeatureCard(
                      icon:
                          FontAwesomeIcons.bolt, // Lightning bolt for real-time
                      title: 'Real-time Processing',
                      description:
                          'Efficient frame-by-frame analysis for instant waste detection',
                    ),
                    CodeFeatureCard(
                      icon: FontAwesomeIcons.microchip, // Microchip for GPU
                      title: 'GPU Acceleration',
                      description:
                          'Leveraging CUDA for high-performance computing',
                    ),
                    CodeFeatureCard(
                      icon: FontAwesomeIcons.brain, // Brain for ML
                      title: 'Advanced ML Models',
                      description: 'Using YOLOv8 for precise object detection',
                    ),
                  ],
                );
              } else {
                return Column(
                  children: const [
                    CodeFeatureCard(
                      icon: FontAwesomeIcons.bolt,
                      title: 'Real-time Processing',
                      description:
                          'Efficient frame-by-frame analysis for instant waste detection',
                    ),
                    SizedBox(height: 40),
                    CodeFeatureCard(
                      icon: FontAwesomeIcons.microchip,
                      title: 'GPU Acceleration',
                      description:
                          'Leveraging CUDA for high-performance computing',
                    ),
                    SizedBox(height: 40),
                    CodeFeatureCard(
                      icon: FontAwesomeIcons.brain,
                      title: 'Advanced ML Models',
                      description: 'Using YOLOv8 for precise object detection',
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CodeFeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const CodeFeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          FaIcon(
            icon,
            size: 48,
            color: Colors.orange[400], // Using a blue accent color
            // color: Colors.white, // Using a blue accent color
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ModelMetricsSection extends StatelessWidget {
  const ModelMetricsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          Text(
            'Model Performance',
            style: GoogleFonts.inter(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Trained on Roboflow with advanced metrics tracking',
            style: GoogleFonts.inter(
              fontSize: 20,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 80),

          // Training Graphs Section
          LayoutBuilder(
            builder: (context, constraints) {
              double containerWidth = constraints.maxWidth > 1200
                  ? 1024
                  : constraints.maxWidth > 800
                      ? constraints.maxWidth * 0.8
                      : constraints.maxWidth * 0.9;

              return Container(
                width: containerWidth,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 40,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMetricsHeader(),
                    const SizedBox(height: 32),
                    _buildModelStats(),
                    const SizedBox(height: 40),
                    _buildTrainingGraphs(),
                    const SizedBox(height: 40),
                    _buildClassPrecisionAnalysis(),
                    const SizedBox(height: 40),
                    _buildClassPrecisionAnalysisTEST(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildClassPrecisionAnalysis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Average Precision by Class (mAP50)',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/training/5.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Detailed Class Performance Analysis',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildClassAnalysisDetail([
                {
                  'class': 'PlasticBottle-Plastikflasche',
                  'precision': 95,
                  'explanation':
                      'Excellent detection rate for plastic bottles, likely due to their distinctive shape and consistent material properties. High performance across various bottle sizes and types, with strong edge detection and material recognition.'
                },
                {
                  'class': 'GreenGlass-GrunesGlas',
                  'precision': 95,
                  'explanation':
                      'Matches plastic bottles in accuracy, showing robust performance in identifying green glass items. Color consistency and material reflectivity patterns contribute to reliable detection despite transparency challenges.'
                },
                {
                  'class': 'Zahnburste-Toothbrush',
                  'precision': 94,
                  'explanation':
                      'Very high accuracy in detecting toothbrushes, particularly impressive given their relatively small size. The model effectively recognizes their distinctive elongated shape and handle-bristle structure.'
                },
                {
                  'class': 'WhiteGlass-WeisesGlas',
                  'precision': 93,
                  'explanation':
                      'Strong performance in identifying white/clear glass, showing good adaptation to transparency and reflection variations. Successful detection despite the challenging nature of transparent materials.'
                },
                {
                  'class': 'Paper-Papier',
                  'precision': 93,
                  'explanation':
                      'Excellent recognition of paper items across various forms (sheets, crumpled, folded). The model handles different paper textures and conditions well, maintaining consistent detection rates.'
                },
                {
                  'class': 'PlasticBag-Plastiktute',
                  'precision': 91,
                  'explanation':
                      'Strong performance in detecting plastic bags despite their deformable nature and variable shapes. The model successfully handles transparency and different bag sizes.'
                },
                {
                  'class': 'Metal-Metall',
                  'precision': 85,
                  'explanation':
                      'Good performance with metal items, though slightly lower due to reflective surfaces and varying light conditions. Still maintains reliable detection across different metal types and shapes.'
                },
                {
                  'class': 'BrownGlass-BraunesGlas',
                  'precision': 87,
                  'explanation':
                      'Strong detection rate for brown glass items, showing good ability to distinguish from other glass colors. Successful handling of various lighting conditions and container shapes.'
                },
                {
                  'class': 'Cardboard-Karton',
                  'precision': 75,
                  'explanation':
                      'Moderate performance with cardboard items. The varying sizes, conditions (flat vs. folded), and similarities to paper present some challenges for precise classification.'
                },
                {
                  'class': 'PlasticContainer-Kunststoffbehalter',
                  'precision': 77,
                  'explanation':
                      'Shows good but lower precision due to the wide variety of container shapes, sizes, and transparency levels. The diverse nature of plastic containers presents more classification challenges.'
                },
              ]),
              const SizedBox(height: 24),
              _buildPerformanceInsights(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceInsights() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.withOpacity(0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Performance Insights:',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.blue[700],
            ),
          ),
          const SizedBox(height: 12),
          _buildInsightPoint(
              'Strongest Categories (95% precision): Plastic bottles and green glass items show exceptional recognition rates, indicating robust feature detection.'),
          _buildInsightPoint(
              'Consistent Performers (91-94%): Most everyday items like toothbrushes, paper, and white glass maintain very high accuracy levels.'),
          _buildInsightPoint(
              'Challenging Categories (75-85%): Items with variable shapes or complex properties (cardboard, plastic containers) show lower but still effective detection rates.'),
          _buildInsightPoint(
              'Overall Performance: The model maintains above 75% precision across all categories, demonstrating reliable waste classification capabilities.'),
        ],
      ),
    );
  }

  Widget _buildClassAnalysisDetail(List<Map<String, dynamic>> details) {
    return Column(
      children: details
          .map((detail) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.blue[700],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${detail['class']}: ',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                TextSpan(
                                  text: '${detail['precision']}%',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        detail['explanation'],
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

Widget _buildMetricsHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Training Metrics',
        style: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'v1.4',
          style: GoogleFonts.inter(
            color: Colors.blue[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

Widget _buildModelStats() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricCard('mAP', '88.5%', Colors.purple,
                  'Mean Average Precision across all classes\nIndicates overall detection accuracy'),
              _buildMetricCard('Precision', '90.6%', Colors.blue,
                  'Accuracy of positive predictions\nMinimizes false positives'),
              _buildMetricCard('Recall', '79.2%', Colors.orange,
                  'Proportion of actual positives identified\nMinimizes false negatives'),
            ],
          );
        } else {
          return Center(
            child: Column(
              children: [
                _buildMetricCard('mAP', '88.5%', Colors.purple,
                    'Mean Average Precision across all classes\nIndicates overall detection accuracy'),
                SizedBox(height: 40),
                _buildMetricCard('Precision', '90.6%', Colors.blue,
                    'Accuracy of positive predictions\nMinimizes false positives'),
                SizedBox(height: 40),
                _buildMetricCard('Recall', '79.2%', Colors.orange,
                    'Proportion of actual positives identified\nMinimizes false negatives'),
              ],
            ),
          );
        }
      }),
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dataset Overview',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blue[700],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '• Total Images: 3,895 (Training: 3,303, Validation: 339, Test: 253)\n'
              '• Model Type: Roboflow 3.0 Instance Segmentation\n'
              '• Data Augmentation: Horizontal/Vertical flips, Zoom (0-25%), Hue (±15°), Exposure (±5%)',
              style: GoogleFonts.inter(
                fontSize: 14,
                height: 1.6,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildMetricCard(
    String title, String value, MaterialColor color, String explanation) {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: color[50],
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: color[700],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: color[700],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          explanation,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: color[700]?.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildTrainingGraphs() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Training Progress',
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 16),
      Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First training graph - Loss curves
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/training/7.png',
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                '\n• mAP Performance: Demonstrates strong improvement from 0.1 to 0.9, stabilizing around epoch 150\n'
                '• Overall Stability: All metrics show strong convergence and maintain steady performance in later epochs\n',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.grey[600],
                ),
              ),

              // const SizedBox(height: 16),

              // Second training graph - mAP progress
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/training/9.png',
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                '\n• Training Metrics Evolution: Multiple loss curves showing steady convergence across different aspects\n'
                '• Loss Metrics:\n'
                '  - Box Loss: Rapid initial decrease, stabilizing below 0.5 after epoch 100\n'
                '  - Class Loss: Sharp reduction from 4.0 to ~1.0, indicating effective class separation\n'
                '  - Object Loss: Consistent decrease, maintaining low values after epoch 150\n'
                '• mAP Performance:\n'
                '  - Standard mAP (dark purple): Shows strong improvement reaching and stabilizing above 0.8\n'
                '  - mAP@50:95 (light purple): Demonstrates steady improvement with stabilization around 0.75-0.8\n'
                '  - Both metrics show consistent upward trends with minimal fluctuation in later epochs\n',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.grey[600],
                ),
              ),
              // const SizedBox(height: 16),

              // Second training graph - mAP progress
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/training/10.png',
                  fit: BoxFit.cover,
                ),
              ),

              Text(
                '\n• Model Performance Summary: Final metrics achieved: mAP: 88.5%, Precision: 90.6%, Recall: 79.2%, indicating robust overall performance.\n',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.grey[600],
                ),
              ),
              // const SizedBox(height: 16),

              // Second training graph - mAP progress
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/training/11.png',
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                '\n• Dataset Utilization: Training conducted on 3,895 total images with effective data augmentation including flips, zoom (0-25%), hue (±15°), and exposure adjustments (±5%).\n',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.grey[600],
                ),
              ),
            ],
          )),
    ],
  );
}

Widget _buildInsightPoint(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.blue[700],
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// Previous imports and class declaration remain the same...

Widget _buildClassPrecisionAnalysisTEST() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Average Precision by Class (mAP50)',
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/training/6.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Class-wise Performance Analysis',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildClassAnalysisDetail([
              {
                'class': 'PlasticBottle-Plastikflasche',
                'precision': 98,
                'explanation':
                    'Highest precision across all classes, showing exceptional accuracy in detecting plastic bottles regardless of size or shape variations.'
              },
              {
                'class': 'Zahnburste-Toothbrush',
                'precision': 97,
                'explanation':
                    'Nearly perfect detection rate for toothbrushes, demonstrating excellent performance with small, elongated objects.'
              },
              // ... rest of the class analysis details ...
            ]),
            const SizedBox(height: 24),
            _buildPerformanceInsights(),
          ],
        ),
      ),
    ],
  );
}

Widget _buildClassAnalysisDetail(List<Map<String, dynamic>> details) {
  return Column(
    children: details
        .map((detail) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.blue[700],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${detail['class']}: ',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              TextSpan(
                                text: '${detail['precision']}%',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      detail['explanation'],
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ))
        .toList(),
  );
}

Widget _buildPerformanceInsights() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue.withOpacity(0.2)),
      borderRadius: BorderRadius.circular(12),
      color: Colors.blue.withOpacity(0.05),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Performance Insights:',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blue[700],
          ),
        ),
        const SizedBox(height: 12),
        _buildInsightPoint(
            'Top Performers (>95%): Plastic bottles and toothbrushes show exceptional recognition rates, with precision of 97-98%.'),
        _buildInsightPoint(
            'Strong Categories (81-94%): Most items including glass, paper, and metal maintain good precision above 80%.'),
        _buildInsightPoint(
            'Areas for Improvement (<65%): Cardboard and plastic containers show lower precision, indicating potential for model optimization.'),
        _buildInsightPoint(
            'Overall Performance: The model achieves 83% mAP50 across all classes, demonstrating strong general classification capabilities.'),
      ],
    ),
  );
}

// Rest of the code remains the same...

class VideoPlayer extends StatefulWidget {
  final String videoUrl;

  const VideoPlayer({
    super.key,
    required this.videoUrl,
  });

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  // Note: You'll need to implement video player functionality here
  // using a package like video_player or chewie

  @override
  Widget build(BuildContext context) {
    // For now, we'll show a placeholder with a play button
    return Stack(
      alignment: Alignment.center,
      children: [
        // Video thumbnail or placeholder
        Container(
          color: Colors.black,
          child: Center(
            child: Icon(
              Icons.play_circle_fill,
              size: 80,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ),
        // Play button overlay
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              final url = Uri.parse(widget.videoUrl);
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ],
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      color: Colors.black,
      child: Center(
        child: Text(
          '© 2025 WasteSenseAI. All rights reserved.',
          style: GoogleFonts.inter(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
