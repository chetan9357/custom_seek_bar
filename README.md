# Custom Seek Bar

A highly customizable Flutter seek bar with emoji, icon, gradient, vertical,
tick marks, and range support.

---

## ✨ Features
- Gradient & rounded seek bar
- Horizontal & vertical orientation
- Tick marks with custom colors
- Emoji & icon thumb
- Value bubble
- Range (min–max) seek bar
- Read-only mode
- RTL support

---
## 📦 Installation
### Add this to your pubspec.yaml:
```yaml
dependencies:
  custom_seek_bar:
    path: url:'../custom_seek_bar\custom_seek_bar'
```
### Using GitHub (recommended during development)
```yaml
dependencies:
  custom_seek_bar:
    git: url: https://github.com/YOUR_USERNAME/custom_seek_bar.git
```
### 📥 Import
```
import 'package:custom_seek_bar/custom_seek_bar.dart'
```
---
## 🎥 Demo

https://github.com/user-attachments/assets/b07bf5b5-a3b5-40f8-97ef-2dd6cfdde330

---

## 🚀 Usage
```dart
AdvancedSeekBar(
  value: 50,
  divisions: 5,
  bubbleEmojis: ['😠', '😐', '😊'],
  emojiThumb: true,
  onChanged: (v) {},
)
```
---
## 🗂 Project Structure
```
lib/
 ├─ custom_seek_bar.dart
 └─ widgets/
     ├─ advanced_seekbar.dart
     ├─ range_seekbar.dart
     ├─ rounded_seekbar.dart
     ├─ gradient_slider_track_shape.dart
     ├─ tick_marks_track_shape.dart
     └─ icon_slider_thumb_shape.dart
```
---
## 📄 License
```
MIT License

Copyright (c) 2025 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
