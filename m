Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2C75BECDB
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 20:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiITSgL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 14:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiITSgJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 14:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D165E32B
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 11:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 684F962C79
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 18:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4D6C43140;
        Tue, 20 Sep 2022 18:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663698967;
        bh=6FrLs0rRuMLzth1sZebR/Vmp4FzCO0IUFNcooBgzI8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5JpTu4jK6hl7b7+0yGV22ry26sY9ianWvlvhypV8Ujf/kiCKDumj+QLiIGg/GXWS
         Z3GdT4t4Hswh4H7nTVyTPjshyloqzq0bReJB47JkTkTw4FlEevgnpD8KNwa31wvQh5
         G0MV0oep/8rdxubKRhyISvLKySfBmP7cStEB0gbrpJPPJN3hGDamgCq0pNnoaKeSV9
         am/fegSl5DuOxmcEy4mjFRZuxkDJtWaezGounQR8/6FbEErcUznJAmgNFpUh/DVbyg
         jtY1EsJsZEcmc+apjxfsR74ez2OG/8gPG4Hfg/eSDsKH8JqTJnz7tZrlu5LUXAL/Ts
         tLW6L/XAfgRXg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v2 2/8] efi: libstub: avoid efi_get_memory_map() for allocating the virt map
Date:   Tue, 20 Sep 2022 20:35:48 +0200
Message-Id: <20220920183554.3870247-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920183554.3870247-1-ardb@kernel.org>
References: <20220920183554.3870247-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6709; i=ardb@kernel.org; h=from:subject; bh=6FrLs0rRuMLzth1sZebR/Vmp4FzCO0IUFNcooBgzI8U=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKgf+bFevbQU1gctaPTUFebhtGAXgIF/WBEbg4pFO E/nn6W2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyoH/gAKCRDDTyI5ktmPJJgiC/ 9v7OJszUUqMstqJimoiAhF1MiLmlBiyb12UWZAvKWuj7hCKHXlaz34tgcz6IrB+Pspwt0xcEXNKMjI ITKKnqkk4M4JRE2KWBvS7KmxO56AW+kfgIorRQ70ECqttd4WJWw2pdhVvN9gfuF9lE+sHMyFtdK9Vo jdip96PCDhLTW0MpGetOw2UL6qsumic/OHgfBy4ds5pwbUKXsBPXxmtMMxjMHrGaAggsqFRxFCKOkH POl2MySwpS+dlHjzLDBgFiyPhVGx3jG6h6qkhyQPuNPEnUWg/SWh66aunr/vNFuFAPrwfNABERMf4X LjAHcChyYN8/cykMgDo8smVmzkaCCN23EKZw5I5ZzwOVFFcEfyTGmTLEA27GOjKv0/bmI1KaPtXqcB bc7AgrEkEvntqsJ4WycfUodBLztMLUIP6cFbpcN1K5UQPOiUdsTiDZXO49CXP0u1xrC6cliEjajuM3 AdfbNAjlQkpGO9B20yLMaWSwbSfRSF+/wmMnDolX7HItA=
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

The virt map is a set of efi_memory_desc_t descriptors that are passed
to SetVirtualAddressMap() to inform the firmware about the desired
virtual mapping of the regions marked as EFI_MEMORY_RUNTIME. The only
reason we currently call the efi_get_memory_map() helper is that it
gives us an allocation that is guaranteed to be of sufficient size.
However, efi_get_memory_map() has grown some additional complexity over
the years, and today, we're actually better off calling the EFI boot
service directly with a zero size, which tells us how much memory should
be enough for the virt map.

While at it, avoid fiddling with the VA map allocation if we will not be
using it anyway, i.e., if efi_novamap is true.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 31 ++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h  |  2 +
 drivers/firmware/efi/libstub/fdt.c      | 39 ++++++++------------
 3 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 4bf751484e8b..90d44834e33e 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -321,6 +321,35 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	return status;
 }
 
