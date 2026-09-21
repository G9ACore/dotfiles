function net-ping
    echo "Проверка DNS..."
    time dig +short ya.ru
    
    echo "Проверка загрузки (10 МБ с зеркала Яндекса, обычно не шейпится)..."
    # -s 2: два потока, --summary-only: минимум вывода
    time aria2c -s 2 -x 2 --summary-interval=0 -q http://mirror.yandex.ru/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-2009.iso -o /dev/null
end