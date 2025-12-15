Return-Path: <linux-efi+bounces-5876-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2901CCC03ED
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79EF93002FE6
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B2832E743;
	Mon, 15 Dec 2025 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SqjoxRdO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624A32B9AA;
	Mon, 15 Dec 2025 23:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842162; cv=none; b=QWOP42X0ysfCsLaoMedyf1RpowfcBWlbdAuCA68vGVYDsvbMTdTIg+r/aNuQE2gZ/9EhdXMJoqNTSnZd1Jj9ed3amtCndHK4oB5SnJq2oku3JbXRK+VScbsDy3epCu5UWg40y3DqDEF4+GfDDviN77TAL48/kNn7bxdeEMuUBBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842162; c=relaxed/simple;
	bh=7LJJEHJ6NN+UBKQrcFX7zAoU4q1/IHE4dAarA1PzQCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khqMnwC8E24Eklm4PBYRk4EylQ3rxvDeahuzJXqB3Scev6q3b7TJOGHawwX0EEM1pQD0ttupHBDJokDN33s51UpAMvE2jHQLqa7M1zN/r6SZNpkA4THPCLYZ5fnecBKyObSBKgp+CqEYGCTY53Gp3B5CVK+wZ5tE89QqUGlow5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SqjoxRdO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJC47e2788343;
	Mon, 15 Dec 2025 23:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=lxPoz
	mTfEztdP2kf7k8psJZLAewCgMEY9vm17wI4UoQ=; b=SqjoxRdO0kJCsc8V0wSlQ
	7l8/oaqjlmEt9WRKTrN6gKg/EReN471QO1/qTSNvE08KYcTYuLKzx//ajATne6kr
	zd9NWR2WowxAUG0KxM1vFaVpA+f3ZLeqIhU68cPvKcYZxCzGu4i/FfcROeQqnl19
	OKvUcTF4cxJum66P8v97kGNeJaF/w2plFl9ZMn+eRsX6P/CbyEaguNSdGXFrkTdd
	1IxyOSbF7Ym7W0JZSD3mUBQlEvT6+apK1/OcZ7NYGGaPBLjQzSpJbSklmKgn9PjE
	Sa6mVNJPTkijjPOx1dkqQvEhcNt6J4OHSw9wpsHOl9J2uwTDhXICxjvtl1uqQr3Z
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b10prk14h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:41:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFL609e024479;
	Mon, 15 Dec 2025 23:41:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9t90g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:40 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNfdlF030553;
	Mon, 15 Dec 2025 23:41:39 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9t8y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:39 +0000
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
Subject: [PATCH v15 26/28] x86/reboot: Secure Launch SEXIT support on reboot paths
Date: Mon, 15 Dec 2025 15:33:14 -0800
Message-ID: <20251215233316.1076248-27-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfX6bmXC1p55Kh/
 CfYpKdRrnPuQz1CeFkvkdovvoF/mXdPtBhm2bnaEmSNuxuapBqPcKcRlEsZA81/dlgbsznIFnCg
 dFkbbP7/1QYpk6gsqCm5RN1iu2jodq00N24spA206yXEKAkv+OOG+lnEsoAuUC71uLoTLC6HVHl
 GjpfYoa9o4MYdGPSiiwNyrPdHDfmaW57aBRWjQPMZGnbxLYAEG3wdkVIVyOKNor2dF80yoHlGXe
 kaYdFkVibhQuvsjVcTpY6QdlpCn7cBJCJM5tvWYa+NzeB73k54p1peyzsrexjhFbgb+wpDNK/Fg
 vF6KHAiAGK0r9L77H5tIsy6/89qCX12sWm+kO09C4JzkmM4Eno2Ye9mSNm0RfPSOnuytzmLC6L4
 U3SUHDOEIMpBF22ZGn4MweUHY1rEcA==
X-Proofpoint-GUID: VhoepOIlXnL9UnCBcbwy61aTfxl7VuwO
X-Proofpoint-ORIG-GUID: VhoepOIlXnL9UnCBcbwy61aTfxl7VuwO
X-Authority-Analysis: v=2.4 cv=dParWeZb c=1 sm=1 tr=0 ts=69409cb5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=UN5060LkAAAA:8
 a=9nggSWBoCkqLOezBdQMA:9 a=E6eXv-vVeS7VqOnxGRGn:22

If the MLE kernel is being powered off, rebooted or halted,
then SEXIT must be called. Note that the GETSEC[SEXIT] leaf
can only be called after a machine_shutdown() has been done on
these paths. The machine_shutdown() is not called on a few paths
like when poweroff action does not have a poweroff callback (into
ACPI code) or when an emergency reset is done. In these cases,
just the TXT registers are finalized but SEXIT is skipped.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
---
 arch/x86/kernel/reboot.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 964f6b0a3d68..b1e6c1972f0b 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -13,6 +13,7 @@
 #include <linux/objtool.h>
 #include <linux/pgtable.h>
 #include <linux/kexec.h>
+#include <linux/slaunch.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
 #include <asm/apic.h>
@@ -778,6 +779,12 @@ static void native_machine_restart(char *__unused)
 
 	if (!reboot_force)
 		machine_shutdown();
+	/*
+	 * The comments for slaunch_finalize() provides the explanation for the
+	 * conditions required to do the SEXIT op reflected in the conditional
+	 * parameter do_sexit.
+	 */
+	slaunch_finalize(!reboot_force);
 	__machine_emergency_restart(0);
 }
 
@@ -788,6 +795,8 @@ static void native_machine_halt(void)
 
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 
+	slaunch_finalize(1);
+
 	stop_this_cpu(NULL);
 }
 
@@ -796,8 +805,12 @@ static void native_machine_power_off(void)
 	if (kernel_can_power_off()) {
 		if (!reboot_force)
 			machine_shutdown();
+		slaunch_finalize(!reboot_force);
 		do_kernel_power_off();
+	} else {
+		slaunch_finalize(0);
 	}
+
 	/* A fallback in case there is no PM info available */
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 }
@@ -825,6 +838,7 @@ void machine_shutdown(void)
 
 void machine_emergency_restart(void)
 {
+	slaunch_finalize(0);
 	__machine_emergency_restart(1);
 }
 
-- 
2.43.7


