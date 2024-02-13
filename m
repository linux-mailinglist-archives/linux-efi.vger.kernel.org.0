Return-Path: <linux-efi+bounces-520-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BBD852483
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 01:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E3628570D
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 00:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4EF7E0E4;
	Tue, 13 Feb 2024 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxgd59/5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F667D419;
	Tue, 13 Feb 2024 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783777; cv=none; b=jFldvJvm+1Fx7eZKvgf0Kxqnu6NhmwhfyxEv+/9D2Q3KCmnp3kZqGvjJJSBIvH3Wb9FhnqahWIknuUGBRV8Nx2CM9chKkcwxS3CdFnoggPIM8W9MlZ2bpnHw/mtAdVidQYMTBW0+1L7g61Exd/7WkdSPJWD8iPdu5sdipRUDbAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783777; c=relaxed/simple;
	bh=7MoyJqrgQeXbVO7HFNFxHSUbIyJrrVVw15WdcgjXy8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkuL6y/VJm4uzkOS329mPC4bcfLVOQc7GZBHKsPWuQwH6N0d7gtqKhUHipVxllCnFPraqWyEeMxVdclg0no/QtC5rRBJTVxAlldgUJ0QzWuO2cMdbg+/h1uknDtfNiyZJYmawR4doVE+ehcpLsWo9AG8aSp4Fuv56VvI3wJ47RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxgd59/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46118C43390;
	Tue, 13 Feb 2024 00:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783777;
	bh=7MoyJqrgQeXbVO7HFNFxHSUbIyJrrVVw15WdcgjXy8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxgd59/5i5AXXtLWwrnfneEhAFi7MRDcxSQr3YU11LCBaMYScSKNlNblye4MyxZhs
	 36xrsbPGLnyz1m/spuT9Rcn23tVaaDpNfTmGNC+NnwJ431oimamt91bbqQvC1SbpSg
	 KN4lamE5ECLOGDjKijOD8vueOPaGXFcLviq5hW9V/2FbqypNlkZXASEe/ACNgHGB9Z
	 U84yCx4kGWeINP1MQatYyPzLnDPqaXfGkNdBlQFEu7X1G6m/bpOrtaLCbdrlixLY8q
	 zn5vevdlf+rgWeGHL+XIkxifW4F0cuaUvwaCkESt/S8Af12QWnSUJhGNLS+P7jXzTP
	 wMDgX/Fme4ZlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Bresticker <abrestic@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-efi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/28] efi: Don't add memblocks for soft-reserved memory
Date: Mon, 12 Feb 2024 19:22:14 -0500
Message-ID: <20240213002235.671934-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index 2fd770b499a3..ff9791ce2e15 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -116,15 +116,6 @@ static __init int is_usable_memory(efi_memory_desc_t *md)
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
@@ -169,6 +160,16 @@ static __init void reserve_regions(void)
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


