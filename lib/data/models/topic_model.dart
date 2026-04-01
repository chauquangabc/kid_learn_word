class Item {
  final String id;
  final String nameEn;
  final String nameVn;
  final String emoji;
  final String color;

  const Item({
    required this.id,
    required this.nameEn,
    required this.nameVn,
    required this.emoji,
    required this.color,
  });

  String getName(String language) => language == 'vn' ? nameVn : nameEn;
}

const List<Item> animals = [
  Item(
    id: 'bear',
    nameEn: 'Bear',
    nameVn: 'Gấu',
    emoji: '🐻',
    color: '#C8A882',
  ),
  Item(id: 'cat', nameEn: 'Cat', nameVn: 'Mèo', emoji: '🐱', color: '#D4B5F5'),
  Item(id: 'cow', nameEn: 'Cow', nameVn: 'Bò', emoji: '🐄', color: '#F5E6C8'),
  Item(id: 'dog', nameEn: 'Dog', nameVn: 'Chó', emoji: '🐶', color: '#F5C8A0'),
  Item(
    id: 'elephant',
    nameEn: 'Elephant',
    nameVn: 'Voi',
    emoji: '🐘',
    color: '#B5C8D4',
  ),
  Item(id: 'fox', nameEn: 'Fox', nameVn: 'Cáo', emoji: '🦊', color: '#F5A87A'),
  Item(
    id: 'giraffe',
    nameEn: 'Giraffe',
    nameVn: 'Hươu cao cổ',
    emoji: '🦒',
    color: '#F5D87A',
  ),
  Item(
    id: 'hippo',
    nameEn: 'Hippo',
    nameVn: 'Hà mã',
    emoji: '🦛',
    color: '#C8B5D4',
  ),
  Item(
    id: 'lion',
    nameEn: 'Lion',
    nameVn: 'Sư tử',
    emoji: '🦁',
    color: '#F5C842',
  ),
  Item(
    id: 'monkey',
    nameEn: 'Monkey',
    nameVn: 'Khỉ',
    emoji: '🐒',
    color: '#C8A06E',
  ),
  Item(
    id: 'panda',
    nameEn: 'Panda',
    nameVn: 'Gấu trúc',
    emoji: '🐼',
    color: '#D4D4D4',
  ),
  Item(
    id: 'penguin',
    nameEn: 'Penguin',
    nameVn: 'Chim cánh cụt',
    emoji: '🐧',
    color: '#A0C8F5',
  ),
  Item(
    id: 'rabbit',
    nameEn: 'Rabbit',
    nameVn: 'Thỏ',
    emoji: '🐰',
    color: '#F5B5C8',
  ),
  Item(
    id: 'tiger',
    nameEn: 'Tiger',
    nameVn: 'Hổ',
    emoji: '🐯',
    color: '#F5A842',
  ),
  Item(
    id: 'zebra',
    nameEn: 'Zebra',
    nameVn: 'Ngựa vằn',
    emoji: '🦓',
    color: '#B5B5B5',
  ),
];

