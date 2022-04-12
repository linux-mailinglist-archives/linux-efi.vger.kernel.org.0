Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9059F4FEAF0
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 01:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiDLXfY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Apr 2022 19:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiDLXcG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Apr 2022 19:32:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582ED92330;
        Tue, 12 Apr 2022 15:18:39 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CIbSme002614;
        Tue, 12 Apr 2022 21:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=2oSiORtt5a9QwiuhXxdU0VsQ+I8NwUBoWpk6NI0GnpI=;
 b=TyaimdxyeZELeLBRiqK5XS+dfaaRi4yOTbP0Nl7Hz0dkxc4SkcE1vFJ0UdZmDbCEhzkE
 /9rSoI4wiFrYOxdXVG2Wuc+lePx+qtIzc1W6vk4e2q7g+taswnlO9Tjyvb18VaZzIskl
 sfFyKdrMWpINR1uSaQ6qW6Q2sGdMb2qE13wluV80cVv8tZn+mW5Tl9eqjWL5ZaF+KYgG
 04vuMB97N34+fNMV17ODjZaxS4pp6jbW/HRXA+vt4mkaHQkdWmJ4FyGPaFepS/vaf1Ta
 Z9RWhqZ0YT7uLakcBugapETlpI9/OUmtqIJgk9VHFuXSelwCIr8E75mVk4LxBb38kdeX wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fdc9ppsjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 21:21:47 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23CLFZC5030137;
        Tue, 12 Apr 2022 21:21:46 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fdc9ppsje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 21:21:46 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23CLDKGr020483;
        Tue, 12 Apr 2022 21:21:45 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01dal.us.ibm.com with ESMTP id 3fb1s9huky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 21:21:45 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23CLLhti32440750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 21:21:43 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD10A136059;
        Tue, 12 Apr 2022 21:21:43 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8BF0136053;
        Tue, 12 Apr 2022 21:21:41 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 12 Apr 2022 21:21:41 +0000 (GMT)
From:   Dov Murik <dovmurik@linux.ibm.com>
To:     linux-efi@vger.kernel.org
Cc:     Dov Murik <dovmurik@linux.ibm.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Borislav Petkov <bp@suse.de>,
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
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 4/4] docs: security: Add secrets/coco documentation
Date:   Tue, 12 Apr 2022 21:21:27 +0000
Message-Id: <20220412212127.154182-5-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412212127.154182-1-dovmurik@linux.ibm.com>
References: <20220412212127.154182-1-dovmurik@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: All8PHM9a5wLlvG52Y76Y60pFu9FqBbv
X-Proofpoint-GUID: iHhYFuIIKZ8o6CQeGJvxz-qn-H1xfyuF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_06,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1015 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add documentation for the efi_secret module which allows access
to Confidential Computing injected secrets.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Documentation/security/index.rst         |   1 +
 Documentation/security/secrets/coco.rst  | 103 ++++++++++++++++++++
 Documentation/security/secrets/index.rst |   9 ++
 3 files changed, 113 insertions(+)

diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 16335de04e8c..6ed8d2fa6f9e 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -17,3 +17,4 @@ Security Documentation
    tpm/index
    digsig
    landlock
+   secrets/index
diff --git a/Documentation/security/secrets/coco.rst b/Documentation/security/secrets/coco.rst
new file mode 100644
index 000000000000..262e7abb1b24
--- /dev/null
+++ b/Documentation/security/secrets/coco.rst
@@ -0,0 +1,103 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+Confidential Computing secrets
+==============================
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
+secrets to userspace applications via securityfs.  The details of the
+efi_secret filesystem interface are in [secrets-coco-abi]_.
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
+	# ls -la /sys/kernel/security/secrets/coco
+	total 0
+	drwxr-xr-x 2 root root 0 Jun 28 11:54 .
+	drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
+	-r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
+	-r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
+	-r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
+	-r--r----- 1 root root 0 Jun 28 11:54 e6f5a162-d67f-4750-a67c-5d065f2a9910
+
+	# hd /sys/kernel/security/secrets/coco/e6f5a162-d67f-4750-a67c-5d065f2a9910
+	00000000  74 68 65 73 65 2d 61 72  65 2d 74 68 65 2d 6b 61  |these-are-the-ka|
+	00000010  74 61 2d 73 65 63 72 65  74 73 00 01 02 03 04 05  |ta-secrets......|
+	00000020  06 07                                             |..|
+	00000022
+
+	# rm /sys/kernel/security/secrets/coco/e6f5a162-d67f-4750-a67c-5d065f2a9910
+
+	# ls -la /sys/kernel/security/secrets/coco
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
+.. [secrets-coco-abi] Documentation/ABI/testing/securityfs-secrets-coco
+.. [sev-api-spec] https://www.amd.com/system/files/TechDocs/55766_SEV-KM_API_Specification.pdf
diff --git a/Documentation/security/secrets/index.rst b/Documentation/security/secrets/index.rst
new file mode 100644
index 000000000000..ced34e9c43bd
--- /dev/null
+++ b/Documentation/security/secrets/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Secrets documentation
+=====================
+
+.. toctree::
+
+   coco
-- 
2.25.1

