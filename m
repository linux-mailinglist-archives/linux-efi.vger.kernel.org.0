Return-Path: <linux-efi+bounces-6224-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH6yNAWdnmkZWgQAu9opvQ
	(envelope-from <linux-efi+bounces-6224-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 25 Feb 2026 07:56:05 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7280019290A
	for <lists+linux-efi@lfdr.de>; Wed, 25 Feb 2026 07:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64782301DD9F
	for <lists+linux-efi@lfdr.de>; Wed, 25 Feb 2026 06:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B1F2C21DF;
	Wed, 25 Feb 2026 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkEd7g1M"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EAC2C11CF;
	Wed, 25 Feb 2026 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002563; cv=none; b=EiNoE64Pvc17tekPqBPqAp1DCZIVw+Gnxx09jtDGzFCGoFJmhGXFro/Wcnc+HLoR6KdnxBWLL3Lf1fNbGyLpSmC0xEsMlhEFsQ65uCoBWSgSwydg+W521swnT7cNLOIMOtZ2O3SX/t9iDyWASGEM+oqbj9SFUs7QVZor9MuAz3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002563; c=relaxed/simple;
	bh=c8mFbnM9U8FHHhGL8ssz28X5TtDgBLCNoO42oAAqqbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKZf7bvkY80kSeVm4YAQ0fbEPE3JKH1qC7IpbOWqUEKVLhjdzjTSSamafGifVacvxcbsEQk38boon7DqSfGXbytOrwKSJOqEJP6yn7bydDrE8hbzsRuJYzRFVHjPPvj+HfPXKANYHtEV6I78977yGD3cNLZVLnQ3uteCF2nVVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkEd7g1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFC9C19425;
	Wed, 25 Feb 2026 06:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772002562;
	bh=c8mFbnM9U8FHHhGL8ssz28X5TtDgBLCNoO42oAAqqbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=SkEd7g1Mj5AaEydDMbFzILf8tBoIZJKGMp96yd43Y0MJCHTwM82ONmBCoNFtVZzHi
	 D3P290d01ENWEEEIIG6mu7AwkXcz2oytKekOZWQu+dD0ft0PXI3sQeWyIrx5I3NJwI
	 +ya5o+VP/DOq4cKJXsWxRf8sLm0ErJfFl0OB0gJ9TG3gfDFJy/QCpT2vHH6v4p+5tk
	 EjT2EPxH2vgE83Fk9bQ9nw6rQIXSrKgBhSSX4KXH+t6VOlPKfKQwLimrlDwFH6ZDSZ
	 bvZ/+w8VMNsmA9i9k2V2OryXWT4BtuDHTkp5B/HzSOdkm1DTUNIjY8tpr+kn7v9XrR
	 Ik6t3ZZdPL5fw==
From: Mike Rapoport <rppt@kernel.org>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH v2] x86/efi: defer freeing of boot services memory
Date: Wed, 25 Feb 2026 08:55:55 +0200
Message-ID: <20260225065555.2471844-1-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6224-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7280019290A
X-Rspamd-Action: no action

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

efi_free_boot_services() frees memory occupied by EFI_BOOT_SERVICES_CODE
and EFI_BOOT_SERVICES_DATA using memblock_free_late().

There are two issue with that: memblock_free_late() should be used for
memory allocated with memblock_alloc() while the memory reserved with
memblock_reserve() should be freed with free_reserved_area().

More acutely, with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
efi_free_boot_services() is called before deferred initialization of the
memory map is complete.

Benjamin Herrenschmidt reports that this causes a leak of ~140MB of
RAM on EC2 t3a.nano instances which only have 512MB or RAM.

If the freed memory resides in the areas that memory map for them is
still uninitialized, they won't be actually freed because
memblock_free_late() calls memblock_free_pages() and the latter skips
uninitialized pages.

Using free_reserved_area() at this point is also problematic because
__free_page() accesses the buddy of the freed page and that again might
end up in uninitialized part of the memory map.

Delaying the entire efi_free_boot_services() could be problematic
because in addition to freeing boot services memory it updates
efi.memmap without any synchronization and that's undesirable late in
boot when there is concurrency.

More robust approach is to only defer freeing of the EFI boot services
memory.

Split efi_free_boot_services() in two. First efi_unmap_boot_services()
collects ranges that should be freed into an array then
efi_free_boot_services() later frees them after deferred init is complete.

