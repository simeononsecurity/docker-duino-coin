# Dockerized Duino-Coin Miner

This repository contains a Dockerized version of the Duino-Coin Miner.

[![Docker Image CI](https://github.com/simeononsecurity/docker-duino-coin/actions/workflows/docker-image.yml/badge.svg)](https://github.com/simeononsecurity/docker-duino-coin/actions/workflows/docker-image.yml)

<a href="https://hub.docker.com/r/simeononsecurity/duinocoin" rel="me"><img src="https://img.shields.io/badge/Docker-Hub-blue" alt="Docker Hub Image simeononsecurity/duinocoin"></a>

## Docker Container

### Build or Pull the Docker Image

#### Build

```bash
git clone https://github.com/simeononsecurity/docker-duino-coin.git
cd duino-coin
docker build -t duinocoin .
```

#### Pull
```
docker pull simeononsecurity/duinocoin
```

### Run the Docker Container

```bash
docker run -td --name duco-container --restart unless-stopped \
  -e DUCO_USERNAME="your_actual_username_or_walletname" \
  -e DUCO_MINING_KEY="your_actual_mining_key" \
  duinocoin
```

#### Example with Configurable Options

```bash
# Build the Docker Image
docker build -t duinocoin .

# Run the Docker Container with Custom Configuration
docker run -td --name duco-container --restart unless-stopped \
  -e DUCO_USERNAME="your_actual_username_or_walletname" \
  -e DUCO_MINING_KEY="your_actual_mining_key" \
  -e DUCO_INTENSITY=50 \
  -e DUCO_THREADS=2 \
  -e DUCO_START_DIFF="MEDIUM" \
  -e DUCO_DONATE=1 \
  -e DUCO_IDENTIFIER="Auto" \
  -e DUCO_ALGORITHM="DUCO-S1" \
  -e DUCO_LANGUAGE="english" \
  -e DUCO_SOC_TIMEOUT=20 \
  -e DUCO_REPORT_SEC=300 \
  -e DUCO_RASPI_LEDS="n" \
  -e DUCO_RASPI_CPU_IOT="n" \
  -e DUCO_DISCORD_RP="n" \
  duinocoin
```

Feel free to adjust the environment variables as needed for your mining preferences. The example includes some commonly used options, and you can refer to the [Duino-Coin README](https://github.com/revoxhere/duino-coin) for more details on available configurations.

If you have any questions or need further assistance, don't hesitate to reach out!
