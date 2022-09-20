Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD85BECDC
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 20:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiITSgN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 14:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiITSgM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 14:36:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7C65E31F
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 11:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D09A62C6D
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 18:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40908C433D7;
        Tue, 20 Sep 2022 18:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663698969;
        bh=RG6ihkxd08x6OFNzQ1ggnfObo1o8yyUZpLnvEd1TDfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwn0Ul/k5ZHt0WnSRhO4JE3QSd+1VnWjl9Snvh/nzAK16nU1z15M8pZFAUQYOgOcv
         2xDYkxZHpadGj94orN8JnchNRzU7o9dPugN54P1ulsl8s0behRAgxidWpbZHlXD2bn
         GgWHaSUnRi0w4kfXWWzmi4dVczQn0p27U8TfMWhc0wZVwK8W+cRSoncnY/RTbSL8Lm
         AZLTRvq923oMISIjpe0SVJJpUPwVFS80EhJttnpYZUEOOEXQT0szfQXccJEKZv3W3z
         2IE5fdfAQXG8AXe/5FW8hhBLgzE9L3hWPlF9sezqNeZfV3mipnPMvpm7zq5we05czC
         UXcljqKGP1PgQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v2 3/8] efi: libstub: simplify efi_get_memory_map() and struct efi_boot_memmap
Date:   Tue, 20 Sep 2022 20:35:49 +0200
Message-Id: <20220920183554.3870247-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920183554.3870247-1-ardb@kernel.org>
References: <20220920183554.3870247-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20483; i=ardb@kernel.org; h=from:subject; bh=RG6ihkxd08x6OFNzQ1ggnfObo1o8yyUZpLnvEd1TDfI=; b=owEB7AET/pANAwAKAcNPIjmS2Y8kAcsmYgBjKggAi6aFq7O2lw3cbPxIm1eAgYxpYkwf/7QWdAhc gNh1zgOJAbIEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyoIAAAKCRDDTyI5ktmPJNYoC/ jwYbfejSg2mtI54GX3nmPZcPCSL1bVddOS9MP9nvfDFU74u1ouxL1DWMlTNloKyHH7A74Z6oPsP4He nA7lOlEMTfATgE/oAS+31q80f7tU8AH44ifVocpSvzfw8pzA6j8zBAhrxublbRyngrneFls7XdCzT1 5CyNi5c3OA2rHnYrLai91YHphuhYmIhje20R4ihiYNuKzRttwEpbeVETefGiY9RyUsUoceXqsc/m/X tQk4iJxPxkV9ZUwM9p+SGEmyUSBAFn75z7reGD9CFOg5Hj5QlARLboPey806cMwTLMvYzZd0pgjlXD iVRBCf9o8KnO/ZuFvkcOC3MINNbRcni9ZtnTz/rc3SaLHEbTqDxXQTrMk+d3NgW4CnuyKzSFjdCVd4 WqAKhbtfOP/pT1Iv/WxD/aw6pP1QckeHGuEL+8w+UZ1pj4gnIugCkikiNBEzAhpBalr1Cu+H8imslB Pt8oQ6IhOe0MbNEn7DhUCOReaFTkFs7bUwtbuZzzzMGg==
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

Currently, struct efi_boot_memmap is a struct that is passed around
between callers of efi_get_memory_map() and the users of the resulting
data, and which carries pointers to various variables whose values are
provided by the EFI GetMemoryMap() boot service.