Link: https://lore.kernel.org/all/ec2aaef14783869b3be6e3c253b2dcbf67dbc12a.camel@kernel.crashing.org
Fixes: 916f676f8dc0 ("x86, efi: Retain boot service code until after switching to virtual mode")
Cc: <stable@vger.kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v1: https://lore.kernel.org/all/20260223075219.2348035-1-rppt@kernel.org
* update the commit message with correct function names (Ben)

 arch/x86/include/asm/efi.h          |  2 +-
 arch/x86/platform/efi/efi.c         |  2 +-
 arch/x86/platform/efi/quirks.c      | 55 +++++++++++++++++++++++++++--
 drivers/firmware/efi/mokvar-table.c |  2 +-
 4 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index f227a70ac91f..51b4cdbea061 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -138,7 +138,7 @@ extern void __init efi_apply_memmap_quirks(void);
 extern int __init efi_reuse_config(u64 tables, int nr_tables);
 extern void efi_delete_dummy_variable(void);
 extern void efi_crash_gracefully_on_page_fault(unsigned long phys_addr);
-extern void efi_free_boot_services(void);
+extern void efi_unmap_boot_services(void);
 
 void arch_efi_call_virt_setup(void);
 void arch_efi_call_virt_teardown(void);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index d00c6de7f3b7..d84c6020dda1 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -836,7 +836,7 @@ static void __init __efi_enter_virtual_mode(void)
 	}
 
 	efi_check_for_embedded_firmwares();
-	efi_free_boot_services();
+	efi_unmap_boot_services();
 
 	if (!efi_is_mixed())
 		efi_native_runtime_setup();
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 553f330198f2..35caa5746115 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -341,7 +341,7 @@ void __init efi_reserve_boot_services(void)
 
 		/*
 		 * Because the following memblock_reserve() is paired
-		 * with memblock_free_late() for this region in
+		 * with free_reserved_area() for this region in
 		 * efi_free_boot_services(), we must be extremely
 		 * careful not to reserve, and subsequently free,
 		 * critical regions of memory (like the kernel image) or
@@ -404,17 +404,33 @@ static void __init efi_unmap_pages(efi_memory_desc_t *md)
 		pr_err("Failed to unmap VA mapping for 0x%llx\n", va);
 }
 
-void __init efi_free_boot_services(void)
+struct efi_freeable_range {
+	u64 start;
+	u64 end;
+};
+
+static struct efi_freeable_range *ranges_to_free;
+
+void __init efi_unmap_boot_services(void)
 {
 	struct efi_memory_map_data data = { 0 };
 	efi_memory_desc_t *md;
 	int num_entries = 0;
+	int idx = 0;
+	size_t sz;
 	void *new, *new_md;
 
 	/* Keep all regions for /sys/kernel/debug/efi */
 	if (efi_enabled(EFI_DBG))
 		return;
 
+	sz = sizeof(*ranges_to_free) * efi.memmap.nr_map + 1;
+	ranges_to_free = kzalloc(sz, GFP_KERNEL);
+	if (!ranges_to_free) {
+		pr_err("Failed to allocate storage for freeable EFI regions\n");
+		return;
+	}
+
 	for_each_efi_memory_desc(md) {
 		unsigned long long start = md->phys_addr;
 		unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
@@ -471,7 +487,15 @@ void __init efi_free_boot_services(void)
 			start = SZ_1M;
 		}
 
-		memblock_free_late(start, size);
+		/*
+		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT parts of the memory
+		 * map are still not initialized and we can't reliably free
+		 * memory here.
+		 * Queue the ranges to free at a later point.
+		 */
+		ranges_to_free[idx].start = start;
+		ranges_to_free[idx].end = start + size;
+		idx++;
 	}
 
 	if (!num_entries)
@@ -512,6 +536,31 @@ void __init efi_free_boot_services(void)
 	}
 }
 
+static int __init efi_free_boot_services(void)
+{
+	struct efi_freeable_range *range = ranges_to_free;
+	unsigned long freed = 0;
+
+	if (!ranges_to_free)
+		return 0;
+
+	while (range->start) {
+		void *start = phys_to_virt(range->start);
+		void *end = phys_to_virt(range->end);
+
+		free_reserved_area(start, end, -1, NULL);
+		freed += (end - start);
+		range++;
+	}
+	kfree(ranges_to_free);
+
+	if (freed)
+		pr_info("Freeing EFI boot services memory: %ldK\n", freed / SZ_1K);
+
+	return 0;
+}
+arch_initcall(efi_free_boot_services);
+
 /*
  * A number of config table entries get remapped to virtual addresses
  * after entering EFI virtual mode. However, the kexec kernel requires
diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index 4ff0c2926097..6842aa96d704 100644
--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -85,7 +85,7 @@ static struct kobject *mokvar_kobj;
  * as an alternative to ordinary EFI variables, due to platform-dependent
  * limitations. The memory occupied by this table is marked as reserved.
  *
- * This routine must be called before efi_free_boot_services() in order
+ * This routine must be called before efi_unmap_boot_services() in order
  * to guarantee that it can mark the table as reserved.
  *
  * Implicit inputs:

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.51.0


