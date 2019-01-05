echo "-------------------INSTALL DEPENDENCIES------------------"
sudo apt-get install build-essential qmlscene qt5-qmake qt5-default qtdeclarative5-dev qml-module-qtquick-controls qtdeclarative5-qtquick2-plugin libqt5qml-graphicaleffects qml-module-qtquick-dialogs qtdeclarative5-localstorage-plugin qtdeclarative5-window-plugin
echo "------------------------ADD REPO-------------------------"
sudo add-apt-repository ppa:bugs-launchpad-net-falkensweb/cool-retro-term
echo "------------------------Apt Update-----------------------"
sudo apt-get update
echo "----------------------Offical Install--------------------"
sudo apt-get install cool-retro-term
echo "--------------------Finished Have Fun :) ----------------"
