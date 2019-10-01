Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B63EBC447B
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2019 01:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfJAXmM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Oct 2019 19:42:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbfJAXmM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Oct 2019 19:42:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x91Ng7YX170490
        for <linux-efi@vger.kernel.org>; Tue, 1 Oct 2019 19:42:10 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdgpn972-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Tue, 01 Oct 2019 19:42:10 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Wed, 2 Oct 2019 00:42:08 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Oct 2019 00:42:03 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x91Ng1mh55705784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Oct 2019 23:42:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64A91A405B;
        Tue,  1 Oct 2019 23:42:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1CAAA4060;
        Tue,  1 Oct 2019 23:41:58 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.224.222])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Oct 2019 23:41:58 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v4 0/4] powerpc: expose secure variables to the kernel and userspace 
Date:   Tue,  1 Oct 2019 19:41:47 -0400
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19100123-0008-0000-0000-0000031D210F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100123-0009-0000-0000-00004A3C2213
Message-Id: <1569973311-3047-1-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010202
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In order to verify the OS kernel on PowerNV systems, secure boot requires
X.509 certificates trusted by the platform. These are stored in secure
variables controlled by OPAL, called OPAL secure variables. In order to
enable users to manage the keys, the secure variables need to be exposed
to userspace.

OPAL provides the runtime services for the kernel to be able to access the
secure variables[1]. This patchset defines the kernel interface for the
OPAL APIs. These APIs are used by the hooks, which load these variables
to the keyring and expose them to the userspace for reading/writing.

The previous version[2] of the patchset added support only for the sysfs
interface. This patch adds two more patches that involves loading of
the firmware trusted keys to the kernel keyring. This patchset is
dependent on the base CONFIG PPC_SECURE_BOOT added by ima arch specific
patches for POWER[3]

Overall, this patchset adds the following support:

* expose secure variables to the kernel via OPAL Runtime API interface
* expose secure variables to the userspace via kernel sysfs interface
* load kernel verification and revocation keys to .platform and
.blacklist keyring respectively.

The secure variables can be read/written using simple linux utilities
cat/hexdump.

For example:
Path to the secure variables is:
/sys/firmware/secvar/vars

Each secure variable is listed as directory. 
$ ls -l
total 0
drwxr-xr-x. 2 root root 0 Aug 20 21:20 db
drwxr-xr-x. 2 root root 0 Aug 20 21:20 KEK
drwxr-xr-x. 2 root root 0 Aug 20 21:20 PK

The attributes of each of the secure variables are(for example: PK):
[db]$ ls -l
total 0
-r--r--r--. 1 root root     0 Oct  1 15:10 data
-r--r--r--. 1 root root 65536 Oct  1 15:10 size
--w-------. 1 root root     0 Oct  1 15:12 update

The "data" is used to read the existing variable value using hexdump. The
data is stored in ESL format.
The "update" is used to write a new value using cat. The update is
to be submitted as AUTH file.

[1] Depends on skiboot OPAL API changes which removes metadata from
the API. https://lists.ozlabs.org/pipermail/skiboot/2019-September/015203.html.
[2] https://lkml.org/lkml/2019/6/13/1644
[3] https://lkml.org/lkml/2019/9/27/407

Changelog:
v4:
* rebased to v5.4-rc1 
* uses __BIN_ATTR_WO macro to create binary attribute as suggested by
  Greg
* removed email id from the file header
* renamed argument keysize to keybufsize in get_next() function
* updated default binary file sizes to 0, as firmware handles checking
against the maximum size
* fixed minor formatting issues in Patch 4/4
* added Greg's and Mimi's Reviewed-by and Ack-by

