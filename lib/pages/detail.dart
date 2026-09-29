import 'package:flutter/material.dart';

import '../models/culinaryList.dart';

const Color _sand = Color(0xFFF3E6D5);
const Color _wine = Color(0xFF800020);
const Color _coral = Color(0xFFD45060);
const Color _paper = Color(0xFFFFF9F2);

class CulinaryDetailPage extends StatelessWidget {
  const CulinaryDetailPage({super.key, required this.culinary});

  final Culinary culinary;

  @override
  Widget build(BuildContext context) {
    final details = [
      (
        icon: Icons.restaurant_menu_rounded,
        label: 'Bahan utama',
        value: culinary.mainIngredient,
      ),
      (
        icon: Icons.local_dining_rounded,
        label: 'Cita rasa',
        value: culinary.flavor,
      ),
      (
        icon: Icons.whatshot_rounded,
        label: 'Tingkat pedas',
        value: culinary.spicyLevel,
      ),
      (
        icon: Icons.schedule_rounded,
        label: 'Waktu penyajian',
        value: culinary.servingTime,
      ),
    ];

    return Scaffold(
      backgroundColor: _sand,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 320,
            backgroundColor: _wine,
            foregroundColor: _paper,
            leading: IconButton(
              tooltip: 'Kembali ke daftar kuliner',
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(culinary.name, style: const TextStyle(color: _paper)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    culinary.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const ColoredBox(
                          color: _wine,
                          child: Center(
                            child: Icon(
                              Icons.restaurant_rounded,
                              color: _paper,
                              size: 64,
                            ),
                          ),
                        ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0x99000000)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _InformationTag(
                            icon: Icons.category_rounded,
                            label: culinary.category,
                          ),
                          _InformationTag(
                            icon: Icons.place_rounded,
                            label: culinary.origin,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _FavoriteButton(),
                      ),
                      const SizedBox(height: 28),
                      const _SectionHeading(title: 'Tentang kuliner ini'),
                      const SizedBox(height: 8),
                      Text(
                        culinary.description,
                        style: const TextStyle(fontSize: 16, height: 1.6),
                      ),
                      const SizedBox(height: 28),
                      const _SectionHeading(title: 'Rasa dan penyajian'),
                      const SizedBox(height: 14),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: details.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 220,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              mainAxisExtent: 160,
                            ),
                        itemBuilder: (context, index) {
                          final detail = details[index];
                          return _DetailCard(
                            icon: detail.icon,
                            label: detail.label,
                            value: detail.value,
                          );
                        },
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

class _FavoriteButton extends StatefulWidget {
  const _FavoriteButton();

  @override
  State<_FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<_FavoriteButton> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: _isFavorite ? 'Hapus dari favorit' : 'Tambah ke favorit',
      onPressed: () => setState(() => _isFavorite = !_isFavorite),
      icon: Icon(
        _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
        color: _isFavorite ? Colors.red : Colors.black54,
      ),
    );
  }
}

class _InformationTag extends StatelessWidget {
  const _InformationTag({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16, color: _wine),
      label: Text(label),
      backgroundColor: _paper,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: _wine,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _coral, size: 22),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: _wine,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              value,
              maxLines: 3,
              style: const TextStyle(fontSize: 14, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
