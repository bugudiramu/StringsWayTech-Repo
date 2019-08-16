import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CloudUploader extends StatefulWidget {
  final File file;
  CloudUploader({this.file});
  @override
  _CloudUploaderState createState() => _CloudUploaderState();
}

class _CloudUploaderState extends State<CloudUploader> {
  final FirebaseStorage _storage = FirebaseStorage(
      storageBucket: 'gs://stringswaytech-image-editor.appspot.com');
  StorageUploadTask _uploadTask;

  // Start the upload event
  void _startUpload() {
    /// file name which is should be unique which is done by current time stamp.
    String filePath = 'images/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              children: [
                if (_uploadTask.isComplete)
                  Container(
                      child: Text(
                        'Completed'.toUpperCase(),
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      padding: const EdgeInsets.all(8.0)),

                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),

                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),

                // Showing Progress bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: LinearProgressIndicator(
                    value: progressPercent,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.tealAccent),
                    semanticsLabel: "uploading!",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '${(progressPercent * 100).toStringAsFixed(2)} % ',
                      style: Theme.of(context).textTheme.subhead),
                ),
              ],
            );
          });
    } else {
      // Button which helps user to upload image to cloud.
      return FloatingActionButton.extended(
        label: Text('Upload to Firebase'),
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );
    }
  }
}
