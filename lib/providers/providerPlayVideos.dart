import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../features/watchVideo/video_repo/repository.dart';
import '../features/watchVideo/youtube_model/youtube_Model.dart';

class ProviderPlayVideos with ChangeNotifier {

  static final ProviderPlayVideos provider = ProviderPlayVideos._internal();

  factory ProviderPlayVideos() {
    return provider;
  }
  ProviderPlayVideos._internal();

  String videoName = "";
  void updateVideoChannelName({required String newVideoName}){
    videoName= newVideoName;
    notifyListeners();
  }
  VideoRepository repository = VideoRepository();
  String subject = "";

  String set_get_subject(String new_subject){
    print("subject: $subject")  ;
    subject = new_subject;
    notifyListeners();
    return subject;
  }

  List<String> get_Ids_by_subject(){

    List<String> InterviewIDs = [
      'Tb3FdYqsTTo',
      'ji9erMiA',
      'tKxaYsmwYmE',
      'R1vYYRqVd9o',
      'D_6nDyQ_mYo',
      'HnPU1U440_4',
      '_Ajv2yrTpW8',
      'cdmaK_Z02ao',
      '7ygzH0uz9uY',
      'DORsYvMfE_8',
      'hs5bComL2tY',
      'fCfU5ZDO7Yg',
      'FhDe3SCGMTo',
      '3nOAVEtLeYE',
    ];

    List<String>  ApplicationIDs = [
      '6V626OoAJMo',
      'DiZPWQ9TY1s',
      'cw2xSxntjKU',
      'pWybGax6aps',
      'crAoKReMPlg',
      'iMPtvKHYjxs',
      'qrAEx6ivLCE',
      'QUYuMlg4xv4',
      'KUo3urihnUA',
      'JVrxaESKn34',
      'nFIy3AC4vVo',
      'QsTa3CdZOPk',
      'pd3tFDGsJD0',
      'jz4Mt9NoiBg',
      'KJwUt5qFswI',
      'ffuFfkaKhdk'
    ];

    List<String>  MathIDs = [
      'HVw04UB-Esk',
      'otcfNeYTmKs',
      'dehX_otpep4',
      'n9IwVkySelw',
      'DSd6pZjM-lQ',
      'C0lXiabodcE',
      '_J0l_RDEtY8',
      'kMut2dqfRFY',
      '8qwWuzEFaVI',
      'xOUMi9yNeUI',
      'e7YB9_MuHQE',
      'sVBYm3yXU0Q',
      'UeWUYPJ-6JM',
      'PxnsnDtlbd0',
      'PAtjvDDaZv0',
      '1bLRlP6ZcBw',
      'aXd7cDVc0v8',
      't882BOyPgbA',
      '-fhHt8NjeII',
      'icIuynGbJAo',
      'VYbarlk-8OM',
    ];

    List<String>  EnglishIDs = [
      'TvGywIxGOpU',
      'vzu5B0A05-E',
      'YPCwt0Dw0dg',
      'HBs7K-DIDlg',
      '93337_hYc48',
      'AURVgclY_U4',
      'KnaGtZDa7ws',
      'YHZcpFXsmlc',
      'SuPaLOWlS_k',
      '3AATSmZjHjI',
      'teugzqMPS3s',
      'O10qLr2Anno',
      'ybxAObim3_M',
      '9tJI4bX2bIQ',
      '2mEwgOQUxxM',
      'YfLk1PuHvdk',
      'Yw1G0LGJ29M',
    ];

    List<String>  EssaysIDs = [
      'EXsSHwws7Xo',
      'K6p8VK3XqjE',
      'mvF895bCp7g',
      'bd1Wcej_b1M',
      'fPM4mjlpEA4',
      'NVMUKpnWWY4',
      '5CKzIqxb4Wk',
      'ePXLREiwOLs',
      'A0eUKxhUnDc',
      'eKdYoKPOS-Q',
      'h9s3-SAeGRw',
      'V4wfrNDTs5w',
      '6O2ZXvG802Y',
      'kTVFXcqH4us',
      'ZLGAcaJ29ks',
      'E-c-8wcxOFs',
      '-hnt551Imas',
      'b633VjoqRSE',
      '1WQQ7NhNtIY',
    ];

    List<String>  TOEFLIDs = [
      'KavRQ7U_yfM',
      'gF4n7XkbVWU',
      'Sw_tCCB203k',
      'j5BeeX9_m0o',
      '-4ggXxt_dPM',
      'kid3RXyRHXY',
      'bAXSvwpZ6lg',
      '2txpcHIpFAg',
      '98kZYWdOLBQ',
      'EGy4WTXsGaY',
      'rJDxIJnjfFw',
      '-dM84P7ICm4',
      'pY95qf2dBAA',
      'WdGIuE_FSps',
      'BNnPzvnlYqU',
      'hj6D0nTddsc',
    ];

    List<String>  DETIDs = [
      'ahXWclK2GT0',
      'WpmPp3JxOpg',
      'Cn6yJkS1jFg',
      '5sZR2PAChwk',
      'GkWjzoveOis',
      '9Ug_Pwk3fYg',
      'BbV6MQNaDHg',
      'khfyDi8dQtw',
      'xfTurQtwH9o',
      'wkw_r6svdbA',
      'KJo7yRMDTc8',
      'fqRgqdWmMHA',
      'QAkoOD1EgCM',
      'wMIHzErRftU',
      'kEz_CHlOM2A',
      'f_fXrv97klA',
      'ApjB55eJ8HU',
      'wIsTPSvHI5g',
      'ODXSNGg7R5o',
      'uv7gpqQKHFg',
      'Ht3odX1bdOk',
      'v2DAkvaJJnM',
      'OieS67MKR4k',
    ];
    List<String>  UniversitiesIDs = [
      'bgY6V1zffJY',
      'rxogxlSeDU8',
    ];

    if(subject == 'Application'){
      print('Application');
      return ApplicationIDs;
      //Application Math English Essays TOEFL DET Interview Universities
    }
    if(subject == 'Math'){
      print("math");
      return MathIDs;
    }
    if(subject == 'English'){
      print("English");
      return EnglishIDs;
    }
    if(subject == 'Essays'){
      return EssaysIDs;
    }
    if(subject == 'TOEFL'){
      return TOEFLIDs;
    }
    if(subject == 'DET'){
      return DETIDs;
    }
    if(subject == 'Interview'){
      return InterviewIDs;
    }
    else{
      return UniversitiesIDs;
    }

  }

