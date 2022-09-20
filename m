Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B605BECE0
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 20:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiITSgW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 14:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiITSgV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 14:36:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5355E31F
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 11:36:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BBB9B82C2C
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 18:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4378FC433D6;
        Tue, 20 Sep 2022 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663698977;
        bh=ogw9GLLbpitYRLX73k+Af3pVRnxh87j+/lGhpnDhH04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P6ncobKWea4fjN+i+uYxx/fJbvCkw3Q1lmVmKZa250xobyzjCxvH2G6lSpWS4L39X
         8hsHPdWgfBfsabCf7NALk2YvdjwrfSGcCSYKkCbqmQF8SaJyycks5wqwJdqmpZS22Z
         a3wUw3FSF3AKUYquImh3Ydu5Kh7uiN54F7hy+GqVkW+i/8lREqahpgcFRi0vK8cfx5
         ZYik9DhE/O5vhNzjxCLn6FqvhV+dY9RVVIgaHcoJl8cnaZx71hLy71yO4vvMlN6rIb
         lsPBkBw+o0gRwpKrd/0yp7DrW7wDUBP6RbTluGJsNXt76pn79TMyjIDCGdHphvVmlx
         ajB8SphD2tdXg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v2 7/8] efi: libstub: install boot-time memory map as config table
Date:   Tue, 20 Sep 2022 20:35:53 +0200
Message-Id: <20220920183554.3870247-8-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920183554.3870247-1-ardb@kernel.org>
References: <20220920183554.3870247-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6540; i=ardb@kernel.org; h=from:subject; bh=ogw9GLLbpitYRLX73k+Af3pVRnxh87j+/lGhpnDhH04=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKggHLjb2RNeDouXhWbiyqOXO0K9/gmBGCxvcNqj+ w2HsqkWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyoIBwAKCRDDTyI5ktmPJNs7DA ChfAI5ND5Amb4s8DtWjk0tgTKTMTPeRn+Q/V04Fcs8DXGDQ4ZiCW+1BMBd1/07zAZ+2/fpsFAA+/Eq 5kYmGQJmgFsEyroSG8cBIoCbvKt8xxiHucmwlRvs57JYnALtiiUAsGUmrmhPBaqAfMJ0cpvP7+XcOg m0ez30FRZS1bp8mSfWFdfPEpanacYKDq7Rw6neqeZlWHwJzA4FIzKMg8qLe9ef5IVoVhpEmNpsyQAh ZnXKXpaB2RfAE/iaxUtfi+qUX3q19U2vcDFCyo4HlRO7XQLSwya+0urKQed55WpzkhhKNtm79nc/xE Zdf7btBUcOUtiDCXTLQSy/8QOKYj0/52VySiJ/Hq/E5ZXyHy65ei94iwRMsOiN+qC/3k9+0cM9nzdb L2tQOnE4BlGk8ELocyNQEJz5NpN2qWoq/8ba3Pb/7A/z8Oln00eIjpyopPC+9Lm2TunABgUdMejXN2 b/6tVR3bs4DqRH917/T9KBQecVSnuPfckMovbeTTPc7Vg=
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

Expose the EFI boot time memory map to the kernel via a configuration
table. This is arch agnostic and enables future changes that remove the
dependency on DT on architectures that don't otherwise rely on it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c      |  2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c |  2 +-
 drivers/firmware/efi/libstub/efistub.h         |  3 ++-
 drivers/firmware/efi/libstub/mem.c             | 27 +++++++++++++++++---
 drivers/firmware/efi/libstub/randomalloc.c     |  2 +-
 drivers/firmware/efi/libstub/relocate.c        |  2 +-
 include/linux/efi.h                            |  1 +
 7 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 83b5ae3721ea..cd3bea25c762 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -47,7 +47,7 @@ static bool check_image_region(u64 base, u64 size)
 	bool ret = false;
 	int map_offset;
 
