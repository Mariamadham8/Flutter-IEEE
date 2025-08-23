# 📱 Flutter Instagram (Learning Notes)

## 🎨 UI & Widgets

### 🔘 Circle Shape with Gradient
```dart
Container(
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    gradient: LinearGradient(
      colors: [Colors.pinkAccent, Colors.orange],
    ),
  ),
  child: CircleAvatar(
    radius: 25,
    backgroundImage: NetworkImage(userImage),
  ),
)
<!-- بيعمل شكل دائري فيه صورة، وبراها Gradient زي Instagram Story -->


🔄 Transform.rotate

Transform.rotate(
  angle: -10,
  child: Icon(Icons.link),
)
<!-- بستخدمها عشان ألف أي Widget بزاوية معينة -->

📑 TabBar + TabBarView

TabBar(
  controller: _tabController,
  indicator: BoxDecoration(
    color: Colors.purple,
    borderRadius: BorderRadius.circular(100),
  ),
  tabs: [
    Icon(Icons.grid_on),
    Icon(Icons.video_library_rounded),
    Icon(Icons.person_add_alt),
  ],
)

Expanded(
  child: TabBarView(
    controller: _tabController,
    children: [
      GridView(...), // posts
      GridView(...), // reels
      GridView(...), // mentions
    ],
  ),
)
<!-- TabBar للتنقل بين الصفحات، TabBarView للـ Content -->


📦 GridView vs ListView
ListView.builder

ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Text(items[index]);
  },
)
<!-- بيعرض عناصر في عمود واحد -->
GridView.builder

GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 1,
    crossAxisSpacing: 1,
    childAspectRatio: 0.9 / 1.1,
  ),
  itemCount: imgs.length,
  itemBuilder: (context, index) {
    return Image.network(imgs[index]);
  },
)
<!-- بيعرض العناصر في شبكة بعدد أعمدة -->
👉 الفرق الأساسي:

ListView = عمود واحد.

GridView = شبكة (Rows + Columns).



🎥 video_player Package
controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
  ..initialize().then((_) {
    setState(() {
      controller.play();
    });
  });

@override
void dispose() {
  controller.dispose();
  super.dispose();
}

controller.value.isInitialized
  ? VideoPlayer(controller)
  : CircularProgressIndicator();
<!-- الفيديو محتاج initialize() قبل التشغيل، و dispose() عشان الموارد تتحرر -->


🌐 API (GET Request)
final url = Uri.parse("https://api.com/data");
final res = await http.get(url);
final json = jsonDecode(res.body) as Map;
خطوات:
أعمل http.get().

أفك البيانات من JSON → Map أو List بـ jsonDecode.

أخزنها في State وأعرضها في الـ UI.

<!-- مثال: عرض Followers أو Username جاي من API -->
✨ State Management + Navigation
لو بعمل Request Data + Navigator.push في نفس الوقت → ساعات بيحصل Error.
الحل: أستخدم loading state زي CupertinoActivityIndicator أو CircularProgressIndicator لحد ما الـ data ترجع.

مش محتاج Threads، Flutter بيشتغل Async بـ Future.



🛠️ Extra Tricks اتعلمتها
🔹 Passing Data to StatefulWidget
class User extends StatefulWidget {
  final Map info;
  const User({super.key, required this.info});

  @override
  State<User> createState() => _UserState();

}
🔹 التعامل مع Null Safety


String? name = widget.info['username'] ?? "Guest";

🔹 تجنب RangeError

if (followers.length > 100) {
  followers[100]['profile_pic_url_hd'];
}
