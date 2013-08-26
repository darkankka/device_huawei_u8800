#!/bin/bash

#
# Copyright (C) 2012 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

VENDOR=huawei
DEVICE=u8800

OUTDIR=vendor/$VENDOR/$DEVICE
PULLDIR=$OUTDIR/proprietary/pulled
EXTERNALDIR=$OUTDIR/proprietary/external

MAKEFILE=../../../$OUTDIR/$DEVICE-vendor-blobs.mk
echo -e "\e[00;35mWriting "$(basename $MAKEFILE) "\e[00m"
(cat << EOF) > $MAKEFILE
#
# Copyright (C) 2012 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

EOF

firstline=true
# First check for libraries that need to be linked.
while read file
do
	# Skip the line if it is a comment or empty line.
	if [[ ${file:0:1} == "#" ]] || [[ ${file:0:1} != "-" ]] || [[ $file == "" ]]; then
		continue
	fi

	# If it's the first match, add the definition.
	if [[ $firstline == true ]]; then
		echo "# Prebuilt libraries that are needed to build open-source libraries" >> $MAKEFILE
		echo "PRODUCT_COPY_FILES += \\" >> $MAKEFILE
		firstline=false
	fi

	# Remove the "-".
	file=${file:1}

	# We have to put the correct line ending, depending on if we had a file
	# previously.
	if [[ $wasfile == true ]]; then
		echo " \\" >> $MAKEFILE
	fi
	echo -en "\t$PULLDIR/$file:obj/lib/$(basename $file)" >> $MAKEFILE
	wasfile=true
done < proprietary-files.txt

if [[ $firstline == false ]]; then
	echo "" >> $MAKEFILE
	echo "" >> $MAKEFILE
fi

# Clear the variables before using them again.
unset file
unset wasfile
firstline=true

# Secondly add standard libraries.
while read file
do
	# Skip the line if it is a comment or empty line.
	if [[ ${file:0:1} == "#" ]] || [[ $file == "" ]]; then
		continue
	# If we have "-" in front of the file, remove it.
	elif [[ ${file:0:1} == "-" ]]; then
		file=${file:1}
	fi

	# If it's the first match, add the definition.
	if [[ $firstline == true ]]; then
		echo "PRODUCT_COPY_FILES += \\" >> $MAKEFILE
		firstline=false
	fi

	# We have to put the correct line ending, depending on if we had a file
	# previously.
	if [[ $wasfile == true ]]; then
		echo " \\" >> $MAKEFILE
	fi
	echo -en "\t$PULLDIR/$file:system/$file" >> $MAKEFILE
	wasfile=true
done < proprietary-files.txt

# Write newline at end of file.
echo "" >> $MAKEFILE

# Clear the variables before using them again.
unset file
unset wasfile

MAKEFILE=../../../$OUTDIR/$DEVICE-external-blobs.mk
echo -e "\e[00;35mWriting "$(basename $MAKEFILE) "\e[00m"
(cat << EOF) > $MAKEFILE
#
# Copyright (C) 2012 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

EOF

firstline=true

# First check for libraries that need to be linked.
while read file
do
	# Skip the line if it is a comment or empty line.
	if [[ ${file:0:1} == "#" ]] || [[ ${file:0:1} != "-" ]] || [[ $file == "" ]]; then
		continue
	fi

	# If it's the first match, add the definition.
	if [[ $firstline == true ]]; then
		echo "# Prebuilt libraries that are needed to build open-source libraries" >> $MAKEFILE
		echo "PRODUCT_COPY_FILES += \\" >> $MAKEFILE
		firstline=false
	fi

	# Remove the "-".
	file=${file:1}

	# We have to put the correct line ending, depending on if we had a file
	# previously.
	if [[ $wasfile == true ]]; then
		echo " \\" >> $MAKEFILE
	fi
	echo -en "\t$EXTERNALDIR/$file:obj/lib/$(basename $file)" >> $MAKEFILE
	wasfile=true
done < external-files.txt

if [[ $firstline == false ]]; then
	echo "" >> $MAKEFILE
	echo "" >> $MAKEFILE
fi

# Clear the variables before using them again.
unset file
unset wasfile
firstline=true

# Secondly add standard libraries.
while read file
do
	# Skip the line if it is a comment or empty line.
	if [[ ${file:0:1} == "#" ]] || [[ $file == "" ]]; then
		continue
	# If we have "-" in front of the file, remove it.
	elif [[ ${file:0:1} == "-" ]]; then
		file=${file:1}
	fi

	# If it's the first match, add the definition.
	if [[ $firstline == true ]]; then
		echo "PRODUCT_COPY_FILES += \\" >> $MAKEFILE
		firstline=false
	fi

	# We have to put the correct line ending, depending on if we had a file
	# previously.
	if [[ $wasfile == true ]]; then
		echo " \\" >> $MAKEFILE
	fi
	echo -en "\t$EXTERNALDIR/$file:system/$file" >> $MAKEFILE
	wasfile=true
done < external-files.txt

# Write newline at end of file.
echo "" >> $MAKEFILE


MAKEFILE=../../../$OUTDIR/$DEVICE-vendor.mk
echo -e "\e[00;35mWriting "$(basename $MAKEFILE) "\e[00m"
(cat << EOF) > $MAKEFILE
#
# Copyright (C) 2012 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

# Pick up overlay for features that depend on non-open-source files
DEVICE_PACKAGE_OVERLAYS += $OUTDIR/overlay

\$(call inherit-product, $OUTDIR/$DEVICE-vendor-blobs.mk)
\$(call inherit-product-if-exists, $OUTDIR/$DEVICE-external-blobs.mk)
EOF


MAKEFILE=../../../$OUTDIR/BoardConfigVendor.mk
echo -e "\e[00;35mWriting "$(basename $MAKEFILE) "\e[00m"
(cat << EOF) > $MAKEFILE
#
# Copyright (C) 2012 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh
EOF