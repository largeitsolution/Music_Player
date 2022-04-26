import 'package:audioplayers/audioplayers.dart';

int indexloop = 0;
int seletedindex = -1;
bool playsymbol = false;
int timeProgress = 0;
int audioDuration = 0;
var alldata;
bool showBottom = false;
// var skip;
bool showdata = false;
List dataList = [];
int currentIndex = -1;
late bool isLoop;
AudioPlayer audioPlayer = AudioPlayer();
PlayerState audioPlayerState = PlayerState.PAUSED;

// AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
Duration position = new Duration();
Duration musicLength = new Duration();

List musicList = [
  {
    'title': 'Allah Amr Rob',
    'singer': 'Kazi Nazrul',
    'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3',
    'image':
        'https://thumbs.dreamstime.com/b/environment-earth-day-hands-trees-growing-seedlings-bokeh-green-background-female-hand-holding-tree-nature-field-gra-130247647.jpg'
  },
 
  {
    'title': 'Allah Amr Malik',
    'singer': 'Begum Requya',
    'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-15.mp3',
    'image': 'https://static.addtoany.com/images/dracaena-cinnabari.jpg'
  },
   {
    'title': 'Allah Amr Sob',
    'singer': ' Sofiya Kamal',
    'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-14.mp3',
    'image': 'https://tinypng.com/images/social/website.jpg'
  },
];
