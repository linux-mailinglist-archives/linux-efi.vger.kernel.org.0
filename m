Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282D84EE38B
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 23:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbiCaV60 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 17:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiCaV6Z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 17:58:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C251A30F7A;
        Thu, 31 Mar 2022 14:56:36 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VJYWs9028753;
        Thu, 31 Mar 2022 21:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=YasENBrV7DzKBvg/cguB2BEpD8shuvJLEmenExKEPO0=;
 b=l1ZTqDW9JTam/WoowlMNJSIstqRD+nIovbQ3pR67cZSn3JI3JRO7rFhEQJezYVo8ojNf
 NsLWh6+K9wiKlux4VPn+sadXBE+c19HiCBHLWYc8gyyi71M4SIGVjjFUc79NXDyL8+pt
 ROduDsYCE9C5zEQof3FcqpB02fa26omqOXgn/gJW5t1z+TVXux0qqPSG+NeN+3oEU4C8
 d6NQXJPPjmpxi7WXUXKOKsAZ8Pmwzpn9NQfsRF8ycbX9ji5XZ+DKHf9OikVKtNFLby6y
 godXVnf5EhbD8N7gDSoWrCVRump032n5rlrl7HoVpHc/JJxzuR+jF6oHL+Cy3h2AgFbx vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f51hw0fs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 21:56:18 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22VLbVvC027540;
        Thu, 31 Mar 2022 21:56:18 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f51hw0fru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 21:56:17 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22VLpmpR001683;
        Thu, 31 Mar 2022 21:56:16 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 3f1tfahkj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 21:56:16 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22VLuFdp26280282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 21:56:15 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 484D8136053;
        Thu, 31 Mar 2022 21:56:15 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABD8713605D;
        Thu, 31 Mar 2022 21:56:13 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 31 Mar 2022 21:56:13 +0000 (GMT)
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
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/4] Allow guest access to EFI confidential computing secret area
Date:   Thu, 31 Mar 2022 21:56:03 +0000
Message-Id: <20220331215607.3182232-1-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HMQ2yf8G45BXyQmjcU0dDDD2p_NU1sOv
X-Proofpoint-ORIG-GUID: cx37SeB8QQ97rqSYGRxTPCYKrXbkNeUH
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_06,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
the EFI configuration table.  The second patch introduces the new
efi_secret module that exposes the content of the secret entries as
securityfs files, and allows clearing out secrets with a file unlink
interface.  The third patch auto-loads the efi_secret module during
startup if the injected secrets area is populated.  The last patch
documents the data flow of confidential computing secret injection.

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

...
[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi: CocoSecret=0x7f222680 SMBIOS=0x7f541000 ACPI=0x7f77e000 ACPI 2.0=0x7f77e014 MEMATTR=0x7ea16418
...
[    1.127627] Run /init as init process
Loading, please wait...
Starting version 245.4-4ubuntu3.15
...
[    0.763204] efi_secret efi_secret.0: Created 4 entries in securityfs secrets/coco
...

# ls -la /sys/kernel/security/secrets/coco
total 0
drwxr-xr-x 2 root root 0 Jun 28 11:54 .
drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
-r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
-r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
-r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
-r--r----- 1 root root 0 Jun 28 11:54 e6f5a162-d67f-4750-a67c-5d065f2a9910

# hd /sys/kernel/security/secrets/coco/e6f5a162-d67f-4750-a67c-5d065f2a9910
00000000  74 68 65 73 65 2d 61 72  65 2d 74 68 65 2d 6b 61  |these-are-the-ka|
00000010  74 61 2d 73 65 63 72 65  74 73 00 01 02 03 04 05  |ta-secrets......|
00000020  06 07                                             |..|
00000022

# rm /sys/kernel/security/secrets/coco/e6f5a162-d67f-4750-a67c-5d065f2a9910

# ls -la /sys/kernel/security/secrets/coco
total 0
drwxr-xr-x 2 root root 0 Jun 28 11:55 .
drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
-r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
-r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
-r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2


[1] https://github.com/tianocore/edk2/commit/01726b6d23d4


---

v9 changes:
- Change the module into a platform driver (thanks Ard)
- Remove special auto-loading code in efi; instead register a platform
  device (udev will load the efi_secret module) (thanks Ard)
- Change logging in the efi_secret module to dev_err() etc.
- efi_secret: first check that the secret area header is valid; only then start
  creating securityfs dirs.

v8: https://lore.kernel.org/linux-coco/20220228114254.1099945-1-dovmurik@linux.ibm.com/
v8 changes:
 - Change path of filesystem to <securityfs>/secrets/coco and fix the
   documentation accordingly (Thanks Gerd, Matthew)
 - Remove patch 2/5 (of v7) because the latest OVMF release (edk2-stable202202)
   already contains the fix to mark the launch secret page as EFI_RESERVED_TYPE.

v7: https://lore.kernel.org/linux-coco/20220201124413.1093099-1-dovmurik@linux.ibm.com/
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



Dov Murik (4):
  efi: Save location of EFI confidential computing area
  virt: Add efi_secret module to expose confidential computing secrets
  efi: Register efi_secret platform device if EFI secret area is
    declared
  docs: security: Add secrets/coco documentation

 Documentation/ABI/testing/securityfs-secrets-coco |  51 +++
 Documentation/security/index.rst                  |   1 +
 Documentation/security/secrets/coco.rst           | 103 ++++++
 Documentation/security/secrets/index.rst          |   9 +
 arch/x86/platform/efi/efi.c                       |   3 +
 drivers/firmware/efi/Kconfig                      |  16 +
 drivers/firmware/efi/efi.c                        |   9 +
 drivers/virt/Kconfig                              |   3 +
 drivers/virt/Makefile                             |   1 +
 drivers/virt/coco/efi_secret/Kconfig              |  16 +
 drivers/virt/coco/efi_secret/Makefile             |   2 +
 drivers/virt/coco/efi_secret/efi_secret.c         | 349 ++++++++++++++++++++
 include/linux/efi.h                               |  10 +
 13 files changed, 573 insertions(+)
 create mode 100644 Documentation/ABI/testing/securityfs-secrets-coco
 create mode 100644 Documentation/security/secrets/coco.rst
 create mode 100644 Documentation/security/secrets/index.rst
 create mode 100644 drivers/virt/coco/efi_secret/Kconfig
 create mode 100644 drivers/virt/coco/efi_secret/Makefile
 create mode 100644 drivers/virt/coco/efi_secret/efi_secret.c


base-commit: 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3
-- 
2.25.1

