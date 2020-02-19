Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5F9164BB7
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 18:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSRTi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 12:19:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSRTh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 12:19:37 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC31224673;
        Wed, 19 Feb 2020 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582132777;
        bh=Dv6uyXEmok6oEm/3BWepdoT4N6mQZdpZSQD3O1qUVIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bC5UK0Y3shDZN1aqGCmw33zkOpZM6lHRZK4rtNSrUciY75fFjiUH9lPHbI8bXCTc2
         KD5LiiBGHxRIB8gUbYlYC4gSjzH6eSUNQ5w7DQ04xE2Q2lMY2FbAB/g/BI90GpMlGx
         NY++pUSDA3lCr47AHhxm8nCQeofMfolJdkooB84o=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Graf <agraf@csgraf.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeff Brasen <jbrasen@nvidia.com>,
        Atish Patra <Atish.Patra@wdc.com>, x86@kernel.org
Subject: [PATCH 2/9] efi: add support for EFI_RT_PROPERTIES table
Date:   Wed, 19 Feb 2020 18:19:00 +0100
Message-Id: <20200219171907.11894-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219171907.11894-1-ardb@kernel.org>
References: <20200219171907.11894-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Take the newly introduced EFI_RT_PROPERTIES_TABLE configuration table
into account, which carries a mask of which EFI runtime services are
still functional after ExitBootServices() has been called by the OS.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 12 ++++++++++++
 include/linux/efi.h        |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 703a019d81b4..a35230517f9c 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -47,6 +47,7 @@ EXPORT_SYMBOL(efi);
 
 static unsigned long __ro_after_init rng_seed = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata mem_reserve = EFI_INVALID_TABLE_ADDR;
+static unsigned long __initdata rt_prop = EFI_INVALID_TABLE_ADDR;
 
 struct mm_struct efi_mm = {
 	.mm_rb			= RB_ROOT,
@@ -449,6 +450,7 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 	{LINUX_EFI_TPM_EVENT_LOG_GUID, "TPMEventLog", &efi.tpm_log},
 	{LINUX_EFI_TPM_FINAL_LOG_GUID, "TPMFinalLog", &efi.tpm_final_log},
 	{LINUX_EFI_MEMRESERVE_TABLE_GUID, "MEMRESERVE", &mem_reserve},
+	{EFI_RT_PROPERTIES_TABLE_GUID, "RTPROP", &rt_prop},
 #ifdef CONFIG_EFI_RCI2_TABLE
 	{DELLEMC_EFI_RCI2_TABLE_GUID, NULL, &rci2_table_phys},
 #endif
@@ -575,6 +577,16 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		}
 	}
 
+	if (rt_prop != EFI_INVALID_TABLE_ADDR) {
+		efi_rt_properties_table_t *tbl;
+
+		tbl = early_memremap(rt_prop, sizeof(*tbl));
+		if (tbl) {
+			efi.runtime_supported_mask &= tbl->runtime_services_supported;
+			early_memunmap(tbl, sizeof(*tbl));
+		}
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 57695f400044..2ab33d5d6ca5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -334,6 +334,7 @@ void efi_native_runtime_setup(void);
 #define EFI_TCG2_PROTOCOL_GUID			EFI_GUID(0x607f766c, 0x7455, 0x42be,  0x93, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
 #define EFI_LOAD_FILE_PROTOCOL_GUID		EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
 #define EFI_LOAD_FILE2_PROTOCOL_GUID		EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
+#define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
 
 #define EFI_IMAGE_SECURITY_DATABASE_GUID	EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
 #define EFI_SHIM_LOCK_GUID			EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
@@ -486,6 +487,14 @@ typedef struct {
 #define EFI_PROPERTIES_TABLE_VERSION	0x00010000
 #define EFI_PROPERTIES_RUNTIME_MEMORY_PROTECTION_NON_EXECUTABLE_PE_DATA	0x1
 
+typedef struct {
+	u16 version;
+	u16 length;
+	u32 runtime_services_supported;
+} efi_rt_properties_table_t;
+
+#define EFI_RT_PROPERTIES_TABLE_VERSION	0x1
+
 #define EFI_INVALID_TABLE_ADDR		(~0UL)
 
 typedef struct {
-- 
2.17.1