v3:
* includes Greg's feedbacks:
 * fixes in Patch 2/4
   * updates the Documentation.
   * fixes code feedbacks
    * adds SYSFS Kconfig dependency for SECVAR_SYSFS
    * fixes mixed tabs and spaces
    * removes "name" attribute for each of the variable name based
    directories
    * fixes using __ATTR_RO() and __BIN_ATTR_RO() and statics and const
    * fixes the racing issue by using kobj_type default groups. Also,
    fixes the kobject leakage.
    * removes extra print messages
  * updates patch description for Patch 3/4
  * removes file name from Patch 4/4 file header comment and removed
  def_bool y from the LOAD_PPC_KEYS Kconfig

* includes Oliver's feedbacks:
  * fixes Patch 1/2
   * moves OPAL API wrappers after opal_nx_proc_init(), fixed the
   naming, types and removed extern.
   * fixes spaces
   * renames get_variable() to get(), get_next_variable() to get_next()
   and set_variable() to set()
   * removed get_secvar_ops() and defined secvar_ops as global
   * fixes consts and statics
   * removes generic secvar_init() and defined platform specific
   opal_secar_init()
   * updates opal_secvar_supported() to check for secvar support even
   before checking the OPAL APIs support and also fixed the error codes.
   * addes function that converts OPAL return codes to linux errno
   * moves secvar check support in the opal_secvar_init() and defined its
   prototype in opal.h
  * fixes Patch 2/2
   * fixes static/const
   * defines macro for max name size
   * replaces OPAL error codes with linux errno and also updated error
   handling
   * moves secvar support check before creating sysfs kobjects in 
   secvar_sysfs_init()
   * fixes spaces  

v2:
* removes complete efi-sms from the sysfs implementation and is simplified
* includes Greg's and Oliver's feedbacks:
 * adds sysfs documentation
 * moves sysfs code to arch/powerpc
 * other code related feedbacks.
* adds two new patches to load keys to .platform and .blacklist keyring.
These patches are added to this series as they are also dependent on
OPAL APIs.

Nayna Jain (4):
  powerpc/powernv: Add OPAL API interface to access secure variable
  powerpc: expose secure variables to userspace via sysfs
  x86/efi: move common keyring handler functions to new file
  powerpc: load firmware trusted keys/hashes into kernel keyring

 Documentation/ABI/testing/sysfs-secvar        |  37 ++++
 arch/powerpc/Kconfig                          |  10 +
 arch/powerpc/include/asm/opal-api.h           |   5 +-
 arch/powerpc/include/asm/opal.h               |   8 +
 arch/powerpc/include/asm/powernv.h            |   2 +
 arch/powerpc/include/asm/secvar.h             |  35 ++++
 arch/powerpc/kernel/Makefile                  |   3 +-
 arch/powerpc/kernel/secvar-ops.c              |  19 ++
 arch/powerpc/kernel/secvar-sysfs.c            | 198 ++++++++++++++++++
 arch/powerpc/platforms/powernv/Kconfig        |   6 +
 arch/powerpc/platforms/powernv/Makefile       |   1 +
 arch/powerpc/platforms/powernv/opal-call.c    |   3 +
 arch/powerpc/platforms/powernv/opal-secvar.c  | 137 ++++++++++++
 arch/powerpc/platforms/powernv/opal.c         |   5 +
 security/integrity/Kconfig                    |   8 +
 security/integrity/Makefile                   |   6 +-
 .../platform_certs/keyring_handler.c          |  80 +++++++
 .../platform_certs/keyring_handler.h          |  32 +++
 .../integrity/platform_certs/load_powerpc.c   |  86 ++++++++
 security/integrity/platform_certs/load_uefi.c |  67 +-----
 20 files changed, 679 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-secvar
 create mode 100644 arch/powerpc/include/asm/secvar.h
 create mode 100644 arch/powerpc/kernel/secvar-ops.c
 create mode 100644 arch/powerpc/kernel/secvar-sysfs.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-secvar.c
 create mode 100644 security/integrity/platform_certs/keyring_handler.c
 create mode 100644 security/integrity/platform_certs/keyring_handler.h
 create mode 100644 security/integrity/platform_certs/load_powerpc.c

-- 
2.20.1

