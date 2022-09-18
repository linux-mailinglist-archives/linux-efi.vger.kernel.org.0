Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD7A5BC01E
	for <lists+linux-efi@lfdr.de>; Sun, 18 Sep 2022 23:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIRVgW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 18 Sep 2022 17:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIRVgW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 18 Sep 2022 17:36:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1AF13FA2
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 14:36:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3125B81330
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 21:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C6EC433C1;
        Sun, 18 Sep 2022 21:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663536978;
        bh=e2Iqplw0yzG3w2OvmovsVI5QKe97+qAlA9sWqfYGy+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXNlShTlVDH3VpyDrZmv2sSBTnHCwdsqBf4dN8zCLeq/oqeJqmPRvKhRaT/XNH1rH
         o0jmqvjEb1C/TJvUfwU8lI6gc4meQwJWREdIuRozSYNwR+IEEEMloUe8WBMzjPQYpP
         ZXntaBRyuEl795ZdKgyOORvT5L3MWuEcmF+s9CgsLo6owLsbo1ZjdqTd03jo7a4aGt
         fSd+z31P7SdI+8LqAxiwu2KFj1DnBnmGmy+Jcc4GSWyst/001jKNJpDZasvm9+ibRH
         mWzTFTuHxzPPaDygfkhDU59G3m2GokKBqWEHTk38Qc0DbNkzaougcI5G2PHeQMzHJk
         qmvwSLnvijTEg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, linux@armlinux.org.uk,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 09/12] efi: libstub: install boot-time memory map as config table
Date:   Sun, 18 Sep 2022 23:35:41 +0200
Message-Id: <20220918213544.2176249-10-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220918213544.2176249-1-ardb@kernel.org>
References: <20220918213544.2176249-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6542; i=ardb@kernel.org; h=from:subject; bh=e2Iqplw0yzG3w2OvmovsVI5QKe97+qAlA9sWqfYGy+g=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjJ48p8Tg+X93WLpbB7UKaWHk+2RveAozj2ZDdoGkp 9ha4xU+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyePKQAKCRDDTyI5ktmPJI/PC/ 4wuuZSvomTMUW3cTd9Xv5tWssa625ULpO+KgA9AZfx36e/IhTvAqUf4N1HBy+LcsCFJHbOw1Ax79p4 9t6rCy6CGDrQi7nMgmPBCAiunfwzBS/SR2aP/9QLZ5YFdW9JeQzXhqyxHcSQoCKYLGwV8aQc8kN2U4 oYQdlqoCDLV3EpBf0Auql8BpW2A0g/RPbNxn6BKSOVRhFd+RrWxOWHVUu9z1vrsAYIBOdGik5PG2Fd sTQVeOXjl9fUUc9/D3FM+wTqaUf4VRwiuYppeUYNzFKUDsZAieIbYuS8cS3HIwUkofbUsxBbZ8Kgsh tiJBaghWZxEKi794pfWyRMkIROK2uJCYv1Il+jM/65hjKPTBmhcQuVgrod0q67GU35vEgZdOVkXLt9 qoD62USu/j+L4uBbBBnkEuafPsf7en2gVZPsR1olA/x0iNrnTRo5K6Kr5bIgO8vE7D25eWL82QxQ6X rhSMKcW43HlJ24vmxSUEBWEIFIyssD5Zn05RglLWa0lyA=
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
 drivers/firmware/efi/libstub/mem.c             | 26 ++++++++++++++++++--
 drivers/firmware/efi/libstub/randomalloc.c     |  2 +-
 drivers/firmware/efi/libstub/relocate.c        |  2 +-
 include/linux/efi.h                            |  1 +
 7 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index e9d516ad5f97..df05c53baa23 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -55,7 +55,7 @@ static bool check_image_region(u64 base, u64 size)
 	bool ret = false;
 	int map_offset;
 
-	status = efi_get_memory_map(&map);
+	status = efi_get_memory_map(&map, false);
 	if (status != EFI_SUCCESS)
 		return false;
 
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 742ecd9e0df3..f1f7a823be17 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -438,7 +438,7 @@ efi_status_t efi_exit_boot_services(void *handle, void *priv,
 	struct efi_boot_memmap *map;
 	efi_status_t status;
 
-	status = efi_get_memory_map(&map);
+	status = efi_get_memory_map(&map, true);
 
 	if (status != EFI_SUCCESS)
 		goto fail;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index f65a8a3844b8..b4fb6d4e8a59 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -897,7 +897,8 @@ void efi_apply_loadoptions_quirk(const void **load_options, u32 *load_options_si
 
 char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len);
 
-efi_status_t efi_get_memory_map(struct efi_boot_memmap **map);
+efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
+				bool install_cfg_tbl);
 
 efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
 				unsigned long max);
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 40721573e494..ed4c145afe11 100644
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
@@ -28,11 +34,23 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap **map)
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
@@ -40,6 +58,10 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap **map)
 	if (status == EFI_SUCCESS) {
 		*map = m;
 	} else {
+		if (install_cfg_tbl)
+			efi_bs_call(install_configuration_table, &tbl_guid,
+				    NULL);
+free_map:
 		efi_bs_call(free_pool, m);
 	}
 
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
index 8668d9769bb0..89f16ec3ebab 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -414,6 +414,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_ZBOOT_MEDIA_GUID		EFI_GUID(0xe565a30d, 0x47da, 0x4dbd,  0xb3, 0x54, 0x9b, 0xb5, 0xc8, 0x4f, 0x8b, 0xe2)
 #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
 #define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
+#define LINUX_EFI_BOOT_MEMMAP_GUID		EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
 
 #define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
 
-- 
2.35.1

