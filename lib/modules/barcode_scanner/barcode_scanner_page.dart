import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:payflow/shared/widgets/bottom_sheet/bottom_sheet_widget.dart';
import '../../shared/themes/app_text_styles.dart';
import '../../shared/widgets/set_label_buttons/set_label_buttons.dart';
import 'barcode_scanner_controller.dart';


class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = BarcodeScannerController();

  @override
  void initState() {
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode) {
        Navigator.pushReplacementNamed(context, "/insert_boleto",
            arguments: controller.status.barcode);
      }
    }
    );

    @override
    Widget build(BuildContext context) {
      // return BottomSheetWidget(
      //   title: "Não foi possível identificar um código de barras.",
      //   subTitle: "Tente escanear novamente ou digite o código do seu boleto.",
      //   primaryLabel: "Escanear novamente",
      //   primaryOnPressed: () {},
      //   secondaryLabel: "Digitar código",
      //   secondaryOnPressed: () {},
      // );
      return SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Stack(
          children: [
            ValueListenableBuilder<BarcodeScannerStatus>(
                valueListenable: controller.valueListenable,
                builder: (_, status, __) {
                  if (status.showCamera) {
                    return Container(
                      child: status.cameraController!.buildPreview(),
                    );
                  } else {
                    return Container();
                  }
                }
            ),
            RotatedBox(
              quarterTurns: 1,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text(
                    "Escaneie o código de barras do boleto",
                    style: TextStyles.buttonBackground,
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back),
                    iconSize: 20.0,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/home");
                    },
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: SetLabelButtons(
                  primaryLabel: "Inserir código do boleto",
                  primaryOnPressed: () {},
                  secondaryLabel: "Adicionar da galeria",
                  secondaryOnPressed: () {},
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
