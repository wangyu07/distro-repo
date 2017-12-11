#!/bin/bash

CUR_DIR=$(cd `dirname $0`; pwd)

#sudo yum install -y devtoolset-4-gcc
#sudo yum install -y devtoolset-4-gcc-c++
#sudo yum install -y devtoolset-4-libstdc++-devel

#source /opt/rh/devtoolset-4/enable


echo "Please make sure that it will use 5.x gcc version to compile, otherwise it might fail" 
echo "Build MySQL 5.7 community version ..."
VERSION="5.7"
RPM_SRC_FILE="mysql-community-5.7.18-1.el7.src.rpm"

SRC_DIR=src${VERSION}

if [ ! -f ${CUR_DIR}/${SRC_DIR}/${RPM_SRC_FILE} ] ; then
    sudo wget -O ${CUR_DIR}/${SRC_DIR}/${RPM_SRC_FILE} http://repo.mysql.com/yum/mysql-${VERSION}-community/el/7/SRPMS/${RPM_SRC_FILE}
fi

pushd ${CUR_DIR}/${SRC_DIR} > /dev/null
rpm2cpio ${RPM_SRC_FILE} | cpio -div
popd > /dev/null

#sed -i 's/x86_64/aarch64/g' ${CUR_DIR}/${SRC_DIR}/mysql.spec

${CUR_DIR}/../../utils/rpm_build.sh  ${CUR_DIR}/${SRC_DIR} mysql.spec
