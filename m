Return-Path: <linux-efi+bounces-3382-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B97B8A95458
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 18:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4923B60FE
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 16:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53A41E570B;
	Mon, 21 Apr 2025 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SzZooK5Q"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3071A1E501C;
	Mon, 21 Apr 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253323; cv=none; b=lmRNU3FHN4EJ2h99y3FqsF0rX5DEKGH4wdPYOsFQHO7p+2tKjdqSIRDafP8xUToY1o1AI0LTIKyb6E6yAe/w+RwtluhtSJ4wgHBGk6X1w5VnkyzW/jcrvOk+JlUsVyqsxD55uGgjPAmwxHNg4VFHcuX4xGCS660dYslfbCLylYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253323; c=relaxed/simple;
	bh=+Dr2rdt07Bf/3vfLKYZUeg3sAhLM47iMFsmNMF203u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZ7DpT5CI0Tata8VnC0oEYw0gaO1fSP8aRgDmo6Q2WevN2zypncqIy4enELsn3IXS0VQl/hcrDFzuNFYaLXeOM/3R0BjEA2gT9Bm/fU2doxEsEOCauc0g5iNWbj6ZUcJoe0Hb9u1Y5C6KDF5k3UUkOhv2ujSuYSnrvuKpkADXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SzZooK5Q; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LCAnpW023188;
	Mon, 21 Apr 2025 16:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=YWEss
	uEBBr4tKu86KInYgbn7SmP5Emu0oAFHvMzKI98=; b=SzZooK5Q1I6PWaR3mOhb7
	P+dqW+qL/OtHZvnDqgFsx4X1vr8ncD/bb8xNG4v41DHGEwPy2saeAab1BxC2NBlq
	GuWEcTQ7/xaFR11cCPdNVDVVw6Yr/zDja+vlmfoVTcUiOl44HPsN42FNeSn4oeDj
	0vi6ZEUuyuv8xeZ37dXDANzvBo+A3r/ip2l5Sha9ci6joAxUjrjnn1+bhzOd6ZWS
	yBYYkFT0youF82NVrmdS0mmysOSPvgFHV28ER/MqnHxTDSj1/qIh7AbrlV5tvKoF
	a0o/HXBLAPD9+FlYTuOvmh6Ptbp+ztN/fE56xeldaZQR+l6VUFtKtGy39KSGmiBY
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4643q8ttty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 16:34:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53LEwVVw002262;
	Mon, 21 Apr 2025 16:34:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46429882cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:34:51 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53LGYoHd032853;
	Mon, 21 Apr 2025 16:34:50 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46429882ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:34:50 +0000
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
Subject: [PATCH v14 07/19] x86/msr: Add variable MTRR base/mask and x2apic ID registers
Date: Mon, 21 Apr 2025 09:27:00 -0700
Message-Id: <20250421162712.77452-8-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504210129
X-Proofpoint-GUID: K4fbtksCDvMCHDiDi9Q-LB7Ia6Bwl_RL
X-Proofpoint-ORIG-GUID: K4fbtksCDvMCHDiDi9Q-LB7Ia6Bwl_RL

Add the MSR values required by Secure Launch to locate particular CPU cores
during application processor (AP) startup, and restore the MTRR state after
an Intel TXT launch.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e6134ef2263d..97cc926c6d1b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -366,6 +366,9 @@
 #define MSR_IA32_RTIT_OUTPUT_BASE	0x00000560
 #define MSR_IA32_RTIT_OUTPUT_MASK	0x00000561
 
+#define MSR_MTRRphysBase0		0x00000200
+#define MSR_MTRRphysMask0		0x00000201
+
 #define MSR_MTRRfix64K_00000		0x00000250
 #define MSR_MTRRfix16K_80000		0x00000258
 #define MSR_MTRRfix16K_A0000		0x00000259
@@ -890,6 +893,8 @@
 #define MSR_IA32_APICBASE_ENABLE	(1<<11)
 #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
 
+#define MSR_IA32_X2APIC_APICID		0x00000802
+
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
-- 
2.39.3


