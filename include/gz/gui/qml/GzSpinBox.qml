/*
 * Copyright (C) 2018 Open Source Robotics Foundation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
*/
import QtQuick 2.9
import QtQuick.Controls 2.15

Item {
  id: root
  signal editingFinished
  property real minimumValue: 0
  property real maximumValue: 100
  property real value: 0.0
  property real stepSize: 1.0
  property int decimals: 0

  property bool __enableUpdateFromSpinbox: true
  onValueChanged: {
    root.__enableUpdateFromSpinbox = false
    spinBox.value = decimalToInt(root.value)
    root.__enableUpdateFromSpinbox = true
  }
  //implicitWidth: spinBox.implicitWidth
  implicitHeight: spinBox.implicitHeight

  readonly property int kMaxInt: Math.pow(2, 31) - 1

  function decimalToInt(decimal) {
    var result = decimal * spinBox.decimalFactor
    if (result >= kMaxInt) {
      return kMaxInt
    }
    return result
  }

  function intToDecimal(intVal) {
    return intVal / spinBox.decimalFactor
  }

  SpinBox {
      id: spinBox

      anchors.fill : parent
      bottomPadding: 0
      topPadding: 0
      implicitHeight: 40
      clip: true

      value: 0

      onValueChanged: {
        if (root.__enableUpdateFromSpinbox) {
          qmlHelper.setItemValue(root, intToDecimal(value));
          root.editingFinished()
        }
      }

      from: decimalToInt(minimumValue)
      to: decimalToInt(root.maximumValue)

      stepSize: decimalToInt(root.stepSize)
      editable: true
      anchors.centerIn: parent

      readonly property real decimalFactor: Math.pow(10, root.decimals)

      contentItem: TextInput {
        font.pointSize: 10
        text: spinBox.textFromValue(spinBox.value, spinBox.locale)
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        readOnly: !spinBox.editable
        validator: spinBox.validator
        inputMethodHints: Qt.ImhFormattedNumbersOnly
        selectByMouse: true
      }

      validator: DoubleValidator {
          bottom: Math.min(spinBox.from, spinBox.to)
          top:  Math.max(spinBox.from, spinBox.to)
          decimals: root.decimals
          notation: DoubleValidator.StandardNotation
      }

      textFromValue: function(value, locale) {
          return intToDecimal(value).toLocaleString(locale, 'f', parent.decimals)
      }

      valueFromText: function(text, locale) {
          return Math.round(decimalToInt(Number.fromLocaleString(locale, text)))
      }

      background: Rectangle {
        implicitWidth: 70
        implicitHeight: parent.implicitHeight
        border.color: "gray"
      }
  }
}

