Return-Path: <linux-efi+bounces-1769-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EF69789D1
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 22:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91A1282FCD
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 20:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFEC1547F3;
	Fri, 13 Sep 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="auACBlqy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D83153836;
	Fri, 13 Sep 2024 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726258566; cv=none; b=e343aLKakTiEgWhm84uZ4+Nz8OdTOedAJn48IhvsZPmMCM58TSS9R5a0gXVc+sQpAi8URa0B5F5EB0NHfHpp9a5FdrY4FZsLtNrg3lD/+KoFGK5tGHNgOXZ2TjCLYgKi+RtQV91hZ7+u0k8NLanTkInw0pIWqqM0toH2JJIKq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726258566; c=relaxed/simple;
	bh=Ekbb1Q88jFmCxW2b8lXU7X0MWMz236zAwpvL67zG9ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qgAdBG2/+oPjEfEL1fRhnnsMYabwxYL7CTqS01e485N1wu4Z5l2/f6bMKdQBQzmbrc8ChhlbYAh6UQAOKMuOVctibTxHE7bM22AyNSvyGXmTWK6kFmb1j5yg1wPlCMh3NDMYFYGCKF7ySJIoz6Zu495jRgUB5BRuRDr881voOsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=auACBlqy; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJ0c9L016842;
	Fri, 13 Sep 2024 20:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=E
	cqTseYjTndPo7qnnktrBgiljIE8peMHL6Zd2VChAJc=; b=auACBlqyc9a/KDE4j
	iIO78V9N/oYd3XOL2ArBn8Gqo0JJcRnxKIEWy2lyE5cqBxXq4NmHUf3AoSD3Q0hq
	e+BNGwRW92sxatocgiLlDctQuwnSRh58knLd+ybAPv/mkbNk1OptnILomzcdJ/D/
	ZDh3cVHwNWT4FBLKgFS4IHLOzguKZpXk7E1dAeTQgkdOt1cI9B21ijuG1GiVWs1Y
	rKNY96kaFqAeJ9PzrV2YEk+TtDPbPZhP7vnogHuzhyO0dEBrYuhoSeqf7VntgHPI
	RY81r1Ihia38uUQjQFOoMebqyIhRoP1koxQwoN4eI6f+S5ouuxXkau5wO9NRjgSw
	9hbrA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41geq9xcaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 20:10:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJ6wZE033703;
	Fri, 13 Sep 2024 20:10:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d3ma4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:10:33 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48DKAWfg020873;
	Fri, 13 Sep 2024 20:10:32 GMT
Received: from localhost.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d3m7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:10:32 +0000
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
Subject: [PATCH v11 02/20] x86: Secure Launch Kconfig
Date: Fri, 13 Sep 2024 13:04:59 -0700
Message-Id: <20240913200517.3085794-3-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240913200517.3085794-1-ross.philipson@oracle.com>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409130143
X-Proofpoint-ORIG-GUID: qD11seGVYcFoJ9CGrRQlvaZVq1RAvV5T
X-Proofpoint-GUID: qD11seGVYcFoJ9CGrRQlvaZVq1RAvV5T

Initial bits to bring in Secure Launch functionality. Add Kconfig
options for compiling in/out the Secure Launch code.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9f2a0e..24df5f468fdc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2056,6 +2056,17 @@ config EFI_RUNTIME_MAP
 
 	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
 
+config SECURE_LAUNCH
+	bool "Secure Launch support"
+	depends on X86_64 && X86_X2APIC && TCG_TPM && CRYPTO_LIB_SHA1 && CRYPTO_LIB_SHA256
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


