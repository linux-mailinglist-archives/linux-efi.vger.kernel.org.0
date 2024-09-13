Return-Path: <linux-efi+bounces-1767-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4466D9789BA
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 22:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9C61C246B4
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 20:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B576315575E;
	Fri, 13 Sep 2024 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nMkqisAw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3086154BEA;
	Fri, 13 Sep 2024 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726258451; cv=none; b=XjoOwlRcWZ0a2tovgPJPFabuKPRrtbnzAVVb5ZeAYBDSc94yrqB9vKE51Wcok8+lA27vYGt5f4dg5ObFwzy+Xkz6/B1fXnnGoDjXXa2pjKJlIm2k+k1CAUAFaZI/zenvg66R+WfJdWdahOstcvf65q4Jl4Bvbis5y/xBLRP7avc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726258451; c=relaxed/simple;
	bh=sOk43r6vmFxmdtIXNcG4EaKtbQdXQhOxZVsz4aP4vhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JLPMRquTfGsLKi1MFlSsbiEVdEwUUgmE4EvuGwbXuQTS4wX4KUrY20hlyCZwhd/m8TpJHwPLAb8hmHm1m7Lbcei0RrPPEIYhx+RSrpJmV/wBWd4S9a968fiA5CgLRt95H+KsqTi7z/oVXUuJncQVHe4zg9BGwGhPqx8xwsNIz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nMkqisAw; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJ0oB9030201;
	Fri, 13 Sep 2024 20:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=Y
	Nv2wwZ99egsX3bHuUPzbFYitff09OWNP/lW0iaYo1Q=; b=nMkqisAw4rBgWVKtx
	ALxzYUEvvjwLojF6KN0oOhpBt/M0SUOWZLUk7ZwZGHSFIV584Y1TMIIAFl3O0i2c
	mbTcBVHrLYz/mPIilqoyvaBA4oBkQOdMJ0XDsPwNYfMLsgRqujle/LN2LVe7ISjG
	7UaeFsVTvOgJ4lqni9ygKmEuSUAAmKfrELrPC38uxzJjDgrFk4lKZcRO4x+MMl1z
	qe/omF1a/ztXURay0TIjPhjohaEQrZoQowIYroONUOWbPNbV7v4n580NsPVsscaj
	VP6qm3Z8mZOkIYgGwmJhNLYpslGQDOjuGMqV3u8iWGYT3zGEW4YxqAn5GHY83q55
	WcYZQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gjbux97g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 20:13:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DKCr13040758;
	Fri, 13 Sep 2024 20:13:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9etg7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:13:21 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48DKDKtL029564;
	Fri, 13 Sep 2024 20:13:20 GMT
Received: from localhost.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9etg5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:13:20 +0000
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
Subject: [PATCH v11 20/20] x86/efi: EFI stub DRTM launch support for Secure Launch
Date: Fri, 13 Sep 2024 13:05:17 -0700
Message-Id: <20240913200517.3085794-21-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130143
X-Proofpoint-GUID: FHwIIj5XO5_PqZa7Fmt9wI4g6gsR6zGP
X-Proofpoint-ORIG-GUID: FHwIIj5XO5_PqZa7Fmt9wI4g6gsR6zGP

This support allows the DRTM launch to be initiated after an EFI stub
launch of the Linux kernel is done. This is accomplished by providing
a handler to jump to when a Secure Launch is in progress. This has to be
called after the EFI stub does Exit Boot Services.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h  |  8 ++
 drivers/firmware/efi/libstub/x86-stub.c | 99 +++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index d33ccbc4a2c6..baf42d6d0796 100644
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
index f8e465da344d..2e063bce1080 100644
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
@@ -923,6 +925,98 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 	return efi_adjust_memory_range_protection(addr, kernel_text_size);
 }
 
+#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
+static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
+						 struct boot_params *boot_params)
+{
+	struct slr_entry_intel_info *txt_info;
+	struct slr_entry_policy *policy;
+	struct txt_os_mle_data *os_mle;
+	bool updated = false;
+	int i;
+
+	txt_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
+	if (!txt_info)
+		return false;
+
+	os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
+	if (!os_mle)
+		return false;
+
+	os_mle->boot_params_addr = (u64)boot_params;
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
@@ -1050,6 +1144,11 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
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


