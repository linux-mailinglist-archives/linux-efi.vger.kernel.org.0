Return-Path: <linux-efi+bounces-538-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3168555EC
	for <lists+linux-efi@lfdr.de>; Wed, 14 Feb 2024 23:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910301F23556
	for <lists+linux-efi@lfdr.de>; Wed, 14 Feb 2024 22:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579FB4315A;
	Wed, 14 Feb 2024 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GafnFw2e"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968C2145B2A;
	Wed, 14 Feb 2024 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707949941; cv=none; b=NNgoyfFsg/fOh3vGGqmS8HJqzGlLzKqcHGt5uVge0/SMazvdIkzFk0d3L7QFlom5AGsRMIRHtkqRz8W477BbiXClQOO6w33qUohRlj4qtgoUB7t5V5lRLd6JRsKO7JK2rjTu6+5Jo3blzWsXqz/zKDMXxLlPc6T5ktdeG8MBS/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707949941; c=relaxed/simple;
	bh=flFnoxSjJPiZN+KWO/A4dvYo7tj50mI8G+STmxqDfgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J2NzAC6GGJclP6ZPh3c7VOYT8SOvBm6+6XJF1Tcj7n6PbqsaKoQurk2M1l0dH2waJqLBE5JOi5ei0Cgh94qHFPjBAgmlD1KOzxX9tUzR1tbXYklan4X4KRFidI8OuarSgsXWezEWMVYG5JyP5ZYXrBBvvqWg0tu7rmRuL6NB9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GafnFw2e; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41ELiRJJ022678;
	Wed, 14 Feb 2024 22:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=LywYV7sKOLgcRW6dEU5AQlOwu5jlNOpmyybhEKQBFTU=;
 b=GafnFw2eABZO4lj7v9fXjWJdBUyJKZDU7FdbeU9CvB6420yuZxeKEZh+v2I8qeNffQAE
 NgZs4j7tgGgequMTvhI0U1lg9YAbg14dayb7B0s5DkqhEV253dHbc9HOYf1ORUbYmn5a
 lFIH0mCHjMhOK+y3VVwvm83Vk+XPjp7nJB1MXSmN3LhC6bLypuvkHqEwmqyUweJPD6rj
 T1k5VRMKbwFFGGrsf4Z9oT7I/KZON3AORKBOOEMX0QjT4vMFFVYlTxH4/EmDSdkge5iG
 Pm7PHPtHPmvAdukUxQO3ecQZG8Zu2X2t7k6AQbstXFQyn0q1zJ/YJBo7JFp3gcMdJgw+ bw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92ppghkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 22:31:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EM0KMa000657;
	Wed, 14 Feb 2024 22:31:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n7hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:48 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EMVTVO004281;
	Wed, 14 Feb 2024 22:31:47 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n72r-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:47 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v8 15/15] x86: EFI stub DRTM launch support for Secure Launch
Date: Wed, 14 Feb 2024 14:18:47 -0800
Message-Id: <20240214221847.2066632-16-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240214221847.2066632-1-ross.philipson@oracle.com>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_14,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140170
X-Proofpoint-ORIG-GUID: jd8QLRG0hZFTbiXK0o9sbVAzU9z96nCn
X-Proofpoint-GUID: jd8QLRG0hZFTbiXK0o9sbVAzU9z96nCn

This support allows the DRTM launch to be initiated after an EFI stub
launch of the Linux kernel is done. This is accomplished by providing
a handler to jump to when a Secure Launch is in progress. This has to be
called after the EFI stub does Exit Boot Services.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 55 +++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 0d510c9a06a4..4df2cf539194 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -9,6 +9,7 @@
 #include <linux/efi.h>
 #include <linux/pci.h>
 #include <linux/stddef.h>
+#include <linux/slr_table.h>
 
 #include <asm/efi.h>
 #include <asm/e820/types.h>
@@ -810,6 +811,57 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 	return EFI_SUCCESS;
 }
 
+static void efi_secure_launch(struct boot_params *boot_params)
+{
+	struct slr_entry_uefi_config *uefi_config;
+	struct slr_uefi_cfg_entry *uefi_entry;
+	struct slr_entry_dl_info *dlinfo;
+	efi_guid_t guid = SLR_TABLE_GUID;
+	struct slr_table *slrt;
+	u64 memmap_hi;
+	void *table;
+	u8 buf[64] = {0};
+
+	table = get_efi_config_table(guid);
+
+	/*
+	 * The presence of this table indicated a Secure Launch
+	 * is being requested.
+	 */
+	if (!table)
+		return;
+
+	slrt = (struct slr_table *)table;
+
+	if (slrt->magic != SLR_TABLE_MAGIC)
+		return;
+
+	/* Add config information to measure the UEFI memory map */
+	uefi_config = (struct slr_entry_uefi_config *)buf;
+	uefi_config->hdr.tag = SLR_ENTRY_UEFI_CONFIG;
+	uefi_config->hdr.size = sizeof(*uefi_config) + sizeof(*uefi_entry);
+	uefi_config->revision = SLR_UEFI_CONFIG_REVISION;
+	uefi_config->nr_entries = 1;
+	uefi_entry = (struct slr_uefi_cfg_entry *)(buf + sizeof(*uefi_config));
+	uefi_entry->pcr = 18;
+	uefi_entry->cfg = boot_params->efi_info.efi_memmap;
+	memmap_hi = boot_params->efi_info.efi_memmap_hi;
+	uefi_entry->cfg |= memmap_hi << 32;
+	uefi_entry->size = boot_params->efi_info.efi_memmap_size;
+	memcpy(&uefi_entry->evt_info[0], "Measured UEFI memory map",
+		strlen("Measured UEFI memory map"));
+
+	if (slr_add_entry(slrt, (struct slr_entry_hdr *)uefi_config))
+		return;
+
+	/* Jump through DL stub to initiate Secure Launch */
+	dlinfo = (struct slr_entry_dl_info *)
+		slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
+
+	asm volatile ("jmp *%%rax"
+		      : : "a" (dlinfo->dl_handler), "D" (&dlinfo->bl_context));
+}
+
 static void __noreturn enter_kernel(unsigned long kernel_addr,
 				    struct boot_params *boot_params)
 {
@@ -934,6 +986,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
+	/* If a Secure Launch is in progress, this never returns */
+	efi_secure_launch(boot_params);
+
 	/*
 	 * Call the SEV init code while still running with the firmware's
 	 * GDT/IDT, so #VC exceptions will be handled by EFI.
-- 
2.39.3


