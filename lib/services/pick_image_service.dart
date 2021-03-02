import 'package:file_picker/file_picker.dart';

class PickImageService {
  
  Future<String> pickImagePath() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null){
      return result.files.single.path;
    }

    return null;
  }

}