const List<Item> fruits = [
  Item(
    id: 'apple',
    nameEn: 'Apple',
    nameVn: 'Táo',
    emoji: '🍎',
    color: '#F5A0A0',
  ),
  Item(
    id: 'banana',
    nameEn: 'Banana',
    nameVn: 'Chuối',
    emoji: '🍌',
    color: '#F5E6A0',
  ),
  Item(
    id: 'cherry',
    nameEn: 'Cherry',
    nameVn: 'Anh đào',
    emoji: '🍒',
    color: '#F5B5C8',
  ),
  Item(
    id: 'grape',
    nameEn: 'Grape',
    nameVn: 'Nho',
    emoji: '🍇',
    color: '#D4B5F5',
  ),
  Item(
    id: 'kiwi',
    nameEn: 'Kiwi',
    nameVn: 'Kiwi',
    emoji: '🥝',
    color: '#C8D4A0',
  ),
  Item(
    id: 'lemon',
    nameEn: 'Lemon',
    nameVn: 'Chanh vàng',
    emoji: '🍋',
    color: '#F5F5A0',
  ),
  Item(
    id: 'mango',
    nameEn: 'Mango',
    nameVn: 'Xoài',
    emoji: '🥭',
    color: '#F5D4A0',
  ),
  Item(
    id: 'orange',
    nameEn: 'Orange',
    nameVn: 'Cam',
    emoji: '🍊',
    color: '#F5C8A0',
  ),
  Item(
    id: 'peach',
    nameEn: 'Peach',
    nameVn: 'Đào',
    emoji: '🍑',
    color: '#F5D4B5',
  ),
  Item(id: 'pear', nameEn: 'Pear', nameVn: 'Lê', emoji: '🍐', color: '#D4E6A0'),
  Item(
    id: 'pineapple',
    nameEn: 'Pineapple',
    nameVn: 'Dứa',
    emoji: '🍍',
    color: '#F5E6C8',
  ),
  Item(
    id: 'strawberry',
    nameEn: 'Strawberry',
    nameVn: 'Dâu tây',
    emoji: '🍓',
    color: '#F5A8A8',
  ),
  Item(
    id: 'watermelon',
    nameEn: 'Watermelon',
    nameVn: 'Dưa hấu',
    emoji: '🍉',
    color: '#A0D4B5',
  ),
  Item(
    id: 'avocado',
    nameEn: 'Avocado',
    nameVn: 'Bơ',
    emoji: '🥑',
    color: '#B5D4A0',
  ),
  Item(
    id: 'pomegranate',
    nameEn: 'Pomegranate',
    nameVn: 'Lựu',
    emoji: '🍎',
    color: '#D4A0A0',
  ),
];

const List<Item> objects = [
  Item(
    id: 'apple',
    nameEn: 'Apple',
    nameVn: 'Táo',
    emoji: '🍎',
    color: '#F5A0A0',
  ),
  Item(
    id: 'ball',
    nameEn: 'Ball',
    nameVn: 'Bóng',
    emoji: '⚽',
    color: '#A0D4A0',
  ),
  Item(
    id: 'bike',
    nameEn: 'Bike',
    nameVn: 'Xe đạp',
    emoji: '🚲',
    color: '#A0C8F5',
  ),
  Item(
    id: 'book',
    nameEn: 'Book',
    nameVn: 'Sách',
    emoji: '📚',
    color: '#F5D4A0',
  ),
  Item(
    id: 'car',
    nameEn: 'Car',
    nameVn: 'Xe hơi',
    emoji: '🚗',
    color: '#A0B5F5',
  ),
  Item(
    id: 'chair',
    nameEn: 'Chair',
    nameVn: 'Ghế',
    emoji: '🪑',
    color: '#C8A882',
  ),
  Item(
    id: 'clock',
    nameEn: 'Clock',
    nameVn: 'Đồng hồ',
    emoji: '🕐',
    color: '#D4C8A0',
  ),
  Item(id: 'cup', nameEn: 'Cup', nameVn: 'Cốc', emoji: '☕', color: '#F5B5A0'),
  Item(
    id: 'house',
    nameEn: 'House',
    nameVn: 'Nhà',
    emoji: '🏠',
    color: '#F5D4B5',
  ),
  Item(
    id: 'pencil',
    nameEn: 'Pencil',
    nameVn: 'Bút chì',
    emoji: '✏️',
    color: '#F5E6A0',
  ),
  Item(
    id: 'table',
    nameEn: 'Table',
    nameVn: 'Bàn',
    emoji: '🪵',
    color: '#C8A882',
  ),
  Item(
    id: 'tree',
    nameEn: 'Tree',
    nameVn: 'Cây',
    emoji: '🌳',
    color: '#A0D4A0',
  ),
];

List<Item> getDataset(String category) {
  switch (category) {
    case 'fruits':
      return fruits;
    case 'animals':
      return animals;
    case 'objects':
      return objects;
    default:
      return [];
  }
}
