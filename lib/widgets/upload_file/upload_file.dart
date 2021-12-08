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
/// @Description: 无

class UploadFile extends StatefulWidget {
  final getUrl;
  const UploadFile({Key? key, Function(String url)? this.getUrl})
      : super(key: key);
  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  String licenseUrl = '';
  File? file; // 预览地址
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
    return Container(
      child: Row(
        children: [
          // 上传的文件列表
          buildPreviewImg(file),
          // 上传组件
          GestureDetector(
            onTap: showPickerBtn,
            child: Image.asset(
              'assets/images/card/add.png',
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }

  // 上传的文件预览
  Widget buildPreviewImg(File? file) {
    return file == null
        ? Container()
        : Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(color: Colors.black12),
            child: GestureDetector(
              onTap: previewImg,
              onLongPress: longPressdeleteImg,
              child: Image.file(
                file,
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          );
  }

  // 底部弹出拍照/从相册中选择
  void showPickerBtn() {
    List<String> listOp = ['拍照', '从相册中选择'];
    BottomSheetUtils.show(
        context: context, list: listOp, action: chooseImgFrom);
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
        file = File(imageInfo!.path);
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
  void previewImg() {
    List<GalleryViewItem> galleryItems = <GalleryViewItem>[
      GalleryViewItem(
        id: 'item1',
        resource: file,
        resoureType: 'file',
      ),
    ];
    NavigatorUtils.pushPageByFade(
      context: context,
      targPage: PhotoView(galleryItems: galleryItems),
    );
  }

  // 长按删除
  void longPressdeleteImg() {
    List<String> list = ['删除'];
    BottomSheetUtils.show(
      context: context,
      list: list,
      action: (int index) {
        setState(() {
          file = null;
        });
      },
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
