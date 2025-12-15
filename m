Return-Path: <linux-efi+bounces-5875-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E45DECC0476
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF67B3078E87
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618B033A03A;
	Mon, 15 Dec 2025 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U3XOGdBk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81DB32E696;
	Mon, 15 Dec 2025 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842151; cv=none; b=gjc5mYTEjQbpl0VkOSQHAgYyNWpoXvZQkVL5trfWd0K7zAyjjmx0z9CrZmyq4CvSOa5Jojaje/17Aqbj6IpcO0qZ1TtP/np348hZXNydywZkv/MFKdEQNGkSYi44PjHyFVYSvm3v4/JqI73SAZ1AYUo7BKWeLcwtEMgG32aKSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842151; c=relaxed/simple;
	bh=98gryRFauHD7qweNk4xNF7tvgz/RfU2w0X85bhaby78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pac+K3ihQXPDtxLqVzoF9og9rmoXtmfL4a3p9rGQxv+VlWce4KZz8N+7CCO8J/G2033+hzlUBDgSQaMOLSX6nUvDuP4mozmf7xAJ9dVfxxn/E18CDHmjJ9IWkkOaQrbc7V/0P/AwMFDxA4eqebsb38ulB4i53AY8Rv1XrgN8QdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U3XOGdBk; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJC9kk2885755;
	Mon, 15 Dec 2025 23:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=M8+fJ
	RN/y992LnvFxhjE4a/BegdJK//9MUX29+x3gZg=; b=U3XOGdBkhKjhwGAJqfZSa
	LshEd+Ed9tPgpcPIQLuVP6V6yx2R+IGJOm9zZplx/DZXhZ1G8eaCuxGkOf3gWmT5
	rCfJ+5OqnCeNTtV32lgGCgIDUOQVCtI5H2DO9tOQVkj0GEa2tGt5yPO85FManbK1
	wVP7xDH7Pp9TnCSnZ1QhcbGjUrbpotQ0kaxpuWHDATCVeIxmxxTWtU9Z1AGwTnkr
	DVSi81DqevHAk1ST5x8oKM1Q0EMA+kTNIwguOcjdb7Yg6ggp/8K5nK6l1R0+OuD0
	udIw+vgC3TBHvErtUlYw5h38+j8l7MbcRECO7XqTrIHPtnHBUKaWPPjgx5UjfJLa
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015u194-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:41:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFMVrxD025010;
	Mon, 15 Dec 2025 23:41:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9j8jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:48 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNflPP007113;
	Mon, 15 Dec 2025 23:41:47 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9j8h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:47 +0000
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
Subject: [PATCH v15 28/28] x86/efi: EFI stub DRTM launch support for Secure Launch
Date: Mon, 15 Dec 2025 15:33:16 -0800
Message-ID: <20251215233316.1076248-29-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-GUID: S3-F52aIXQmqNN7zR9luY9IdQwtz0QiE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfXz8ftYOC1ESpC
 MzJtfhcvryBZAM8pTJ9EzPY2rEgrzfTuppOJQhr2zFC+NuJhFckYSItKfnUzVqnwIqLnPU3A89z
 ZImt8Tx8hl6Zjdr63UsdjwRmAE9RhFhZcdHgp2+cs3wXJa/11YbTOumsZFlMYRIlLJ8mJNWOY79
 Xt3NLxk1ICc583DMkZa1zUaFbBjXN9rfsltpBzYZ1tbQK+ewkR03vYqGLAiWutxcvnd0FoV6tHb
 FiA0t43nQL5ilX+VTcPxuunyp/XmAMdZKYrpRUm18tlv8pZkHaJznbRro43TwkUUS8jkOGsuHnt
 v+kDLhL6LHD9SvSqL/b/x2HWkz3TtWGqfPdZ+MBEIugGkSGaXFBiIM6mxpbAMD0yYat8f5N1aQV
 lqvFqsFlZ6Nweo4M36BlJFlMVezXzw==
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=69409cbd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=mErUaaQqPOyLTE2wGXUA:9
X-Proofpoint-ORIG-GUID: S3-F52aIXQmqNN7zR9luY9IdQwtz0QiE

This support allows the DRTM launch to be initiated after an EFI stub
launch of the Linux kernel is done. This is accomplished by providing
a handler to jump to when a Secure Launch is in progress. This has to be
called after the EFI stub does Exit Boot Services.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h  |   8 ++
 drivers/firmware/efi/libstub/x86-stub.c | 100 ++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

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
index 761121a77f9e..e664dfddc173 100644
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
@@ -795,6 +797,101 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry,
 						  kernel_inittext_size);
 }
 
+#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
+
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
+
+#else
+
+static void efi_secure_launch(struct boot_params *boot_params)
+{
+}
+
+#endif /* IS_ENABLED(CONFIG_SECURE_LAUNCH) */
+
 static void __noreturn enter_kernel(unsigned long kernel_addr,
 				    struct boot_params *boot_params)
 {
@@ -929,6 +1026,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
+	/* If a Secure Launch is in progress, this never returns */
+	efi_secure_launch(boot_params);
+
 	/*
 	 * Call the SEV init code while still running with the firmware's
 	 * GDT/IDT, so #VC exceptions will be handled by EFI.
-- 
2.43.7


