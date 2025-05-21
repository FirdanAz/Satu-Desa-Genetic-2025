import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class IuranSampahCard extends StatefulWidget {
  final int year;
  final int currentMonth; // Bulan saat ini (1-12)
  final List<bool> paidMonths; // Index 0: Jan, dst...
  final void Function(int month)? onBayarPressed;

  const IuranSampahCard({
    super.key,
    required this.year,
    required this.currentMonth,
    required this.paidMonths,
    this.onBayarPressed,
  });

  @override
  State<IuranSampahCard> createState() => _IuranSampahCardState();
}

class _IuranSampahCardState extends State<IuranSampahCard> {
  late int selectedMonth;

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.currentMonth; // default: bulan saat ini
  }

  @override
  Widget build(BuildContext context) {
    final monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];
    final paid = widget.paidMonths[selectedMonth - 1];
    print(paid);
    final isBayarAvailable = !paid;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primary, Color(0xFF6DB389)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Image.asset(
                'assets/icons/ic_recycle.png',
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Iuran Retribusi Sampah',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Rp15.000/bulan',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Tahun dan navigasi (jika perlu)
          Row(
            children: [
              Text(
                'Thn ${widget.year}',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              const Icon(Icons.arrow_drop_down_sharp, color: Colors.white),
            ],
          ),
          const SizedBox(height: 12),
          // Bulan dan status centang
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 12,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final isPaid = widget.paidMonths[index];
                final isSelected = selectedMonth == index + 1;

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedMonth = index + 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        monthNames[index],
                        style: TextStyle(
                          color:
                              isSelected ? Colors.yellowAccent : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Image.asset(
                        isPaid
                            ? 'assets/icons/ic_indicator_done.png'
                            : 'assets/icons/ic_indicator_not_yet.png',
                        width: 22,
                        height: 22,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Status dan tombol bayar
          Row(
            children: [
              Expanded(
                child: Text(
                  paid
                      ? 'Anda Sudah Membayar Iuran Bulan ${monthNames[widget.currentMonth - 1]}'
                      : 'Iuran Bulan ${monthNames[widget.currentMonth - 1]} Belum Dibayar',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: isBayarAvailable
                    ? () => widget.onBayarPressed?.call(selectedMonth)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  foregroundColor: Colors.green[800],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  disabledBackgroundColor: Colors.white24,
                ),
                child: Text(
                  isBayarAvailable ? 'Lunasi Iuran' : 'Lunas',
                  style: TextStyle(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
