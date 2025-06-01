import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:satu_desa/core/constant/constant.dart';
import 'package:satu_desa/core/public/widgets/custom_appbar.dart';
import 'package:satu_desa/core/public/widgets/custom_text_field.dart';
import 'package:satu_desa/core/public/widgets/info_empty_widget.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/aspiration/cubit/aspiration_cubit.dart';
import 'package:satu_desa/features/aspiration/models/aspirasi_model.dart';
import 'package:satu_desa/features/bottom_navigation/views/home_nav_wrapper.dart';

class AspirasiFormPage extends StatefulWidget {
  const AspirasiFormPage({super.key, this.existingAspirasi});

  final AspirasiModel? existingAspirasi;

  @override
  State<AspirasiFormPage> createState() => _AspirasiFormPageState();
}

class _AspirasiFormPageState extends State<AspirasiFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _lokasiController = TextEditingController();
  bool _sembunyikanNama = false;
  final List<XFile> _images = [];
  final List<String> _existingImageUrls = [];
  final List<int> _existingImageIds = [];

  @override
  void initState() {
    super.initState();
    final aspirasi = widget.existingAspirasi;
    print("INITSTATE: existingAspirasi => $aspirasi");

    if (aspirasi != null) {
      _judulController.text = aspirasi.judul;
      _deskripsiController.text = aspirasi.deskripsi;
      _lokasiController.text = aspirasi.lokasi;
      _sembunyikanNama = aspirasi.anonim == 1;

      if (aspirasi.images.isNotEmpty) {
        _existingImageUrls.addAll(aspirasi.images.map((e) => e.path));
        _existingImageIds.addAll(aspirasi.images.map((e) => e.id));
      }
    }
  }

  void _removeExistingImage(int index) {
    context
        .read<AspirationCubit>()
        .deleteImageAspirasi(imageId: _existingImageIds[index]);
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      _existingImageUrls.removeAt(index);
      _existingImageIds.removeAt(index);
    });
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> selectedImages = await picker.pickMultiImage();

    setState(() {
      _images.addAll(selectedImages);
    });
    }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final isEdit = widget.existingAspirasi != null;

      QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        animType: QuickAlertAnimType.scale,
        title: isEdit ? "Update Aspirasi?" : "Data sudah sesuai?",
        text: isEdit
            ? "Kamu akan memperbarui aspirasi ini."
            : "Pastikan data yang diisi sudah sesuai",
        confirmBtnText: isEdit ? "Update" : "Sudah",
        confirmBtnTextStyle: TextStyle(fontSize: 14, color: Colors.white),
        onConfirmBtnTap: () async {
          if (Navigator.canPop(context)) Navigator.pop(context);

          QuickAlert.show(
            context: context,
            type: QuickAlertType.loading,
            animType: QuickAlertAnimType.scale,
            text: isEdit ? "Memperbarui..." : "Menyimpan...",
          );

          final List<File> imageFiles =
              _images.map((xfile) => File(xfile.path)).toList();

          if (isEdit) {
            context.read<AspirationCubit>().updateAspirasi(
                aspirasiId: widget.existingAspirasi!.id,
                judul: _judulController.text,
                deskripsi: _deskripsiController.text,
                lokasi: _lokasiController.text,
                anonim: _sembunyikanNama,
                newImages: imageFiles.isNotEmpty ? imageFiles : null,
                retainedImageIds: _existingImageIds);
          } else {
            context.read<AspirationCubit>().postAspirasi(
                  judul: _judulController.text,
                  deskripsi: _deskripsiController.text,
                  lokasi: _lokasiController.text,
                  anonim: _sembunyikanNama,
                  images: imageFiles.isNotEmpty ? imageFiles : null,
                );
          }
        },
        confirmBtnColor: AppColor.primary,
      );
    }
  }

  void _listener(BuildContext context, AspirationState state) {
    if (state.status == AspirationStatus.loading) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.loading,
          animType: QuickAlertAnimType.scale,
          barrierDismissible: false,
          text: "Memuat...");
    } else if (state.status == AspirationStatus.success) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeNavWrapper(
            selectedIndex: 1,
          ),
        ),
        (route) => false,
      );
    } else if (state.status == AspirationStatus.failed) {
      showDialog(
        context: context,
        builder: (context) => Dialog.fullscreen(
          child: Container(
            child: Center(
              child: InfoEmptyWidget(
                  emptyText: "Ups!! ada error\n ${state.errorMessage}"),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PublicWidget().customAppBar(
          title: widget.existingAspirasi != null
              ? "Edit Aspirasi"
              : "Ajukan Aspirasi",
          context: context),
      backgroundColor: AppColor.bgButton,
      body: BlocListener<AspirationCubit, AspirationState>(
        listener: _listener,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(30),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Text(
                    'Sampaikan Aspirasimu di Sini',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 14),
                  Text(
                      'Kami siap mendengarkan keluhan, usulan, dan harapanmu demi desa yang lebih baik.'),
                  SizedBox(height: 20),

                  // Judul
                  CustomTextFieldWidget(
                    controller: _judulController,
                    title: 'Judul Aspirasi *',
                    hint: 'Contoh: "Jalan Berlubang"',
                    iconEnabled: "true",
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Judul wajib diisi' : null,
                  ),
                  SizedBox(height: 16),

                  CustomTextFieldWidget(
                    controller: _deskripsiController,
                    title: 'Deskripsi *',
                    maxLines: 7,
                    iconEnabled: "true",
                    type: TextInputType.multiline,
                    validator: (val) => val == null || val.isEmpty
                        ? 'Deskripsi wajib diisi'
                        : null,
                  ),
                  SizedBox(height: 16),

                  CustomTextFieldWidget(
                    controller: _lokasiController,
                    title: 'Lokasi *',
                    hint: 'Contoh: Dusun Jaya, Rt01, Rw07',
                    iconEnabled: "true",
                    validator: (val) => val == null || val.isEmpty
                        ? 'Lokasi wajib diisi'
                        : null,
                  ),

                  SizedBox(height: 20),

                  // Upload Foto
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Unggah Foto (Opsional)',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColor.descText)),
                      TextButton.icon(
                        onPressed: _pickImages,
                        icon: Icon(Icons.add_photo_alternate_outlined),
                        label: Text(
                          'Tambah Foto',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Preview Foto
                  // Preview Foto
                  if (_images.isNotEmpty || _existingImageUrls.isNotEmpty)
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          // Gambar dari server
                          ..._existingImageUrls.asMap().entries.map((entry) {
                            final index = entry.key;
                            final url = entry.value;

                            return Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      Constant.baseUrlImage + url,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () => QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.confirm,
                                      title: "Hapus Gambar?",
                                      confirmBtnText: "Hapus",
                                      showCancelBtn: false,
                                      onConfirmBtnTap: () =>
                                          _removeExistingImage(index),
                                    ),
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.red,
                                      child: Icon(Icons.close,
                                          size: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),

                          // Gambar dari lokal
                          ..._images.asMap().entries.map((entry) {
                            final index = entry.key;
                            final file = entry.value;
                            return Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(file.path),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () => _removeImage(index),
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.red,
                                      child: Icon(Icons.close,
                                          size: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    )
                  else
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.descText),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Belum ada foto yang diunggah',
                          style: TextStyle(color: AppColor.primary),
                        ),
                      ),
                    ),

                  SizedBox(height: 16),

                  // Checkbox
                  CheckboxListTile(
                    value: _sembunyikanNama,
                    onChanged: (val) =>
                        setState(() => _sembunyikanNama = val ?? false),
                    title: Text(
                      'Sembunyikan Nama Anda',
                      style: TextStyle(color: AppColor.descText, fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Kirim
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColor.primary,
                      disabledForegroundColor: Colors.red,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: AppColor.descText),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    child: Text(
                      widget.existingAspirasi != null
                          ? 'Update Aspirasi'
                          : 'Kirim Aspirasi',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
