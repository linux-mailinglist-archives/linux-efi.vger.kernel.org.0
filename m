Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19595BC020
	for <lists+linux-efi@lfdr.de>; Sun, 18 Sep 2022 23:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIRVg1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 18 Sep 2022 17:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIRVg0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 18 Sep 2022 17:36:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B7313FAB
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 14:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FCF561599
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 21:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E1AC433B5;
        Sun, 18 Sep 2022 21:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663536985;
        bh=MJHabceJjCWQVg/sduyUYpKDir7hmmzhm7sjKN5i5A4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGDAcSsxvgf7t8oouaGalmV/SGj6kjO3ox+b67ik27jhDfRWgssRORUDNcl7hgDll
         e5mnjyms0aj1ClU+N1y/2zFWzjVspM/dUmOdKGNJbp+3j9FqRNBKjswP37iD4l7p6h
         KeV7YNF1giOzSfoL+1TjfYWchsE5Ctvfs1VPvZOMDRM+3hMNGiLKC1loRrKy9X2KUb
         X6J11JcfYA8/d1BSydySj+K47gS8PFmut7fzl2U+DaPvuoMOkelJ1wn/G7gIsxso90
         9djYvCHQCdTAiSdgNuP4cYncOVg15jtlw3qxCDExvAT8dzTeMJ0hmY+kT5P9fKmQpv
         kjaY1uKvRXaDQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, linux@armlinux.org.uk,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 12/12] efi: loongarch: add support for DT hardware descriptions
Date:   Sun, 18 Sep 2022 23:35:44 +0200
Message-Id: <20220918213544.2176249-13-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220918213544.2176249-1-ardb@kernel.org>
References: <20220918213544.2176249-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3282; i=ardb@kernel.org; h=from:subject; bh=MJHabceJjCWQVg/sduyUYpKDir7hmmzhm7sjKN5i5A4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjJ48v8zXv8FfbQcQtAcYHvMvFjY74Go4gdwo8EnV2 25O2DWuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyePLwAKCRDDTyI5ktmPJHZ5C/ 4xPhD5tRO6GsKh08CLM2v/WGfIinP5OnGhqyVMiRKdYZH38r9Hjnp0hJw0MxSnwLIPj1uWYIlRpjLY ntHC/HRYvUIBUJCESsnMPgxBv4WBsuSr27QidBgh7sP/f75E7h9cWc9swGOdEr8IUzEBzek8RQN+x6 dArD1fYyNI2ssKdv3Xq7D5apO0tXD70zd9Bcung/TexMt/CHcYuGYcYN/r+aqjYrLpU4gM9GYH542A RMjqo+ZvQ9QrcpnC/64VOFt8EqOwTq3aAsSyKevBuOxber8hNH+es70YOTzo9TGCf9bgM3twOixT6H TYQoKv4XwZXcZp6IUrbbKgNfIQ6y5EpStmEgNBwZcklhNv9dXT9nrpVBOBtclDD43bfMSTm4cAhO7f QtNaD0cwWMJ33UWr81juJAvL5uQarltTqa9ItPm6scp49CsmXXoKM8szeVZKZkeOE153Cj0IZPOXEZ waKhLYd7SL/17nfyGAi5Aqf+GgfSgkwXqOExSg4V6jMqo=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Treat device tree data in the same way as we treat ACPI tables: discover
them from the EFI configuration table array, and parse the properties
that describe hardware. This means we omit /chosen and the /memory
nodes, which carry information that we should be receiving from EFI. not
from the device tree.

On the non-EFI boot path, parse the DT passed via the boot entrypoint as
usual: things like bootargs, initrd and other bootloader generated data
are all loaded from the DT /chosen node, along with memory descriptions
and other things we would otherwise get from EFI.

Note that this approach is similar to x86, which also supports FDT for
hardware descriptions but not for boottime generated data.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/loongarch/Kconfig      |  2 ++
 arch/loongarch/kernel/efi.c | 14 ++++++++++++++
 arch/loongarch/kernel/env.c |  6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 14a2a1ec8561..721b1dc38bdf 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -104,6 +104,8 @@ config LOONGARCH
 	select MODULES_USE_ELF_RELA if MODULES
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
+	select OF
+	select OF_EARLY_FLATTREE
 	select PCI
 	select PCI_DOMAINS_GENERIC
 	select PCI_ECAM if ACPI
diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index 3b80675726ec..96c8621da2ba 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/kobject.h>
 #include <linux/memblock.h>
+#include <linux/of_fdt.h>
 #include <linux/reboot.h>
 #include <linux/uaccess.h>
 
@@ -28,10 +29,12 @@ static unsigned long efi_nr_tables;
 static unsigned long efi_config_table;
 
 static unsigned long __initdata boot_memmap = EFI_INVALID_TABLE_ADDR;
+static unsigned long __initdata boot_fdt = EFI_INVALID_TABLE_ADDR;
 
 static efi_system_table_t *efi_systab;
 static efi_config_table_type_t arch_tables[] __initdata = {
 	{LINUX_EFI_BOOT_MEMMAP_GUID,	&boot_memmap,	"MEMMAP" },
+	{DEVICE_TREE_GUID,		&boot_fdt,	"FDT" },
 	{},
 };
 
@@ -100,4 +103,15 @@ void __init efi_init(void)
 			early_memunmap(tbl, sizeof(*tbl));
 		}
 	}
+
+	if (boot_fdt != EFI_INVALID_TABLE_ADDR) {
+		void *tbl;
+
+		tbl = early_memremap_ro(boot_fdt, sizeof(*tbl));
+		if (tbl) {
+			early_init_dt_verify(tbl);
+			early_init_dt_scan_root();
+			early_init_fdt_reserve_self();
+		}
+	}
 }
diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
index 05c38d28476e..3267063df1f9 100644
--- a/arch/loongarch/kernel/env.c
+++ b/arch/loongarch/kernel/env.c
@@ -8,6 +8,7 @@
 #include <linux/efi.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
+#include <linux/of_fdt.h>
 #include <asm/early_ioremap.h>
 #include <asm/bootinfo.h>
 #include <asm/loongson.h>
@@ -29,6 +30,11 @@ void __init init_environ(void)
 		efi_system_table = fw_arg1;
 		set_bit(EFI_BOOT, &efi.flags);
 	} else {
+		void *fdt_ptr = early_memremap_ro(fw_arg1, SZ_64K);
+
+		early_init_dt_scan(fdt_ptr);
+		early_init_fdt_reserve_self();
+
 		clear_bit(EFI_BOOT, &efi.flags);
 	}
 }
-- 
2.35.1

