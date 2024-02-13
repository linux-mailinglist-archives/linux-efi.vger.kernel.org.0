Return-Path: <linux-efi+bounces-521-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE60E8524DC
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 02:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925691F22902
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 01:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72886129A63;
	Tue, 13 Feb 2024 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU5bHa6i"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C68129A60;
	Tue, 13 Feb 2024 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783830; cv=none; b=UGTP/V+YjqT3WnsqICE5bDeuDsHSxIWDWBVQOPSE2Jt7TE42eiwNTeIsrzy4RHWVuVxqCv16A96fGuWUi2/BgTL4oN0rtmMR085TMKRySvp2pEx5jU+Jeue7Cb2av90eHoDp4b2dQCsECCygqv/GFZHdyoXDF9TXophxd/YqT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783830; c=relaxed/simple;
	bh=Pn07thD0aJ/gRCqlLhA7LBD8t5v3filXzrlPtc3D2NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f73bjtP5XUAezYTP2iAw4uZbaSvlJcFryMdA2SBC2wEKrP2XLYEcM2v7okIrHZNx4ZnXEFB9h0cE4Nijur2gJ6K9GvG0+P7zcRgDZl70TgvdKEu7Dr8osrzUNigB3PTJRh1vupxZbSY9+eh14ayrIOyVxQBsq+nVLVnU31x8keM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MU5bHa6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907CEC43394;
	Tue, 13 Feb 2024 00:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783829;
	bh=Pn07thD0aJ/gRCqlLhA7LBD8t5v3filXzrlPtc3D2NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MU5bHa6iYrRu+3fJSjNoiHqTiQGQ0lBMi4PriHx/IFoogBas4y0Se0G8wkX3yyoUb
	 V8XRN24wP5ndF6ha64rk1USUWu3CDrrI6WVDKgJAV9Z6dbZkUrEbWHzvzZ7QvVa/ib
	 xDHpzas8Hl3PSkSvNy9iM+4muWQKjeASNEt3X01huWyI55DVoqs+sBkAIICUrm0EFG
	 /KjR7j8Vsw59dJtUeKjnO8R2WY9PtDkEz1NDJnhAG4v7PNi1XrVXrUeGI9zMQUX8iH
	 V7ej8WJ1J/NF0xQ9c6s15+yhO39KMOtC1VsZuTWZppu+yMBOeMAEsdszlGpWTklcve
	 WHnJG8F9Fsvvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Bresticker <abrestic@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-efi@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 14/22] efi: runtime: Fix potential overflow of soft-reserved region size
Date: Mon, 12 Feb 2024 19:23:16 -0500
Message-ID: <20240213002331.672583-14-sashal@kernel.org>
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

[ Upstream commit de1034b38a346ef6be25fe8792f5d1e0684d5ff4 ]

md_size will have been narrowed if we have >= 4GB worth of pages in a
soft-reserved region.

Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/arm-runtime.c   | 2 +-
 drivers/firmware/efi/riscv-runtime.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 3359ae2adf24..9054c2852580 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -107,7 +107,7 @@ static int __init arm_enable_runtime_services(void)
 		efi_memory_desc_t *md;
 
 		for_each_efi_memory_desc(md) {
-			int md_size = md->num_pages << EFI_PAGE_SHIFT;
+			u64 md_size = md->num_pages << EFI_PAGE_SHIFT;
 			struct resource *res;
 
 			if (!(md->attribute & EFI_MEMORY_SP))
diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
index d28e715d2bcc..6711e64eb0b1 100644
--- a/drivers/firmware/efi/riscv-runtime.c
+++ b/drivers/firmware/efi/riscv-runtime.c
@@ -85,7 +85,7 @@ static int __init riscv_enable_runtime_services(void)
 		efi_memory_desc_t *md;
 
 		for_each_efi_memory_desc(md) {
-			int md_size = md->num_pages << EFI_PAGE_SHIFT;
+			u64 md_size = md->num_pages << EFI_PAGE_SHIFT;
 			struct resource *res;
 
 			if (!(md->attribute & EFI_MEMORY_SP))
-- 
2.43.0


