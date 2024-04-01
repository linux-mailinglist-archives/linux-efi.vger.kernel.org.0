Return-Path: <linux-efi+bounces-910-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF02B894249
	for <lists+linux-efi@lfdr.de>; Mon,  1 Apr 2024 18:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17C61C21B81
	for <lists+linux-efi@lfdr.de>; Mon,  1 Apr 2024 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63F74C3C3;
	Mon,  1 Apr 2024 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hsec50z5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC38481D1;
	Mon,  1 Apr 2024 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990275; cv=none; b=TRJxRWIyMaS9SBNGpW8tlBqaOytGOSxW3dzBwfXt4zi4124akb7Zl6PSpDxRdT4jkC4SN9Nd2U9tW9PK3cD05tzKuRCjJWgUYKKZBm80qYzhdZ162doizc4KZf2DVVMYz24xsCEbqOlLntf3sblGYQVs8hdm7iU132wys17ewHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990275; c=relaxed/simple;
	bh=JaHB1WCfSl+JRh0Aed6/FLQFQXdNaijhbRYev4Inkc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+ASVjeurnPWNfBDfAZH2CJMHBt/ePtrxqnqFStDe75a/IqsonL5jxgXdkUSPpm0okxkaoHy5Rpfu8hSe9vMkgUVDk0JVF3szuhzLjT9WuQdOV50Av6oKSq2rdW9VEQyMLdsurRZFoVJX4695LFc+gDEp1tfdSNTNN/dPVTBHsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hsec50z5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACE9C433C7;
	Mon,  1 Apr 2024 16:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990275;
	bh=JaHB1WCfSl+JRh0Aed6/FLQFQXdNaijhbRYev4Inkc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hsec50z5VueWVLhL2ryaxr11Fmp6IY9Ms0EUF3pYg/nyj0UruxdPA15ivpiqDQxMi
	 VD/L9LAQh5VmRxXG895mc3sC1OF2XzechtGWeWmi2kr8NRLR+BQAdU6tM9lYW7ishB
	 DNQ5z9p5kucOWipfA32zWUiWf58cqBRhxdER4Hvk=
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
Subject: [PATCH 6.6 300/396] efi/libstub: fix efi_random_alloc() to allocate memory at alloc_min or higher address
Date: Mon,  1 Apr 2024 17:45:49 +0200
Message-ID: <20240401152556.846021617@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 4e96a855fdf47..7e18528595502 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -120,7 +120,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 			continue;
 		}
 
-		target = round_up(md->phys_addr, align) + target_slot * align;
+		target = round_up(max(md->phys_addr, alloc_min), align) + target_slot * align;
 		pages = size / EFI_PAGE_SIZE;
 
 		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
-- 
2.43.0




