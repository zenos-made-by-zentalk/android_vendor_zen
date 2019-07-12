for device in $(curl -s https://raw.githubusercontent.com/zenos-made-by-zentalk/android_vendor_zen/pie/zen.devices)
do
for var in eng user userdebug; do
add_lunch_combo zen_$device-$var
done
done
