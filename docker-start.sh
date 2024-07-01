#!/bin/bash

# Set the base path
base_path="/app/duino-coin"

python_script="${base_path}/PC_Miner.py"

chmod +x "${base_path}/PC_Miner.py" 

# Find the line containing "VER = x.x" in the Python script and extract the version number
ver_value=$(grep -oP 'VER = \K\d+\.\d+' "$python_script")

# Set the environment variable
export VER="$ver_value"

# Display the extracted value (optional)
echo "Extracted PC Miner VER value: $VER"

## Create Expected Path
mkdir "${base_path}/Duino-Coin PC Miner ${ver_value}"

# Find the highest version number in the folder
highest_version=$(ls -d "${base_path}/Duino-Coin PC Miner"* | grep -Eo 'Duino-Coin PC Miner [0-9.]+' | sort -Vr | head -n 1)

# Construct the full path with the highest version number
full_path="${base_path}/${highest_version}"

#Create Expected Config File
touch "${full_path}/Miner_config.cfg"

# Detect ARM architecture
if [ "$(uname -m)" = "armv6l" ] || [ "$(uname -m)" = "armv7l" ] || [ "$(uname -m)" = "aarch64" ]; then
  DUCO_RASPI_CPU_IOT="y"
else
  DUCO_RASPI_CPU_IOT="n"
fi

# Export for Dockerfile to pick up
export DUCO_RASPI_CPU_IOT

echo '[PC Miner]' > "${full_path}/Miner_config.cfg"
echo "username = ${DUCO_USERNAME}" >> "${full_path}/Miner_config.cfg"
echo "mining_key = $(echo -n ${DUCO_MINING_KEY} | base64)" >> "${full_path}/Miner_config.cfg"
echo "intensity = ${DUCO_INTENSITY}" >> "${full_path}/Miner_config.cfg"
echo "threads = ${DUCO_THREADS}" >> "${full_path}/Miner_config.cfg"
echo "start_diff = ${DUCO_START_DIFF}" >> "${full_path}/Miner_config.cfg"
echo "donate = ${DUCO_DONATE}" >> "${full_path}/Miner_config.cfg"
echo "identifier = ${DUCO_IDENTIFIER}" >> "${full_path}/Miner_config.cfg"
echo "algorithm = ${DUCO_ALGORITHM}" >> "${full_path}/Miner_config.cfg"
echo "language = ${DUCO_LANGUAGE}" >> "${full_path}/Miner_config.cfg"
echo "soc_timeout = ${DUCO_SOC_TIMEOUT}" >> "${full_path}/Miner_config.cfg"
echo "report_sec = ${DUCO_REPORT_SEC}" >> "${full_path}/Miner_config.cfg"
echo "raspi_leds = ${DUCO_RASPI_LEDS}" >> "${full_path}/Miner_config.cfg"
echo "raspi_cpu_iot = ${DUCO_RASPI_CPU_IOT}" >> "${full_path}/Miner_config.cfg"
echo "discord_rp = ${DUCO_DISCORD_RP}" >> "${full_path}/Miner_config.cfg"

cp "${full_path}/Miner_config.cfg" "${full_path}/Settings.cfg"
cp "${full_path}/Miner_config.cfg" "${base_path}/Settings.cfg"

#Needed to start script
wget -O "${full_path}/Translations.json" https://raw.githubusercontent.com/revoxhere/duino-coin/master/Resources/PC_Miner_langs.json
wget -O "${full_path}/Donate.exe" https://server.duinocoin.com/donations/DonateExecutableWindows.exe

python3 "${base_path}/PC_Miner.py"
