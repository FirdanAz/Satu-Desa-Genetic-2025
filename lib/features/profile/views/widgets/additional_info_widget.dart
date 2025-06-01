import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';

class AdditionalInfoWidget extends StatelessWidget {
  const AdditionalInfoWidget({super.key, required this.domisili, required this.role});
  final String domisili;
  final String role;

  @override
  Widget build(BuildContext context) {
    final LocalDataPersistance localData = LocalDataPersistance();

    return Container(
      padding: const EdgeInsets.only(top: 14, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [AppColor.primary, Color(0xff6DB389)],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 15),
                _buildInfoIcon(Icons.location_on_outlined),
                const SizedBox(width: 9),
                _buildInfoContent(
                    "Domisili",
                    localData.getUserCity() != null
                        ? localData.getUserCity().toString()
                        : domisili),
              ],
            ),
          ),
          Container(
              width: 2,
              height: 46,
              color: AppColor.bgOnPrimary.withValues(alpha: 0.40)),
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 15),
                _buildInfoIcon(Icons.group_outlined),
                const SizedBox(width: 9),
                _buildInfoContent(
                  "Posisi",
                  localData.getUserRole() == 'admin' ? "Pengelola" : "Penduduk",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoIcon(IconData icon) {
    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.21),
      ),
      child: Icon(icon, color: AppColor.bgOnPrimary),
    );
  }

  Widget _buildInfoContent(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColor.bgOnPrimary.withValues(alpha: 0.89),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.33,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColor.bgOnPrimary,
            fontWeight: FontWeight.w500,
            height: 1.42,
          ),
        ),
      ],
    );
  }
}
