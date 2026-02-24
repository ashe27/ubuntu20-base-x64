FROM ubuntu:20.04

# 防止构建时弹出地理位置选择框导致卡死
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
	dbus-x11 \
    ninja-build \
	gcovr \
	# Qt 5.7 编译和运行所需的依赖
	"^libxcb.*" libx11-dev libx11-xcb-dev libxext-dev libxi-dev libxfixes-dev libglu1-mesa-dev libfreetype6-dev libxrender-dev libfontconfig1-dev libxkbcommon-dev libxkbcommon-x11-dev libdbus-1-dev libasound2-dev libpulse-dev libudev-dev libwayland-dev libatspi2.0-dev libgl1-mesa-dev libegl1-mesa-dev libgles2-mesa-dev zlib1g-dev libssl-dev libpng-dev libjpeg-dev libgbm-dev libdrm-dev libmtdev-dev unixodbc-dev libinput-dev libicu-dev libproxy-dev libdouble-conversion-dev libharfbuzz-dev freetds-dev libcups2-dev libpq-dev \
    && rm -rf /var/lib/apt/lists/*
