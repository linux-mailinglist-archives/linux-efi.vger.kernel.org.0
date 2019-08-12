Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD038A1E3
	for <lists+linux-efi@lfdr.de>; Mon, 12 Aug 2019 17:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfHLPFO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Aug 2019 11:05:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39477 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfHLPFN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Aug 2019 11:05:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id u25so12064139wmc.4
        for <linux-efi@vger.kernel.org>; Mon, 12 Aug 2019 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z3sLGJ9Y6NSuUVoK4Ad/f3JwEEVat2vLXpskef4Wjpw=;
        b=uUtpswhjcXonrclDX2pzC/OLlMB8CR4jdNsbVCyyJfbFyBbMWg+0Aew0YrDSAbgynn
         UBHZ5qxiR/FLZ0Ct92Vg9vySGyIMlp0Yt/g4bYii5IWID7ZLPf+RyFBRXZAedOHhY3f1
         x8kbYQmk9C1++IuCm9gK2XiUkD/aqYVIN9apkB5giAeUyZKNaA/0ZJXRkq79Y5kkKhE4
         1SGL8XBz3c2V4QL0D7Qs4FM7A3jQbeESD3X1qiLoi9x1D7WoWNGemRbTg5N+WEtmjXeP
         zpXj0JUd+0iUU29AgEne7VQpoPzhKcNXb81u+/xT9VS4QG/w5s0GItw7dh6fJS+Hrplh
         PIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z3sLGJ9Y6NSuUVoK4Ad/f3JwEEVat2vLXpskef4Wjpw=;
        b=Wol/l+acOuhLJMMOa/9SCU4FW8IcG4DRjYNMaOsxugh66B1KcbdBOl9jQRyyG7VGnb
         th2ZTXIuzWIPIcGRgGyvdtl2EQ5QNGXUvbPIuSvid9EA064v1S8Hc86OZIh+J1DTEuk7
         RvpdDeX18uNCH72ZeyZOERj67UzJjTKdXuZPV68yqegyuvjK+HYFQp2MBCKej0vLRMjR
         hncAcGjteMXXhtdTYRTIOE22JzA4yWgkHa1+N4FIaL0t0DZhkPHn7I+rQi1EHG3Xq6/2
         D3BC4+E9/1WL+zhljrOYArg0EIgCn3oZaqHVTETewJunLRPve5Dy31m6FQqPGqgl1MG5
         bhHA==
X-Gm-Message-State: APjAAAU2dFpuwTPad7a81m+nnrqWEPDYi5WnNeCPXfjPDSSqy7SlnpRe
        pxm98+gsLbrBhIve1DpFZwQlt3AdTjURbw==
X-Google-Smtp-Source: APXvYqwjMTQwZ5HfDfZM+Cgs8md0RkIXE6Dfx5lrM/wyv+HTDldo8cpMPCTwuzIY2DevaLtmSA4WEw==
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr3789211wmf.47.1565622310553;
        Mon, 12 Aug 2019 08:05:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a407:da00:1c0e:f938:89a1:8e17])
        by smtp.gmail.com with ESMTPSA id h97sm31027269wrh.74.2019.08.12.08.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 08:05:09 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Narendra K <Narendra.K@dell.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 2/5] efi/x86: move UV_SYSTAB handling into arch/x86
Date:   Mon, 12 Aug 2019 18:04:49 +0300
Message-Id: <20190812150452.27983-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
References: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SGI UV UEFI machines are tightly coupled to the x86 architecture
so there is no need to keep any awareness of its existence in the
generic EFI layer, especially since we already have the infrastructure
to handle arch-specific configuration tables, and were even already
using it to some extent.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/uv/uv.h   |  4 +++-
 arch/x86/platform/efi/efi.c    |  6 ++++--
 arch/x86/platform/uv/bios_uv.c | 10 ++++++----
 drivers/firmware/efi/efi.c     |  1 -
 include/linux/efi.h            |  1 -
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index e60c45fd3679..6bc6d89d8e2a 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -12,10 +12,12 @@ struct mm_struct;
 #ifdef CONFIG_X86_UV
 #include <linux/efi.h>
 
