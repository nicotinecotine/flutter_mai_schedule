import 'package:flutter/material.dart';
import 'package:flutter_mai_schedule/pages/main_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _MyBottomAppBar(),
      body: _MyBody(),
    );
  }
}

class _MyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 60,
        left: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Добро пожаловать!',
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Данное приложение представляет из себя мега-гига бета-версию. Почти на каждом этапе его использования Вас будут преследовать баги.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          const Text(
            'Приятного пользования. Благодарю Вас за понимание!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Row(
            children: const [
              Text(
                'Для претензий: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '@nicotinecotinine (tg)',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _MyBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.yellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 18, bottom: 18),
            child: const Text(
              'Далее',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 24),
            ),
          ),
          onPressed: () {
            Route route =
                MaterialPageRoute(builder: (context) => const MyMainPage());
            Navigator.push(context, route);
          },
        ),
      ),
    );
  }
}
