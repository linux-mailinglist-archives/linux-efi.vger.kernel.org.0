Return-Path: <linux-efi+bounces-5871-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 184F2CC0455
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EED7302DB77
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E19337BA2;
	Mon, 15 Dec 2025 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AMjcoxVJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349CE336ED1;
	Mon, 15 Dec 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842136; cv=none; b=jwzOeIfZbgkdMvwlNpwLNULn/HSpkLzyNAfyhKnI4A7j2kyGfyHO4nQJKK6MoWiCAMOvA37sUBZB3HkoCw1+6r1p1SsD9cLtAeKAX7LkKcWQbQAXAIJZ9NFPXqWHBRl4r9+lNm7ayBLCd2MreGQv5ZdaOJtfJNvMqXWAC2xkcoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842136; c=relaxed/simple;
	bh=kwc6IcMM5wvToqeTkhGDg8JNjHNDJfY+2AYJk3jCqIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8VDBpU47YU30K3FDO9XLfRIOBidiXfHCfYAEHppDn5+zdQt97AvKC8cdNrmhmMr98c1sg0ulu/oHfBDuKwc9GQDgwCsBHzSvxPSbDCAxey4SfzaRzSRHTlJEaQuB5QNfEFemryhSPgTUsjkTGoqJy3WPBuE1Gn5OahtXFi7Mkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AMjcoxVJ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCIiZ2859372;
	Mon, 15 Dec 2025 23:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=OMFly
	L/wiM/BIWX7Ku8AARzuRyfqmOM+RjpJD/TJIRw=; b=AMjcoxVJv8Y0S9W7B9fPS
	KWV5ca5Rn6EedrjOlW57rOYfBEFAnvwmLssmC3NkpE8IE2jqtHk8Urp/Szr4VnH2
	Baqm+btfhPD19MblIgAQWRgzqBYvrA+ZQ4VwfpB5i6FKLXjyFLo8IB0D9/Rg2ydk
	8s31CGPXsr1m9mnBJQ2sdPrqWJnu2HWFAGFUouTdUXWR3GZPxkt+ZMPd102ary5x
	SaSN7l+3R+q0Jfr4/quU8gyZomAoKXke4b5sigQ395QHAd3vSnL5yxd8uQ9ogTKG
	UoDjI0mUqPtWTBQqS5HqqlJmCd30M+HULwA7vH66h9QNDfkVsoTUrRFW5V1iHs/2
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0yrujyxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:41:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFLJnF0022770;
	Mon, 15 Dec 2025 23:41:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkjkcdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:00 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNeu3P010824;
	Mon, 15 Dec 2025 23:40:59 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkjkcdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:59 +0000
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
Subject: [PATCH v15 17/28] x86: Add early SHA-1 support for Secure Launch early measurements
Date: Mon, 15 Dec 2025 15:33:05 -0800
Message-ID: <20251215233316.1076248-18-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfX+7AlQAOepJ2V
 gekVgXA0s3kuhFlnv0tSJS+CdZJtQV6M46lT8tVGENHdYEHtk1JQZxUa935lMmy1c5vgawTTN8X
 YrpwSILLQnEOAmwwp9Z2br0EcF/4t3PTkPtJfgINmxG7NQZq/WvDkctpY47A7Xf6ZuGD7XzbE2U
 gR1D8759RqnS5OodlRlPcZNwSk7n208fxrUdEaFrylhzfaKf8LuQLgcb5hMGMdMHzvvPrhLx00p
 ehPjsYHtur4GvNbhV5wv2FZ/co39pY2NU92IFzqj4/bCqBIAFmnJyOSASS9aoMwzruYs6S7obCW
 Xk7FkQI6vcPlajs1o4dtzIwdF6v9bvntzpOopEPaKrLr84X25jp1ajxpXg9u7cbO/eH/PM0LW5p
 T/qvnmnGnG/Zx2by8W362KtP9LrkKULr0bbZotaX/eIWZLVfNmw=
X-Authority-Analysis: v=2.4 cv=TL9Iilla c=1 sm=1 tr=0 ts=69409c8d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=UN5060LkAAAA:8 a=yPCof4ZbAAAA:8
 a=FMA3igD34ZM5tMG_usoA:9 a=E6eXv-vVeS7VqOnxGRGn:22 cc=ntf awl=host:13654
X-Proofpoint-GUID: quJzcWfx7Dd30r4aywsmOfxCJIXRy10y
X-Proofpoint-ORIG-GUID: quJzcWfx7Dd30r4aywsmOfxCJIXRy10y

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

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/boot/compressed/Makefile | 4 ++++
 arch/x86/boot/compressed/sha1.c   | 7 +++++++
 2 files changed, 11 insertions(+)
 create mode 100644 arch/x86/boot/compressed/sha1.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 74657589264d..69592146ced7 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -112,6 +112,10 @@ ifdef CONFIG_EFI_SBAT
 $(obj)/sbat.o: $(CONFIG_EFI_SBAT_FILE)
 endif
 
+slaunch-objs += $(obj)/sha1.o
+
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(slaunch-objs)
+
 $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
 
diff --git a/arch/x86/boot/compressed/sha1.c b/arch/x86/boot/compressed/sha1.c
new file mode 100644
index 000000000000..dd1b4cf5caf5
--- /dev/null
+++ b/arch/x86/boot/compressed/sha1.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Apertus Solutions, LLC.
+ */
+
+#undef CONFIG_CRYPTO_LIB_SHA1_ARCH
+#include "../../../../lib/crypto/sha1.c"
-- 
2.43.7


