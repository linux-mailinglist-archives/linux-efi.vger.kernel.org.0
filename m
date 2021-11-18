Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A867455A84
	for <lists+linux-efi@lfdr.de>; Thu, 18 Nov 2021 12:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343942AbhKRLhs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 06:37:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1343926AbhKRLhd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Nov 2021 06:37:33 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIAGeSG028085;
        Thu, 18 Nov 2021 11:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=bJyIG1THTivVhB2BZ9QU4NOZvj9mhtZ9mG7eBiHj4Tw=;
 b=F+K/VglwBnj6dIoNKvxJBrQDqH1vKPxw6MwKrUHltUz2ADsQrPbTF85Jnf6X03bz1h12
 8A+HLi7yYA2jzdiA5GcDbl7I5fGL+/XXuYfSz+VXR80AIWYyRw/LiKLLN5RnDjxTyK6e
 +794BsLFyez9t4x5pS9Qn47r72+myqm1Dp04aFWOJvZKMVzXy0/R94a9QZQa4qmojVgV
 B+dHUUjdnDwvqPE+azhrhjZ93kIN2EUsu6bUkYerIwK3vEerGLTS+qEnOLuEEd0KQ8vN
 S3SJH09bREx23RtHIJkqWEKQCUd8lnJDzHmB5Fa9q5vZt4Y7hxELx2cIMWxTLCuV1xXg Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cdmxc9n52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 11:34:11 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AIArIlt014968;
        Thu, 18 Nov 2021 11:34:10 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cdmxc9n4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 11:34:10 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AIBRDrS023773;
        Thu, 18 Nov 2021 11:34:09 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 3ca50cj2hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 11:34:09 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AIBY67650004236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 11:34:06 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B967AE077;
        Thu, 18 Nov 2021 11:34:06 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 100E1AE06F;
        Thu, 18 Nov 2021 11:34:06 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Nov 2021 11:34:06 +0000 (GMT)
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
Subject: [PATCH v5 4/4] docs: security: Add coco/efi_secret documentation
Date:   Thu, 18 Nov 2021 11:33:59 +0000
Message-Id: <20211118113359.642571-5-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211118113359.642571-1-dovmurik@linux.ibm.com>
References: <20211118113359.642571-1-dovmurik@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YjJ-wr7c-NLArkOHZ2vFJaxPh-Y4Anj_
X-Proofpoint-ORIG-GUID: Gyv5FU_GAGXKmmECFz_KincPtLYEmh5Q
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_05,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180067
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add documentation for the efi_secret module which allows access
to Confidential Computing injected secrets.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
---
 Documentation/security/coco/efi_secret.rst | 103 +++++++++++++++++++++
 Documentation/security/coco/index.rst      |   9 ++
 Documentation/security/index.rst           |   1 +
 3 files changed, 113 insertions(+)
 create mode 100644 Documentation/security/coco/efi_secret.rst
 create mode 100644 Documentation/security/coco/index.rst

diff --git a/Documentation/security/coco/efi_secret.rst b/Documentation/security/coco/efi_secret.rst
new file mode 100644
index 000000000000..bb7acae22e90
--- /dev/null
+++ b/Documentation/security/coco/efi_secret.rst
@@ -0,0 +1,103 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+efi_secret
+==========
+
+This document describes how Confidential Computing secret injection is handled
+from the firmware to the operating system.
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
+``KVM_SEV_LAUNCH_SECRET`` command (see [amd-mem-enc]_).  The strucutre of the
+injected Guest Owner secret data should be a GUIDed table of secret values; the
+binary format is described in ``drivers/virt/coco/efi_secret/efi_secret.c``
+under "Structure of the EFI secret area".
+
+On kernel start, the kernel's EFI driver saves the location of the secret
+memory (taken from the EFI configuration table) in the ``efi.coco_secret``
+field.
+
+When a userspace application needs to access the secrets inside the guest VM,
+it loads the efi_secret kernel module (``CONFIG_EFI_SECRET=m``) which exposes
+the secrets via securityfs.  The details of the efi_secret filesystem interface
+are in [efi-secret-abi]_.
+
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
+	# modprobe efi_secret
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
+.. [amd-mem-enc] :ref:`Documentation/virt/kvm/amd-memory-encryption <amdmemenc>`
+.. [efi-secret-abi] :ref:`Documentation/ABI/testing/securityfs-coco-efi_secret <efisecret>`
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
index 16335de04e8c..d4ef543825a7 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -17,3 +17,4 @@ Security Documentation
    tpm/index
    digsig
    landlock
+   coco
-- 
2.25.1

