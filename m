Return-Path: <linux-efi+bounces-5858-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C36FCC0395
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51EFB307C191
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F259832B988;
	Mon, 15 Dec 2025 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NDlxrGK+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF932ABC6;
	Mon, 15 Dec 2025 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842092; cv=none; b=dWIcJFuo4RcsH7Fw2EaQ3XKqHhV6szaLIN2I8t3sNAnI54YyZtZ83dOb7kDDyanGvlTI3Ywm8zwrnWM2Sqh2iqEq9mMdpRrBCud8JqfC3qOxj+HrDNJxTbvb+Yw6ndFBNDbGby2lPHZslxPMdoBFwzJYJ4yz7a+A2NEMh4QxzmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842092; c=relaxed/simple;
	bh=Gvd5paaLMS0IQXsoU4x/AvvX4grz9WKdT63LzD66er8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ocvk0V6j6uElSN5HI3W3kF7Q7l7NUclkcioTh+4q51zPks0lmMEYsvWmFy7SuVRZl+8Av17A9sTGNM9DAHYfNCiDJZ7aqUdgpSpC/dwbSknNFW1VdphnKuMnOFhzugDUNrUczpn9njhkoZcYiJtPZuwg1of/Gi0/+MvN+1kEeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NDlxrGK+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCJ582796331;
	Mon, 15 Dec 2025 23:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=0WI46
	Z3lajmefJKfjcG1vgomwZ6dyV+X4tN7/fvcgnQ=; b=NDlxrGK+S9HQvV0QWDeJ9
	rafu2V/7h5qcLDrhLdNAxURBRQ5sMy9rkm8NJSJHSeHoCkomUWfzOgM3/ctcJKI3
	00B8vJNMiijgQ3Bmy4KTOWmODRLvb2b7E8CClpc0BY2GTZpQMWYSifXhyUMSa9O6
	VnvxT3GeOZ6gsP6cxPg9cMo6FJ0gHkfzI2qh/CFZqE1t3fGraep8M3IbdFf1rd5+
	OKlVPW34MCLlNXZtcaCGitjbjF+gWyJ79iKnwE9C0MpGpQxljAr/z65N5EPLdXZN
	Z65HW0eqg5vZ99Jilz39zJKwiabgEBeA49pYCrGA4IVi3doCG+0UHRq/A2KagG8B
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xja318k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:40:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFLNR2A025236;
	Mon, 15 Dec 2025 23:40:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9tqb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:48 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNem4w035074;
	Mon, 15 Dec 2025 23:40:48 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9tq8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:47 +0000
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
Subject: [PATCH v15 13/28] x86: Secure Launch Kconfig
Date: Mon, 15 Dec 2025 15:33:01 -0800
Message-ID: <20251215233316.1076248-14-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Authority-Analysis: v=2.4 cv=TbWbdBQh c=1 sm=1 tr=0 ts=69409c82 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=lFVpMFQ50T_KeCnR02gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfX+iYEjjofZxFN
 0ijCJsbTSMT08LLNzXIcnSQQ6WSRiNtiG9wyHcv633VHQ36xAf2HCfBhje5FVcZnuV6/w3bS9Mq
 LcrhgCywMpgCX7uGapaaahWLC6gYcz/3FDNvOz8sdL4W5YmnPJe4r5saz61AVTOxXS59z1dfEKZ
 RuQi/2ePjA/y/IiAM8CGOHKx4v9fFXDisvccLB/Pen/rJ9yvHkEUHWoCCtmZ27V7cugN6lTjAQv
 XHih2y1NL1J3tR5fYyZhn6MQlJWsxYE/RsbkxthIGpqCo44lV5pKgTDhNs8t73KA7p9yAbNtsvl
 eb38MY6AijxUMFboeA7UNXc0OVuN+ep2D2gx4QOCYpnUALpjtTu4alfiUKDoPrHhis3kOuVFiWb
 iilYxt3PscC2cOxl8XQ1fQkpAa2B1g==
X-Proofpoint-ORIG-GUID: K_e1lx7zlLbdWf2uDlUk-eE7WHGPKBBQ
X-Proofpoint-GUID: K_e1lx7zlLbdWf2uDlUk-eE7WHGPKBBQ

Add a Kconfig option for compiling in/out the Secure Launch feature.
Secure Launch is controlled by a singel boolean on/off.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616af03a..9404d207c420 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1975,6 +1975,20 @@ config EFI_RUNTIME_MAP
 
 	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
 
+config SECURE_LAUNCH
+	bool "Secure Launch DRTM support"
+	depends on X86_64 && X86_X2APIC && TCG_TIS && TCG_CRB
+	select CRYPTO_LIB_SHA1
+	select CRYPTO_LIB_SHA256
+	help
+	  The Secure Launch feature allows a kernel to be launched directly
+	  through a vendor neutral DTRM (Dynamic Root of Trust for Measurement)
+	  solution, with Intel TXT being one example.  The DRTM establishes an
+	  environment where the CPU measures the kernel image, employing the TPM,
+	  before starting it. Secure Launch then continues the measurement chain
+	  over kernel configuration information and other launch artifacts (e.g.
+	  any initramfs image).
+
 source "kernel/Kconfig.hz"
 
 config ARCH_SUPPORTS_KEXEC
-- 
2.43.7


