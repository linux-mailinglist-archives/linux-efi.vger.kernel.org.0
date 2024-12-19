Return-Path: <linux-efi+bounces-2402-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730289F84EE
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2024 20:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9F316312D
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2024 19:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB841BD9D2;
	Thu, 19 Dec 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="He4wFQm4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8C01BD4E5;
	Thu, 19 Dec 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638152; cv=none; b=PJStYgaxHuQH7MVCmCLtf/JP+AZyWGsuwu2uUUlVUuMMia2HHW3416Y7VHbvbMXyXEmfzg1hvF5nbyvw4lKVMau/6S2i3cOzKzn1zZBEgsYUINz4a7lamJn4N9/9auTmcLz3b6abWslSJdd7tq5X3r0m4yG4GerSHNb6nWNTnUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638152; c=relaxed/simple;
	bh=dmaclvxf9TnntMUluXb08EwHCTH4g/hWhBwJSuhJdWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EGoP+oHuKWWktfFbimY/B3qAQojW+hYCOEWIYjikW20AoMx9K3p4K7dWODs7fiPqfgTLWzWyE3TH8J5KeH8xNqC/ZvZsnG5LV9AkGg9i309wfO4Zdh4n4B2sn7c6foyaPceZNab8zvMUT0ILHPDJduZMDWKuccLzYLSJ8V/70ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=He4wFQm4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJINN2R003444;
	Thu, 19 Dec 2024 19:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=iHkSe
	z91kyWzaGskjIuEmyVAQSjTMQkYdSsIHKK4oeU=; b=He4wFQm4R0AQd4cMmutdc
	srHS4Jje2+rRGeCTEzdgw5HO9ep5KBh8lApU0EqWZ6/xtwclSU1F+9DtMCQfk1IA
	feNt3+Weed16EYAu/YOKMVx41SwwA/JS2hukKJZqlOAlG49HXo6MHRouBbTotBWx
	YWdhzdT2KG+uctT6+IY5gWpxIYLFDEWst1LdmiCeJCc/BGuKFgaUcpfnnDDBK6YK
	oeLmSNlDczmO8bh9+tHYWfduGn5p9bK46KynwmXhS12WxQmkVgpyvqGGo+Jl2QoR
	GaQ/+t94NiscgDqrNvrPvvsY1gvAglBqGWdDTrpKrS2rbwqK+qZqrMW1126NSvl4
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0m0c1uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 19:54:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJI2KUL032770;
	Thu, 19 Dec 2024 19:54:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fhvkvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Dec 2024 19:54:22 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BJJsLtY009143;
	Thu, 19 Dec 2024 19:54:21 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fhvkeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Dec 2024 19:54:21 +0000
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
Subject: [PATCH v12 02/19] x86: Secure Launch Kconfig
Date: Thu, 19 Dec 2024 11:41:59 -0800
Message-Id: <20241219194216.152839-3-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412190158
X-Proofpoint-GUID: BdejskqseAZS49t0swJrHH4Qfaq3EQZM
X-Proofpoint-ORIG-GUID: BdejskqseAZS49t0swJrHH4Qfaq3EQZM

Initial bits to bring in Secure Launch functionality. Add Kconfig
options for compiling in/out the Secure Launch code.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d7bd0ae48c4..86af03707f04 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2057,6 +2057,17 @@ config EFI_RUNTIME_MAP
 
 	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
 
+config SECURE_LAUNCH
+	bool "Secure Launch support"
+	depends on X86_64 && X86_X2APIC && TCG_TIS && TCG_CRB && CRYPTO_LIB_SHA1 && CRYPTO_LIB_SHA256
+	help
+	   The Secure Launch feature allows a kernel to be loaded
+	   directly through an Intel TXT measured launch. Intel TXT
+	   establishes a Dynamic Root of Trust for Measurement (DRTM)
+	   where the CPU measures the kernel image. This feature then
+	   continues the measurement chain over kernel configuration
+	   information and init images.
+
 source "kernel/Kconfig.hz"
 
 config ARCH_SUPPORTS_KEXEC
-- 
2.39.3


