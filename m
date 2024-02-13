Return-Path: <linux-efi+bounces-523-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8857852505
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 02:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661DD1F2452E
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 01:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B539927441;
	Tue, 13 Feb 2024 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K17b8BRD"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13712C7E3;
	Tue, 13 Feb 2024 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783852; cv=none; b=mpEeXF36Woy1LM1kvR5qfEmRopLsMkvEwgJxH5sCymEtUGO2GKu4snOy+iC+AYDRw2IqFfIFEphBS5ItBa16N1mnur9OG+KgD+EEPkjxIZ1AcdAQHKx7mEn9+XGyRY3nUHQmS7OyIlveEvzf/yN6lQanBYP3MAMJJMUj67kSri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783852; c=relaxed/simple;
	bh=Pn07thD0aJ/gRCqlLhA7LBD8t5v3filXzrlPtc3D2NY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lpMxN+95NTy88E7eCMRHpFghDCXH1W0PWIrGD9b7X4Og8tJBfqG4gB2d0/M/QbMpBiOtvFn3ESCCx4Y9BQeTLziDdTVuMhcwdwyq8mBRvKxKt5MCe5mSjIdUmEroD1IShMzSOo/AoyeJWy14HrtXw/3QrKuF5lYfhwv4AQE0+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K17b8BRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22279C433C7;
	Tue, 13 Feb 2024 00:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783852;
	bh=Pn07thD0aJ/gRCqlLhA7LBD8t5v3filXzrlPtc3D2NY=;
	h=From:To:Cc:Subject:Date:From;
	b=K17b8BRDXI9UUuYCQuEkx/LtHYQa8/raXBzAwPwXFrdqUFc+aNCFsiK4DBaZnaVy1
	 aXdes+Tn14bQ+6lradtiXUG/wpIwVXG4OeS3gdk3UA90Z4Ir9JoVuKnsA67RvLNTbh
	 /96xQW/BuUI1lVnsG6AIjabkL9Dal0rTLKvaJEVc+ecVBUaPrx7Cv3Vsn3bFPUq3kH
	 8rOpVbcQRDLKl1Puwjwl55fwmIV6MOlhSf+PL5Q40KA+S84iK+2K6UpDZ6jFf7LPqq
	 iE5Uk5THw9S1IxZqUUDuZl8FYeVmiGUmSzxAUd29Kkw0yo4/3h8afSaYb1NkOUJbb7
	 t8hjKLUipykhw==
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
Subject: [PATCH AUTOSEL 5.10 1/6] efi: runtime: Fix potential overflow of soft-reserved region size
Date: Mon, 12 Feb 2024 19:24:03 -0500
Message-ID: <20240213002409.673084-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
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


