Return-Path: <linux-efi+bounces-5868-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0E8CC0401
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32FA7303D9EB
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC48336EDC;
	Mon, 15 Dec 2025 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AD8a63yi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724083358AF;
	Mon, 15 Dec 2025 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842135; cv=none; b=A6ChsfGr0UB8FExRdRgB1GZFysEbIQ1dEOvCjBBPA4ZQU+wrd57VN9n2ieIxKS4SjN9/y36HJK9ZOi+pivWIkunzmeQO/kUbIFc5xL+oOJu8BW1+787lI4sXBfrzEISr5gmqT+bNY8Bfk2AF9ia7Ngs2ckZ0+7hrt1Qo7a3kzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842135; c=relaxed/simple;
	bh=VY7YhXBIDRfYrDEPf2BYJiLRxW7W7DgksGnXWSWz4fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUV73C/AjNV1NZ2ddKmMODR3oaUVjcFsTOHl9KrEXkMU4ls6TG1lnQC5IjwwMEPmARDKVgkA4yb0kxtfnycVCzxnh2lq2oSOpa+CeuztCusPL3G19eZXX4fM7J2a0GKBOGg2TqBBQ5Ri18u1pv+Zd6TcGjRQ+qRhqcpaQ8Rvt2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AD8a63yi; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJC4bX2858947;
	Mon, 15 Dec 2025 23:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=RTErE
	W60NVNbbEbJqdIXfQ+l8bdIG1WUJgNFh8cldIU=; b=AD8a63yiuniu4GEPJ4LMB
	jOklHlupPgp/GNRmC69smC7cJUDWtQoqI5NaiEEHHVLo0RCjO5HnMQcTOZ36a9Ct
	yaUIlMa0oXUJkLf7z3jx4Vtog50JBGdPM4G7dQQRfVQHbgiIAFAi6R+fk6s2oZUf
	Ykz+U22XBFyNLJGCOJ7gTn35ei1CMf5hVKA/wRTOWjKmtm6o3ybTkz+hOWdDmHXO
	dYfwKnJwY/oyBmsX65UN1gvW5Swg2ZhSBc0VgrMLMuuBk7xyhkoz2fhrg+4VwSEf
	El/TTpSVHKNtZJ2MaCiPwZ6puRzoLTb8CdvSkn44MSz6mY2Pj28P/hT4YFES6ttN
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0yrujyyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:41:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFLACBB005925;
	Mon, 15 Dec 2025 23:41:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkck9y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:34 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNfXW2026610;
	Mon, 15 Dec 2025 23:41:33 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkck9xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:33 +0000
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
Subject: [PATCH v15 25/28] kexec: Secure Launch kexec SEXIT support
Date: Mon, 15 Dec 2025 15:33:13 -0800
Message-ID: <20251215233316.1076248-26-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfX46hpwxnwEmwQ
 D9/2YIhMNidoVBYB0MY2Npq5e6YvsI4qdSqITv79OdaxngvlNc6iqcvkT7iecEambj6yANyMnoc
 A5DiElvPq06E9JJOgz2kLtlh6RLnclrq2385ZGAAyMXiaZuqewKTVZUQe3F2JkhdfLxnZ+9nMDK
 4Ts5yqu8H9QtK28FbunyAVlJePva+7Oj+uuTv1DDCMIk5vX3OEtjbPKgEx+Puv3UMsCmeoAjViC
 NJ5QKTb5ZiChjATt6/Nt2fD2Lec9GU5RWKM4t24pGuA3aNB0Kx1ZLETo2l7O89AonO0/Og63h7q
 zZP8gJA5O6mMdHhWUrm2zYWN8kpbR/G/mszMGpuWP32abSPMsvxPyUJHMf9B1vGZZwk3D4ghkjU
 rQZExP6+DmKqTae2xlXj8N4csvv6db/xLNvhSh8VO3q6cHPYQZM=
X-Authority-Analysis: v=2.4 cv=TL9Iilla c=1 sm=1 tr=0 ts=69409caf b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=UN5060LkAAAA:8 a=yPCof4ZbAAAA:8
 a=uyB61-HevAl04F39IPgA:9 a=E6eXv-vVeS7VqOnxGRGn:22 cc=ntf awl=host:12109
X-Proofpoint-GUID: lJej_lW-b9ZZk6yOckhtABQaIq9nN2CK
X-Proofpoint-ORIG-GUID: lJej_lW-b9ZZk6yOckhtABQaIq9nN2CK

