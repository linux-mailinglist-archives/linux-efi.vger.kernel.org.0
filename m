Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0D346140E
	for <lists+linux-efi@lfdr.de>; Mon, 29 Nov 2021 12:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242946AbhK2Lsr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Nov 2021 06:48:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233691AbhK2Lqq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Nov 2021 06:46:46 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATBfOXO024260;
        Mon, 29 Nov 2021 11:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=Wm8o20KrrN+7621cVhyG+BDWkNngf+zcQkYMNpcNVs4=;
 b=fYGcx0+jln6kRjvCdTP7gy6AKGRfjUOuzVwfwfn7NLUzPb9RYiDUekx6fAMAJTm+Y01j
 shsScP+wCb+PHyexnbjxJ0Bs2ZI0MB5ZKwvZsEsdWpUa5umQFJEOc/i87Qrr7ZcH5CDn
 /5nj2qqE67KN4hU3gC1JR0/vrMsY5C6gsCBGHxtGKuodRRXZbchPF3PtDi/y3YHPIyY4
 gXTSTHBRY6riIyxfpekrvBeOuGwEOLOM/+wUVq7NZSQZ5shb2Dw90Nk8ZjX2+hYh0iuN
 t26SBshgtyW57VkgCj3a7kTPhNyEf5m0q9uHokMb0jQ/QAMdJCbmluxALrJxtMdC2+ay nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmx76r0pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 11:43:06 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATBh6E3002432;
        Mon, 29 Nov 2021 11:43:06 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmx76r0nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 11:43:06 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATBWac4019399;
        Mon, 29 Nov 2021 11:43:04 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 3ckcaa7dr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 11:43:04 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATBh1wl46268858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 11:43:01 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8184D124072;
        Mon, 29 Nov 2021 11:43:01 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B39D12405C;
        Mon, 29 Nov 2021 11:43:01 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 11:43:01 +0000 (GMT)
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
Subject: [PATCH v6 5/5] docs: security: Add coco/efi_secret documentation
Date:   Mon, 29 Nov 2021 11:42:51 +0000
Message-Id: <20211129114251.3741721-6-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
References: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F8TMeZFkqI81PMr8INtpp5VBZsmO1Kk3
X-Proofpoint-GUID: wwdoCwMBofNXoj0FtHZ-DrdpRRQwJM81
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_07,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290058
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add documentation for the efi_secret module which allows access
to Confidential Computing injected secrets.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
---
 Documentation/security/coco/efi_secret.rst | 102 +++++++++++++++++++++
 Documentation/security/coco/index.rst      |   9 ++
 Documentation/security/index.rst           |   1 +
 3 files changed, 112 insertions(+)
 create mode 100644 Documentation/security/coco/efi_secret.rst
 create mode 100644 Documentation/security/coco/index.rst

