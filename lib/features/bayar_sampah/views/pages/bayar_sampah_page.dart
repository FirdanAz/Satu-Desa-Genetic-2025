import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:satu_desa/core/public/shimmer/shimmer_bayar_sampah_page.dart';
import 'package:satu_desa/core/public/widgets/custom_list_tile.dart';
import 'package:satu_desa/core/public/widgets/info_empty_widget.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/bayar_sampah/cubit/sampah_cubit.dart';
import 'package:satu_desa/features/bayar_sampah/models/history_transaksi_model.dart';
import 'package:satu_desa/features/bayar_sampah/views/pages/midtrans_payment_page.dart';
import 'package:satu_desa/features/bayar_sampah/views/pages/payment_detail_page.dart';
import 'package:satu_desa/features/bayar_sampah/views/widgets/iuran_sampah_card.dart';

class BayarSampahPage extends StatefulWidget {
  const BayarSampahPage({super.key});

  @override
  State<BayarSampahPage> createState() => _BayarSampahPageState();
}

class _BayarSampahPageState extends State<BayarSampahPage> {
  final LocalDataPersistance _localData = LocalDataPersistance();
  final cubit = SampahCubit()..getHistoryTransaksi();
  final int _year = 2025;
  List<bool> paidMonths = [];

  List<bool> getPaidMonthsFromModel(
      List<HistoryTransaksiModel> payments, int targetYear) {
    final List<bool> paidMonths = List.generate(12, (_) => false);

    for (var payment in payments) {
      if (payment.transactionStatus == 'paid' &&
          payment.createdAt.year == targetYear) {
        final monthIndex = payment.month - 1; // index dari 0
        paidMonths[monthIndex] = true;
      }
    }

    return paidMonths;
  }

  String formatRupiah(String raw) {
    final double number = double.tryParse(raw) ?? 0.0;

    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0, // hilangkan angka di belakang koma
    );

    return formatter.format(number);
  }

  String formatTanggal(DateTime date) {
    final formatter = DateFormat('d MMM yyyy', 'id_ID');
    return formatter.format(date);
  }

  String getBulan(DateTime date) {
    return DateFormat.MMMM('id_ID').format(date); // Output: "April"
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bayar Sampah'),
        backgroundColor: AppColor.primary,
        toolbarHeight: 100,
        titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColor.bgButton,
      body: BlocListener<SampahCubit, SampahState>(
        bloc: cubit,
        listener: (context, state) {
          if (state.status == SampahStatus.snapTokenObtained) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MidtransPaymentPage(
                  snapToken: state.snapToken!,
                ),
              ),
            );
          } else if (state.status == SampahStatus.failed) {
            AwesomeDialog(
              context: context,
              animType: AnimType.rightSlide,
              dialogType: DialogType.warning,
              title: state.errorMessage,
            ).show();
          }
        },
        child: BlocBuilder<SampahCubit, SampahState>(
          bloc: cubit,
          builder: (context, state) {
            if (state.status == SampahStatus.loading) {
              return ShimmerBayarSampahPage();
            } else if (state.status == SampahStatus.success) {
              final year = state.yearTransaction ?? DateTime.now().year;
              final paidMonths =
                  getPaidMonthsFromModel(state.transaksiModel!, year);
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IuranSampahCard(
                        year: _year,
                        currentMonth: DateTime.now().month,
                        paidMonths: paidMonths,
                        onBayarPressed: (selectedMonth) {
                          final monthNames = [
                            'Januari',
                            'Februari',
                            'Maret',
                            'April',
                            'Mei',
                            'Juni',
                            'Juli',
                            'Agustus',
                            'September',
                            'Oktober',
                            'November',
                            'Desember'
                          ];
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.scale,
                            title:
                                "Bayar Iuran Bulan ${monthNames[selectedMonth - 1]}?",
                            btnOkText: "Bayar",
                            btnOkColor: AppColor.primary,
                            btnOkOnPress: () {
                              cubit.postCreatePayment(
                                year: _year.toString(),
                                month: selectedMonth.toString(),
                              );
                            },
                          ).show();
                        },
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Text(
                        "Riwayat Transaksi",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      state.transaksiModel!.isNotEmpty
                          ? Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.transaksiModel!.length,
                                itemBuilder: (context, index) {
                                  var data = state.transaksiModel![index];

                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PaymentDetailPage(
                                                    nama: _localData
                                                        .getUserName()!,
                                                    bulan: getBulan(
                                                        data.createdAt),
                                                    metodePembayaran:
                                                        data.paymentMethod,
                                                    jumlah: formatRupiah(
                                                        data.amount)),
                                          ));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getBulan(DateTime(_year, data.month)),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppColor.descText),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        CustomListTile(
                                          iconAsset: "assets/icons/ic_done.svg",
                                          title: 'Iuran Retribusi Sampah',
                                          subTitle: formatRupiah(data.amount),
                                          action: formatTanggal(data.createdAt),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider()
                                      ],
                                    ),
                                  );
                                },
                              ))
                          : Center(
                              child: InfoEmptyWidget(
                                  emptyText: "Riwayat Transaksi"))
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
