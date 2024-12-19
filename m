Return-Path: <linux-efi+bounces-2416-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ABB9F8530
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2024 21:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A588166190
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2024 20:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEDD1BFE0D;
	Thu, 19 Dec 2024 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EDrL977f"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8B1BD9D3;
	Thu, 19 Dec 2024 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638295; cv=none; b=NDMMM4xq0o1Wljr30Rb2E6mfyf4/1rfYOEnn3YSlsWtE8tq99dlh2McN9sDlT89jfBdaUBm6gWBEVbWgwKozbqMIcKBBJw6IqsFwPTlvSAsaDz/8vdhjGHIyXI7IsiX8Gng2ZzcFc1rsJ/MiITSX8mkU66RHhQ39iNgNtYJ93zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638295; c=relaxed/simple;
	bh=HKup6Twxuzvh9My98TZ9Rm5s01uCW6W1C5fvM8b8NC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GGHUKF4hihZZuH59M0RbP/EHD0ulHo9J+I40s01IY0Lm5dPfJi9y2KbIRFhW1NmPOHelYeGChuhAv77hp+lRJehWStG/x2te607bcP3bFK8azCXOTlWl18l/SawQyCGHHMHpggIwGD3kZTzQYKuC5p4PwSiAMq+4nYjUtEU7hjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EDrL977f; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJIMh9G029748;
	Thu, 19 Dec 2024 19:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=CAR2X
	DvMpSDNgRI4ba9QodPpLgYuOG3w5cBkcUBDh0g=; b=EDrL977flAIHAN2R2MTGb
	r0LSdAUHvjZxGmUdu+JcB2XC7CumxXPw6SbNh6/bmnL4HJbdh6UPhItXq3Vn7iTU
	k4MEpidVnaEMZ6d3Mm7fVVwSBOvjAyuNjwvfYlvry46CHDXq0CtzCSP//JZbFFjE
	wtbvaJeij0hJux2qbW1uXi1DNjHEsT9aR/FkN9rj2B0d2t1OTzl+jzmbNAeQV3tf
	6wMiF/lGGhCdfNuuViTPnl391YL6lqd6XppdrocGQem7kdVAMwWdVAZUY43YlVFm
	W50ZICD7oSudfinCgskpbUo7zcaiGexE4CgCM6zY63dvZZzUtCKWdrTHSR80ecK7
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22cuvc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 19:56:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJJHs6P018324;
	Thu, 19 Dec 2024 19:56:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fbvwk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Dec 2024 19:56:50 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BJJunsH002858;
	Thu, 19 Dec 2024 19:56:49 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fbvwgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Dec 2024 19:56:49 +0000
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
Subject: [PATCH v12 19/19] x86/efi: EFI stub DRTM launch support for Secure Launch
Date: Thu, 19 Dec 2024 11:42:16 -0800
Message-Id: <20241219194216.152839-20-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412190158
X-Proofpoint-GUID: n26lGIjuWLBeE41cJiA9lwyEURTykH58
X-Proofpoint-ORIG-GUID: n26lGIjuWLBeE41cJiA9lwyEURTykH58

This support allows the DRTM launch to be initiated after an EFI stub
launch of the Linux kernel is done. This is accomplished by providing
a handler to jump to when a Secure Launch is in progress. This has to be
called after the EFI stub does Exit Boot Services.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h  |  8 +++
 drivers/firmware/efi/libstub/x86-stub.c | 94 +++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 76e44c185f29..f63e5197ea53 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -135,6 +135,14 @@ void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
 	*hi = upper_32_bits(data);
 }
 
+static inline
+void efi_set_u64_form(u32 lo, u32 hi, u64 *data)
+{
+	u64 upper = hi;
+
+	*data = lo | upper << 32;
+}
+
 /*
  * Allocation types for calls to boottime->allocate_pages.
  */
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 188c8000d245..403a191c31cc 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -9,6 +9,8 @@
 #include <linux/efi.h>
 #include <linux/pci.h>
 #include <linux/stddef.h>
+#include <linux/slr_table.h>
+#include <linux/slaunch.h>
 
 #include <asm/efi.h>
 #include <asm/e820/types.h>
@@ -922,6 +924,93 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 	return efi_adjust_memory_range_protection(addr, kernel_text_size);
 }
 
+#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
+static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
+						 struct boot_params *boot_params)
+{
+	struct slr_entry_intel_info *txt_info;
+	struct slr_entry_policy *policy;
+	bool updated = false;
+	int i;
+
+	txt_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
+	if (!txt_info)
+		return false;
+
+	txt_info->boot_params_addr = (u64)boot_params;
+
+	policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
+	if (!policy)
+		return false;
+
+	for (i = 0; i < policy->nr_entries; i++) {
+		if (policy->policy_entries[i].entity_type == SLR_ET_BOOT_PARAMS) {
+			policy->policy_entries[i].entity = (u64)boot_params;
+			updated = true;
+			break;
+		}
+	}
+
+	/*
+	 * If this is a PE entry into EFI stub the mocked up boot params will
+	 * be missing some of the setup header data needed for the second stage
+	 * of the Secure Launch boot.
+	 */
+	if (image) {
+		struct setup_header *hdr = (struct setup_header *)((u8 *)image->image_base +
+					    offsetof(struct boot_params, hdr));
+		u64 cmdline_ptr;
+
+		boot_params->hdr.setup_sects = hdr->setup_sects;
+		boot_params->hdr.syssize = hdr->syssize;
+		boot_params->hdr.version = hdr->version;
+		boot_params->hdr.loadflags = hdr->loadflags;
+		boot_params->hdr.kernel_alignment = hdr->kernel_alignment;
+		boot_params->hdr.min_alignment = hdr->min_alignment;
+		boot_params->hdr.xloadflags = hdr->xloadflags;
+		boot_params->hdr.init_size = hdr->init_size;
+		boot_params->hdr.kernel_info_offset = hdr->kernel_info_offset;
+		efi_set_u64_form(boot_params->hdr.cmd_line_ptr, boot_params->ext_cmd_line_ptr,
+				 &cmdline_ptr);
+		boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);
+	}
+
+	return updated;
+}
+
+static void efi_secure_launch(struct boot_params *boot_params)
+{
+	struct slr_entry_dl_info *dlinfo;
+	efi_guid_t guid = SLR_TABLE_GUID;
+	dl_handler_func handler_callback;
+	struct slr_table *slrt;
+
+	/*
+	 * The presence of this table indicated a Secure Launch
+	 * is being requested.
+	 */
+	slrt = (struct slr_table *)get_efi_config_table(guid);
+	if (!slrt || slrt->magic != SLR_TABLE_MAGIC)
+		return;
+
+	/*
+	 * Since the EFI stub library creates its own boot_params on entry, the
+	 * SLRT and TXT heap have to be updated with this version.
+	 */
+	if (!efi_secure_launch_update_boot_params(slrt, boot_params))
+		return;
+
+	/* Jump through DL stub to initiate Secure Launch */
+	dlinfo = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
+
+	handler_callback = (dl_handler_func)dlinfo->dl_handler;
+
+	handler_callback(&dlinfo->bl_context);
+
+	unreachable();
+}
+#endif
+
 static void __noreturn enter_kernel(unsigned long kernel_addr,
 				    struct boot_params *boot_params)
 {
@@ -1049,6 +1138,11 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
+#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
+	/* If a Secure Launch is in progress, this never returns */
+	efi_secure_launch(boot_params);
+#endif
+
 	/*
 	 * Call the SEV init code while still running with the firmware's
 	 * GDT/IDT, so #VC exceptions will be handled by EFI.
-- 
2.39.3


