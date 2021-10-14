Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732C542D9C7
	for <lists+linux-efi@lfdr.de>; Thu, 14 Oct 2021 15:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhJNNLa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Oct 2021 09:11:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230321AbhJNNLa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Oct 2021 09:11:30 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EBpwq7023739;
        Thu, 14 Oct 2021 09:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=qU/XOUjaTt/UxbVycomg7aYTCJYmz5tCWJ3m4uB9Xeg=;
 b=AWHULMlJHe3EZnxNdFytl4c78XYrNOI3QVqluzVw4tyOIKbEtqs+fWmklvrI3Wg4qSMx
 vRQv+2O+zZIjw3eyU2L3qBgkwsoQdCO6GGyjrGoTPGBy6EMaGbss6pyxxlTfHRyIh+Aw
 YdkZTtw4cbUhws7kfOL38SpaWliXB5DNxdxjck8YFlWBOg67seBovsR74pTZA8kuj2NF
 Trt0dJOWsk9DnC0axj4lfClGkb8IGsCfdXUf8oLZ1cOFDtkobXaECf3vZG3G+TDd0ZJz
 +id3I6bS0pVVqOoz0cY2iAg0KJbTWtLk94Y1c6J23pdBhnPXGFdm/aYfAVcknossf4lA EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bnt945dd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 09:08:58 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19ED66Ex018527;
        Thu, 14 Oct 2021 09:08:57 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bnt945dbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 09:08:57 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19ED1eSG006186;
        Thu, 14 Oct 2021 13:08:55 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01wdc.us.ibm.com with ESMTP id 3bk2qbqdq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 13:08:55 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19ED8rJm16515434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 13:08:54 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A074778072;
        Thu, 14 Oct 2021 13:08:53 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 477CA78060;
        Thu, 14 Oct 2021 13:08:52 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 14 Oct 2021 13:08:52 +0000 (GMT)
From:   Dov Murik <dovmurik@linux.ibm.com>
To:     linux-efi@vger.kernel.org
Cc:     Dov Murik <dovmurik@linux.ibm.com>, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Allow guest access to EFI confidential computing secret area
Date:   Thu, 14 Oct 2021 13:08:45 +0000
Message-Id: <20211014130848.592611-1-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9oz8uvpx_DiuXdCwA6Rn8B9DoK-HP34Q
X-Proofpoint-ORIG-GUID: -PHGkZB063iiEqi_-_o0Xb1glDx_5O2b
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-14_08,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110140084
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Confidential computing (coco) hardware such as AMD SEV (Secure Encrypted
Virtualization) allows guest owners to inject secrets into the VMs
memory without the host/hypervisor being able to read them.  In SEV,
secret injection is performed early in the VM launch process, before the
guest starts running.