-	status = efi_get_memory_map(&map);
+	status = efi_get_memory_map(&map, false);
 	if (status != EFI_SUCCESS)
 		return false;
 
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 8efbec217016..17665f89196f 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -437,7 +437,7 @@ efi_status_t efi_exit_boot_services(void *handle, void *priv,
 	struct efi_boot_memmap *map;
 	efi_status_t status;
 
-	status = efi_get_memory_map(&map);
+	status = efi_get_memory_map(&map, true);
 	if (status != EFI_SUCCESS)
 		return status;
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index e26f8625a2b5..8e4017b7e663 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -876,7 +876,8 @@ void efi_apply_loadoptions_quirk(const void **load_options, int *load_options_si
 
 char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len);
 
-efi_status_t efi_get_memory_map(struct efi_boot_memmap **map);
+efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
+				bool install_cfg_tbl);
 
 efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
 				unsigned long max);
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index c92b7dbc6dfe..45841ef55a9f 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -9,14 +9,20 @@
  * efi_get_memory_map() - get memory map
  * @map:		pointer to memory map pointer to which to assign the
  *			newly allocated memory map
+ * @install_cfg_tbl:	whether or not to install the boot memory map as a
+ *			configuration table
  *
  * Retrieve the UEFI memory map. The allocated memory leaves room for
  * up to EFI_MMAP_NR_SLACK_SLOTS additional memory map entries.
  *
  * Return:	status code
  */
-efi_status_t efi_get_memory_map(struct efi_boot_memmap **map)
+efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
+				bool install_cfg_tbl)
 {
+	int memtype = install_cfg_tbl ? EFI_ACPI_RECLAIM_MEMORY
+				      : EFI_LOADER_DATA;
+	efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
 	struct efi_boot_memmap *m, tmp;
 	efi_status_t status;
 	unsigned long size;
@@ -28,20 +34,35 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap **map)
 		return EFI_LOAD_ERROR;
 
 	size = tmp.map_size + tmp.desc_size * EFI_MMAP_NR_SLACK_SLOTS;
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(*m) + size,
+	status = efi_bs_call(allocate_pool, memtype, sizeof(*m) + size,
 			     (void **)&m);
 	if (status != EFI_SUCCESS)
 		return status;
 
+	if (install_cfg_tbl) {
+		/*
+		 * Installing a configuration table might allocate memory, and
+		 * this may modify the memory map. This means we should install
+		 * the configuration table first, and re-install or delete it
+		 * as needed.
+		 */
+		status = efi_bs_call(install_configuration_table, &tbl_guid, m);
+		if (status != EFI_SUCCESS)
+			goto free_map;
+	}
+
 	m->buff_size = m->map_size = size;
 	status = efi_bs_call(get_memory_map, &m->map_size, m->map, &m->map_key,
 			     &m->desc_size, &m->desc_ver);
 	if (status != EFI_SUCCESS)
-		goto free_map;
+		goto uninstall_table;
 
 	*map = m;
 	return EFI_SUCCESS;
 
+uninstall_table:
+	if (install_cfg_tbl)
+		efi_bs_call(install_configuration_table, &tbl_guid, NULL);
 free_map:
 	efi_bs_call(free_pool, m);
 	return status;
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 5d6000c717cc..9fb5869896be 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -61,7 +61,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 	efi_status_t status;
 	int map_offset;
 
-	status = efi_get_memory_map(&map);
+	status = efi_get_memory_map(&map, false);
 	if (status != EFI_SUCCESS)
 		return status;
 
diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
index cd80db33ab1e..bf6fbd5d22a1 100644
--- a/drivers/firmware/efi/libstub/relocate.c
+++ b/drivers/firmware/efi/libstub/relocate.c
@@ -28,7 +28,7 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 	unsigned long nr_pages;
 	int i;
 
-	status = efi_get_memory_map(&map);
+	status = efi_get_memory_map(&map, false);
 	if (status != EFI_SUCCESS)
 		goto fail;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 778ddb22f7da..252b9b328577 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -410,6 +410,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_INITRD_MEDIA_GUID		EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
 #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
 #define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
+#define LINUX_EFI_BOOT_MEMMAP_GUID		EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
 
 #define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
 
-- 
2.35.1

