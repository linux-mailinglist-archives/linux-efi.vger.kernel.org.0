Return-Path: <linux-efi+bounces-280-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DFC81C4FC
	for <lists+linux-efi@lfdr.de>; Fri, 22 Dec 2023 07:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01EC01C2355F
	for <lists+linux-efi@lfdr.de>; Fri, 22 Dec 2023 06:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12B3C2CC;
	Fri, 22 Dec 2023 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y9Fq2YF/"
X-Original-To: linux-efi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70861C15D;
	Fri, 22 Dec 2023 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yU3iHmVkyNenY3Ygs6B97t6TKU1FGwCrzyLjAadn8qA=; b=Y9Fq2YF/D5TZGOGA4x9PVLHTu7
	t8KdUpe12ElY31I1fw1BNII8tZVdpsQUhtwLGiRqZ/R6P0Mqs9RHTPUAQVuwJiSt/CjYpPXOEO6e9
	6ngM04iYYVuImVC/wX0lsRYwUCymISnodJXj+GkL24n2DHNHSnMCwftLhrShyPA5WE9/7MjTGXpsG
	W2Yh5Xnkh1M+ByTUnbxymRz117uCptlnTkhVnw+XNczQpPQ+uYpZC0agq+9TWhW+LLRJjHG60eHqY
	DRmUHeHwsOffY88awAAqZ1KfOJ833401IzE/a3whouiCfmqoQuoe8YijoT6FxgKUjns160i1+sRs/
	VztGSgtQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGYsV-0053eM-38;
	Fri, 22 Dec 2023 06:19:24 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org
Subject: [PATCH] efi: memmap: fix kernel-doc warnings
Date: Thu, 21 Dec 2023 22:19:23 -0800
Message-ID: <20231222061923.10170-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct all kernel-doc notation to repair warnings that are
reported by scripts/kernel-doc:

memmap.c:38: warning: No description found for return value of '__efi_memmap_init'
memmap.c:82: warning: No description found for return value of 'efi_memmap_init_early'
memmap.c:132: warning: Function parameter or member 'addr' not described in 'efi_memmap_init_late'
memmap.c:132: warning: Excess function parameter 'phys_addr' description in 'efi_memmap_init_late'
memmap.c:132: warning: No description found for return value of 'efi_memmap_init_late'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/memmap.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff -- a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -32,7 +32,7 @@
  * space isn't setup.  Once the kernel is fully booted we can fallback
  * to the more robust memremap*() API.
  *
- * Returns zero on success, a negative error code on failure.
+ * Returns: zero on success, a negative error code on failure.
  */
 int __init __efi_memmap_init(struct efi_memory_map_data *data)
 {
@@ -77,6 +77,8 @@ int __init __efi_memmap_init(struct efi_
  *
  * Use early_memremap() to map the passed in EFI memory map and assign
  * it to efi.memmap.
+ *
+ * Returns: zero on success, a negative error code on failure.
  */
 int __init efi_memmap_init_early(struct efi_memory_map_data *data)
 {
@@ -107,7 +109,7 @@ void __init efi_memmap_unmap(void)
 
 /**
  * efi_memmap_init_late - Map efi.memmap with memremap()
- * @phys_addr: Physical address of the new EFI memory map
+ * @addr: Physical address of the new EFI memory map
  * @size: Size in bytes of the new EFI memory map
  *
  * Setup a mapping of the EFI memory map using ioremap_cache(). This
@@ -126,7 +128,7 @@ void __init efi_memmap_unmap(void)
  * runtime so that things like efi_mem_desc_lookup() and
  * efi_mem_attributes() always work.
  *
- * Returns zero on success, a negative error code on failure.
+ * Returns: zero on success, a negative error code on failure.
  */
 int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
 {

