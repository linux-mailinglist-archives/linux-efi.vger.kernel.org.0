Return-Path: <linux-efi+bounces-911-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A513A8943AA
	for <lists+linux-efi@lfdr.de>; Mon,  1 Apr 2024 19:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611E4283954
	for <lists+linux-efi@lfdr.de>; Mon,  1 Apr 2024 17:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415D048CDD;
	Mon,  1 Apr 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LVBISFlc"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13815446B6;
	Mon,  1 Apr 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991196; cv=none; b=WHgjornnHruFSy0uT+8KXyQU17kxvh5XYf5ZuMkGM8r7P3NkBHAPuFmRAy5bB52ZTAOnXJsutMFcjG66VfjFddFBd5AVJaFreRPwcNR835FEM6yhjIhL8A34X+T0Lxw1KEozY+OGoUUYYQI+yzNaD5+nRXaS/FhyS58FmoLjKJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991196; c=relaxed/simple;
	bh=IUn9rlGtMqQ/fkR3wzenl7yv+FIXkxoGsD7rh5GLSco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7iPPl58SnZ4WoSkXLq6yQGDbwPn2IwWZUafoJdoMz3d8cmthJ6O4OlupWdxlll3RSerS6SIBtSmyCj7uKEWajFQ/KUcA0nk1DPpPKDRdOkttIc5StR6/Xmw0e9agbWCfP8THVqvEVHVqm9w4WK/vVK8DbCZ6o8sCYrnPkm3xX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LVBISFlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5BBC433C7;
	Mon,  1 Apr 2024 17:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711991195;
	bh=IUn9rlGtMqQ/fkR3wzenl7yv+FIXkxoGsD7rh5GLSco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LVBISFlciAObau30TzXre4DyU82ZXrIGCbpCWcFgu9lCw1vHTqGX0YgU5wIaGKkwm
	 3EOUfUBvBt2iuDb0Ryqai7CsXgpcX1KyTQlh08kTXunlLeF2RWuJdEGJhecIIe+ys1
	 SjQJg+kgFyUxQjeXigichTyGP6OpCWG115SsGCT4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-efi@vger.kernel.org,
	Tom Englund <tomenglund26@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kazuma Kondo <kazuma-kondo@nec.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 192/272] efi/libstub: fix efi_random_alloc() to allocate memory at alloc_min or higher address
Date: Mon,  1 Apr 2024 17:46:22 +0200
Message-ID: <20240401152536.879375205@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KONDO KAZUMA(近藤　和真) <kazuma-kondo@nec.com>

[ Upstream commit 3cb4a4827596abc82e55b80364f509d0fefc3051 ]

Following warning is sometimes observed while booting my servers:
  [    3.594838] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
  [    3.602918] swapper/0: page allocation failure: order:10, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0-1
  ...
  [    3.851862] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocation

If 'nokaslr' boot option is set, the warning always happens.

On x86, ZONE_DMA is small zone at the first 16MB of physical address
space. When this problem happens, most of that space seems to be used by
decompressed kernel. Thereby, there is not enough space at DMA_ZONE to
meet the request of DMA pool allocation.

The commit 2f77465b05b1 ("x86/efistub: Avoid placing the kernel below
LOAD_PHYSICAL_ADDR") tried to fix this problem by introducing lower
bound of allocation.

But the fix is not complete.

efi_random_alloc() allocates pages by following steps.
1. Count total available slots ('total_slots')
2. Select a slot ('target_slot') to allocate randomly
3. Calculate a starting address ('target') to be included target_slot
4. Allocate pages, which starting address is 'target'

In step 1, 'alloc_min' is used to offset the starting address of memory
chunk. But in step 3 'alloc_min' is not considered at all.  As the
result, 'target' can be miscalculated and become lower than 'alloc_min'.

When KASLR is disabled, 'target_slot' is always 0 and the problem
happens everytime if the EFI memory map of the system meets the
condition.

Fix this problem by calculating 'target' considering 'alloc_min'.

Cc: linux-efi@vger.kernel.org
Cc: Tom Englund <tomenglund26@gmail.com>
Cc: linux-kernel@vger.kernel.org
Fixes: 2f77465b05b1 ("x86/efistub: Avoid placing the kernel below LOAD_PHYSICAL_ADDR")
Signed-off-by: Kazuma Kondo <kazuma-kondo@nec.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/libstub/randomalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 7ba05719a53ba..0d7b11b55ff31 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -119,7 +119,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 			continue;
 		}
 
-		target = round_up(md->phys_addr, align) + target_slot * align;
+		target = round_up(max(md->phys_addr, alloc_min), align) + target_slot * align;
 		pages = size / EFI_PAGE_SIZE;
 
 		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
-- 
2.43.0




