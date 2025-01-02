import 'package:flutter/material.dart';
import 'package:renuka_travels/components/custum_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var kheight = MediaQuery.sizeOf(context).height;
    var kwidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "logo",
          child: Image.asset(
            "assets/logo.png",
            width: 100,
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
      ),
      drawer: CustumDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Section-01
            Section01(kwidth: kwidth, kheight: kheight),
            //Section-02
            Section02(kwidth: kwidth, kheight: kheight),
          ],
        ),
      ),
    );
  }
}

class Section02 extends StatelessWidget {
  const Section02({
    super.key,
    required this.kwidth,
    required this.kheight,
  });

  final double kwidth;
  final double kheight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          width: kwidth,
          color: Color(0xFFebf5ff),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Aligns children to the left
                  children: [
                    Text(
                      "The Best And Most",
                      style: TextStyle(
                          fontSize: kwidth * 0.075,
                          fontWeight: FontWeight.w500),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Trusted ",
                        style: TextStyle(
                            fontSize: kwidth * 0.075,
                            fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text: "Service",
                            style: TextStyle(
                                fontSize: kwidth * 0.075,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFF4AC20)),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "For more than a decade, we’ve been proudly serving hundreds of travelers, providing exceptional experiences across Sri Lanka. Our latest platform is designed to make planning your perfect trip easier than ever, offering tailored services for everyone looking to explore the beauty of Sri Lanka.",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: kheight * 0.02,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.asset(
                            "assets/div02-cover.png",
                            width: kwidth * 0.9,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "100+",
                              style: TextStyle(
                                  color: Color(0xFFF4AC20),
                                  fontSize: kwidth * 0.075,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: kwidth *
                                  0.25, // Restrict the width for wrapping
                              child: Text(
                                "Customers & Partners",
                                textAlign: TextAlign
                                    .center, // Align text within the column
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: kwidth * 0.04,
                                ), // Optional styling
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "10+",
                              style: TextStyle(
                                  color: Color(0xFFF4AC20),
                                  fontSize: kwidth * 0.075,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: kwidth * 0.25,
                              child: Text(
                                "Years of Experience",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: kwidth * 0.04,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "50+",
                              style: TextStyle(
                                  color: Color(0xFFF4AC20),
                                  fontSize: kwidth * 0.075,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: kwidth * 0.25,
                              child: Text(
                                "Success Journey",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: kwidth * 0.04,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Section01 extends StatelessWidget {
  const Section01({
    super.key,
    required this.kwidth,
    required this.kheight,
  });

  final double kwidth;
  final double kheight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0),
          child: Row(
            children: [
              Text(
                "It’s a Big World Out There,",
                style: TextStyle(
                    fontSize: kwidth * 0.075, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Text(
                "Go Explore",
                style: TextStyle(
                    fontSize: kwidth * 0.075,
                    color: Color(0xFFF4AC20),
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Dreaming of an unforgettable trip to Sri Lanka? Discover the hidden gems, plan your itinerary, explore top hotels, and manage your budget with ease. Sign up now to start crafting your personalized Sri Lankan adventure today!",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: kheight * 0.02,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Image.asset(
          "assets/home-div01.png",
          width: kwidth * 0.95,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              fixedSize:
                  WidgetStateProperty.all(Size(kwidth * 0.8, kheight * 0.06)),
              backgroundColor: WidgetStateProperty.all(Color(0xFFF4AC20)),
            ),
            child: Text(
              "Customize Your Own Plan",
              style: TextStyle(
                  fontSize: kheight * 0.02,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    );
  }
}
