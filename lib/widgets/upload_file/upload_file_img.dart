import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/common/global.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/http_helper.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/utils/bottomsheet_utils.dart';
import 'package:flutter_car_live/utils/log_utils.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:flutter_car_live/widgets/photo_view/photo_view.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:image_picker/image_picker.dart';

/// @Author: Tiancong
/// @Date: 2021-12-08 10:32:55
/// @Description: 需求
/// 1. 加载网络图片
/// 2. 点击图片预览
/// 3. 长按图片编辑(重新上传)

class UploadFileImg extends StatefulWidget {
  final getUrl;
  final initialNetUrl; // 要加载的网络图片地址
  final width;
  final height;
  final displayOnly; // 是否只是展示用
  const UploadFileImg({
    Key? key,
    required String this.initialNetUrl,
    Function(String url)? this.getUrl,
    bool? this.displayOnly = false,
    double? this.width = 100,
    double? this.height = 100,
  }) : super(key: key);
  @override
  _UploadFileImgState createState() => _UploadFileImgState();
}

class _UploadFileImgState extends State<UploadFileImg> {
  String licenseUrl = '';
  File? tempFile; // 临时预览地址
  // 不加broadcast()是单订阅流,智能有一个听众,否则会报Stream has already been listened to
  StreamController<String> _streamController =
      StreamController<String>.broadcast(); //多订阅流
  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 单击预览
        tempFile == null
            ? previewImg(
                id: widget.initialNetUrl,
                resource: widget.initialNetUrl,
                resoureType: 'network',
              )
            : previewImg(
                id: tempFile?.path ??
                    'id${DateTime.now().millisecondsSinceEpoch}',
                resource: tempFile,
                resoureType: 'file',
              );
      },
      onLongPress: () {
        if (widget.displayOnly) return;
        // 长按底部弹出拍照/从相册选择选择项
        showPickerBtn();
      },
      child: Container(
        color: Colors.black12,
        child: tempFile == null
            ? Image.network(
                widget.initialNetUrl,
                width: widget.width,
                height: widget.height,
                fit: BoxFit.contain,
              )
            : Image.file(
                tempFile!,
                width: widget.width,
                height: widget.height,
                fit: BoxFit.contain,
              ),
      ),
    );
  }

  // 底部弹出拍照/从相册中选择
  void showPickerBtn() {
    List<String> listOp = ['拍照', '从相册中选择'];
    BottomSheetUtils.show(
      context: context,
      list: listOp,
      action: chooseImgFrom,
    );
  }

  // 选择照片
  void chooseImgFrom(int index) async {
    ImagePicker _picker = ImagePicker();
    XFile? imageInfo;
    // 打开摄像头
    if (index == 0) {
      LogUtils.e('打开摄像头');
      imageInfo = await _picker.pickImage(source: ImageSource.camera);
    }
    // 从本地取
    if (index == 1) {
      LogUtils.e('打开相册');
      imageInfo = await _picker.pickImage(source: ImageSource.gallery);
    }

    if (imageInfo != null) {
      setState(() {
        tempFile = File(imageInfo!.path);
      });
      MultipartFile _file = await MultipartFile.fromFile(
        imageInfo.path,
        filename: imageInfo.name,
      );

      // 注意 showDialog是个无状态组件, 所以调用setstate不会更新;showDialog相当于打开一个新路由
      // 参考链接https://blog.csdn.net/yumi0629/article/details/81939936
      showDialog(
        context: context,
        builder: (context) => FutureProgressDialog(
          uploadFile(
            file: _file,
            getUrl: (String url) {
              if (widget.getUrl != null) {
                widget.getUrl(url);
              }
            },
          ),
          message: StreamBuilder<String>(
            initialData: '',
            stream: _streamController.stream,
            builder: (context, snapshot) => Text(' 正在上传... ${snapshot.data}%'),
          ),
        ),
      );
    }
    return;
  }

  // 预览图片
  void previewImg({
    required String id,
    required dynamic resource,
    required String resoureType,
  }) {
    List<GalleryViewItem> galleryItems = <GalleryViewItem>[
      GalleryViewItem(
        id: id,
        resource: resource,
        resoureType: resoureType,
      ),
    ];
    NavigatorUtils.pushPageByFade(
      context: context,
      targPage: PhotoView(galleryItems: galleryItems),
    );
  }

  ///文件上传步骤
  ///1.现获取上传token
  ///2.获取文件对象并调用上传到服务器
  Future<String> uploadFile({
    MultipartFile? file,
    Function(String url)? getUrl,
  }) async {
    String uploadToken = '';
    ResponseInfo upTokenInfo = await Fetch.post(
      url: HttpHelper.getUploadToken,
      withLoading: false,
    );
    if (upTokenInfo.success) {
      uploadToken = upTokenInfo.data;
    }
    if (uploadToken.length == 0) {
      ToastUtils.showToast('获取上传令牌失败');
      return '';
    }
    if (file == null) {
      ToastUtils.showToast('获取文件信息失败');
      return '';
    }
    FormData formData = FormData.fromMap({
      "uploadToken": uploadToken,
      "file": file,
      "uid": Global.profile.user?.uid,
    });
    ResponseInfo responseInfo = await Fetch.upload(
        url: HttpHelper.uploadFile,
        data: formData,
        withLoading: false,
        uploadProgress: (int count, int total) {
          String progress = ((count / total) * 100).toStringAsFixed(0);
          _streamController.add(progress);
        });
    if (responseInfo.success) {
      if (getUrl != null) {
        getUrl(responseInfo.data);
      }
      return responseInfo.data;
    }
    ToastUtils.showToast('文件上传失败');
    return '';
  }
}
