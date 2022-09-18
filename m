Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DB35BC01A
	for <lists+linux-efi@lfdr.de>; Sun, 18 Sep 2022 23:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIRVgO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 18 Sep 2022 17:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIRVgN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 18 Sep 2022 17:36:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481F813FAB
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 14:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DABF4B812A8
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 21:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA597C43470;
        Sun, 18 Sep 2022 21:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663536969;
        bh=pFFKtVvyGui788KkPIr8qCSZNOG59os7CxAM3GPqbwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4PnawotcUkGyB9QJD7jlK0op0/HjDykGILMFdaAKFvNB1YVLzUNbpXdLh+z9p8Si
         mvvil3ib1z+aCg3hRJOvWXmaBMY6ObiXuPQuz2yxAOLAtOB+Py1IYOWjnUPMjtT9vl
         LDPnUh1Toh+W8OXg6u0ABOOr4BI5zK03Pg+kd6AAQN2UR5KBIrX/ciP2XBDh7HWPkn
         21btCosjZNCvCfN75cZg2P5mhfevFCM7hkEqfYvntV7L2KppgOO8TDQ77Mpok3DB4u
         NUP3+1OOBaOH+Jexr7q2ZafDknUh4+VLuCNMmsDO/gItD4Urj1cMRvIIRAzUjmMh9N
         de0qY1LG9BrtQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, linux@armlinux.org.uk,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 05/12] efi: libstub: avoid efi_get_memory_map() for allocating the virt map
Date:   Sun, 18 Sep 2022 23:35:37 +0200
Message-Id: <20220918213544.2176249-6-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220918213544.2176249-1-ardb@kernel.org>
References: <20220918213544.2176249-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6231; i=ardb@kernel.org; h=from:subject; bh=pFFKtVvyGui788KkPIr8qCSZNOG59os7CxAM3GPqbwk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjJ48ik3xeBegCYYbjhN1J/gEU0eF7jTfVCyGH6+ZJ ooX+UxaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyePIgAKCRDDTyI5ktmPJDSZC/ 9Zxb9vu5oQJ1rP8p3RhN3pWA2ge5cJEwFZEXxIFitUOEvGeOPpZcvY7wZUMsYItq+SqoRR1uy2h73x kUtARR3Me7jwELSlxV9jDKvRBsqq+F2pR+XOAFNvGmtJktCJP8pabIEYPcR7CTgFi7hTK1wnVEttML y7UWDvfF66AAdW2WfijDfBGGVf1c3TACzBQry7BQr9xgvL4xUCyXE79zNa0rduKgUbJD6oPLtedCim 39x0/tBll1OLbXbWnc15+kGehGij+nkJSicJxyLowuf91BhBzWYyN0M6fMi0j0yiHf+OZYT1xpwWh1 UXcKyL+3StieFd7Sbzp2IYiE78W4Y2tRpg88olY4/DxuECuhYP74GYlF7ceZWG0oWeg3KnoyWiEiGI g7IrqTxpCYD8qcNovCKty7kLsJGJPYiw/Eis35lTWDLv6ka8nHu7bm7bXh2nVxZpMI2eCGjUY9UV3L 7jAK6ZWT6q3qKbT/3y0ERkaK4rdOjXvxaXloHPp6pwnQE=
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

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 31 ++++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h  |  2 ++
 drivers/firmware/efi/libstub/fdt.c      | 27 +++++------------
 3 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 97eaa487fdfd..6d9ce2c89576 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -319,6 +319,35 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
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
@@ -334,6 +363,8 @@ void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
 	efi_memory_desc_t *in, *out = runtime_map;
 	int l;
 
+	*count = 0;
+
 	for (l = 0; l < map_size; l += desc_size) {
 		u64 paddr, size;
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 02fb5f7c8eff..20705712deff 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -885,6 +885,8 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 
 void *get_fdt(unsigned long *fdt_size);
 
+efi_status_t efi_alloc_virtmap(efi_memory_desc_t **virtmap,
+			       unsigned long *desc_size, u32 *desc_ver);
 void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
 		     unsigned long desc_size, efi_memory_desc_t *runtime_map,
 		     int *count);
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 804f542be3f2..ab59889c38f1 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -199,7 +199,7 @@ static efi_status_t update_fdt_memmap(void *fdt, struct efi_boot_memmap *map)
 
 struct exit_boot_struct {
 	efi_memory_desc_t	*runtime_map;
-	int			*runtime_entry_count;
+	int			runtime_entry_count;
 	void			*new_fdt_addr;
 };
 
@@ -213,7 +213,7 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
 	 * entries so that we can pass it straight to SetVirtualAddressMap()
 	 */
 	efi_get_virtmap(*map->map, *map->map_size, *map->desc_size,
-			p->runtime_map, p->runtime_entry_count);
+			p->runtime_map, &p->runtime_entry_count);
 
 	return update_fdt_memmap(p->new_fdt_addr, map);
 }
@@ -246,26 +246,18 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
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
+	status = efi_alloc_virtmap(&priv.runtime_map, &desc_size, &desc_ver);
 	if (status != EFI_SUCCESS) {
 		efi_err("Unable to retrieve UEFI memory map.\n");
 		return status;
@@ -289,10 +281,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 		goto fail_free_new_fdt;
 	}
 
-	runtime_entry_count		= 0;
-	priv.runtime_map		= runtime_map;
-	priv.runtime_entry_count	= &runtime_entry_count;
-	priv.new_fdt_addr		= (void *)*new_fdt_addr;
+	priv.new_fdt_addr = (void *)*new_fdt_addr;
 
 	status = efi_exit_boot_services(handle, &map, &priv, exit_boot_func);
 
@@ -304,8 +293,8 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 
 		/* Install the new virtual address map */
 		svam = efi_system_table->runtime->set_virtual_address_map;
-		status = svam(runtime_entry_count * desc_size, desc_size,
-			      desc_ver, runtime_map);
+		status = svam(priv.runtime_entry_count * desc_size, desc_size,
+			      desc_ver, priv.runtime_map);
 
 		/*
 		 * We are beyond the point of no return here, so if the call to
@@ -337,7 +326,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	efi_free(MAX_FDT_SIZE, *new_fdt_addr);
 
 fail:
-	efi_system_table->boottime->free_pool(runtime_map);
+	efi_bs_call(free_pool, priv.runtime_map);
 
 	return EFI_LOAD_ERROR;
 }
-- 
2.35.1

