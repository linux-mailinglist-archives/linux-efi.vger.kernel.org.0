Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E9A3E4C8E
	for <lists+linux-efi@lfdr.de>; Mon,  9 Aug 2021 21:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhHITCr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Aug 2021 15:02:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235246AbhHITCr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Aug 2021 15:02:47 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179Icr4g057538;
        Mon, 9 Aug 2021 15:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=HpqaO3+MhiLePUDKJkioMaJjmHnxGYgpMvVEEt+qXKg=;
 b=PN2eVIZhPrmGoezSPvR6ROuitrF+cm/kjSXMTyVKr8vd9VZTwiLqlUDvLGCOtk5KZv1q
 G2csg3mna4iYaeqAXKBolGb/AmvHjIH+8stXTpHAyoDUO16nAtdvFkKpGsM9fWOTy61t
 wQxaNJee7y6PRnN2jhdGJ9xsxp5kNx/bkWoKNEROdzk6oUZ2wxbey1HWAtpLPePBbohr
 lrmWKEXj/ib7dKAlD4uPEiP9ayqo//uK0h1CIJ224KPVq6XTWeEzrKA+gWJIzOuRZugh
 DD7VoCO+tK2+jXrmSlSY4EMGgf2RFcO8brMut+MEqUSvR2oiFG/3gT0P0AysjZIP+YrJ 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab1j8fcwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 15:02:05 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 179IhPRU084423;
        Mon, 9 Aug 2021 15:02:05 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab1j8fcw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 15:02:05 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179Iv0jb012346;
        Mon, 9 Aug 2021 19:02:03 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 3a9htb3wcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 19:02:03 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179J22eO42140026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 19:02:02 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31580112066;
        Mon,  9 Aug 2021 19:02:02 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBAD911206B;
        Mon,  9 Aug 2021 19:02:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.2.130.16])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  9 Aug 2021 19:02:01 +0000 (GMT)
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
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Allow access to confidential computing secret area in SEV guests
Date:   Mon,  9 Aug 2021 19:01:54 +0000
Message-Id: <20210809190157.279332-1-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2_POTc4eDedfA_kbZXChZhodWJSIokXz
X-Proofpoint-ORIG-GUID: B8rkwtUXUfE5w291her3XjbeAw70QWrD
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_07:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090131
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
securityfs using a new sev_secret kernel module.

The first patch in efi/libstub copies the secret area from the EFI
memory to specially allocated memory; the second patch reserves that
memory block; and the third patch introduces the new sev_secret module
that exposes the content of the secret entries as securityfs files, and
allows clearing out secrets with a file unlink interface.

As a usage example, consider a guest performing computations on
encrypted files.  The Guest Owner provides the decryption key (= secret)
using the secret injection mechanism.  The guest application reads the
secret from the sev_secret filesystem and proceeds to decrypt the files
into memory and then performs the needed computations on the content.

In this example, the host can't read the files from the disk image
because they are encrypted.  Host can't read the decryption key because
it is passed using the secret injection mechanism (= secure channel).
Host can't read the decrypted content from memory because it's a
confidential (memory-encrypted) guest.

This has been tested with AMD SEV guests, but the kernel side of
handling the secret area has no SEV-specific dependencies, and therefore
might be usable (perhaps with minor changes) for any confidential
computing hardware that can publish the secret area via the standard EFI
config table entry.

Here is a simple example for usage of the sev_secret module in a guest
to which a secret are with 4 secrets was injected during launch:

# modprobe sev_secret
# ls -la /sys/kernel/security/coco/sev_secret
total 0
drwxr-xr-x 2 root root 0 Jun 28 11:54 .
drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
-r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
-r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
-r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
-r--r----- 1 root root 0 Jun 28 11:54 e6f5a162-d67f-4750-a67c-5d065f2a9910

# xxd /sys/kernel/security/coco/sev_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
00000000: 7468 6573 652d 6172 652d 7468 652d 6b61  these-are-the-ka
00000010: 7461 2d73 6563 7265 7473 0001 0203 0405  ta-secrets......
00000020: 0607                                     ..

# rm /sys/kernel/security/coco/sev_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910

# ls -la /sys/kernel/security/coco/sev_secret
total 0
drwxr-xr-x 2 root root 0 Jun 28 11:55 .
drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
-r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
-r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
-r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2


Previously sent as an RFC series [2].

[1] https://github.com/tianocore/edk2/commit/01726b6d23d4
[2] https://lore.kernel.org/linux-coco/20210628183431.953934-1-dovmurik@linux.ibm.com/


Dov Murik (3):
  efi/libstub: Copy confidential computing secret area
  efi: Reserve confidential computing secret area
  virt: Add sev_secret module to expose confidential computing secrets

 arch/x86/platform/efi/efi.c               |   1 +
 drivers/firmware/efi/Makefile             |   2 +-
 drivers/firmware/efi/coco.c               |  41 +++
 drivers/firmware/efi/efi.c                |   3 +
 drivers/firmware/efi/libstub/Makefile     |   2 +-
 drivers/firmware/efi/libstub/coco.c       |  68 +++++
 drivers/firmware/efi/libstub/efi-stub.c   |   2 +
 drivers/firmware/efi/libstub/efistub.h    |   2 +
 drivers/firmware/efi/libstub/x86-stub.c   |   2 +
 drivers/virt/Kconfig                      |   3 +
 drivers/virt/Makefile                     |   1 +
 drivers/virt/coco/sev_secret/Kconfig      |  11 +
 drivers/virt/coco/sev_secret/Makefile     |   2 +
 drivers/virt/coco/sev_secret/sev_secret.c | 313 ++++++++++++++++++++++
 include/linux/efi.h                       |   9 +
 15 files changed, 460 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/efi/coco.c
 create mode 100644 drivers/firmware/efi/libstub/coco.c
 create mode 100644 drivers/virt/coco/sev_secret/Kconfig
 create mode 100644 drivers/virt/coco/sev_secret/Makefile
 create mode 100644 drivers/virt/coco/sev_secret/sev_secret.c


base-commit: 36a21d51725af2ce0700c6ebcb6b9594aac658a6
-- 
2.25.1