+extern unsigned long uv_systab_phys;
+
 extern enum uv_system_type get_uv_system_type(void);
 static inline bool is_early_uv_system(void)
 {
-	return !((efi.uv_systab == EFI_INVALID_TABLE_ADDR) || !efi.uv_systab);
+	return uv_systab_phys && uv_systab_phys != EFI_INVALID_TABLE_ADDR;
 }
 extern int is_uv_system(void);
 extern int is_uv_hubless(void);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 8d9be97a5607..9866a3584765 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -59,7 +59,7 @@ static efi_system_table_t efi_systab __initdata;
 
 static efi_config_table_type_t arch_tables[] __initdata = {
 #ifdef CONFIG_X86_UV
-	{UV_SYSTEM_TABLE_GUID, "UVsystab", &efi.uv_systab},
+	{UV_SYSTEM_TABLE_GUID, "UVsystab", &uv_systab_phys},
 #endif
 	{NULL_GUID, NULL, NULL},
 };
@@ -74,7 +74,9 @@ static const unsigned long * const efi_tables[] = {
 	&efi.boot_info,
 	&efi.hcdp,
 	&efi.uga,
-	&efi.uv_systab,
+#ifdef CONFIG_X86_UV
+	&uv_systab_phys,
+#endif
 	&efi.fw_vendor,
 	&efi.runtime,
 	&efi.config_table,
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 7c69652ffeea..c2ee31953372 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -14,6 +14,8 @@
 #include <asm/uv/bios.h>
 #include <asm/uv/uv_hub.h>
 
+unsigned long uv_systab_phys __ro_after_init = EFI_INVALID_TABLE_ADDR;
+
 struct uv_systab *uv_systab;
 
 static s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
@@ -185,13 +187,13 @@ EXPORT_SYMBOL_GPL(uv_bios_set_legacy_vga_target);
 void uv_bios_init(void)
 {
 	uv_systab = NULL;
-	if ((efi.uv_systab == EFI_INVALID_TABLE_ADDR) ||
-	    !efi.uv_systab || efi_runtime_disabled()) {
+	if ((uv_systab_phys == EFI_INVALID_TABLE_ADDR) ||
+	    !uv_systab_phys || efi_runtime_disabled()) {
 		pr_crit("UV: UVsystab: missing\n");
 		return;
 	}
 
-	uv_systab = ioremap(efi.uv_systab, sizeof(struct uv_systab));
+	uv_systab = ioremap(uv_systab_phys, sizeof(struct uv_systab));
 	if (!uv_systab || strncmp(uv_systab->signature, UV_SYSTAB_SIG, 4)) {
 		pr_err("UV: UVsystab: bad signature!\n");
 		iounmap(uv_systab);
@@ -203,7 +205,7 @@ void uv_bios_init(void)
 		int size = uv_systab->size;
 
 		iounmap(uv_systab);
-		uv_systab = ioremap(efi.uv_systab, size);
+		uv_systab = ioremap(uv_systab_phys, size);
 		if (!uv_systab) {
 			pr_err("UV: UVsystab: ioremap(%d) failed!\n", size);
 			return;
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index cbdbdbc8f9eb..4dfd873373bd 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -43,7 +43,6 @@ struct efi __read_mostly efi = {
 	.boot_info		= EFI_INVALID_TABLE_ADDR,
 	.hcdp			= EFI_INVALID_TABLE_ADDR,
 	.uga			= EFI_INVALID_TABLE_ADDR,
-	.uv_systab		= EFI_INVALID_TABLE_ADDR,
 	.fw_vendor		= EFI_INVALID_TABLE_ADDR,
 	.runtime		= EFI_INVALID_TABLE_ADDR,
 	.config_table		= EFI_INVALID_TABLE_ADDR,
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 60a6242765d8..171bb1005a10 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -988,7 +988,6 @@ extern struct efi {
 	unsigned long boot_info;	/* boot info table */
 	unsigned long hcdp;		/* HCDP table */
 	unsigned long uga;		/* UGA table */
-	unsigned long uv_systab;	/* UV system table */
 	unsigned long fw_vendor;	/* fw_vendor */
 	unsigned long runtime;		/* runtime table */
 	unsigned long config_table;	/* config tables */
-- 
2.17.1

