import 'package:flutter/material.dart';
import '../../core/utils/responsive.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(child: _TextContent()),
                SizedBox(width: 40),
                Expanded(child: _ImagePlaceholder()),
              ],
            )
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _TextContent(),
                SizedBox(height: 24),
                _ImagePlaceholder(),
              ],
            ),
    );
  }
}

class _TextContent extends StatelessWidget {
  const _TextContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hi, I'm Izzuddin",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Text(
          "Senior Mobile Engineer\nFlutter & iOS Specialist",
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.grey,
      child: const Center(child: Text("Image")),
    );
  }
}