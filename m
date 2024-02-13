Return-Path: <linux-efi+bounces-522-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D678524DF
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 02:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1AB1C23A94
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 01:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FABE129A7F;
	Tue, 13 Feb 2024 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diMySrVF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FBD129A76;
	Tue, 13 Feb 2024 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783831; cv=none; b=U9/MNB+v28IZ4gUXoCxaHcQb26TvFo2Q9ehKWmmz6ey3+ZpVBl15K9G4DzKDLnHKcljJ1YbxrcMxI6WTQMHFGK63t7Q85I7d4z3yzCgE7M17F+SqOsMPs3k12rng4zZP0kBLWaqZvy9IzOvjTTMNaHNzeKx3g7voJYMg8acExdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783831; c=relaxed/simple;
	bh=TH0bT3FCpZRnjsD4TrW+5wdXP+U1K+rITffT1EEfUtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEeuHq2oS4fYRir+DXj0fx16JRfNsu9Nl7jxV8bMtKV/LPjGV+LBWuWEkWbCG6to4ckfcWob947OH9+rfvV7BNJ9miWQYAoHIkD5qFj2dgu9MgBZU28DiF0xEJav5dzTk16RfaA3ph2DZK3ugQoe9akKFUcITjY5OnpiIOSmLF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diMySrVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C47BC433C7;
	Tue, 13 Feb 2024 00:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783830;
	bh=TH0bT3FCpZRnjsD4TrW+5wdXP+U1K+rITffT1EEfUtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diMySrVFnn/c6nVUrdJlYqyCcFN8mTgn724KAtC4kUnLSyzBNxa5oRJ2vRLFfYXwG
	 yvgIL5DXd0qzAgbRzHgm0/8XKZHzJZ0wT83wxuMIWKxjGp/Dgp3Sk1mR/0SSJ3heK7
	 ggbnBllX5CjauvxNd+dSWF6V323ebGMKeUvmUUwe3l4DtYXbZXw1pOs0mn49vAe4Tg
	 TPTMK7nlnSX07Qf7ubLlb6h+dZh9sgMYt3hthQQ0NIs3MwM47Pj37LW/bPHburGyn5
	 C4+TeQnki/WWQemNpajzlUoj4xEPA+RWck/j97by4tq2Bu0Hhiappyshd04+QKtB+K
	 mn32z0YWC1hhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Bresticker <abrestic@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-efi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 15/22] efi: Don't add memblocks for soft-reserved memory
Date: Mon, 12 Feb 2024 19:23:17 -0500
Message-ID: <20240213002331.672583-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002331.672583-1-sashal@kernel.org>
References: <20240213002331.672583-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Andrew Bresticker <abrestic@rivosinc.com>

[ Upstream commit 0bcff59ef7a652fcdc6d535554b63278c2406c8f ]

Adding memblocks for soft-reserved regions prevents them from later being
hotplugged in by dax_kmem.

Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/efi-init.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index b2c829e95bd1..4639ac6e4f9a 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -141,15 +141,6 @@ static __init int is_usable_memory(efi_memory_desc_t *md)
 	case EFI_BOOT_SERVICES_DATA:
 	case EFI_CONVENTIONAL_MEMORY:
 	case EFI_PERSISTENT_MEMORY:
-		/*
-		 * Special purpose memory is 'soft reserved', which means it
-		 * is set aside initially, but can be hotplugged back in or
-		 * be assigned to the dax driver after boot.
-		 */
-		if (efi_soft_reserve_enabled() &&
-		    (md->attribute & EFI_MEMORY_SP))
-			return false;
-
 		/*
 		 * According to the spec, these regions are no longer reserved
 		 * after calling ExitBootServices(). However, we can only use
@@ -194,6 +185,16 @@ static __init void reserve_regions(void)
 		size = npages << PAGE_SHIFT;
 
 		if (is_memory(md)) {
+			/*
+			 * Special purpose memory is 'soft reserved', which
+			 * means it is set aside initially. Don't add a memblock
+			 * for it now so that it can be hotplugged back in or
+			 * be assigned to the dax driver after boot.
+			 */
+			if (efi_soft_reserve_enabled() &&
+			    (md->attribute & EFI_MEMORY_SP))
+				continue;
+
 			early_init_dt_add_memory_arch(paddr, size);
 
 			if (!is_usable_memory(md))
-- 
2.43.0


