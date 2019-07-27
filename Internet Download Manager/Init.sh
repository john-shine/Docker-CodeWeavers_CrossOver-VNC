# !/bin/bash

${INSTALLDIR}/bin/cxbottle --create --bottle "${BOTTLE}" --description "IDM容器" --template "winxp"
sed -i -e 's/;;"AllowUntrusted" = ""/"AllowUntrusted" = "1"/' ${HOME}/.cxoffice/${BOTTLE}/cxbottle.conf

# 安装IDM
echo '接下来，需要在CrossOver中安装Internet Download Manager (网络与通信 > 网络工具 > IDM下载器)'
${INSTALLDIR}/bin/crossover

# fix double startmenu item
rm -f ${HOME}/.cxoffice/${BOTTLE}/desktopdata/cxmenu/StartMenu.*_users_Public_Start*Menu/Programs/Internet+Download+Manager/*.lnk
rm -f ${HOME}/.cxoffice/${BOTTLE}/drive_c/users/Public/Start\ Menu/Programs/Internet\ Download\ Manager/*.lnk
${INSTALLDIR}/bin/cxmenu --bottle ${BOTTLE} --sync --mode 'install'


[[ -d /mnt/drive_d ]] && ln -sf /mnt/drive_d "${HOME}/.cxoffice/${BOTTLE}/dosdevices/d:"

${INSTALLDIR}/bin/wine --bottle ${BOTTLE} --wait-children --wl-app 'reboot.exe'