import 'package:flutter/material.dart';

class FilterSheet extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;

  static const _items = [
    ('Semua Kategori', Icons.apps, Color(0xFF2D6A4F)),
    ('Alam', Icons.park, Color(0xFF388E3C)),
    ('Budaya', Icons.account_balance, Color(0xFFE65100)),
    ('Pantai', Icons.beach_access, Color(0xFF00838F)),
    ('Agrowisata', Icons.eco, Color(0xFF6A1B9A)),
  ];

  const FilterSheet({super.key, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Kategori',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B4332),
            ),
          ),
          const SizedBox(height: 16),
          ..._items.map((item) {
            final label = item.$1;
            final icon = item.$2;
            final color = item.$3;
            final labelKey = label == 'Semua Kategori' ? 'Semua' : label;
            final isSel = selected == labelKey;
            return GestureDetector(
              onTap: () => onSelect(labelKey),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: isSel ? const Color(0xFF2D6A4F) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSel ? const Color(0xFF2D6A4F) : Colors.black12,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: isSel ? Colors.white : color, size: 22),
                    const SizedBox(width: 14),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 15,
                        color: isSel ? Colors.white : const Color(0xFF333333),
                        fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    if (isSel)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 20,
                      ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
