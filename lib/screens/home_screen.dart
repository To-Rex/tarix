import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/physics_controller.dart';
import '../models/physics_topic.dart';
import '../screens/detail_screen.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhysicsController>();

    return Scaffold(
      backgroundColor: Theme.of(context).cardTheme.color,
      appBar: AppBar(
        title: Text('app_name'.tr),
        centerTitle: true,
        actions: [Obx(() => IconButton(
              icon: Icon(
                controller.isGridView.value ? Icons.list : Icons.grid_view,
                color: Theme.of(context).appBarTheme.iconTheme?.color,
              ),
              onPressed: controller.toggleView,
              tooltip: controller.isGridView.value ? 'List ko‘rinishi' : 'Grid ko‘rinishi',
            ))
        ]
      ),
      drawer: const AppDrawer(),
      body: Container(
        child: Obx(
              () => controller.topics.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : controller.isGridView.value
              ? _buildGridView(context, controller)
              : _buildListView(context, controller),
        ),
      ),
    );
  }

  Widget _buildGridView(BuildContext context, PhysicsController controller) {
    return GridView.builder(
      key: const ValueKey('grid'),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: controller.topics.length,
      itemBuilder: (context, index) {
        final topic = controller.topics[index];
        return _buildTopicCard(context, topic, index);
      },
    );
  }

  Widget _buildListView(BuildContext context, PhysicsController controller) {
    return ListView.builder(
      key: const ValueKey('list'),
      padding: const EdgeInsets.all(16),
      itemCount: controller.topics.length,
      itemBuilder: (context, index) {
        final topic = controller.topics[index];
        return Container(
          height: 140,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: _buildTopicCard(context, topic, index),
        );
      },
    );
  }

  Widget _buildTopicCard(BuildContext context, PhysicsTopic topic, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeInOut,
      transform: Matrix4.identity()..translate(0.0, index.isEven ? 10.0 : -10.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Theme.of(context).cardTheme.color,
        //shadowColor: Theme.of(context).cardTheme.shadowColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Get.to(() => DetailScreen(topic: topic)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: Get.isDarkMode
                          ? [const Color(0xFF42A5F5).withOpacity(0.3), const Color(0xFF42A5F5).withOpacity(0.1)]
                          : [const Color(0xFF1976D2).withOpacity(0.3), const Color(0xFF1976D2).withOpacity(0.1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.science,
                    size: 20,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  topic.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Flexible(
                  child: Text(
                    topic.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}