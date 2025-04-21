Return-Path: <linux-efi+bounces-3380-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15AFA95448
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 18:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F39E166D14
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4671E51F1;
	Mon, 21 Apr 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ND1Lz8/7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C31E834E;
	Mon, 21 Apr 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253304; cv=none; b=AVzXe8enycPuMH6BEeeX93cYDKOlQgG6MSR6IJJV7skQB84FwseFcaic/Cy8/7JUVkL8f2E32s6NK6sVtF4gfDmObdgEwz3TuEPojk64dRYaAvAgUiSrAKqEKWud3TahLkjSO22OPh6mE8GaBMizzT4bYcqaDfWnf+6Bic8NKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253304; c=relaxed/simple;
	bh=L4iHXRYv66HNnSqLCzOkKOgwJ6Utvq5/1k6BFepuGgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+xRYhykHkpNirTgaXEQHU0ywNqdOHH8z28kBM9f14iPj98YlISorzY7X3nTTLh4NsisUUklO2plFGTgqo25tROQ36Sh/SPBiTn/ggChEL5p+/puenK1OFRLwVHryAmjci/QFTkm/+xMDA98KWFj2GxCrjNupk6tQjkXAwW6Jeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ND1Lz8/7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LCAnoB010779;
	Mon, 21 Apr 2025 16:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=7kSVn
	UGRmXGnt6Hu5AW59CrGcJNVvGcYxvVfDM7JsNM=; b=ND1Lz8/75yHWD4A4o7Ies
	VS39U/NUlysaO6mx6tHxJ5ipMVEZ6NuqBkGEgFmSeI/v+YSaAUGt7+jB/oAIcaB2
	XDRaFhFHjx4GsJL04XJ0ETRAMg45thA/nSHOf/rNCTc21/L4IvVyMOsd85fIMmHj
	d4MO1QP4pS1NY/x6ozhb5lGHgA9SJQ6oioDe1nuAklVLDMEKH3qKynVzxUXCmtPE
	5O4Dm73K0GcnckEuORkL2BdgA1D8g0Lo7EBpSmzg3Btqk2mFXY8KtHcEElkwJAYX
	BmuUA8HxrkT1PH+TiFG3zcm79nCWDhPNtPA8nFWPj7atM4xD8sqz245otHmvpLOB
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46428c2uk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 16:34:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53LFlCVL010433;
	Mon, 21 Apr 2025 16:34:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464298rfk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:34:31 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53LGYUBP035253;
	Mon, 21 Apr 2025 16:34:30 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464298rfgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:34:30 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev
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
Subject: [PATCH v14 05/19] x86: Add early SHA-1 support for Secure Launch early measurements
Date: Mon, 21 Apr 2025 09:26:58 -0700
Message-Id: <20250421162712.77452-6-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250421162712.77452-1-ross.philipson@oracle.com>
References: <20250421162712.77452-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_08,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504210129
X-Proofpoint-ORIG-GUID: g_bdBBzJ4UWGX0e_US-juPaSsnp7fW4S
X-Proofpoint-GUID: g_bdBBzJ4UWGX0e_US-juPaSsnp7fW4S

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

commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")

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
index fdbce022db55..e74228f7a607 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -107,6 +107,8 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/sha1.o
+
 $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
 
diff --git a/arch/x86/boot/compressed/sha1.c b/arch/x86/boot/compressed/sha1.c
new file mode 100644
index 000000000000..f58ab7cadb46
--- /dev/null
+++ b/arch/x86/boot/compressed/sha1.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Apertus Solutions, LLC.
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