diff --git a/Documentation/security/coco/efi_secret.rst b/Documentation/security/coco/efi_secret.rst
new file mode 100644
index 000000000000..fa74899b68a3
--- /dev/null
+++ b/Documentation/security/coco/efi_secret.rst
@@ -0,0 +1,102 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+EFI secret
+==========
+
+This document describes how Confidential Computing secret injection is handled
+from the firmware to the operating system, in the EFI driver and the efi_secret
+kernel module.
+
+
+Introduction
+============
+
+Confidential Computing (coco) hardware such as AMD SEV (Secure Encrypted
+Virtualization) allows guest owners to inject secrets into the VMs
+memory without the host/hypervisor being able to read them.  In SEV,
+secret injection is performed early in the VM launch process, before the
+guest starts running.
+
+The efi_secret kernel module allows userspace applications to access these
+secrets via securityfs.
+
+
+Secret data flow
+================
+
+The guest firmware may reserve a designated memory area for secret injection,
+and publish its location (base GPA and length) in the EFI configuration table
+under a ``LINUX_EFI_COCO_SECRET_AREA_GUID`` entry
+(``adf956ad-e98c-484c-ae11-b51c7d336447``).  This memory area should be marked
+by the firmware as ``EFI_RESERVED_TYPE``, and therefore the kernel should not
+be use it for its own purposes.
+
+During the VM's launch, the virtual machine manager may inject a secret to that
+area.  In AMD SEV and SEV-ES this is performed using the
+``KVM_SEV_LAUNCH_SECRET`` command (see [sev]_).  The strucutre of the injected
+Guest Owner secret data should be a GUIDed table of secret values; the binary
+format is described in ``drivers/virt/coco/efi_secret/efi_secret.c`` under
+"Structure of the EFI secret area".
+
+On kernel start, the kernel's EFI driver saves the location of the secret area
+(taken from the EFI configuration table) in the ``efi.coco_secret`` field.
+Later it checks if the secret area is populated: it maps the area and checks
+whether its content begins with ``EFI_SECRET_TABLE_HEADER_GUID``
+(``1e74f542-71dd-4d66-963e-ef4287ff173b``).  If the secret area is populated,
+the EFI driver will autoload the efi_secret kernel module, which exposes the
+secretes to userspace applications via securityfs.  The details of the
+efi_secret filesystem interface are in [efi-secret-abi]_.
+
+
+Application usage example
+=========================
+
+Consider a guest performing computations on encrypted files.  The Guest Owner
+provides the decryption key (= secret) using the secret injection mechanism.
+The guest application reads the secret from the efi_secret filesystem and
+proceeds to decrypt the files into memory and then performs the needed
+computations on the content.
+
+In this example, the host can't read the files from the disk image
+because they are encrypted.  Host can't read the decryption key because
+it is passed using the secret injection mechanism (= secure channel).
+Host can't read the decrypted content from memory because it's a
+confidential (memory-encrypted) guest.
+
+Here is a simple example for usage of the efi_secret module in a guest
+to which an EFI secret area with 4 secrets was injected during launch::
+
+	# ls -la /sys/kernel/security/coco/efi_secret
+	total 0
+	drwxr-xr-x 2 root root 0 Jun 28 11:54 .
+	drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
+	-r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
+	-r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
+	-r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
+	-r--r----- 1 root root 0 Jun 28 11:54 e6f5a162-d67f-4750-a67c-5d065f2a9910
+
+	# xxd /sys/kernel/security/coco/efi_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
+	00000000: 7468 6573 652d 6172 652d 7468 652d 6b61  these-are-the-ka
+	00000010: 7461 2d73 6563 7265 7473 0001 0203 0405  ta-secrets......
+	00000020: 0607                                     ..
+
+	# rm /sys/kernel/security/coco/efi_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
+
+	# ls -la /sys/kernel/security/coco/efi_secret
+	total 0
+	drwxr-xr-x 2 root root 0 Jun 28 11:55 .
+	drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
+	-r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
+	-r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
+	-r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
+
+
+References
+==========
+
+See [sev-api-spec]_ for more info regarding SEV ``LAUNCH_SECRET`` operation.
+
+.. [sev] Documentation/virt/kvm/amd-memory-encryption.rst
+.. [efi-secret-abi] Documentation/ABI/testing/securityfs-coco-efi_secret
+.. [sev-api-spec] https://www.amd.com/system/files/TechDocs/55766_SEV-KM_API_Specification.pdf
diff --git a/Documentation/security/coco/index.rst b/Documentation/security/coco/index.rst
new file mode 100644
index 000000000000..56b803d4b33e
--- /dev/null
+++ b/Documentation/security/coco/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================
+Confidential Computing documentation
+====================================
+
+.. toctree::
+
+   efi_secret
diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 16335de04e8c..3662e93a3eba 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -17,3 +17,4 @@ Security Documentation
    tpm/index
    digsig
    landlock
+   coco/index
-- 
2.25.1

