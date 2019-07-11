for device in $(python vendor/zen/tools/get_official_devices.py)
do
for var in user userdebug; do
add_lunch_combo zen_$device-$var
done
done
