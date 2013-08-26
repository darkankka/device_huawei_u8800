/*
 * Copyright (C) 2012 The Android Open-Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef ANDROID_PROXIMITY_SENSOR_H
#define ANDROID_PROXIMITY_SENSOR_H

#include <stdint.h>
#include <errno.h>
#include <sys/cdefs.h>
#include <sys/types.h>
#include <linux/input/aps-12d.h>

#include "nusensors.h"
#include "SensorBase.h"
#include "InputEventReader.h"
#include "APSSensor.h"


struct input_event;

class ProximitySensor : public SensorBase {
private:
    InputEventCircularReader mInputReader;
    bool mEnabled;
    bool mHasPendingEvent;
    sensors_event_t mPendingEvent;

    float getProxValue(uint16_t adc_count);
    float getCorrectADC(uint16_t adc_count);
    struct aps_12d_settings settings;
public:
            ProximitySensor();
    virtual ~ProximitySensor();
    virtual int enable(int32_t handle, int enabled);
    virtual int setDelay(int32_t handle, int64_t ns);
    virtual bool hasPendingEvents() const;
    virtual int readEvents(sensors_event_t* data, int count);
};

/*****************************************************************************/

#endif  // ANDROID_PROXIMITY_SENSOR_H
