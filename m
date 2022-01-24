Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227994993DE
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jan 2022 21:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351906AbiAXUhv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Jan 2022 15:37:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35530 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385003AbiAXUb0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Jan 2022 15:31:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51AA1B8123F;
        Mon, 24 Jan 2022 20:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB3FC340E5;
        Mon, 24 Jan 2022 20:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643056274;
        bh=nVi2CTUQeOlTZN5lGXMJ/7/7klLVVusHmKxSq2MKub4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWJ8DDUU0CjAKsgDmZMDuwKPhw0taf9YhZMvkoBU8OGmSqwm/4/17a5t34EzHbEk5
         DAGt23Vpkg34tLXXnjrNLcWVMAqPU0zLD+1K1BNy4ljJSdFN3BCkQrygVagSVDcaUa
         r1n4g2WAqrUCxjWHPgmzpur/T43GSu9o2yqMySUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 428/846] efi: apply memblock cap after memblock_add()
Date:   Mon, 24 Jan 2022 19:39:05 +0100
Message-Id: <20220124184115.739459776@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124184100.867127425@linuxfoundation.org>
References: <20220124184100.867127425@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Pingfan Liu <kernelfans@gmail.com>

[ Upstream commit b398123bff3bcbc1facb0f29bf6e7b9f1bc55931 ]

On arm64, during kdump kernel saves vmcore, it runs into the following bug:
...
[   15.148919] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmem_cache_node' (offset 0, size 4096)!
[   15.159707] ------------[ cut here ]------------
[   15.164311] kernel BUG at mm/usercopy.c:99!
[   15.168482] Internal error: Oops - BUG: 0 [#1] SMP
[   15.173261] Modules linked in: xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm nvme nvme_core xgene_hwmon i2c_designware_platform i2c_designware_core dm_mirror dm_region_hash dm_log dm_mod overlay squashfs zstd_decompress loop
[   15.206186] CPU: 0 PID: 542 Comm: cp Not tainted 5.16.0-rc4 #1
[   15.212006] Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F12 (SCP: 1.5.20210426) 05/13/2021
[   15.221125] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   15.228073] pc : usercopy_abort+0x9c/0xa0
[   15.232074] lr : usercopy_abort+0x9c/0xa0
[   15.236070] sp : ffff8000121abba0
[   15.239371] x29: ffff8000121abbb0 x28: 0000000000003000 x27: 0000000000000000
[   15.246494] x26: 0000000080000400 x25: 0000ffff885c7000 x24: 0000000000000000
[   15.253617] x23: 000007ff80400000 x22: ffff07ff80401000 x21: 0000000000000001
[   15.260739] x20: 0000000000001000 x19: ffff07ff80400000 x18: ffffffffffffffff
[   15.267861] x17: 656a626f2042554c x16: 53206d6f72662064 x15: 6574636574656420
[   15.274983] x14: 74706d6574746120 x13: 2129363930342065 x12: 7a6973202c302074
[   15.282105] x11: ffffc8b041d1b148 x10: 00000000ffff8000 x9 : ffffc8b04012812c
[   15.289228] x8 : 00000000ffff7fff x7 : ffffc8b041d1b148 x6 : 0000000000000000
[   15.296349] x5 : 0000000000000000 x4 : 0000000000007fff x3 : 0000000000000000
[   15.303471] x2 : 0000000000000000 x1 : ffff07ff8c064800 x0 : 000000000000006b
[   15.310593] Call trace:
[   15.313027]  usercopy_abort+0x9c/0xa0
[   15.316677]  __check_heap_object+0xd4/0xf0
[   15.320762]  __check_object_size.part.0+0x160/0x1e0
[   15.325628]  __check_object_size+0x2c/0x40
[   15.329711]  copy_oldmem_page+0x7c/0x140
[   15.333623]  read_from_oldmem.part.0+0xfc/0x1c0
[   15.338142]  __read_vmcore.constprop.0+0x23c/0x350
[   15.342920]  read_vmcore+0x28/0x34
[   15.346309]  proc_reg_read+0xb4/0xf0
[   15.349871]  vfs_read+0xb8/0x1f0
[   15.353088]  ksys_read+0x74/0x100
[   15.356390]  __arm64_sys_read+0x28/0x34
...

This bug introduced by commit b261dba2fdb2 ("arm64: kdump: Remove custom
linux,usable-memory-range handling"), which moves
memblock_cap_memory_range() to fdt, but it breaches the rules that
memblock_cap_memory_range() should come after memblock_add() etc as said
in commit e888fa7bb882 ("memblock: Check memory add/cap ordering").

As a consequence, the virtual address set up by copy_oldmem_page() does
not bail out from the test of virt_addr_valid() in check_heap_object(),
and finally hits the BUG_ON().

Since memblock allocator has no idea about when the memblock is fully
populated, while efi_init() is aware, so tackling this issue by calling the
interface early_init_dt_check_for_usable_mem_range() exposed by of/fdt.

Fixes: b261dba2fdb2 ("arm64: kdump: Remove custom linux,usable-memory-range handling")
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Nick Terrell <terrelln@fb.com>
Cc: linux-arm-kernel@lists.infradead.org
To: devicetree@vger.kernel.org
To: linux-efi@vger.kernel.org
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20211215021348.8766-1-kernelfans@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/efi-init.c | 5 +++++
 drivers/of/fdt.c                | 2 +-
 include/linux/of_fdt.h          | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index b19ce1a83f91a..b2c829e95bd14 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -235,6 +235,11 @@ void __init efi_init(void)
 	}
 
 	reserve_regions();
+	/*
+	 * For memblock manipulation, the cap should come after the memblock_add().
+	 * And now, memblock is fully populated, it is time to do capping.
+	 */
+	early_init_dt_check_for_usable_mem_range();
 	efi_esrt_init();
 	efi_mokvar_table_init();
 
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 105b1a47905ab..32e5e782d43da 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -975,7 +975,7 @@ static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
  * early_init_dt_check_for_usable_mem_range - Decode usable memory range
  * location from flat tree
  */
-static void __init early_init_dt_check_for_usable_mem_range(void)
+void __init early_init_dt_check_for_usable_mem_range(void)
 {
 	const __be32 *prop;
 	int len;
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index cf6a65b94d40e..6508b97dbf1d2 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -62,6 +62,7 @@ extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
 				     int depth, void *data);
 extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
 				     int depth, void *data);
+extern void early_init_dt_check_for_usable_mem_range(void);
 extern int early_init_dt_scan_chosen_stdout(void);
 extern void early_init_fdt_scan_reserved_mem(void);
 extern void early_init_fdt_reserve_self(void);
@@ -87,6 +88,7 @@ extern void unflatten_and_copy_device_tree(void);
 extern void early_init_devtree(void *);
 extern void early_get_first_memblock_info(void *, phys_addr_t *);
 #else /* CONFIG_OF_EARLY_FLATTREE */
+static inline void early_init_dt_check_for_usable_mem_range(void) {}
 static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
 static inline void early_init_fdt_scan_reserved_mem(void) {}
 static inline void early_init_fdt_reserve_self(void) {}
-- 
2.34.1



