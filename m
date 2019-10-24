Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF362E2901
	for <lists+linux-efi@lfdr.de>; Thu, 24 Oct 2019 05:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392407AbfJXDrk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Oct 2019 23:47:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406600AbfJXDrj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Oct 2019 23:47:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9O3l7kK135854
        for <linux-efi@vger.kernel.org>; Wed, 23 Oct 2019 23:47:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vu42xrejf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 23 Oct 2019 23:47:38 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Thu, 24 Oct 2019 04:47:35 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 24 Oct 2019 04:47:31 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9O3kt0638469938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 03:46:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C564AE04D;
        Thu, 24 Oct 2019 03:47:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E8AAAE045;
        Thu, 24 Oct 2019 03:47:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.192.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Oct 2019 03:47:25 +0000 (GMT)
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
        Nayna Jain <nayna@linux.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH v9 0/8] powerpc: Enabling IMA arch specific secure boot policies
Date:   Wed, 23 Oct 2019 22:47:09 -0500
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102403-0016-0000-0000-000002BC7C2C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102403-0017-0000-0000-0000331DBEBF
Message-Id: <20191024034717.70552-1-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-24_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910240033
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patchset extends the previous version[1] by adding support for
checking against a blacklist of binary hashes.

The IMA subsystem supports custom, built-in, arch-specific policies to
define the files to be measured and appraised. These policies are honored
based on priority, where arch-specific policy is the highest and custom
is the lowest.

PowerNV system uses a Linux-based bootloader to kexec the OS. The
bootloader kernel relies on IMA for signature verification of the OS
kernel before doing the kexec. This patchset adds support for powerpc
arch-specific IMA policies that are conditionally defined based on a
system's secure boot and trusted boot states. The OS secure boot and
trusted boot states are determined via device-tree properties.

The verification needs to be performed only for binaries that are not
blacklisted. The kernel currently only checks against the blacklist of
keys. However, doing so results in blacklisting all the binaries that
are signed by the same key. In order to prevent just one particular
binary from being loaded, it must be checked against a blacklist of
binary hashes. This patchset also adds support to IMA for checking
against a hash blacklist for files. signed by appended signature.

[1] http://patchwork.ozlabs.org/cover/1149262/ 

Changelog:

v9:
* Includes feedbacks from Michael
  * fix the missing of_node_put()
* Includes Mimi's feedbacks
  * fix the policy show() function to display check_blacklist
  * fix the other comment related and patch description
  * add the example of blacklist in the Patch 7/8
Note: Patch 7/8 is giving errors when checkpatch.pl is run because
of the format of showing measurement record as part of the example. I am
not very sure if that can be fixed as we need to represent the
measurements as is.

v8:
* Updates the Patch Description as per Michael's and Mimi's feedback
* Includes feedbacks from Michael for the device tree and policies
  * removes the arch-policy hack by defining three arrays.
  * fixes related to device-tree calls 
  * other code specific feedbacks
* Includes feedbacks from Mimi on the blacklist
  * generic blacklist function is modified than previous version
  * other coding fixes

v7:
* Removes patch related to dt-bindings as per input from Rob Herring. 
* fixes Patch 1/8 to use new device-tree updates as per Oliver
  feedback to device-tree documentation in skiboot mailing list.
(https://lists.ozlabs.org/pipermail/skiboot/2019-September/015329.html)
* Includes feedbacks from Mimi, Thiago
  * moves function get_powerpc_fw_sb_node() from Patch 1 to Patch 3 
  * fixes Patch 2/8 to use CONFIG_MODULE_SIG_FORCE.
  * updates Patch description in Patch 5/8
  * adds a new patch to add wrapper is_binary_blacklisted()
  * removes the patch that deprecated permit_directio

v6:
* includes feedbacks from Michael Ellerman on the patchset v5
  * removed email ids from comments
  * add the doc for the device-tree
  * renames the secboot.c to secure_boot.c and secboot.h to secure_boot.h
  * other code specific fixes
* split the patches to differentiate between secureboot and trustedboot
state of the system
* adds the patches to support the blacklisting of the binary hash.

v5:
* secureboot state is now read via device tree entry rather than OPAL
secure variables
* ima arch policies are updated to use policy based template for
measurement rules

v4:
* Fixed the build issue as reported by Satheesh Rajendran.

v3:
* OPAL APIs in Patch 1 are updated to provide generic interface based on
key/keylen. This patchset updates kernel OPAL APIs to be compatible with
generic interface.
* Patch 2 is cleaned up to use new OPAL APIs.
* Since OPAL can support different types of backend which can vary in the
variable interpretation, the Patch 2 is updated to add a check for the
backend version
* OPAL API now expects consumer to first check the supported backend version
before calling other secvar OPAL APIs. This check is now added in patch 2.
* IMA policies in Patch 3 is updated to specify appended signature and
per policy template.
* The patches now are free of any EFIisms.

v2:

* Removed Patch 1: powerpc/include: Override unneeded early ioremap
functions
* Updated Subject line and patch description of the Patch 1 of this series
* Removed dependency of OPAL_SECVAR on EFI, CPU_BIG_ENDIAN and UCS2_STRING
* Changed OPAL APIs from static to non-static. Added opal-secvar.h for the
same
* Removed EFI hooks from opal_secvar.c
* Removed opal_secvar_get_next(), opal_secvar_enqueue() and
opal_query_variable_info() function
* get_powerpc_sb_mode() in secboot.c now directly calls OPAL Runtime API
rather than via EFI hooks.
* Fixed log messages in get_powerpc_sb_mode() function.
* Added dependency for PPC_SECURE_BOOT on configs PPC64 and OPAL_SECVAR
* Replaced obj-$(CONFIG_IMA) with obj-$(CONFIG_PPC_SECURE_BOOT) in
arch/powerpc/kernel/Makefile

Nayna Jain (8):
  powerpc: detect the secure boot mode of the system
  powerpc/ima: add support to initialize ima policy rules
  powerpc: detect the trusted boot state of the system
  powerpc/ima: define trusted boot policy
  ima: make process_buffer_measurement() generic
  certs: add wrapper function to check blacklisted binary hash
  ima: check against blacklisted hashes for files with modsig
  powerpc/ima: update ima arch policy to check for blacklist

 Documentation/ABI/testing/ima_policy   |  4 ++
 arch/powerpc/Kconfig                   | 11 ++++
 arch/powerpc/include/asm/secure_boot.h | 29 ++++++++++
 arch/powerpc/kernel/Makefile           |  2 +
 arch/powerpc/kernel/ima_arch.c         | 74 ++++++++++++++++++++++++++
 arch/powerpc/kernel/secure_boot.c      | 58 ++++++++++++++++++++
 certs/blacklist.c                      |  9 ++++
 include/keys/system_keyring.h          |  6 +++
 include/linux/ima.h                    |  3 +-
 security/integrity/ima/ima.h           | 11 ++++
 security/integrity/ima/ima_appraise.c  | 33 ++++++++++++
 security/integrity/ima/ima_main.c      | 63 ++++++++++++++--------
 security/integrity/ima/ima_policy.c    | 12 ++++-
 security/integrity/integrity.h         |  1 +
 14 files changed, 291 insertions(+), 25 deletions(-)
 create mode 100644 arch/powerpc/include/asm/secure_boot.h
 create mode 100644 arch/powerpc/kernel/ima_arch.c
 create mode 100644 arch/powerpc/kernel/secure_boot.c

-- 
2.20.1

