FROM ubuntu:20.04

# 防止构建时弹出地理位置选择框导致卡死
ENV DEBIAN_FRONTEND=noninteractive

# 默认设为 0（代表不使用国内源，供 GitHub 使用）
ARG USE_CHINA_MIRROR=0

# 根据传入的参数决定是否替换源
RUN echo "当前 USE_CHINA_MIRROR 的值为: ${USE_CHINA_MIRROR}" && \
    if [ "${USE_CHINA_MIRROR}" = "1" ]; then \
        echo "deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list && \
        echo "deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
        echo "deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
        echo "deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list && \
        mkdir -p /root/.pip && \
        echo "[global]" > /root/.pip/pip.conf && \
        echo "index-url = https://mirrors.aliyun.com/pypi/simple/" >> /root/.pip/pip.conf; \
    fi

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
	dbus-x11 \
    ninja-build \
	python3-pip \
    python3-setuptools \
	# Qt 5.7 编译和运行所需的依赖
	"^libxcb.*" libx11-dev libx11-xcb-dev libxext-dev libxi-dev libxfixes-dev libglu1-mesa-dev libfreetype6-dev libxrender-dev libfontconfig1-dev libxkbcommon-dev libxkbcommon-x11-dev libdbus-1-dev libasound2-dev libpulse-dev libudev-dev libwayland-dev libatspi2.0-dev libgl1-mesa-dev libegl1-mesa-dev libgles2-mesa-dev zlib1g-dev libssl-dev libpng-dev libjpeg-dev libgbm-dev libdrm-dev libmtdev-dev unixodbc-dev libinput-dev libicu-dev libproxy-dev libdouble-conversion-dev libharfbuzz-dev freetds-dev libcups2-dev libpq-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir gcovr
