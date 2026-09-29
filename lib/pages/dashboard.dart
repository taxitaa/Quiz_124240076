import 'package:flutter/material.dart';
import '../models/culinaryList.dart';
import 'detail.dart' as culinary_detail;

const Color _sand = Color(0xFFF3E6D5);
const Color _wine = Color(0xFF800020);
const Color _coral = Color(0xFFD45060);
const Color _paper = Color(0xFFFFF9F2);

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _sand,
      appBar: AppBar(
        title: const Text('Culinarizz'),
        backgroundColor: _wine,
        foregroundColor: _paper,
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
            icon: const Icon(Icons.logout_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: const _DashboardContent(),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1120),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Jelajahi cita rasa Nusantara',
                style: TextStyle(
                  color: _wine,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = switch (constraints.maxWidth) {
                      >= 900 => 4,
                      >= 560 => 3,
                      _ => 2,
                    };
                    final cardWidth =
                        (constraints.maxWidth - (columns - 1) * 14) / columns;

                    return GridView.builder(
                      itemCount: culinaryList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        mainAxisExtent: cardWidth / 1.4 + 100,
                      ),
                      itemBuilder: (context, index) =>
                          _CulinaryTile(culinary: culinaryList[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CulinaryTile extends StatelessWidget {
  const _CulinaryTile({required this.culinary});

  final Culinary culinary;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _paper,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) =>
                  culinary_detail.CulinaryDetailPage(culinary: culinary),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.4,
              child: Image.network(
                culinary.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const ColoredBox(
                  color: _sand,
                  child: Center(
                    child: Icon(
                      Icons.restaurant_rounded,
                      color: _wine,
                      size: 42,
                    ),
                  ),
                ),
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const ColoredBox(
                    color: _sand,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: _coral,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    culinary.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _wine,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    culinary.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    culinary.origin,
                    style: const TextStyle(color: _coral, fontSize: 12),
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

class CulinaryDetailPage extends StatelessWidget {
  const CulinaryDetailPage({super.key, required this.culinary});

  final Culinary culinary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _sand,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            backgroundColor: _wine,
            foregroundColor: _paper,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(culinary.name),
              background: Image.network(
                culinary.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const ColoredBox(
                  color: _wine,
                  child: Icon(
                    Icons.restaurant_rounded,
                    color: _paper,
                    size: 64,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        children: [
                          _InformationTag(label: culinary.category),
                          _InformationTag(label: culinary.origin),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        culinary.description,
                        style: const TextStyle(fontSize: 16, height: 1.6),
                      ),
                      const SizedBox(height: 24),
                      _DetailRow(
                        label: 'Bahan utama',
                        value: culinary.mainIngredient,
                      ),
                      _DetailRow(label: 'Cita rasa', value: culinary.flavor),
                      _DetailRow(
                        label: 'Tingkat pedas',
                        value: culinary.spicyLevel,
                      ),
                      _DetailRow(
                        label: 'Waktu penyajian',
                        value: culinary.servingTime,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InformationTag extends StatelessWidget {
  const _InformationTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(Icons.place_rounded, size: 16, color: _wine),
      label: Text(label),
      backgroundColor: _paper,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: _wine, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(height: 1.4)),
        ],
      ),
    );
  }
}
