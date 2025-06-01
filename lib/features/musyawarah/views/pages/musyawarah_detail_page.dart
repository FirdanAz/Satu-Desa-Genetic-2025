import 'package:flutter/material.dart';
import 'package:satu_desa/core/public/widgets/custom_appbar.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class MusyawarahDetailPage extends StatefulWidget {
  @override
  _MusyawarahDetailPageState createState() => _MusyawarahDetailPageState();
}

class _MusyawarahDetailPageState extends State<MusyawarahDetailPage> {
  int totalSuara = 0;
  int sabtuPagi = 0;
  int mingguPagi = 0;
  String pilihan = "";

  void vote(String hari) {
    setState(() {
      if (pilihan.isEmpty) {
        if (hari == 'Sabtu') sabtuPagi++;
        if (hari == 'Minggu') mingguPagi++;
        totalSuara++;
        pilihan = hari;
      }
    });
  }

  double getPersen(int jumlah) {
    if (totalSuara == 0) return 0.0;
    return jumlah / totalSuara;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PublicWidget().customAppBar(title: "", context: context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Image.asset("assets/images/mock_musyawarah2.png", fit: BoxFit.fitWidth,),
              const SizedBox(height: 16,),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColor.descText, width: 1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hasil Musyawarah", style: TextStyle(fontWeight: FontWeight.w500, color: AppColor.descText)),
                    SizedBox(height: 12),
                
                    // Sabtu Pagi
                    RadioListTile(
                      title: Text("Sabtu Pagi", style: TextStyle(color: AppColor.descText),),
                      value: 'Sabtu',
                      groupValue: pilihan,
                      onChanged: (val) => vote('Sabtu'),
                      secondary: Text("${(getPersen(sabtuPagi) * 100).toStringAsFixed(0)}% (${sabtuPagi} suara)"),
                    ),
                    LinearProgressIndicator(
                      value: getPersen(sabtuPagi),
                      color: Colors.green,
                      backgroundColor: Colors.grey[300],
                    ),
                    SizedBox(height: 16),
                
                    // Minggu Pagi
                    RadioListTile(
                      title: Text("Minggu Pagi",  style: TextStyle(color: AppColor.descText)),
                      value: 'Minggu',
                      groupValue: pilihan,
                      onChanged: (val) => vote('Minggu'),
                      secondary: Text("${(getPersen(mingguPagi) * 100).toStringAsFixed(0)}% (${mingguPagi} suara)"),
                    ),
                    LinearProgressIndicator(
                      value: getPersen(mingguPagi),
                      color: AppColor.primary,
                      backgroundColor: Colors.grey[300],
                    ),
                
                    SizedBox(height: 20),
                    Text(
                      "*Musyawarah belum dimulai",
                      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
