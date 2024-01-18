import 'package:image_picker/image_picker.dart';

PickImage(ImageSource source) async {
  final ImagePicker _ImagePicker = ImagePicker();

  XFile? _file = await _ImagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  } else {
    print("No image selected");
  }
}
