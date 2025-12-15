Return-Path: <linux-efi+bounces-5860-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3871BCC0340
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A13B23002EBD
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675DF32E749;
	Mon, 15 Dec 2025 23:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aY0CzUJK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2E332ABC6;
	Mon, 15 Dec 2025 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842111; cv=none; b=fwyRiOp5aW4nlmYqecY8cKDXmKIQN5eK4l4fGM+uk3RQDbYIfgsMcQ3Ja4W/8O3Jv3iqH90fzFS57IGjai0ebmSrcmzjGQPB3YiMbtRaQ9MiX6lwI0DW4Yvej85zLhe5Yz67t3EEFtShi8sVEMy3sUl+Iy90QP/Nq+mBSmSX8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842111; c=relaxed/simple;
	bh=YdxlIlRhjRfMZWkWm8NU33dQsL0per34cJGBi4ge7a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7/PdXSDxnJYTd4ErFS856UKMtu8XN6KlY67oSaPBa9STi1nL4PJIY7UsAWZqGgWChc+KTa13QRo+qn5BLXWe2nQBaxskvIRdqlr6q9X7tIqsmJxBruGe895MX74G/wMbmh6zDudfzZbEcePS4c5yx4s+YKgo1uA4Ja0DS9IEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aY0CzUJK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCYn22721828;
	Mon, 15 Dec 2025 23:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=meX1M
	+kdakNqcbpqJnT6mnAgHOX0RxoLtLovWFxT6Kc=; b=aY0CzUJKs4zGjYo+jhkY3
	tCHovohKEBhu3hG6NjUrle4AUblQAyvksFrnrMBTLVlFtsMLmsAW8ySGpR1sD+tX
	0iqK+tAjwrujUxmkZqdS/Gkxds0hybLH3djuOEncz9qM+QyvH9KsVLM3fsXGmPwx
	bxdksgGTnXiEu/dBpeXpUoGuAeoVy/G3SMcHY1qtLWAeUVIPEzzkgqgi+pYYasxm
	0BGwlbCG6WMz2XjmbmntxJsBBH4t8mYvz0S1N2rkF8/WB4IvuPJG9IxLGh5Adjdp
	OYdZ0Ef4eUjJqqB0BgqkjXiOi3d+Ug5Q7Ug1lqNdk7/CG1esY5Yjw3VrC6fli/7m
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xqxu429-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:41:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFMuunX022539;
	Mon, 15 Dec 2025 23:41:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkjkcev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:03 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNf2D4011005;
	Mon, 15 Dec 2025 23:41:02 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkjkce5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:02 +0000
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
Subject: [PATCH v15 18/28] x86: Add early SHA-256 support for Secure Launch early measurements
Date: Mon, 15 Dec 2025 15:33:06 -0800
Message-ID: <20251215233316.1076248-19-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251215233316.1076248-1-ross.philipson@oracle.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_05,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfXwQonRUQ6g85E
 opSINGdG70XSHXdq8qk8TtGSRM7xh9JRf2uNKHs7qrgUNjC/wLqGIupxRiO/Kb/Im6LX5BZ2b8J
 4ZCOBJGMIRaBVIFj2SCyc5s8siTKOi7qLgy2+wSW8Gh5eqZVWe7TskAv3rmPB9xpClwoXcK6eS4
 9DpkbDouG75fnqxQ4gnilUs+OgSPG61bto2LDtgwHjnaSNrn+xd7W6SN6ilu/eEnihO4Q7Zj7Oe
 V4v6JGiAlDzX2rAi3kNzAuHHnWmyzNiAW8xYZYQ6+uMbFZBJEuvGOzXg2T0tFqAUw/H5kD+EKC9
 pfjySnoTEtm6UosMb1t2lJQJqFRL6r0CReZ7ZFFMGFKGr4nOvgJC2I0Gv6RYSuV9c20MBv/mcrQ
 xIAwF5lZp336jQMyxK7Cek2PfZJcawsFHntKO2Kvjk9JYjoI13A=
X-Proofpoint-GUID: 48lxa0XfujKRu7g25Cxaq_7v_0Q2em1O
X-Proofpoint-ORIG-GUID: 48lxa0XfujKRu7g25Cxaq_7v_0Q2em1O
X-Authority-Analysis: v=2.4 cv=BYDVE7t2 c=1 sm=1 tr=0 ts=69409c91 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=UN5060LkAAAA:8 a=yPCof4ZbAAAA:8
 a=E3ObfN1v1ytJGMqOQf8A:9 a=E6eXv-vVeS7VqOnxGRGn:22 cc=ntf awl=host:13654

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The SHA-256 algorithm is necessary to measure configuration information into
the TPM as early as possible before using the values. This implementation
uses the established approach of #including the SHA-256 libraries directly in
the code since the compressed kernel is not uncompressed at this point.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/boot/compressed/Makefile | 1 +
 arch/x86/boot/compressed/sha256.c | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 arch/x86/boot/compressed/sha256.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 69592146ced7..0ea8a11ec271 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -113,6 +113,7 @@ $(obj)/sbat.o: $(CONFIG_EFI_SBAT_FILE)
 endif
 
 slaunch-objs += $(obj)/sha1.o
+slaunch-objs += $(obj)/sha256.o
 
 vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(slaunch-objs)
 
diff --git a/arch/x86/boot/compressed/sha256.c b/arch/x86/boot/compressed/sha256.c
new file mode 100644
index 000000000000..7795926e7e1d
--- /dev/null
+++ b/arch/x86/boot/compressed/sha256.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/crypto/sha256.c"
-- 
2.43.7


