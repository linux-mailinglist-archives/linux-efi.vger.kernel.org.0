Return-Path: <linux-efi+bounces-419-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF5283273D
	for <lists+linux-efi@lfdr.de>; Fri, 19 Jan 2024 11:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601A9284A2B
	for <lists+linux-efi@lfdr.de>; Fri, 19 Jan 2024 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9F83C09F;
	Fri, 19 Jan 2024 10:06:51 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356AA24B2C;
	Fri, 19 Jan 2024 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658811; cv=none; b=uw86kp3+U3hDxcqjzCdbKaYevxqzDJZqS8ilzNznEClP5Nc+QnQBXsD42J6yQ6ih0EpQsjOLHBMuUYwSci4KFcUcYIHxe9WkvJYz99vURJ8Vuv9QabPKo887QMlYREJgh17P59MZcwQMLiYBc7dESUdSL+6JcIyMpY1eNwlYpZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658811; c=relaxed/simple;
	bh=VJCGQXobIs8lfUw5OJy3Sa1KNxoL542YxU2hIThA74g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PFBOYod3Dj1R+YjMSjrCLJFscyQgr/pgvxWuhOvdsUqUKzPiCTpC0TbLE+bgfDH4hgsTJ+KbBTP7s0zioP5nvvnDG1kK1uTGaaxidc47ZfXohEAYuqGb5gj8l5HdX057pVGWMygS+0qUswJYbVHfjVffgNF61te1kQhUny7+btI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W-viZ4F_1705658797;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W-viZ4F_1705658797)
          by smtp.aliyun-inc.com;
          Fri, 19 Jan 2024 18:06:38 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: ardb@kernel.org
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] efi/libstub: Add one kernel-doc comment
Date: Fri, 19 Jan 2024 18:06:35 +0800
Message-Id: <20240119100635.12333-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the description of @memory_type to silence the warning:
drivers/firmware/efi/libstub/alignedmem.c:27: warning: Function parameter or struct member 'memory_type' not described in 'efi_allocate_pages_aligned'

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/firmware/efi/libstub/alignedmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmware/efi/libstub/alignedmem.c
index 6b83c492c3b8..8ff51c6a2aa1 100644
--- a/drivers/firmware/efi/libstub/alignedmem.c
+++ b/drivers/firmware/efi/libstub/alignedmem.c
@@ -14,6 +14,7 @@
  * @max:	the address that the last allocated memory page shall not
  *		exceed
  * @align:	minimum alignment of the base of the allocation
+ * @memory_type: the type of memory to allocate, as defined by efi_memory_type
  *
  * Allocate pages as EFI_LOADER_DATA. The allocated pages are aligned according
  * to @align, which should be >= EFI_ALLOC_ALIGN. The last allocated page will
-- 
2.20.1.7.g153144c


