Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81CF3B6881
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jun 2021 20:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhF1ShV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Jun 2021 14:37:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54236 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234402AbhF1ShU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Jun 2021 14:37:20 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SIXl5B040299;
        Mon, 28 Jun 2021 14:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=H6dy111e1voGFBW+BvI3b1gIFcd+YE9u4Lv0ktfnnBM=;
 b=FnSAvXhcovhMwwanHhhu17PIXZIKEBwFE9AEp7+7OiQnd6+daRR9eNUX8d0381fnPlLe
 4zu1nd0+Wp4Vbulp02uutqAJGQNIrMp8PeyQnAU0mUwHLM4lTLVSJTxSqPYlvSRAz0e3
 /DNdLd5wxzm6pfQhm+5qj27z1tyrVuyg88eDe6OgSk85qA9jZtbrsxwBzR4O/bICRNiT
 1YL9TLEfRev0+DKvPMeDeeSrxFxJ/zqwPpGRlLb8CAnf7+Lzv731HnPh24k67fc70cmJ
 +zCbisRqcldEmRlrILDYYNOXUXVmUGj440rX4iJ5qtl262V7teXIo1oZkNkGtqhvjRiB 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fhu2kq5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 14:34:39 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15SIYdLA044938;
        Mon, 28 Jun 2021 14:34:39 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fhu2kq5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 14:34:39 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SISAvC027398;
        Mon, 28 Jun 2021 18:34:38 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 39duvb8msa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 18:34:38 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SIYb4530474516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 18:34:37 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44638AC060;
        Mon, 28 Jun 2021 18:34:37 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06FBAAC062;
        Mon, 28 Jun 2021 18:34:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.2.130.16])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 18:34:36 +0000 (GMT)
From:   Dov Murik <dovmurik@linux.ibm.com>
To:     linux-efi@vger.kernel.org
Cc:     Dov Murik <dovmurik@linux.ibm.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/3] Allow access to confidential computing secret area
Date:   Mon, 28 Jun 2021 18:34:28 +0000
Message-Id: <20210628183431.953934-1-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PFCNBpUcIe_-Ouc9gJIW3AkqEQE85WnA
X-Proofpoint-GUID: OWE6BPlPz7Vdes6vOC-8u9azeZ5imWyl
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_14:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280121
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
that exposes the content of the secret entries as securityfs files, and
allows clearing out secrets with a file unlink interface.

This has been tested with AMD SEV guests, but the kernel side of
handling the secret area has no SEV-specific dependencies, and therefore
should be usable for any confidential computing hardware that can
publish the secret area via the standard EFI config table entry.

Here is a simple example for usage of the sev_secret module in a guest to which
secrets were injected during launch:

# modprobe sev_secret
# ls -la /sys/kernel/security/sev_secret/
total 0
drwxr-xr-x 2 root root 0 Jun 28 11:54 .
drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
-r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
-r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
-r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
-r--r----- 1 root root 0 Jun 28 11:54 e6f5a162-d67f-4750-a67c-5d065f2a9910

# xxd /sys/kernel/security/sev_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
00000000: 7468 6573 652d 6172 652d 7468 652d 6b61  these-are-the-ka
00000010: 7461 2d73 6563 7265 7473 0001 0203 0405  ta-secrets......
00000020: 0607                                     ..

# rm /sys/kernel/security/sev_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910

# ls -la /sys/kernel/security/sev_secret/
total 0
drwxr-xr-x 2 root root 0 Jun 28 11:55 .
drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
-r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
-r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
-r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2


[1] https://github.com/tianocore/edk2/commit/01726b6d23d4

v2 changes:
 - Add unlink support in sev_secret securityfs.


Dov Murik (3):
  efi/libstub: Copy confidential computing secret area
  efi: Reserve confidential computing secret area
  virt: Add sev_secret module to expose confidential computing secrets

 drivers/firmware/efi/Makefile                 |   2 +-
 drivers/firmware/efi/confidential-computing.c |  41 +++
 drivers/firmware/efi/efi.c                    |   5 +
 drivers/firmware/efi/libstub/Makefile         |   3 +-
 .../efi/libstub/confidential-computing.c      |  68 ++++
 drivers/firmware/efi/libstub/efi-stub.c       |   2 +
 drivers/firmware/efi/libstub/efistub.h        |   2 +
 drivers/firmware/efi/libstub/x86-stub.c       |   2 +
 drivers/virt/Kconfig                          |   2 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/sev_secret/Kconfig               |  11 +
 drivers/virt/sev_secret/Makefile              |   2 +
 drivers/virt/sev_secret/sev_secret.c          | 298 ++++++++++++++++++
 include/linux/efi.h                           |  11 +
 14 files changed, 448 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/efi/confidential-computing.c
 create mode 100644 drivers/firmware/efi/libstub/confidential-computing.c
 create mode 100644 drivers/virt/sev_secret/Kconfig
 create mode 100644 drivers/virt/sev_secret/Makefile
 create mode 100644 drivers/virt/sev_secret/sev_secret.c


base-commit: 62fb9874f5da54fdb243003b386128037319b219
-- 
2.25.1

