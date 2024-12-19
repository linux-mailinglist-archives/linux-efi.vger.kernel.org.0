Return-Path: <linux-efi+bounces-2407-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B69C39F8508
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2024 20:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82CDE7A1FBF
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2024 19:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5221F190A;
	Thu, 19 Dec 2024 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L1wqa4Jn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497F41C1F05;
	Thu, 19 Dec 2024 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638178; cv=none; b=HfeasC3a/uhocZ4fwE9cUwULyhNLTS8d5vMqD0gSZyPnVJGJSYhxZ9HCvisVBnADgHZun+FDytpAtsc/ta0xs7o36MGEMFpip/bLCQMYHsJqeL8JfaLDE5OFYCDyke/vEiId2mStvPeZTgfObKqdR0iyPApG15JEkpiGkhGUzo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638178; c=relaxed/simple;
	bh=hyNr8bEfvdwWLmEWWV6tzD5BV5iNwJQpYwExEZqpVLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JppTxyTXWjUCQZf3vjRgX6Fms9n63DBtDfZlKLQy170UnGh4RHYI8H1uaxWZX1ekwKVef6sLsk/8kbDZBXBArbPCJGK135X3nuECtmcmFc6dhQIGV/D2n98JaSu+8RfFCCOzmr0RwnMc0sDNkV0O37QTXk7TbDP1EXxyIfuCQJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L1wqa4Jn; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJIMiOT031417;
	Thu, 19 Dec 2024 19:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=4tXZ+
	0Nsfxg0v9dxCmt558jUx/Sa3ysdkwfYdW/6Hgo=; b=L1wqa4Jnk7ai8pYk2HQyk
	BZWVyoMKzSmgfz4UyEJDyA9zn6hT6rk/PULqaFs13Pb7gyodxCHANGKA39BVVGGt
	2p2kNMpilhQeBEGZOM4M8aReLYMS2Qir09+K7psQH4OcmDonAMn3ivccLoW0tkkd
	cM99IbrTZgRSP7ANbtVGBzRKEiX7ahiDFAoWzF12ZZMlLeqGjaYgVyvTXZ/zQei8
	HkBROPekn2M6lo5g4UJcX3VWYYi8eP7mOciQMt6Q1slA1u7jqY6p1xBPfbignEHq
	honUd/T62vCakhHTiC+UP/Y7DxrjBs4AxrlqAeqlmxviTXM8F2Z4GtMzefPHla/8
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj5hkb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 19:54:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJI0Ntx000589;
	Thu, 19 Dec 2024 19:54:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fbs35n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Dec 2024 19:54:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BJJsjIT004050;
	Thu, 19 Dec 2024 19:54:45 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fbs33j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Dec 2024 19:54:45 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v12 05/19] x86: Add early SHA-1 support for Secure Launch early measurements
Date: Thu, 19 Dec 2024 11:42:02 -0800
Message-Id: <20241219194216.152839-6-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241219194216.152839-1-ross.philipson@oracle.com>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-19_09,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412190158
X-Proofpoint-GUID: 3yK52mBWn8F--Hd72BJAKcODxbAYm-bE
X-Proofpoint-ORIG-GUID: 3yK52mBWn8F--Hd72BJAKcODxbAYm-bE

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

Secure Launch is written to be compliant with the Intel TXT Measured Launch
Developer's Guide. The MLE Guide dictates that the system can be configured to
use both the SHA-1 and SHA-2 hashing algorithms.

Regardless of the preference towards SHA-2, if the firmware elected to start
with the SHA-1 and SHA-2 banks active and the dynamic launch was configured to
include SHA-1, Secure Launch is obligated to record measurements for all
algorithms requested in the launch configuration.

The user environment or the integrity management does not desire to use SHA-1,
it is free to just ignore the SHA-1 bank in any integrity operation with the
TPM. If there is a larger concern about the SHA-1 bank being active, it is free
to deliberately cap the SHA-1 PCRs, recording the event in the D-RTM log.

The SHA-1 code here has its origins in the code from the main kernel:

commit c4d5b9f ("crypto: sha1 - implement base layer for SHA-1")

