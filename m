Return-Path: <linux-efi+bounces-516-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF6E852383
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 01:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18CA1C2343E
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 00:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03168535B1;
	Tue, 13 Feb 2024 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4tMrDxI"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43D535A7;
	Tue, 13 Feb 2024 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783561; cv=none; b=erUn24t0iJ4Pw2XhJ7mFLNBp1Z7vnK0J1gaHn6Siyx8ADptaM6YrKUAvXLqq73V4jSokz+msfE7ZdFCqzRHcmRnW7PZsyYie7xZ2R3u/eagNWBRfiDn/56SaNDpJtzgVan4TOj9xxItYGX2nJS0f2Y2CX7JOwCV37FikDtwvJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783561; c=relaxed/simple;
	bh=rSdm8GtcF5/59w8pl5EIjpl5PEXAZu1qIwxcy0H4qTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR08TikqTod/agcWo0w8Om3apyUUoQLskR5mqqkYyGJQ5KUiLuq7AwTSM4JEiJPHR6Gg/+7m/5R1QBq7Hd0Vtft0qU/mwDi0Fpc2A3wqR8Xj9dXRt5Jgn0FBw/CIfP/Fe0Nvh/8Kmrv0ONYdJVKu0tnOn83XPtHH2TPhqg0sYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4tMrDxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981CCC43394;
	Tue, 13 Feb 2024 00:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783561;
	bh=rSdm8GtcF5/59w8pl5EIjpl5PEXAZu1qIwxcy0H4qTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W4tMrDxI3pymGzBPnKbOJch2Uq6mv3Ce6dx3oIaxci0XLzIlZNE9qNkpNXSivnEy8
	 7oMlBuXE8GL4z6LFqk38EZSRSOuZStW+cHJydP6eJLylvuhRNfUfnxO78xFj/tzNbN
	 Hkq+VsE+GXLKRc5FucFNn86JkYLxXLcnzG4Z4C/hFhe2Nw0NbturM1xcTFPMTn3qOS
	 Zp350QP2d3W/WH1BsptU5goUyzjX9GvNDEpv6fBUx2ECvlue4j5YxmHvOgw8g5SQiX
	 q4RcTR2HpPLb5Wwe/Wnl/KTxG/3NW7X0LyNtXj0FSVvbgK/bgk5BEQGScNZ8m0Ignk
	 e6Mro3S8yigiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Bresticker <abrestic@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-efi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 33/58] efi: Don't add memblocks for soft-reserved memory
Date: Mon, 12 Feb 2024 19:17:39 -0500
Message-ID: <20240213001837.668862-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index d4987d013080..a00e07b853f2 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -143,15 +143,6 @@ static __init int is_usable_memory(efi_memory_desc_t *md)
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
@@ -196,6 +187,16 @@ static __init void reserve_regions(void)
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