+/*
+ * efi_allocate_virtmap() - create a pool allocation for the virtmap
+ *
+ * Create an allocation that is of sufficient size to hold all the memory
+ * descriptors that will be passed to SetVirtualAddressMap() to inform the
+ * firmware about the virtual mapping that will be used under the OS to call
+ * into the firmware.
+ */
+efi_status_t efi_alloc_virtmap(efi_memory_desc_t **virtmap,
+			       unsigned long *desc_size, u32 *desc_ver)
+{
+	unsigned long size, mmap_key;
+	efi_status_t status;
+
+	/*
+	 * Use the size of the current memory map as an upper bound for the
+	 * size of the buffer we need to pass to SetVirtualAddressMap() to
+	 * cover all EFI_MEMORY_RUNTIME regions.
+	 */
+	size = 0;
+	status = efi_bs_call(get_memory_map, &size, NULL, &mmap_key, desc_size,
+			     desc_ver);
+	if (status != EFI_BUFFER_TOO_SMALL)
+		return EFI_LOAD_ERROR;
+
+	return efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
+			   (void **)virtmap);
+}
+
 /*
  * efi_get_virtmap() - create a virtual mapping for the EFI memory map
  *
@@ -336,6 +365,8 @@ void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
 	efi_memory_desc_t *in, *out = runtime_map;
 	int l;
 
+	*count = 0;
+
 	for (l = 0; l < map_size; l += desc_size) {
 		u64 paddr, size;
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index b0ae0a454404..e9d466822b67 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -864,6 +864,8 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 
 void *get_fdt(unsigned long *fdt_size);
 
+efi_status_t efi_alloc_virtmap(efi_memory_desc_t **virtmap,
+			       unsigned long *desc_size, u32 *desc_ver);
 void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
 		     unsigned long desc_size, efi_memory_desc_t *runtime_map,
 		     int *count);
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 804f542be3f2..bb141be6dfce 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -199,7 +199,7 @@ static efi_status_t update_fdt_memmap(void *fdt, struct efi_boot_memmap *map)
 
 struct exit_boot_struct {
 	efi_memory_desc_t	*runtime_map;
-	int			*runtime_entry_count;
+	int			runtime_entry_count;
 	void			*new_fdt_addr;
 };
 
@@ -212,8 +212,9 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
 	 * populate @runtime_map with copies of just the EFI_MEMORY_RUNTIME
 	 * entries so that we can pass it straight to SetVirtualAddressMap()
 	 */
-	efi_get_virtmap(*map->map, *map->map_size, *map->desc_size,
-			p->runtime_map, p->runtime_entry_count);
+	if (!efi_novamap)
+		efi_get_virtmap(*map->map, *map->map_size, *map->desc_size,
+				p->runtime_map, &p->runtime_entry_count);
 
 	return update_fdt_memmap(p->new_fdt_addr, map);
 }
@@ -246,29 +247,24 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	unsigned long map_size, desc_size, buff_size;
 	u32 desc_ver;
 	unsigned long mmap_key;
-	efi_memory_desc_t *memory_map, *runtime_map;
+	efi_memory_desc_t *memory_map;
 	efi_status_t status;
-	int runtime_entry_count;
 	struct efi_boot_memmap map;
 	struct exit_boot_struct priv;
 
-	map.map		= &runtime_map;
 	map.map_size	= &map_size;
 	map.desc_size	= &desc_size;
 	map.desc_ver	= &desc_ver;
 	map.key_ptr	= &mmap_key;
 	map.buff_size	= &buff_size;
 
-	/*
-	 * Get a copy of the current memory map that we will use to prepare
-	 * the input for SetVirtualAddressMap(). We don't have to worry about
-	 * subsequent allocations adding entries, since they could not affect
-	 * the number of EFI_MEMORY_RUNTIME regions.
-	 */
-	status = efi_get_memory_map(&map);
-	if (status != EFI_SUCCESS) {
-		efi_err("Unable to retrieve UEFI memory map.\n");
-		return status;
+	if (!efi_novamap) {
+		status = efi_alloc_virtmap(&priv.runtime_map, &desc_size,
+					   &desc_ver);
+		if (status != EFI_SUCCESS) {
+			efi_err("Unable to retrieve UEFI memory map.\n");
+			return status;
+		}
 	}
 
 	efi_info("Exiting boot services...\n");
@@ -289,10 +285,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 		goto fail_free_new_fdt;
 	}
 
-	runtime_entry_count		= 0;
-	priv.runtime_map		= runtime_map;
-	priv.runtime_entry_count	= &runtime_entry_count;
-	priv.new_fdt_addr		= (void *)*new_fdt_addr;
+	priv.new_fdt_addr = (void *)*new_fdt_addr;
 
 	status = efi_exit_boot_services(handle, &map, &priv, exit_boot_func);
 
@@ -304,8 +297,8 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 
 		/* Install the new virtual address map */
 		svam = efi_system_table->runtime->set_virtual_address_map;
-		status = svam(runtime_entry_count * desc_size, desc_size,
-			      desc_ver, runtime_map);
+		status = svam(priv.runtime_entry_count * desc_size, desc_size,
+			      desc_ver, priv.runtime_map);
 
 		/*
 		 * We are beyond the point of no return here, so if the call to
@@ -337,7 +330,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	efi_free(MAX_FDT_SIZE, *new_fdt_addr);
 
 fail:
-	efi_system_table->boottime->free_pool(runtime_map);
+	efi_bs_call(free_pool, priv.runtime_map);
 
 	return EFI_LOAD_ERROR;
 }
-- 
2.35.1

