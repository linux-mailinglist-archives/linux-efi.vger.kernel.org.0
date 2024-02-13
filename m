Return-Path: <linux-efi+bounces-519-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C797A852480
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 01:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E001C23B41
	for <lists+linux-efi@lfdr.de>; Tue, 13 Feb 2024 00:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADF27C09F;
	Tue, 13 Feb 2024 00:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTDfEL7w"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540187CF1D;
	Tue, 13 Feb 2024 00:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783776; cv=none; b=bEzAgWsM5jSeKFEO8D8kL23onKiLtP9eNxd+pr9NwwaEiZTY1+NsbwW5whQgstuoyNEV3oKY+18wpmiGa1efRpn68fHMGqvRqICJMV4G3fvb4TCaEO8/B6kW//OckbWPR7nolSrQkFieVAEM8pjy11uYKOGQ3i203wCynmsAqpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783776; c=relaxed/simple;
	bh=gentspeUg3lNv4PK8QA7OTi5omE8+hd7xEAFzJeXqTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWocvs1RcvfqvuQxWRp5W/B/q0XRKK+YT4wL71UkAQA8gNyLr+VgJ4uYLM5ZAVpVUsVLhnbFGBeJI8OXfNP78Ehrr7wq61mF+Mdbc/sHqUleXjPi6YYY0Fii005hQoYKPKHU7ucI/ARr3VhuwGAAVr6FH5ZPAyeyEwUkkvPnNbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTDfEL7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B17C433C7;
	Tue, 13 Feb 2024 00:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783775;
	bh=gentspeUg3lNv4PK8QA7OTi5omE8+hd7xEAFzJeXqTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTDfEL7wbjvxaAPGofzRWncxs+63nv1vSg5CHL2IOW6HShcOIgo9kKULo8TN85QXW
	 UA519AR8uHFoaNSVvRWvj16vZ2EIeTO7R+JV5ip3o1YwRsuQ1i4XaDKgUJkbRJcx+d
	 58JLNz+z9U9gTddiiEpXRyPObswdaqOFdmy/LtHYMcV80zhCqim5i421x8qM3rtpVN
	 xCpVCaAqE3oQ90jWUlgHd5vr60lE7iBYs1nuADK2yhzxvaDcnU2ZMQEpUhyw8H07Pj
	 ipyGvia2p0bYCysmfARliDkVIf/BZy5rMhAnRYyAtNDtiMa5Q0hss527/S7zV0D3cw
	 ag0pDOf10heFA==
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
Subject: [PATCH AUTOSEL 6.1 15/28] efi: runtime: Fix potential overflow of soft-reserved region size
Date: Mon, 12 Feb 2024 19:22:13 -0500
Message-ID: <20240213002235.671934-15-sashal@kernel.org>
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
index 7c48c380d722..1995f0a2e0fc 100644
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
index d0daacd2c903..6b142aa35389 100644
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


