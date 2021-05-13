Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D5637F2FA
	for <lists+linux-efi@lfdr.de>; Thu, 13 May 2021 08:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhEMG2M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 May 2021 02:28:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231304AbhEMG2J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 May 2021 02:28:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14D6EbI7011135;
        Thu, 13 May 2021 02:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Oy6qL1rkJBWQzYlIHt95RLl8wBSmcbdaLyxkZyIqDsk=;
 b=e9xl/vo/lIeeWsUbiIFIpnIxzsVaqDTBFoAdxTTc8hgc2CfcoRu6Yj2dI2bhjGcY6GD5
 8T/mKG/10dilhd/YqC5EAdz9JtFwalfIpX4zTgIvueGYNvZTpDnapMpwJg9wfnwp5dFM
 WF6fsRmwgPysKxBqsPqpq8L/L6daEVKv3z02ToxUskoLx+qKBDQegIuZmk+IwZ0YKXmX
 pVIxcjbelAh2FbYrAp04LMmcZgRLJ0Ei6/yAQJRnPjpXged+VAcYMqtmvp64/HTL+IGZ
 RDgvVFGDaybq3RC7me0YoN0JMcTMKZfMng/n/UGekM2jg1RnrfcMUv1JPJmafnd3m1iJ Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38gxnvg7r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 02:26:47 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14D6GKuY022677;
        Thu, 13 May 2021 02:26:47 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38gxnvg7r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 02:26:46 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14D6C7K3002081;
        Thu, 13 May 2021 06:26:45 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 38dj99axq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 06:26:45 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14D6Qiuk19726660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 06:26:44 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1A147805F;
        Thu, 13 May 2021 06:26:43 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D102678060;
        Thu, 13 May 2021 06:26:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.2.130.16])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 13 May 2021 06:26:42 +0000 (GMT)
From:   Dov Murik <dovmurik@linux.ibm.com>
To:     linux-efi@vger.kernel.org
Cc:     Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] Allow access to confidential computing secret area
Date:   Thu, 13 May 2021 06:26:31 +0000
Message-Id: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zOUGFAz3faWe8gvbrT8JGwuKcdW3Rrnm
X-Proofpoint-ORIG-GUID: l-_Ay05EdoRCc5bBau-Tg7ZDuUvMZUAz
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_03:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105130046
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Confidential computing hardware such as AMD SEV (Secure Encrypted
Virtualization) allows guest owners to inject secrets into the VMs
memory without the host/hypervisor being able to read them.  In SEV,
secret injection is performed early in the VM launch process, before the
guest starts running.

Support for secret injection is already available in OVMF (in its AmdSev
package; see edk2 commit 01726b6d23d4 "OvmfPkg/AmdSev: Expose the Sev
Secret area using a configuration table" [1]), but the secrets were not
available in the guest kernel.

The patch series copies the secrets from the EFI-provided memory to
kernel reserved memory, and optionally exposes them to userspace via
securityfs using a new sev_secret kernel module.

The first patch in efi/libstub copies the secret area from the EFI
memory to specially allocated memory; the second patch reserves that
memory block; and the third patch introduces the new sev_secret module
that exposes the content of the secret entries as securityfs files.

This has been tested with AMD SEV guests, but the kernel side of
handling the secret area has no SEV-specific dependencies, and therefore
should be usable for any confidential computing hardware that can
publish the secret area via the standard EFI config table entry.

Here is a simple example for usage of the sev_secret module in a guest to which
secrets were injected during launch:

# modprobe sev_secret
# ls -la /sys/kernel/security/sev_secret
total 0
drwxr-xr-x 2 root root 0 May 12 18:03 .
drwxr-xr-x 3 root root 0 May 12 18:02 ..
-r--r----- 1 root root 0 May 12 18:03 736870e5-84f0-4973-92ec-06879ce3da0b
-r--r----- 1 root root 0 May 12 18:03 83c83f7f-1356-4975-8b7e-d3a0b54312c6
-r--r----- 1 root root 0 May 12 18:03 9553f55d-3da2-43ee-ab5d-ff17f78864d2
-r--r----- 1 root root 0 May 12 18:03 e6f5a162-d67f-4750-a67c-5d065f2a9910

# xxd /sys/kernel/security/sev_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
00000000: 7468 6573 652d 6172 652d 7468 652d 6b61  these-are-the-ka
00000010: 7461 2d73 6563 7265 7473 0001 0203 0405  ta-secrets......
00000020: 0607                                     ..


[1] https://github.com/tianocore/edk2/commit/01726b6d23d4


Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-efi@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Dov Murik (3):
  efi/libstub: Copy confidential computing secret area
  efi: Reserve confidential computing secret area
  virt: Add sev_secret module to expose confidential computing secrets

 drivers/firmware/efi/Makefile                 |   2 +-
 drivers/firmware/efi/confidential-computing.c |  41 +++
 drivers/firmware/efi/efi.c                    |   5 +
 drivers/firmware/efi/libstub/Makefile         |   3 +-
 .../efi/libstub/confidential-computing.c      |  68 +++++
 drivers/firmware/efi/libstub/efi-stub.c       |   2 +
 drivers/firmware/efi/libstub/efistub.h        |   2 +
 drivers/firmware/efi/libstub/x86-stub.c       |   2 +
 drivers/virt/Kconfig                          |   2 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/sev_secret/Kconfig               |  11 +
 drivers/virt/sev_secret/Makefile              |   2 +
 drivers/virt/sev_secret/sev_secret.c          | 260 ++++++++++++++++++
 include/linux/efi.h                           |  11 +
 14 files changed, 410 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/efi/confidential-computing.c
 create mode 100644 drivers/firmware/efi/libstub/confidential-computing.c
 create mode 100644 drivers/virt/sev_secret/Kconfig
 create mode 100644 drivers/virt/sev_secret/Makefile
 create mode 100644 drivers/virt/sev_secret/sev_secret.c


base-commit: c06a2ba62fc401b7aaefd23f5d0bc06d2457ccc1
-- 
2.25.1

