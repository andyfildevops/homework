#!/bin/bash

# Масив основних пакетів
base_packages=(apache2 mariadb-server ufw docker.io)

# Визначення дистрибутива
get_distro() {
    . /etc/os-release
    echo "$ID"
}

# Функція встановлення пакетів
install_packages() {
    local cmd="$1"
    shift
    $cmd update -y
    $cmd install -y "$@"
}

# Вмикання та запуск служб
enable_services() {
    local distro="$1"
    local services=()

    case "$distro" in
        ubuntu|debian)
            services=(apache2 mariadb ufw docker)
            ;;
        fedora)
            services=(httpd mariadb firewalld docker)
            ;;
        centos|rhel)
            services=(httpd mariadb firewalld docker)
            ;;
        *)
            echo "Невідомий дистрибутив: $distro"
            return 1
            ;;
    esac

    echo "Увімкнення служб: ${services[*]}"
    for service in "${services[@]}"; do
        systemctl enable --now "$service" 2>/dev/null && echo "$service активовано" || echo "Не вдалося активувати $service"
    done
}

main() {
    distro=$(get_distro)
    echo "Виявлено дистрибутив: $distro"

    # Визначення пакетного менеджера
    case "$distro" in
        ubuntu|debian) pkg_cmd="apt-get" ;;
        fedora) pkg_cmd="dnf" ;;
        centos|rhel) pkg_cmd="yum" ;;
        *)
            echo "Підтримка $distro не реалізована."
            exit 1
            ;;
    esac

    # Об'єднання базових і додаткових пакетів
    all_packages=("${base_packages[@]}" "$@")

    echo "Оновлення системи та встановлення пакетів..."
    install_packages "$pkg_cmd" "${all_packages[@]}"

    enable_services "$distro"

    echo "Готово! Встановлені пакети: ${all_packages[*]}"
}

main "$@"
