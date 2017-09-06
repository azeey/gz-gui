/*
 * Copyright (C) 2017 Open Source Robotics Foundation
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

#ifndef IGNITION_GUI_ENUMS_HH_
#define IGNITION_GUI_ENUMS_HH_

#include "ignition/gui/qt.h"

namespace ignition
{
namespace gui
{
  /// \brief Data roles
  enum DataRole
  {
    /// \brief Text which is displayed for the user.
    DISPLAY_NAME = Qt::UserRole + 100,

    /// \brief URI including detailed query. This is the information carried
    /// during a drag-drop operation.
    URI_QUERY,

    /// \brief Data type name, such as "Double" or "Bool", or "model", "link".
    /// Used to specialize display according to type.
    TYPE,

    /// \brief Flag indicating whether an item should be expanded or not.
    TO_EXPAND
  };
}
}
#endif