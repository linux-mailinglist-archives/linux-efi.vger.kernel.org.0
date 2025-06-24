Return-Path: <linux-efi+bounces-3946-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A92AE5EEB
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 10:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A0C4A1693
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 08:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BAB2571C3;
	Tue, 24 Jun 2025 08:19:00 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8879223BCFF;
	Tue, 24 Jun 2025 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753140; cv=none; b=XPMBh8gYtyiigPWfJ4cCbAjHPYj32r8rXEaKOWHhRQeT8Fk0eyIgGwGg8cw9GucgL8G5MoqiQytX7OpWyky9R6rIi39qqieX9g3qQnECMYFXNXxkUjGzNz4bQqJia3p+eu4bixZ+kqVV5rQ0FDSpQWy+ZVOc4eOPiOzz0kD8T6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753140; c=relaxed/simple;
	bh=z34k/rz5oU4KRhHSyCwlYWpvC4hE0GFChAVXhYLHPqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3LfUu8VgmxSeDAv5m5v8bBMluyaIgAslXsbBX7M2qBZ6CmlhJrzuSM2JcGsbsob4a1OtzA3tkT7O3VG7/zsZUnXWXUxI04ntMI+od7zUy75tY3O6TnpnPaG9ICxdjRML1PbtB5yTxPBiraRv82o/V057vYnCipUDZ1qNotyZhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.207.111.194])
	by gateway (Coremail) with SMTP id _____8Axx2ltX1poxxYcAQ--.28731S3;
	Tue, 24 Jun 2025 16:18:54 +0800 (CST)
Received: from ubuntu.. (unknown [111.207.111.194])
	by front1 (Coremail) with SMTP id qMiowMCxbsVsX1po5oYoAQ--.60731S2;
	Tue, 24 Jun 2025 16:18:53 +0800 (CST)
From: Ming Wang <wangming01@loongson.cn>
To: Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-efi@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: lixuefeng@loongson.cn,
	chenhuacai@loongson.cn,
	gaojuxin@loongson.cn
Subject: [PATCH] efi/loongarch: Reserve EFI memory map region
Date: Tue, 24 Jun 2025 16:18:52 +0800
Message-ID: <20250624081852.1563985-1-wangming01@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxbsVsX1po5oYoAQ--.60731S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAgEDEmhZ3+0IvAAAsl
X-Coremail-Antispam: 1Uk129KBj93XoW7CF1kuF1rCr4UXr48Aw4UWrX_yoW8Kr17p3
	4xAr4kKrs5AFn3X34xG3y8uF45ua93K34fWF9Iyr909ws8AF1xZr4ftFyY9ay2qr4kGw1j
	gFn8Ca4Iva1DJabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20x
	vEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jbYFAUUUUU=

The EFI memory map at 'boot_memmap' is crucial for kdump to understand
the primary kernel's memory layout. This memory region, typically part
of EFI Boot Services (BS) data, can be overwritten after ExitBootServices
if not explicitly preserved by the kernel.

This commit addresses this by:
1. Calling memblock_reserve() to reserve the entire physical region
   occupied by the EFI memory map (header + descriptors). This prevents
   the primary kernel from reallocating and corrupting this area.
2. Setting the EFI_PRESERVE_BS_REGIONS flag in efi.flags. This indicates
   that efforts have been made to preserve critical BS data regions,
   which can be useful for other kernel subsystems or debugging.

These changes ensure the original EFI memory map data remains intact,
improving kdump reliability and potentially aiding other EFI-related
functionalities that might rely on preserved BS data.

Signed-off-by: Ming Wang <wangming01@loongson.cn>
---
 arch/loongarch/kernel/efi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index de21e72759ee..98b1f0c030fc 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -135,6 +135,7 @@ void __init efi_init(void)
 	tbl = early_memremap_ro(boot_memmap, sizeof(*tbl));
 	if (tbl) {
 		struct efi_memory_map_data data;
+		phys_addr_t reserve_size = sizeof(*tbl) + tbl->map_size;
 
 		data.phys_map		= boot_memmap + sizeof(*tbl);
 		data.size		= tbl->map_size;
@@ -144,6 +145,18 @@ void __init efi_init(void)
 		if (efi_memmap_init_early(&data) < 0)
 			panic("Unable to map EFI memory map.\n");
 
+		/*
+		 * Reserve the physical memory region occupied by the EFI
+		 * memory map table (header + descriptors). This is crucial
+		 * for kdump, as the kdump kernel relies on this original
+		 * memmap passed by the bootloader. Without reservation,
+		 * this region could be overwritten by the primary kernel.
+		 * Also, set the EFI_PRESERVE_BS_REGIONS flag to indicate that
+		 * critical boot services data regions like this are preserved.
+		 */
+		memblock_reserve((phys_addr_t)boot_memmap, reserve_size);
+		set_bit(EFI_PRESERVE_BS_REGIONS, &efi.flags);
+
 		early_memunmap(tbl, sizeof(*tbl));
 	}
 
-- 
2.43.0


