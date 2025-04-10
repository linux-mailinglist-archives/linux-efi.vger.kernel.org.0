Return-Path: <linux-efi+bounces-3279-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195C2A84E89
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 22:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1ED99C2C32
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 20:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CEA290BD5;
	Thu, 10 Apr 2025 20:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CFUp2XG0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883F3290BCD;
	Thu, 10 Apr 2025 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744318103; cv=none; b=ncDti3Q0CrtmvP8jMD7rH+MzdSrUpiepkxmqBTvWS62rlHWBq00TUpdzi6Ba0u5RSCiiH4fqDivQLLHuGkF4Q2enRMrtTASilIxnJbl6meWwzXw7AR7qJZQO/ulY3asD5D9hS3tebd4+QgS4xs8xvbmx+/max2kqzbLJYYEbONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744318103; c=relaxed/simple;
	bh=+Dr2rdt07Bf/3vfLKYZUeg3sAhLM47iMFsmNMF203u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3NxGBsIkilUnztISBLAVyHA00nwetR4HKyGexGgEXHHwNdSzM7WdYbgt7QvcWme/n0WWSsI4SZqLVpkxrRmNVQFMa+nlqKmla+QBQUPKjFE9woXfYmvI9Ih6RPUgyG/YCtvPgY8rLjfEE1jcKXJC3eSzYcz2ikTk6J5X2AobZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CFUp2XG0; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AKg5tD005056;
	Thu, 10 Apr 2025 20:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=YWEss
	uEBBr4tKu86KInYgbn7SmP5Emu0oAFHvMzKI98=; b=CFUp2XG07OWruIPahfe88
	6KKpxV7rwd3DryYNThGRUvEt5HoIQx5esuDfZnJqhdd9nvyuLSCzHssp1c8hSkvH
	PqCACKHhddxyvRosWNaQLAZPQY5FjDzre7EMK8FyUvRDKFwNz6nL3aawdyR3pASA
	YJAmqJ+bpBM6P/7Fyl4E58x2ZMnVlZUvRMaoMpwOBPc9Dt/C68716vkyFMgaqHIH
	cWdwR70RewROI9BLkHJM/HgEFNpHYiUXEvoi9HycQY13GRWLTx7mCsEvu/Ia90tt
	dfWK3N96ykh3ZC9kIJYU6WY/dwLB/F157Ade/QyYadUkO2kWIZQ1AYchLnS+XWeU
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xn8fr0me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 20:47:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53AKj6GQ001435;
	Thu, 10 Apr 2025 20:47:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttycs7we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Apr 2025 20:47:53 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53AKlq1n036725;
	Thu, 10 Apr 2025 20:47:52 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttycs7qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Apr 2025 20:47:52 +0000
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
Subject: [PATCH v13 07/19] x86/msr: Add variable MTRR base/mask and x2apic ID registers
Date: Thu, 10 Apr 2025 13:41:37 -0700
Message-Id: <20250410204149.2576104-8-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250410204149.2576104-1-ross.philipson@oracle.com>
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504100150
X-Proofpoint-GUID: lAWO1KP3vHfidO3SGQ-Y4hW6ZXQSrRr5
X-Proofpoint-ORIG-GUID: lAWO1KP3vHfidO3SGQ-Y4hW6ZXQSrRr5

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


