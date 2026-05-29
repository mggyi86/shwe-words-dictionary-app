import 'package:flutter/material.dart';

void main() {
  runApp(const ShweWordsApp());
}

class AppColors {
  static const Color darkBlue = Color(0xFF1A237E);
  static const Color gold = Color(0xFFD4AF37);
  static const Color teal = Color(0xFF4DB6AC);
  static const Color lightBg = Color(0xFFF4F7F4);
  static const Color textDark = Color(0xFF2D3748);
  static const Color textLight = Color(0xFF718096);
  static const Color white = Colors.white;
}

class ShweWordsApp extends StatelessWidget {
  const ShweWordsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShweWords',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.lightBg,
        primaryColor: AppColors.darkBlue,
        fontFamily: 'Roboto', // Replace with custom Myanmar font in pubspec.yaml
      ),
      home: const DictionaryScreen(),
    );
  }
}

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  int _selectedTabIndex = 0;

  final List<Map<String, String>> _words = [
    {'en': 'add', 'mm': '~ addition ထပ်ပေါင်းခြင်း'},
    {'en': 'add on', 'mm': 'ထပ်ပေါင်းသည်'},
    {'en': 'paddle', 'mm': 'တက်'},
    {'en': 'swaddle', 'mm': '~ sb/oneself in sth ~ sb/oneself in sth ထုပ်သည်'},
    {'en': 'straddle', 'mm': 'ခွသည်'},
    {'en': 'addiction', 'mm': 'မူးယစ်ဆေး စသည် မူးယစ်ဆေး စသည် စွဲနေမှု'},
    {'en': 'crawdaddy', 'mm': ''},
    {'en': 'saddle horse', 'mm': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildSegmentedControl(),
            const SizedBox(height: 12),
            Expanded(
              child: _buildWordList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.darkBlue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.menu_book, color: AppColors.gold, size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                'ShweWords',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.history, color: AppColors.textDark),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: AppColors.textDark),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'add',
            hintStyle: const TextStyle(color: AppColors.textDark, fontSize: 16),
            prefixIcon: const Icon(Icons.search, color: AppColors.textDark),
            suffixIcon: const Icon(Icons.close, color: AppColors.textLight),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 8.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.teal.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            _buildTab('English', 0, Icons.check),
            Container(width: 1, color: AppColors.teal.withOpacity(0.3)),
            _buildTab('Myanmar', 1, Icons.translate),
            Container(width: 1, color: AppColors.teal.withOpacity(0.3)),
            _buildTab('Synonym', 2, Icons.swap_horiz),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index, IconData icon) {
    bool isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.teal.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(index == 0 ? 20 : 0),
              right: Radius.circular(index == 2 ? 20 : 0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: AppColors.textDark),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.textDark,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWordList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      itemCount: _words.length,
      itemBuilder: (context, index) {
        final word = _words[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.teal.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                word['en']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              if (word['mm']!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  word['mm']!,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textLight,
                    height: 1.4,
                  ),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
