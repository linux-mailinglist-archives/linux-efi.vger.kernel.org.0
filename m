Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106A23D36D
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2019 19:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390295AbfFKRGV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jun 2019 13:06:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390558AbfFKRGV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jun 2019 13:06:21 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BH2gRk131294
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2019 13:06:19 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2enadkmp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2019 13:06:19 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Tue, 11 Jun 2019 18:06:16 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 18:06:13 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5BH6CBp54853650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 17:06:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4094E11C050;
        Tue, 11 Jun 2019 17:06:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7931A11C04C;
        Tue, 11 Jun 2019 17:06:09 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.199.191])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 17:06:09 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: [PATCH v4 0/3] powerpc: Enabling IMA arch specific secure boot policies
Date:   Tue, 11 Jun 2019 13:06:02 -0400
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19061117-0028-0000-0000-0000037967DD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061117-0029-0000-0000-0000243957E1
Message-Id: <1560272765-5768-1-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110109
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch set, previously named "powerpc: Enabling secure boot on powernv
systems - Part 1", is part of a series that implements secure boot on
PowerNV systems.

In order to verify the OS kernel on PowerNV, secure boot requires X.509
certificates trusted by the platform, the secure boot modes, and several
other pieces of information. These are stored in secure variables
controlled by OPAL, also known as OPAL secure variables.

The IMA architecture specific policy support on POWER is dependent on OPAL
runtime services to access secure variables. OPAL APIs in skiboot are
modified to define generic interface compatible to any backend. This
patchset is consequently updated to be compatible with new OPAL API
interface. This has cleaned up any EFIsms in the arch specific code.
Further, the ima arch specific policies are updated to be able to support
appended signatures. They also now use per policy template.

Exposing the OPAL secure variables to userspace will be posted as a
separate patch set, allowing the IMA architecture specific policy on POWER
to be upstreamed independently.

This patch set adds the following features:

1. Add support for OPAL Runtime API to access secure variables controlled
by OPAL.
2. Define IMA arch-specific policies based on the secure boot state and
mode of the system. On secure boot enabled PowerNV systems, the OS kernel
signature will be verified by IMA appraisal.

Pre-requisites for this patchset are:
1. OPAL APIs in Skiboot[1]
2. Appended signature support in IMA [2]
3. Per policy template support in IMA [3]

[1] https://patchwork.ozlabs.org/project/skiboot/list/?series=112868 
[2] https://patchwork.ozlabs.org/cover/1087361/. Updated version will be
posted soon
[3] Repo: https://kernel.googlesource.com/pub/scm/linux/kernel/git/zohar/linux-integrity
Branch: next-queued-testing. Commit: f241bb1f42aa95

----------------------------------------------------------------------------------

Original Cover Letter:

This patch set is part of a series that implements secure boot on PowerNV
systems.

In order to verify the OS kernel on PowerNV, secure boot requires X.509
certificates trusted by the platform, the secure boot modes, and several
other pieces of information. These are stored in secure variables
controlled by OPAL, also known as OPAL secure variables.

The IMA architecture specific policy support on Power is dependent on OPAL
runtime services to access secure variables. Instead of directly accessing
the OPAL runtime services, version 3 of this patch set relied upon the
EFI hooks. This version drops that dependency and calls the OPAL runtime
services directly. Skiboot OPAL APIs are due to be posted soon.

Exposing the OPAL secure variables to userspace will be posted as a
separate patch set, allowing the IMA architecture specific policy on Power
to be upstreamed independently.

This patch set adds the following features:

1. Add support for OPAL Runtime API to access secure variables controlled
by OPAL.
2. Define IMA arch-specific policies based on the secure boot state and
mode of the system. On secure boot enabled powernv systems, the OS kernel
signature will be verified by IMA appraisal.

[1] https://patchwork.kernel.org/cover/10882149/

Changelog:

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

Claudio Carvalho (1):
  powerpc/powernv: Add OPAL API interface to get secureboot state

Nayna Jain (2):
  powerpc/powernv: detect the secure boot mode of the system
  powerpc: Add support to initialize ima policy rules

 arch/powerpc/Kconfig                         | 14 ++++
 arch/powerpc/include/asm/opal-api.h          |  4 +-
 arch/powerpc/include/asm/opal-secvar.h       | 23 ++++++
 arch/powerpc/include/asm/opal.h              |  6 ++
 arch/powerpc/include/asm/secboot.h           | 21 +++++
 arch/powerpc/kernel/Makefile                 |  1 +
 arch/powerpc/kernel/ima_arch.c               | 54 +++++++++++++
 arch/powerpc/platforms/powernv/Kconfig       |  6 ++
 arch/powerpc/platforms/powernv/Makefile      |  1 +
 arch/powerpc/platforms/powernv/opal-call.c   |  2 +
 arch/powerpc/platforms/powernv/opal-secvar.c | 85 ++++++++++++++++++++
 arch/powerpc/platforms/powernv/secboot.c     | 61 ++++++++++++++
 include/linux/ima.h                          |  3 +-
 13 files changed, 279 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/include/asm/opal-secvar.h
 create mode 100644 arch/powerpc/include/asm/secboot.h
 create mode 100644 arch/powerpc/kernel/ima_arch.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-secvar.c
 create mode 100644 arch/powerpc/platforms/powernv/secboot.c

-- 
2.20.1

