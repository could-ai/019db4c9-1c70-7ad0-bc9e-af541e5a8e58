import 'package:flutter/material.dart';
import 'models.dart';

void main() {
  runApp(const NovelApp());
}

class NovelApp extends StatefulWidget {
  const NovelApp({super.key});

  @override
  State<NovelApp> createState() => _NovelAppState();
}

class _NovelAppState extends State<NovelApp> {
  // Global state for 18+ Uncensored Mode
  final ValueNotifier<bool> is18PlusMode = ValueNotifier<bool>(false);

  @override
  void dispose() {
    is18PlusMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Novel Reader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A1A),
          elevation: 0,
        ),
      ),
      home: StoryListScreen(is18PlusMode: is18PlusMode),
    );
  }
}

class StoryListScreen extends StatelessWidget {
  final ValueNotifier<bool> is18PlusMode;

  const StoryListScreen({super.key, required this.is18PlusMode});

  void _showSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          decoration: const BoxDecoration(
            color: Color(0xFF1A1A1A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<bool>(
                valueListenable: is18PlusMode,
                builder: (context, is18Plus, child) {
                  return SwitchListTile(
                    title: const Text(
                      'Enable 18+ Uncensored Mode',
                      style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text('Shows mature content and explicit descriptions.'),
                    value: is18Plus,
                    activeColor: Colors.redAccent,
                    onChanged: (value) {
                      is18PlusMode.value = value;
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettings(context),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockStories.length,
        itemBuilder: (context, index) {
          final story = mockStories[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryDetailScreen(
                      story: story,
                      is18PlusMode: is18PlusMode,
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    story.coverUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          story.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'by ${story.author}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class StoryDetailScreen extends StatelessWidget {
  final Story story;
  final ValueNotifier<bool> is18PlusMode;

  const StoryDetailScreen({
    super.key,
    required this.story,
    required this.is18PlusMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              story.coverUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Synopsis',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    story.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Chapters',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: story.chapters.length,
                    itemBuilder: (context, index) {
                      final chapter = story.chapters[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.menu_book),
                        title: Text(chapter.title),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReaderScreen(
                                chapter: chapter,
                                is18PlusMode: is18PlusMode,
                                storyTitle: story.title,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReaderScreen extends StatelessWidget {
  final Chapter chapter;
  final String storyTitle;
  final ValueNotifier<bool> is18PlusMode;

  const ReaderScreen({
    super.key,
    required this.chapter,
    required this.storyTitle,
    required this.is18PlusMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4ECD8), // Novel paper-like background
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(storyTitle, style: const TextStyle(fontSize: 14, color: Colors.white70)),
            Text(chapter.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: is18PlusMode,
        builder: (context, is18Plus, child) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            itemCount: chapter.blocks.length,
            itemBuilder: (context, index) {
              final block = chapter.blocks[index];
              
              if (block.is18PlusOnly && !is18Plus) {
                return const SizedBox.shrink(); // Hide completely if not in 18+ mode
              }

              final textToShow = block.getDisplayText(is18Plus);
              
              if (textToShow.isEmpty) return const SizedBox.shrink();

              // Add visual indicator for uncensored text if in 18+ mode
              final isShowingUncensored = is18Plus && block.uncensoredText != null;

              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Container(
                  padding: isShowingUncensored ? const EdgeInsets.only(left: 12) : null,
                  decoration: isShowingUncensored 
                    ? const BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.redAccent, width: 3),
                        ),
                      ) 
                    : null,
                  child: Text(
                    textToShow,
                    style: const TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 18,
                      height: 1.6,
                      color: Color(0xFF2C2C2C), // Dark text for readability on paper background
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
