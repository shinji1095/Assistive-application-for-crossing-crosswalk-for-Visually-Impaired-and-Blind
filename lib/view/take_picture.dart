import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_a/view_model/takePictureViewModel.dart';

class takePicturePage extends ConsumerWidget {
  const takePicturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(takePictureViewModelProvider);
    final viewModel = ref.watch(takePictureViewModelProvider.notifier);
    const types = ['科学・テクノロジー', '文化・芸術', 'スポーツ'];
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MVVMサンプル'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    'メールアドレスを入力',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TextField(
                controller: viewModel.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              Row(children: [Text('※ state.email => ${state.email}')]),
              const SizedBox(height: 40),
              const Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    'あなたの興味を選んでください。',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              for (final type in types)
                InkWell(
                  onTap: () => viewModel.updateTypeList(type),
                  child: Row(
                    children: [
                      const SizedBox(width: 60),
                      Icon(
                        Icons.circle_outlined,
                        color: state.typeList.contains(type)
                            ? Colors.red
                            : Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      Text(type),
                    ],
                  ),
                ),
              const SizedBox(height: 15),
              Row(children: [Text('※ state.typeList => ${state.typeList}')]),
              const SizedBox(height: 40),
              Row(
                children: [
                  Checkbox(
                    value: state.isPolicyChecked,
                    onChanged: (bool? newValue) {
                      viewModel.updateIsPolicyChecked(newValue!);
                    },
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    '利用規約に同意します。',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(children: [
                Text('※ state.isPolicyChecked => ${state.isPolicyChecked}'),
              ]),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}