A modified version of this code was introduced to the lib/crypto/sha1.c to bring
it in line with the SHA-256 code and allow it to be pulled into the setup kernel
in the same manner as SHA-256 is.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/boot/compressed/Makefile |  2 +
 arch/x86/boot/compressed/sha1.c   |  6 +++
 include/crypto/sha1.h             |  1 +
 lib/crypto/sha1.c                 | 81 +++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+)
 create mode 100644 arch/x86/boot/compressed/sha1.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f2051644de94..7eb03afb841b 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -107,6 +107,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
 vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/sha1.o
+
 $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
 
diff --git a/arch/x86/boot/compressed/sha1.c b/arch/x86/boot/compressed/sha1.c
new file mode 100644
index 000000000000..d754489941ac
--- /dev/null
+++ b/arch/x86/boot/compressed/sha1.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Apertus Solutions, LLC.
+ */
+
+#include "../../../../lib/crypto/sha1.c"
diff --git a/include/crypto/sha1.h b/include/crypto/sha1.h
index 044ecea60ac8..d715dd5332e1 100644
--- a/include/crypto/sha1.h
+++ b/include/crypto/sha1.h
@@ -42,5 +42,6 @@ extern int crypto_sha1_finup(struct shash_desc *desc, const u8 *data,
 #define SHA1_WORKSPACE_WORDS	16
 void sha1_init(__u32 *buf);
 void sha1_transform(__u32 *digest, const char *data, __u32 *W);
+void sha1(const u8 *data, unsigned int len, u8 *out);
 
 #endif /* _CRYPTO_SHA1_H */
diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
index ebb60519ae93..0bd32df31743 100644
--- a/lib/crypto/sha1.c
+++ b/lib/crypto/sha1.c
@@ -137,5 +137,86 @@ void sha1_init(__u32 *buf)
 }
 EXPORT_SYMBOL(sha1_init);
 
+static void __sha1_transform(u32 *digest, const char *data)
+{
+	u32 ws[SHA1_WORKSPACE_WORDS];
+
+	sha1_transform(digest, data, ws);
+
+	/* Ensure local data for generating digest is cleared in all cases */
+	memzero_explicit(ws, sizeof(ws));
+}
+
+static void sha1_update(struct sha1_state *sctx, const u8 *data, unsigned int len)
+{
+	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
+	int blocks;
+
+	sctx->count += len;
+
+	if (unlikely((partial + len) < SHA1_BLOCK_SIZE))
+		goto out;
+
+	if (partial) {
+		int p = SHA1_BLOCK_SIZE - partial;
+
+		memcpy(sctx->buffer + partial, data, p);
+		data += p;
+		len -= p;
+
+		__sha1_transform(sctx->state, sctx->buffer);
+	}
+
+	blocks = len / SHA1_BLOCK_SIZE;
+	len %= SHA1_BLOCK_SIZE;
+
+	if (blocks) {
+		while (blocks--) {
+			__sha1_transform(sctx->state, data);
+			data += SHA1_BLOCK_SIZE;
+		}
+	}
+	partial = 0;
+
+out:
+	memcpy(sctx->buffer + partial, data, len);
+}
+
+static void sha1_final(struct sha1_state *sctx, u8 *out)
+{
+	const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
+	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
+	__be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
+	__be32 *digest = (__be32 *)out;
+	int i;
+
+	sctx->buffer[partial++] = 0x80;
+	if (partial > bit_offset) {
+		memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
+		partial = 0;
+
+		__sha1_transform(sctx->state, sctx->buffer);
+	}
+
+	memset(sctx->buffer + partial, 0x0, bit_offset - partial);
+	*bits = cpu_to_be64(sctx->count << 3);
+	__sha1_transform(sctx->state, sctx->buffer);
+
+	for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
+		put_unaligned_be32(sctx->state[i], digest++);
+
+	*sctx = (struct sha1_state){};
+}
+
+void sha1(const u8 *data, unsigned int len, u8 *out)
+{
+	struct sha1_state sctx = {0};
+
+	sha1_init(sctx.state);
+	sha1_update(&sctx, data, len);
+	sha1_final(&sctx, out);
+}
+EXPORT_SYMBOL(sha1);
+
 MODULE_DESCRIPTION("SHA-1 Algorithm");
 MODULE_LICENSE("GPL");
-- 
2.39.3