OVMF already reserves designated area for secret injection (in its
AmdSev package; see edk2 commit 01726b6d23d4 "OvmfPkg/AmdSev: Expose the
Sev Secret area using a configuration table" [1]), but the secrets were
not available in the guest kernel.

The patch series copies the secrets from the EFI-provided memory to
kernel reserved memory, and optionally exposes them to userspace via
securityfs using a new efi_secret kernel module.

The first patch in efi/libstub copies the secret area from the EFI
memory to specially allocated memory; the second patch reserves that
memory block; and the third patch introduces the new efi_secret module
that exposes the content of the secret entries as securityfs files, and
allows clearing out secrets with a file unlink interface.

As a usage example, consider a guest performing computations on
encrypted files.  The Guest Owner provides the decryption key (= secret)
using the secret injection mechanism.  The guest application reads the
secret from the efi_secret filesystem and proceeds to decrypt the files
into memory and then performs the needed computations on the content.

In this example, the host can't read the files from the disk image
because they are encrypted.  Host can't read the decryption key because
it is passed using the secret injection mechanism (= secure channel).
Host can't read the decrypted content from memory because it's a
confidential (memory-encrypted) guest.

This has been tested with AMD SEV and SEV-ES guests, but the kernel side
of handling the secret area has no SEV-specific dependencies, and
therefore might be usable (perhaps with minor changes) for any
confidential computing hardware that can publish the secret area via the
standard EFI config table entry.

Here is a simple example for usage of the efi_secret module in a guest
to which an EFI secret area with 4 secrets was injected during launch:

# modprobe efi_secret
# ls -la /sys/kernel/security/coco/efi_secret
total 0
drwxr-xr-x 2 root root 0 Jun 28 11:54 .
drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
-r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
-r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
-r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
-r--r----- 1 root root 0 Jun 28 11:54 e6f5a162-d67f-4750-a67c-5d065f2a9910

# xxd /sys/kernel/security/coco/efi_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
00000000: 7468 6573 652d 6172 652d 7468 652d 6b61  these-are-the-ka
00000010: 7461 2d73 6563 7265 7473 0001 0203 0405  ta-secrets......
00000020: 0607                                     ..

# rm /sys/kernel/security/coco/efi_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910

# ls -la /sys/kernel/security/coco/efi_secret
total 0
drwxr-xr-x 2 root root 0 Jun 28 11:55 .
drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
-r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
-r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
-r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2


[1] https://github.com/tianocore/edk2/commit/01726b6d23d4

---

v3 changes:
 - Rename the module to efi_secret
 - Remove the exporting of clean_cache_range
 - Use clflush_cache_range in wipe_memory
 - Document function wipe_memory
 - Initialize efi.coco_secret to EFI_INVALID_TABLE_ADDR to correctly detect
   when there's no secret area published in the EFI configuration tables

v2: https://lore.kernel.org/linux-coco/20211007061838.1381129-1-dovmurik@linux.ibm.com
v2 changes:
 - Export clean_cache_range()
 - When deleteing a secret, call clean_cache_range() after explicit_memzero
 - Add Documentation/ABI/testing/securityfs-coco-sev_secret

v1: https://lore.kernel.org/linux-coco/20210809190157.279332-1-dovmurik@linux.ibm.com/

RFC: https://lore.kernel.org/linux-coco/20210628183431.953934-1-dovmurik@linux.ibm.com/


Dov Murik (3):
  efi/libstub: Copy confidential computing secret area
  efi: Reserve confidential computing secret area
  virt: Add efi_secret module to expose confidential computing secrets

 .../ABI/testing/securityfs-coco-efi_secret    |  50 +++
 arch/x86/platform/efi/efi.c                   |   1 +
 drivers/firmware/efi/Makefile                 |   2 +-
 drivers/firmware/efi/coco.c                   |  41 +++
 drivers/firmware/efi/efi.c                    |   4 +
 drivers/firmware/efi/libstub/Makefile         |   2 +-
 drivers/firmware/efi/libstub/coco.c           |  68 ++++
 drivers/firmware/efi/libstub/efi-stub.c       |   2 +
 drivers/firmware/efi/libstub/efistub.h        |   2 +
 drivers/firmware/efi/libstub/x86-stub.c       |   2 +
 drivers/virt/Kconfig                          |   3 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/coco/efi_secret/Kconfig          |  10 +
 drivers/virt/coco/efi_secret/Makefile         |   2 +
 drivers/virt/coco/efi_secret/efi_secret.c     | 324 ++++++++++++++++++
 include/linux/efi.h                           |   9 +
 16 files changed, 521 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/securityfs-coco-efi_secret
 create mode 100644 drivers/firmware/efi/coco.c
 create mode 100644 drivers/firmware/efi/libstub/coco.c
 create mode 100644 drivers/virt/coco/efi_secret/Kconfig
 create mode 100644 drivers/virt/coco/efi_secret/Makefile
 create mode 100644 drivers/virt/coco/efi_secret/efi_secret.c


base-commit: 60a9483534ed0d99090a2ee1d4bb0b8179195f51
-- 
2.25.1

