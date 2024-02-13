Return-Path: <linux-efi+bounces-524-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2811A852509
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 02:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA78B27919
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 01:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3552712C7F3;
	Tue, 13 Feb 2024 00:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p82THCF1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96812C7E2;
	Tue, 13 Feb 2024 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783854; cv=none; b=HWbJ0JcBJhNiqOI+llWhErv4oL2eeHymvo72pZl94kmUWR8SWQUBEyQz31xW5CPt+0W5aGHq6jo3w2XGgN8uGOB7hyFEmhtXYBq/wSyIyxRXlSy9LqqsNpQDaiq97+ib3ImrMMJJDa4yiw0CwujG22eUx1NYJC6Ry96YCqewqq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783854; c=relaxed/simple;
	bh=dZdi5+4wLx6MYLCZl42TFJHToe2xGLEQryVfB/WG4fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekn4d2ZuxcfrZvOOhuQ4muOYlLRpLuddIa+DBDNOJE2h7dVuQh1E/Ls2wUZU/uULgGbNIqQqhwJqLXkzRvK/0rtmjVGplE36whpyMubsWcf9NLfgvD1BtUX6uTbX6tlIOZuIW/SpmYYnniFmY2DlGIoZGJPKgEzQL/act16maAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p82THCF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF73C43399;
	Tue, 13 Feb 2024 00:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783853;
	bh=dZdi5+4wLx6MYLCZl42TFJHToe2xGLEQryVfB/WG4fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p82THCF1EPmHOFGyNd6AIWsMHzcKRG7YPfjz8nSvLREeQlRveEW28m4HyjrYsYGaD
	 kpygTNtEvK2l4Y4PgWFilGHn2gT7o3hkbAxkbZ7qz3NsNkk0AxmSzkHvknQJf2wTDD
	 o4lFsJOs5MioS1jcZNlPnS2ohJf7y4TpZmN8Q1+Y/qKMeTK9r6/dCXicj4n/fboUEV
	 C4h33YOXmIXZMnbz/GDvH9MAIyNLIZf46EC0B71nI6mkyF5T3euoAztsxtU8q6QPQ/
	 8seePXLl2FFqnYnHxd7QvUhhD+PXhYFjT59Ok9aAfdbLeJJ+f7az6t1LroI5mT8gqK
	 WmY2Xla1Ir95A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Bresticker <abrestic@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-efi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/6] efi: Don't add memblocks for soft-reserved memory
Date: Mon, 12 Feb 2024 19:24:04 -0500
Message-ID: <20240213002409.673084-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002409.673084-1-sashal@kernel.org>
References: <20240213002409.673084-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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
index f55a92ff12c0..86da3c7a5036 100644
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