Prior to running the next kernel via kexec, the Secure Launch code
closes down private SMX resources and does an SEXIT. This allows the
next kernel to start normally, effectively exiting the DRTM
environment.

The function slaunch_finalize() takes a boolean argument that controls
whether a GETSEC[SEXIT] can be issued. When true, the finalize code can
completely shutdown and exit the DRTM. This allows another kernel to
start normally and in turn can re-establish another DRTM session.

In cases where the machine has not been fully shutdown (e.g. machione_shutdown()
was not called), the SEXIT step cannot be done (SEXIT will fail if other
processors are busy). In these cases SEXIT is not attempted.  This normally
occurs on power off or reboot operations where it doesn't really matter.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/slaunch.c | 80 +++++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c       |  8 ++++
 2 files changed, 88 insertions(+)

diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index 0699cbf41753..c61445c079ff 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -533,3 +533,83 @@ void __init slaunch_fixup_ap_wake_vector(void)
 
 	pr_info("TXT AP startup vector address updated\n");
 }
+
+static inline void smx_getsec_sexit(void)
+{
+	asm volatile ("getsec\n" : : "a" (SMX_X86_GETSEC_SEXIT));
+}
+
+/*
+ * Used during kexec and on reboot paths to finalize the TXT state
+ * and do an SEXIT SMX operation, exiting the DRTM and disabling SMX mode.
+ */
+void slaunch_finalize(int do_sexit)
+{
+	u64 one = TXT_REGVALUE_ONE, val;
+	void __iomem *config;
+
+	if (!slaunch_is_txt_launch())
+		return;
+
+	config = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+	if (!config) {
+		pr_emerg("TXT: SEXIT failed to ioremap TXT private registers\n");
+		return;
+	}
+
+	/* Clear secrets bit for SEXIT */
+	memcpy_toio(config + TXT_CR_CMD_NO_SECRETS, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/* Unlock memory configurations */
+	memcpy_toio(config + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/* Close the TXT private register space */
+	memcpy_toio(config + TXT_CR_CMD_CLOSE_PRIVATE, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/*
+	 * Calls to iounmap are skipped due to the system state this late in the
+	 * kexec process. Local IRQs are disabled and iounmap causes a TLB flush
+	 * which in turn causes a warning. Leaving these mappings is not an issue
+	 * since the next kernel is going to completely re-setup memory management.
+	 */
+
+	/* Map public registers and do a final read fence */
+	config = ioremap(TXT_PUB_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_emerg("TXT: SEXIT failed to ioremap TXT public registers\n");
+		return;
+	}
+
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	pr_emerg("TXT clear secrets bit and unlock memory complete.\n");
+
+	/*
+	 * Mostly finalized but the system is still in SMX mode. At this point if the
+	 * system has been quiesced, the APs are halted and the current process is
+	 * running on the BSP, a final GETSEC(SEXIT) can be done exiting DRTM/SMX mode.
+	 * This cannot be done on certain boot paths where the system has not been quiesced
+	 * (e.g. where machine_shutdown() has not been called).
+	 */
+	if (!do_sexit)
+		return;
+
+	if (smp_processor_id() != 0)
+		panic("TXT: SEXIT must be called on CPU 0\n");
+
+	/*
+	 * In case SMX mode was disabled, enable it for SEXIT. Clearing the bit
+	 * anytime during DRTM operation will not have an affect until the next
+	 * GETSEC() op is performed.
+	 */
+	cr4_set_bits(X86_CR4_SMXE);
+
+	/* Do the SEXIT SMX operation */
+	smx_getsec_sexit();
+
+	pr_info("TXT SEXIT complete.\n");
+}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index fa00b239c5d9..7d092747a0da 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -41,6 +41,7 @@
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
 #include <linux/dma-map-ops.h>
+#include <linux/slaunch.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1196,6 +1197,13 @@ int kernel_kexec(void)
 		cpu_hotplug_enable();
 		pr_notice("Starting new kernel\n");
 		machine_shutdown();
+
+		/*
+		 * If a Secure Launch is in progress and the current kernel is
+		 * running as a DRTM with TXT, finalize the Secure Launch state
+		 * and do the GETSEC(SEXIT) returning from SMX mode to do the KEXEC.
+		 */
+		slaunch_finalize(1);
 	}
 
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
-- 
2.43.7