This is overly complex, and it is much easier to carry these values in
the struct itself. So turn the struct into one that carries these data
items directly, including a flex array for the variable number of EFI
memory descriptors that the boot service may return.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c      | 17 ++---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 26 ++++---
 drivers/firmware/efi/libstub/efistub.h         | 15 +---
 drivers/firmware/efi/libstub/fdt.c             | 37 +++++-----
 drivers/firmware/efi/libstub/mem.c             | 74 +++++++-------------
 drivers/firmware/efi/libstub/randomalloc.c     | 23 ++----
 drivers/firmware/efi/libstub/relocate.c        | 21 ++----
 drivers/firmware/efi/libstub/x86-stub.c        | 20 ++----
 include/linux/efi.h                            |  9 +++
 9 files changed, 85 insertions(+), 157 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 577173ee1f83..83b5ae3721ea 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -42,26 +42,17 @@ efi_status_t check_platform_features(void)
  */
 static bool check_image_region(u64 base, u64 size)
 {
-	unsigned long map_size, desc_size, buff_size;
-	efi_memory_desc_t *memory_map;
-	struct efi_boot_memmap map;
+	struct efi_boot_memmap *map;
 	efi_status_t status;
 	bool ret = false;
 	int map_offset;
 
-	map.map =	&memory_map;
-	map.map_size =	&map_size;
-	map.desc_size =	&desc_size;
-	map.desc_ver =	NULL;
-	map.key_ptr =	NULL;
-	map.buff_size =	&buff_size;
-
 	status = efi_get_memory_map(&map);
 	if (status != EFI_SUCCESS)
 		return false;
 
-	for (map_offset = 0; map_offset < map_size; map_offset += desc_size) {
-		efi_memory_desc_t *md = (void *)memory_map + map_offset;
+	for (map_offset = 0; map_offset < map->map_size; map_offset += map->desc_size) {
+		efi_memory_desc_t *md = (void *)map->map + map_offset;
 		u64 end = md->phys_addr + md->num_pages * EFI_PAGE_SIZE;
 
 		/*
@@ -74,7 +65,7 @@ static bool check_image_region(u64 base, u64 size)
 		}
 	}
 
-	efi_bs_call(free_pool, memory_map);
+	efi_bs_call(free_pool, map);
 
 	return ret;
 }
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 3d972061c1b0..85c68aa83673 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -419,7 +419,6 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 /**
  * efi_exit_boot_services() - Exit boot services
  * @handle:	handle of the exiting image
- * @map:	pointer to receive the memory map
  * @priv:	argument to be passed to @priv_func
  * @priv_func:	function to process the memory map before exiting boot services
  *
@@ -432,14 +431,13 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
  *
  * Return:	status code
  */
-efi_status_t efi_exit_boot_services(void *handle,
-				    struct efi_boot_memmap *map,
-				    void *priv,
+efi_status_t efi_exit_boot_services(void *handle, void *priv,
 				    efi_exit_boot_map_processing priv_func)
 {
+	struct efi_boot_memmap *map;
 	efi_status_t status;
 
-	status = efi_get_memory_map(map);
+	status = efi_get_memory_map(&map);
 
 	if (status != EFI_SUCCESS)
 		goto fail;
@@ -451,7 +449,7 @@ efi_status_t efi_exit_boot_services(void *handle,
 	if (efi_disable_pci_dma)
 		efi_pci_disable_bridge_busmaster();
 
-	status = efi_bs_call(exit_boot_services, handle, *map->key_ptr);
+	status = efi_bs_call(exit_boot_services, handle, map->map_key);
 
 	if (status == EFI_INVALID_PARAMETER) {
 		/*
@@ -467,13 +465,13 @@ efi_status_t efi_exit_boot_services(void *handle,
 		 * buffer should account for any changes in the map so the call
 		 * to get_memory_map() is expected to succeed here.
 		 */
-		*map->map_size = *map->buff_size;
+		map->map_size = map->buff_size;
 		status = efi_bs_call(get_memory_map,
-				     map->map_size,
-				     *map->map,
-				     map->key_ptr,
-				     map->desc_size,
-				     map->desc_ver);
+				     &map->map_size,
+				     &map->map,
+				     &map->map_key,
+				     &map->desc_size,
+				     &map->desc_ver);
 
 		/* exit_boot_services() was called, thus cannot free */
 		if (status != EFI_SUCCESS)
@@ -484,7 +482,7 @@ efi_status_t efi_exit_boot_services(void *handle,
 		if (status != EFI_SUCCESS)
 			goto fail;
 
-		status = efi_bs_call(exit_boot_services, handle, *map->key_ptr);
+		status = efi_bs_call(exit_boot_services, handle, map->map_key);
 	}
 
 	/* exit_boot_services() was called, thus cannot free */
@@ -494,7 +492,7 @@ efi_status_t efi_exit_boot_services(void *handle,
 	return EFI_SUCCESS;
 
 free_map:
-	efi_bs_call(free_pool, *map->map);
+	efi_bs_call(free_pool, map);
 fail:
 	return status;
 }
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index e9d466822b67..ed32055f0340 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -160,15 +160,6 @@ void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
  */
 #define EFI_MMAP_NR_SLACK_SLOTS	8
 
-struct efi_boot_memmap {
-	efi_memory_desc_t	**map;
-	unsigned long		*map_size;
-	unsigned long		*desc_size;
-	u32			*desc_ver;
-	unsigned long		*key_ptr;
-	unsigned long		*buff_size;
-};
-
 typedef struct efi_generic_dev_path efi_device_path_protocol_t;
 
 typedef void *efi_event_t;
@@ -850,9 +841,7 @@ typedef efi_status_t (*efi_exit_boot_map_processing)(
 	struct efi_boot_memmap *map,
 	void *priv);
 
-efi_status_t efi_exit_boot_services(void *handle,
-				    struct efi_boot_memmap *map,
-				    void *priv,
+efi_status_t efi_exit_boot_services(void *handle, void *priv,
 				    efi_exit_boot_map_processing priv_func);
 
 efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
@@ -891,7 +880,7 @@ void efi_apply_loadoptions_quirk(const void **load_options, int *load_options_si
 
 char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len);
 
-efi_status_t efi_get_memory_map(struct efi_boot_memmap *map);
+efi_status_t efi_get_memory_map(struct efi_boot_memmap **map);
 
 efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
 				unsigned long max);
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index bb141be6dfce..dce9747fe4c7 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -170,25 +170,25 @@ static efi_status_t update_fdt_memmap(void *fdt, struct efi_boot_memmap *map)
 	if (node < 0)
 		return EFI_LOAD_ERROR;
 
-	fdt_val64 = cpu_to_fdt64((unsigned long)*map->map);
+	fdt_val64 = cpu_to_fdt64((unsigned long)map->map);
 
 	err = fdt_setprop_inplace_var(fdt, node, "linux,uefi-mmap-start", fdt_val64);
 	if (err)
 		return EFI_LOAD_ERROR;
 
-	fdt_val32 = cpu_to_fdt32(*map->map_size);
+	fdt_val32 = cpu_to_fdt32(map->map_size);
 
 	err = fdt_setprop_inplace_var(fdt, node, "linux,uefi-mmap-size", fdt_val32);
 	if (err)
 		return EFI_LOAD_ERROR;
 
-	fdt_val32 = cpu_to_fdt32(*map->desc_size);
+	fdt_val32 = cpu_to_fdt32(map->desc_size);
 
 	err = fdt_setprop_inplace_var(fdt, node, "linux,uefi-mmap-desc-size", fdt_val32);
 	if (err)
 		return EFI_LOAD_ERROR;
 
-	fdt_val32 = cpu_to_fdt32(*map->desc_ver);
+	fdt_val32 = cpu_to_fdt32(map->desc_ver);
 
 	err = fdt_setprop_inplace_var(fdt, node, "linux,uefi-mmap-desc-ver", fdt_val32);
 	if (err)
@@ -198,22 +198,25 @@ static efi_status_t update_fdt_memmap(void *fdt, struct efi_boot_memmap *map)
 }
 
 struct exit_boot_struct {
+	struct efi_boot_memmap	*boot_memmap;
 	efi_memory_desc_t	*runtime_map;
 	int			runtime_entry_count;
 	void			*new_fdt_addr;
 };
 
-static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
-				   void *priv)
+static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
 {
 	struct exit_boot_struct *p = priv;
+
+	p->boot_memmap = map;
+
 	/*
 	 * Update the memory map with virtual addresses. The function will also
 	 * populate @runtime_map with copies of just the EFI_MEMORY_RUNTIME
 	 * entries so that we can pass it straight to SetVirtualAddressMap()
 	 */
 	if (!efi_novamap)
-		efi_get_virtmap(*map->map, *map->map_size, *map->desc_size,
+		efi_get_virtmap(map->map, map->map_size, map->desc_size,
 				p->runtime_map, &p->runtime_entry_count);
 
 	return update_fdt_memmap(p->new_fdt_addr, map);
@@ -244,20 +247,11 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 					    unsigned long fdt_addr,
 					    unsigned long fdt_size)
 {
-	unsigned long map_size, desc_size, buff_size;
+	unsigned long desc_size;
 	u32 desc_ver;
-	unsigned long mmap_key;
-	efi_memory_desc_t *memory_map;
 	efi_status_t status;
-	struct efi_boot_memmap map;
 	struct exit_boot_struct priv;
 
-	map.map_size	= &map_size;
-	map.desc_size	= &desc_size;
-	map.desc_ver	= &desc_ver;
-	map.key_ptr	= &mmap_key;
-	map.buff_size	= &buff_size;
-
 	if (!efi_novamap) {
 		status = efi_alloc_virtmap(&priv.runtime_map, &desc_size,
 					   &desc_ver);
@@ -269,7 +263,6 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 
 	efi_info("Exiting boot services...\n");
 
-	map.map = &memory_map;
 	status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, ULONG_MAX);
 	if (status != EFI_SUCCESS) {
 		efi_err("Unable to allocate memory for new device tree.\n");
@@ -287,7 +280,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 
 	priv.new_fdt_addr = (void *)*new_fdt_addr;
 
-	status = efi_exit_boot_services(handle, &map, &priv, exit_boot_func);
+	status = efi_exit_boot_services(handle, &priv, exit_boot_func);
 
 	if (status == EFI_SUCCESS) {
 		efi_set_virtual_address_map_t *svam;
@@ -306,6 +299,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 		 * incoming kernel but proceed normally otherwise.
 		 */
 		if (status != EFI_SUCCESS) {
+			efi_memory_desc_t *p;
 			int l;
 
 			/*
@@ -314,8 +308,9 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 			 * the incoming kernel that no virtual translation has
 			 * been installed.
 			 */
-			for (l = 0; l < map_size; l += desc_size) {
-				efi_memory_desc_t *p = (void *)memory_map + l;
+			for (l = 0; l < priv.boot_memmap->map_size;
+			     l += priv.boot_memmap->desc_size) {
+				p = (void *)priv.boot_memmap->map + l;
 
 				if (p->attribute & EFI_MEMORY_RUNTIME)
 					p->virt_addr = 0;
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index feef8d4be113..c92b7dbc6dfe 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -5,71 +5,45 @@
 
 #include "efistub.h"
 
-static inline bool mmap_has_headroom(unsigned long buff_size,
-				     unsigned long map_size,
-				     unsigned long desc_size)
-{
-	unsigned long slack = buff_size - map_size;
-
-	return slack / desc_size >= EFI_MMAP_NR_SLACK_SLOTS;
-}
-
 /**
  * efi_get_memory_map() - get memory map
- * @map:	on return pointer to memory map
+ * @map:		pointer to memory map pointer to which to assign the
+ *			newly allocated memory map
  *
  * Retrieve the UEFI memory map. The allocated memory leaves room for
  * up to EFI_MMAP_NR_SLACK_SLOTS additional memory map entries.
  *
  * Return:	status code
  */
-efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
+efi_status_t efi_get_memory_map(struct efi_boot_memmap **map)
 {
-	efi_memory_desc_t *m = NULL;
+	struct efi_boot_memmap *m, tmp;
 	efi_status_t status;
-	unsigned long key;
-	u32 desc_version;
+	unsigned long size;
 
-	*map->desc_size =	sizeof(*m);
-	*map->map_size =	*map->desc_size * 32;
-	*map->buff_size =	*map->map_size;
-again:
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
-			     *map->map_size, (void **)&m);
+	tmp.map_size = 0;
+	status = efi_bs_call(get_memory_map, &tmp.map_size, NULL, &tmp.map_key,
+			     &tmp.desc_size, &tmp.desc_ver);
+	if (status != EFI_BUFFER_TOO_SMALL)
+		return EFI_LOAD_ERROR;
+
+	size = tmp.map_size + tmp.desc_size * EFI_MMAP_NR_SLACK_SLOTS;
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(*m) + size,
+			     (void **)&m);
 	if (status != EFI_SUCCESS)
-		goto fail;
+		return status;
 
-	*map->desc_size = 0;
-	key = 0;
-	status = efi_bs_call(get_memory_map, map->map_size, m,
-			     &key, map->desc_size, &desc_version);
-	if (status == EFI_BUFFER_TOO_SMALL ||
-	    !mmap_has_headroom(*map->buff_size, *map->map_size,
-			       *map->desc_size)) {
-		efi_bs_call(free_pool, m);
-		/*
-		 * Make sure there is some entries of headroom so that the
-		 * buffer can be reused for a new map after allocations are
-		 * no longer permitted.  Its unlikely that the map will grow to
-		 * exceed this headroom once we are ready to trigger
-		 * ExitBootServices()
-		 */
-		*map->map_size += *map->desc_size * EFI_MMAP_NR_SLACK_SLOTS;
-		*map->buff_size = *map->map_size;
-		goto again;
-	}
+	m->buff_size = m->map_size = size;
+	status = efi_bs_call(get_memory_map, &m->map_size, m->map, &m->map_key,
+			     &m->desc_size, &m->desc_ver);
+	if (status != EFI_SUCCESS)
+		goto free_map;
 
-	if (status == EFI_SUCCESS) {
-		if (map->key_ptr)
-			*map->key_ptr = key;
-		if (map->desc_ver)
-			*map->desc_ver = desc_version;
-	} else {
-		efi_bs_call(free_pool, m);
-	}
+	*map = m;
+	return EFI_SUCCESS;
 
-fail:
-	*map->map = m;
+free_map:
+	efi_bs_call(free_pool, m);
 	return status;
 }
 
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 715f37479154..5d6000c717cc 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -55,20 +55,11 @@ efi_status_t efi_random_alloc(unsigned long size,
 			      unsigned long *addr,
 			      unsigned long random_seed)
 {
-	unsigned long map_size, desc_size, total_slots = 0, target_slot;
+	unsigned long total_slots = 0, target_slot;
 	unsigned long total_mirrored_slots = 0;
-	unsigned long buff_size;
+	struct efi_boot_memmap *map;
 	efi_status_t status;
-	efi_memory_desc_t *memory_map;
 	int map_offset;
-	struct efi_boot_memmap map;
-
-	map.map =	&memory_map;
-	map.map_size =	&map_size;
-	map.desc_size =	&desc_size;
-	map.desc_ver =	NULL;
-	map.key_ptr =	NULL;
-	map.buff_size =	&buff_size;
 
 	status = efi_get_memory_map(&map);
 	if (status != EFI_SUCCESS)
@@ -80,8 +71,8 @@ efi_status_t efi_random_alloc(unsigned long size,
 	size = round_up(size, EFI_ALLOC_ALIGN);
 
 	/* count the suitable slots in each memory map entry */
-	for (map_offset = 0; map_offset < map_size; map_offset += desc_size) {
-		efi_memory_desc_t *md = (void *)memory_map + map_offset;
+	for (map_offset = 0; map_offset < map->map_size; map_offset += map->desc_size) {
+		efi_memory_desc_t *md = (void *)map->map + map_offset;
 		unsigned long slots;
 
 		slots = get_entry_num_slots(md, size, ilog2(align));
@@ -109,8 +100,8 @@ efi_status_t efi_random_alloc(unsigned long size,
 	 * to calculate the randomly chosen address, and allocate it directly
 	 * using EFI_ALLOCATE_ADDRESS.
 	 */
-	for (map_offset = 0; map_offset < map_size; map_offset += desc_size) {
-		efi_memory_desc_t *md = (void *)memory_map + map_offset;
+	for (map_offset = 0; map_offset < map->map_size; map_offset += map->desc_size) {
+		efi_memory_desc_t *md = (void *)map->map + map_offset;
 		efi_physical_addr_t target;
 		unsigned long pages;
 
@@ -133,7 +124,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 		break;
 	}
 
-	efi_bs_call(free_pool, memory_map);
+	efi_bs_call(free_pool, map);
 
 	return status;
 }
diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
index 8ee9eb2b9039..cd80db33ab1e 100644
--- a/drivers/firmware/efi/libstub/relocate.c
+++ b/drivers/firmware/efi/libstub/relocate.c
@@ -23,21 +23,12 @@
 efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 				 unsigned long *addr, unsigned long min)
 {
-	unsigned long map_size, desc_size, buff_size;
-	efi_memory_desc_t *map;
+	struct efi_boot_memmap *map;
 	efi_status_t status;
 	unsigned long nr_pages;
 	int i;
-	struct efi_boot_memmap boot_map;
 
-	boot_map.map		= &map;
-	boot_map.map_size	= &map_size;
-	boot_map.desc_size	= &desc_size;
-	boot_map.desc_ver	= NULL;
-	boot_map.key_ptr	= NULL;
-	boot_map.buff_size	= &buff_size;
-
-	status = efi_get_memory_map(&boot_map);
+	status = efi_get_memory_map(&map);
 	if (status != EFI_SUCCESS)
 		goto fail;
 
@@ -52,12 +43,12 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 
 	size = round_up(size, EFI_ALLOC_ALIGN);
 	nr_pages = size / EFI_PAGE_SIZE;
-	for (i = 0; i < map_size / desc_size; i++) {
+	for (i = 0; i < map->map_size / map->desc_size; i++) {
 		efi_memory_desc_t *desc;
-		unsigned long m = (unsigned long)map;
+		unsigned long m = (unsigned long)map->map;
 		u64 start, end;
 
-		desc = efi_early_memdesc_ptr(m, desc_size, i);
+		desc = efi_early_memdesc_ptr(m, map->desc_size, i);
 
 		if (desc->type != EFI_CONVENTIONAL_MEMORY)
 			continue;
@@ -87,7 +78,7 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 		}
 	}
 
-	if (i == map_size / desc_size)
+	if (i == map->map_size / map->desc_size)
 		status = EFI_NOT_FOUND;
 
 	efi_bs_call(free_pool, map);
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 05ae8bcc9d67..1ae1e7e576b9 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -716,32 +716,22 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
 
 	efi_set_u64_split((unsigned long)efi_system_table,
 			  &p->efi->efi_systab, &p->efi->efi_systab_hi);
-	p->efi->efi_memdesc_size	= *map->desc_size;
-	p->efi->efi_memdesc_version	= *map->desc_ver;
-	efi_set_u64_split((unsigned long)*map->map,
+	p->efi->efi_memdesc_size	= map->desc_size;
+	p->efi->efi_memdesc_version	= map->desc_ver;
+	efi_set_u64_split((unsigned long)map->map,
 			  &p->efi->efi_memmap, &p->efi->efi_memmap_hi);
-	p->efi->efi_memmap_size		= *map->map_size;
+	p->efi->efi_memmap_size		= map->map_size;
 
 	return EFI_SUCCESS;
 }
 
 static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 {
-	unsigned long map_sz, key, desc_size, buff_size;
-	efi_memory_desc_t *mem_map;
 	struct setup_data *e820ext = NULL;
 	__u32 e820ext_size = 0;
 	efi_status_t status;
-	__u32 desc_version;
-	struct efi_boot_memmap map;
 	struct exit_boot_struct priv;
 
-	map.map			= &mem_map;
-	map.map_size		= &map_sz;
-	map.desc_size		= &desc_size;
-	map.desc_ver		= &desc_version;
-	map.key_ptr		= &key;
-	map.buff_size		= &buff_size;
 	priv.boot_params	= boot_params;
 	priv.efi		= &boot_params->efi_info;
 
@@ -750,7 +740,7 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 		return status;
 
 	/* Might as well exit boot services now */
-	status = efi_exit_boot_services(handle, &map, &priv, exit_boot_func);
+	status = efi_exit_boot_services(handle, &priv, exit_boot_func);
 	if (status != EFI_SUCCESS)
 		return status;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d2b84c2fec39..f1b3e0d1b3fa 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -518,6 +518,15 @@ typedef union {
 	efi_system_table_32_t mixed_mode;
 } efi_system_table_t;
 
+struct efi_boot_memmap {
+	unsigned long		map_size;
+	unsigned long		desc_size;
+	u32			desc_ver;
+	unsigned long		map_key;
+	unsigned long		buff_size;
+	efi_memory_desc_t	map[];
+};
+
 /*
  * Architecture independent structure for describing a memory map for the
  * benefit of efi_memmap_init_early(), and for passing context between
-- 
2.35.1