 Future<List<YoutubeModel>> getAllVideos() async {
   List<YoutubeModel> list_models = [];
   List <String> list_video_ids = get_Ids_by_subject();

    for(int i = 0; i<list_video_ids.length; i++){
      var result = await VideoRepository.getVideoInfo(list_video_ids[i]);

      if (result.statusCode == 200) {
        YoutubeModel video_info = YoutubeModel.fromJson(jsonDecode(result.body));
        video_info.video_id = list_video_ids[i];
        list_models.add(video_info);
      }
    }
    return list_models;
  }

  YoutubeModel video_playing = YoutubeModel(title: '', authorName: '', video_id: '', authorURL: '', type: '', height: 100, width: 100, version: '', providerName: '', providerURL: '', thumbnailHeight: 100, thumbnailWidth: 100, thumbnailURL: '', html: '', );

  Future<YoutubeModel> set_video_playing() async {
    List<YoutubeModel> list_videos= await getAllVideos();
    video_playing = list_videos[0];
    return video_playing;
 }

Future<YoutubeModel>? update_video_playing(String video_id) async {
  List<YoutubeModel> list_videos= await getAllVideos();
  for(int i = 0; i<list_videos.length; i++){
    if(list_videos[i].video_id == video_id){
      video_playing = list_videos[i];
    }
  }
  return video_playing;
}

}