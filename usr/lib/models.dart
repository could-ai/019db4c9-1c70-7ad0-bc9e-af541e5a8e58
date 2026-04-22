class StoryBlock {
  final String text;
  final String? uncensoredText;
  final bool is18PlusOnly;

  StoryBlock({
    required this.text,
    this.uncensoredText,
    this.is18PlusOnly = false,
  });

  String getDisplayText(bool is18PlusMode) {
    if (is18PlusMode && uncensoredText != null) {
      return uncensoredText!;
    }
    return text;
  }
}

class Chapter {
  final String title;
  final List<StoryBlock> blocks;

  Chapter({
    required this.title,
    required this.blocks,
  });
}

class Story {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String description;
  final List<Chapter> chapters;

  Story({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.description,
    required this.chapters,
  });
}

final List<Story> mockStories = [
  Story(
    id: '1',
    title: 'The Crimson Academy',
    author: 'Yuki K.',
    coverUrl: 'https://images.unsplash.com/photo-1541562232579-512a21360020?auto=format&fit=crop&w=500&q=80',
    description: 'A magical academy where the night hides dangerous secrets and intense desires. Follow the journey of a new transfer student who discovers the hidden truth of the Crimson Dormitory.',
    chapters: [
      Chapter(
        title: 'Chapter 1: The Arrival',
        blocks: [
          StoryBlock(text: 'The grand gates of the Crimson Academy loomed before me. It was everything the brochures promised: majestic, imposing, and slightly terrifying.'),
          StoryBlock(text: 'I met my new roommate, a tall student with striking violet eyes. "Welcome," they said with a polite smile.', 
                     uncensoredText: 'I met my new roommate, a tall student with striking violet eyes. Their gaze traveled slowly up and down my body. "Well, aren\'t you a tempting new addition," they purred with a wicked smile.'),
          StoryBlock(text: 'We spent the evening studying the academy\'s extensive rulebook.',
                     uncensoredText: 'We spent the evening breaking the academy\'s most strict rules, exploring every inch of each other until the early morning light.'),
          StoryBlock(text: '', is18PlusOnly: true, uncensoredText: 'The intensity of the night left me breathless, realizing the academy was a place of unbridled passion.'),
          StoryBlock(text: 'As I finally went to sleep, I knew my life here would never be the same.'),
        ]
      ),
      Chapter(
        title: 'Chapter 2: Midnight Studies',
        blocks: [
          StoryBlock(text: 'The library was quiet. The scent of old parchment filled the air.'),
          StoryBlock(text: 'We sat close to each other, reading a fascinating book on magical theory.',
                     uncensoredText: 'We sat close, their hand sliding up my thigh under the table while we pretended to read a book on magical theory.'),
          StoryBlock(text: 'Suddenly, a professor walked by, so we focused on our notes.',
                     uncensoredText: 'Suddenly, a professor walked by. We barely managed to hide our flushed faces and disheveled clothes.'),
          StoryBlock(text: 'Studying here is definitely challenging, but I am learning so much.'),
        ]
      )
    ]
  ),
  Story(
    id: '2',
    title: 'Neon Nights: Cyber City',
    author: 'Akira R.',
    coverUrl: 'https://images.unsplash.com/photo-1515462277126-2dd0c162007a?auto=format&fit=crop&w=500&q=80',
    description: 'In the neon-drenched streets of Neo-Tokyo, a hacker and a rogue android find themselves tangled in a conspiracy that threatens the entire city.',
    chapters: [
      Chapter(
        title: 'Prologue',
        blocks: [
          StoryBlock(text: 'Rain poured down the neon signs. The alleyway smelled of ozone and cheap noodles.'),
          StoryBlock(text: 'She pulled me into the shadows as the patrol drones flew past overhead.'),
          StoryBlock(text: 'We shared a tense moment of silence, glad to have escaped.',
                     uncensoredText: 'We pressed tightly against each other in the narrow shadows. The adrenaline rush quickly turned into raw, undeniable lust as she pressed her lips forcefully against mine.'),
          StoryBlock(text: 'Once the coast was clear, we headed to the safehouse.'),
        ]
      )
    ]
  ),
];
