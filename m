Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368374A5C70
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 13:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbiBAMo5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 07:44:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229966AbiBAMo4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 07:44:56 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211CdUvY017127;
        Tue, 1 Feb 2022 12:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=UGY2abURcnpFtpm/upKHv5PzAHKnxDA3gsUO9xBlR1A=;
 b=Ufx4S52u55nN1+/SFfMx5vv6W2+31Zai0pO60QYQqIcGmEA7ppnEyfkYVF4OpSBwV6QN
 JcAKtSS0jXdWu1+tvfOmSwKkGPLcv51OgSyTld0MLBcPU4W0ZzDLFiqX7a9BjbT1baDV
 EMEul3IEFMwBH72IQYX41YN/z6cZzF+CYvNqt7lVpwIz5irntDLXPESktqkzbwHN2NQo
 VEaQ+eYbptSajEMHqA9tQBqEr1Viez9pj8Xng+lJCtwPuBSP9f3jrpzeAxE4AUEa8hLd
 XO17RDsHN8W8e09t6ibH6gfqchYv04EL92NCbQEbIBXGyGbOqMm/bPLr+Gxql7mfy+ft Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxj34e0c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 12:44:43 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211ChVMp008186;
        Tue, 1 Feb 2022 12:44:42 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxj34e0bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 12:44:42 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211CchWj011833;
        Tue, 1 Feb 2022 12:44:41 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 3dvw7auc92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 12:44:41 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211CidPi28377498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 12:44:39 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97457BE05B;
        Tue,  1 Feb 2022 12:44:39 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6962BE056;
        Tue,  1 Feb 2022 12:44:37 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 12:44:37 +0000 (GMT)
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
        Gerd Hoffmann <kraxel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/5] Allow guest access to EFI confidential computing secret area
Date:   Tue,  1 Feb 2022 12:44:08 +0000
Message-Id: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eoXuoar1ulbAVKbBO-AH3UV6PdfF9mnQ
X-Proofpoint-GUID: LgRHRopGbNsWBzHaokhDVnAP2rtfVJy1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_03,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010068
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

The patch series keeps the address of the EFI-provided memory for
injected secrets, and exposes the secrets to userspace via securityfs
using a new efi_secret kernel module.  The module is autoloaded (by the
EFI driver) if the secret area is populated.

The first patch in EFI keeps the address of the secret area as passed in
the EFI configuration table.  The second patch is a quirk fix for older
firmwares didn't mark the secrets page as EFI_RESERVED_TYPE.  The third
patch introduces the new efi_secret module that exposes the content of
the secret entries as securityfs files, and allows clearing out secrets
with a file unlink interface.  The fourth patch auto-loads the
efi_secret module during startup if the injected secrets area is
populated.  The last patch documents the data flow of confidential
computing secret injection.

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

To enable this functionality, set CONFIG_EFI_SECRET=m when building the
guest kernel.

Here is a simple example for usage of the efi_secret module in a guest
to which an EFI secret area with 4 secrets was injected during launch:

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

v7 changes:
 - Improve description of efi_secret module in Kconfig.
 - Fix sparse warnings on pointer address space mismatch
   (Reported-by: kernel test robot <lkp@intel.com>)

v6: https://lore.kernel.org/linux-coco/20211129114251.3741721-1-dovmurik@linux.ibm.com/
v6 changes:
 - Autoload the efi_secret module if the secret area is populated
   (thanks Greg KH).
 - efi_secret: Depend on X86_64 because we use ioremap_encrypted() which
   is only defined for this arch.
 - efi_secret.c: Remove unneeded tableheader_guid local variable.
 - Documentation fixes.

v5: https://lore.kernel.org/linux-coco/20211118113359.642571-1-dovmurik@linux.ibm.com/
v5 changes:
 - Simplify EFI code: instead of copying the secret area, the firmware
   marks the secret area as EFI_RESERVED_TYPE, and then the uefi_init()
   code just keeps the pointer as it appears in the EFI configuration
   table.  The use of reserved pages is similar to the AMD SEV-SNP
   patches for handling SNP-Secrets and SNP-CPUID pages.
 - In order to handle OVMF releases out there which mark the
   confidential computing secrets page as EFI_BOOT_SERVICES_DATA, add
   efi/libstub code that detects this and fixes the E820 map to reserve
   this page.
 - In the efi_secret module code, map the secrets page using
   ioremap_encrypted (again, similar to the AMD SEV-SNP guest patches
   for accessing SNP-Secrets and SNP-CPUID pages).
 - Add documentation in Documentation/security/coco/efi_secret.

v4: https://lore.kernel.org/linux-coco/20211020061408.3447533-1-dovmurik@linux.ibm.com/
v4 changes:
 - Guard all the new EFI and efi-stub code (patches 1+2) with #ifdef
   CONFIG_EFI_COCO_SECRET (thanks Greg KH).  Selecting
   CONFIG_EFI_SECRET=m (patch 3) will enable the EFI parts as well.
 - Guard call to clflush_cache_range() with #ifdef CONFIG_X86
   (Reported-by: kernel test robot <lkp@intel.com>)

v3: https://lore.kernel.org/linux-coco/20211014130848.592611-1-dovmurik@linux.ibm.com/
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


Dov Murik (5):
  efi: Save location of EFI confidential computing area
  efi/libstub: Reserve confidential computing secret area
  virt: Add efi_secret module to expose confidential computing secrets
  efi: Load efi_secret module if EFI secret area is populated
  docs: security: Add coco/efi_secret documentation

 .../ABI/testing/securityfs-coco-efi_secret    |  51 +++
 Documentation/security/coco/efi_secret.rst    | 102 ++++++
 Documentation/security/coco/index.rst         |   9 +
 Documentation/security/index.rst              |   1 +
 arch/x86/platform/efi/efi.c                   |   3 +
 drivers/firmware/efi/Kconfig                  |  16 +
 drivers/firmware/efi/Makefile                 |   1 +
 drivers/firmware/efi/coco.c                   |  58 +++
 drivers/firmware/efi/efi.c                    |   6 +
 drivers/firmware/efi/libstub/x86-stub.c       |  28 ++
 drivers/virt/Kconfig                          |   3 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/coco/efi_secret/Kconfig          |  19 +
 drivers/virt/coco/efi_secret/Makefile         |   2 +
 drivers/virt/coco/efi_secret/efi_secret.c     | 337 ++++++++++++++++++
 include/linux/efi.h                           |  10 +
 16 files changed, 647 insertions(+)
 create mode 100644 Documentation/ABI/testing/securityfs-coco-efi_secret
 create mode 100644 Documentation/security/coco/efi_secret.rst
 create mode 100644 Documentation/security/coco/index.rst
 create mode 100644 drivers/firmware/efi/coco.c
 create mode 100644 drivers/virt/coco/efi_secret/Kconfig
 create mode 100644 drivers/virt/coco/efi_secret/Makefile
 create mode 100644 drivers/virt/coco/efi_secret/efi_secret.c


base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
-- 
2.25.1

