Return-Path: <linux-efi+bounces-3394-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFCEA95491
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 18:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07D516B3D3
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42181EB180;
	Mon, 21 Apr 2025 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EchcpW3V"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C8D1E5732;
	Mon, 21 Apr 2025 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253426; cv=none; b=ueZMO59QQpK81qQ4135rzuBvr2C+gdGK7jYAStadd/0ghkjSATK4LKqOf24GvbgJkAqnW/5y8mOa7dJx0PCL/ogdNLmA2qCxtmh00xJxr91TESFB1u+sBvAXmUYjppzzrMp+1njYJn5LHWJmCiylPw5ThzXUjuTeBT/+7tKgQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253426; c=relaxed/simple;
	bh=OVtUR75UdG+ta6xSnWSh/M7h5jKSHGTKRRKuzl7Prv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTrv1iiLk8x8zVdDYY8DFW6TLR62hKzOQWEKvm0Aw/NHIwvELxOpvAFv/OoQ9fQKgGIBDLweA5oMM6guDc24YP7dqLVrWgIFlbmeZIUsj+uyM9pj7wTTX2zZ9vGImMasJJJMv/4J22DevG8sDVB/CJGhl6txcyj6lZ3kZ1uKUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EchcpW3V; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LCAn6Z002167;
	Mon, 21 Apr 2025 16:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=dYf3j
	c9+aZuxTXSzRykvVpdyrAgLZb6GlSjWb/TZTek=; b=EchcpW3Vsbzrtbi8bA72O
	l0grk57TVl2koHg1hixlA2oX6WXqoWlzgkvBcO7EKYP2zDyEnxYo5Qohym3r+TbQ
	Bqth/GEW3whHkibcjQePOkvoX6w352Nvg2a7bgNFOt4HWNExaWIGyGs+oxVpQxqi
	Suao60gR29RpgkFqO+/64d0/TX2v3V1dMv3vEMaDz5Irr7/2hafNhM4wg5ud9rZq
	fGMtt6fajUsjNXDn/IzSrXRC9DiJ/Qib+j4euh1J1Sb5wkcWKUfLk3PdTeQj4+x0
	qU01RdGmktDhInAxdrSoUXSlaB9+VQY+hb1N9oNb/wv8tmc9YIVRzCLhLGrqkfxO
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642raavwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 16:36:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53LGNUmp021147;
	Mon, 21 Apr 2025 16:36:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46429er452-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:36:35 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53LGaYaS023132;
	Mon, 21 Apr 2025 16:36:34 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46429er43p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:36:34 +0000
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
Subject: [PATCH v14 19/19] x86/efi: EFI stub DRTM launch support for Secure Launch
Date: Mon, 21 Apr 2025 09:27:12 -0700
Message-Id: <20250421162712.77452-20-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504210129
X-Proofpoint-ORIG-GUID: yOAYGSbdZ-sm1qCyDVD7lQDGS8tFzLDG
X-Proofpoint-GUID: yOAYGSbdZ-sm1qCyDVD7lQDGS8tFzLDG

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
index f5ba032863a9..6e4cbf02500b 100644
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
index cafc90d4caaf..bfa36466a79c 100644
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
@@ -791,6 +793,93 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry,
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
@@ -925,6 +1014,11 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
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


