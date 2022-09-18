import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/provider/offers/offers_provider.dart';
import 'package:coladaapp/provider/qr/qr_provider.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/utils/ui_helper.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/button_widget.dart';
import 'package:coladaapp/widgets/loading_dialog.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class QRCamera extends ConsumerStatefulWidget {
  const QRCamera({Key? key}) : super(key: key);

  @override
  _QRCameraState createState() => _QRCameraState();
}

class _QRCameraState extends ConsumerState<QRCamera> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        loadingDialog(context);

        controller.pauseCamera();
        _getValaidateQR(result!.code!).then((value) => {
              if (value != null)
                {
                  _getCheckInQR(value).then((value) {
                    Navigator.pop(context);
                    if (value != null && value.length != 0) {
                      context.router.replace(const QRStoreOffersPage());
                    } else {
                      UIHelper.showNotification("no data");
                      controller.resumeCamera();
                    }
                  })
                }
              else
                {
                  Navigator.pop(context),
                  controller.resumeCamera(),
                  // context.router.replace(const QRStoreOffersPage())
                }
            });

        debugPrint('result ${result!.code}');
      });
    });
  }

  Future _getValaidateQR(String data) async {
    final QRProv = ref.read(qrProvider);

    return await QRProv.getValidateQR(data);
  }

  Future _getCheckInQR(String storeId) async {
    final QRProv = ref.read(qrProvider);

    return await QRProv.getCheckInQR(storeId);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBarWidget(
          title: LocaleKeys.camera_title.tr(),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: Constants.padding,
                right: 0,
                left: 0,
                child: TextWidget(
                  LocaleKeys.scan_instructions.tr(),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: SizedBox(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.padding,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: QRView(
                        key: qrKey,
                        onQRViewCreated: (value) {
                          _onQRViewCreated(value, context);
                        },
                        overlay: QrScannerOverlayShape(
                          borderRadius: 8,
                          borderColor: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: Constants.padding,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.padding,
                  ),
                  child: ButtonWidget(
                    title: LocaleKeys.scan_user_confirmation.tr(),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
