Return-Path: <linux-efi+bounces-2369-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DC09ED567
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 20:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D2F282049
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 19:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A278248811;
	Wed, 11 Dec 2024 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeSLY7T/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2AE248FBC;
	Wed, 11 Dec 2024 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943154; cv=none; b=X30jD6Bzd03u6t8MbSEWuo6hMWtZzaMTZH4l1OXYF3+Xj8ynOmQkEcdfpXEHkN/lTkhd0oyyRp+oX/c1qeePr91aRmZq0/JziEu7V8F6a5RaYvMjODCNv37kQ5MiSfydSRsFOQ7U3C0JqVQIcz3lnVicVd3+zsoonFcUUOhl7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943154; c=relaxed/simple;
	bh=l/nACr1/gui4Ot7CYT7tF6FVb1oiQZbn/0HryvqdUyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyJ4JYcn6QRs+xVTH9aHWRdTmCUe5M9PP/lr7jXWTOOf7qmgEx7ExHJnu3ZUq6wEsZEqjhOsQoomWadov+3rHsrf0aSW/dOTxsO0hVf9jiq6L77Vx61q/gz9wtUghFEQtO9wpZZhpEFEqLQqyto/Gd4acEeZW+xGcfza54Xu64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeSLY7T/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0615BC4CED4;
	Wed, 11 Dec 2024 18:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943154;
	bh=l/nACr1/gui4Ot7CYT7tF6FVb1oiQZbn/0HryvqdUyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aeSLY7T/X80aVW6ZDHkCjgRQllVL9l4w+0Id+sJaS0bgw80fMrfNOiWNJggANV6fh
	 BmrpuGNvKELwvcGEyFqBZx33Qj5h3dbiG4CDKikUNWCwhVtGFsp7wxEE+Ha3rhBXdM
	 fjAMhI+moRjtfcaBLPHUn+OvVAUDF3yJ7eOof7AKcTVQI7WfcEt4sk51ej6hm7ZJmf
	 IhkauyfVbV4bXj7WdDo1wU/Aj7vQfBHUswWq/5KPY5DZGMW7SWJwXzxGabHMCoZCZs
	 cKtPrcA0d1Ksl83KTM46Br5rL83RcLlVt3DE/DryaAdCOeouZAj1vUDrcKD1/sCaKr
	 qifCtL+gCg7Rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Xuefeng Zhao <zhaoxuefeng@loongson.cn>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Tianyang Zhang <zhangtianyang@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	ardb@kernel.org,
	chenhuacai@kernel.org,
	linux-efi@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 10/23] LoongArch: Fix reserving screen info memory for above-4G firmware
Date: Wed, 11 Dec 2024 13:51:47 -0500
Message-ID: <20241211185214.3841978-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185214.3841978-1-sashal@kernel.org>
References: <20241211185214.3841978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.65
Content-Transfer-Encoding: 8bit

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 55dc2f8f263448f1e6c7ef135d08e640d5a4826e ]

Since screen_info.lfb_base is a __u32 type, an above-4G address need an
ext_lfb_base to present its higher 32bits. In init_screen_info() we can
use __screen_info_lfb_base() to handle this case for reserving screen
info memory.

Signed-off-by: Xuefeng Zhao <zhaoxuefeng@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index de4f3def4af0b..4ae77e9300d58 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -90,7 +90,7 @@ static void __init init_screen_info(void)
 	memset(si, 0, sizeof(*si));
 	early_memunmap(si, sizeof(*si));
 
-	memblock_reserve(screen_info.lfb_base, screen_info.lfb_size);
+	memblock_reserve(__screen_info_lfb_base(&screen_info), screen_info.lfb_size);
 }
 
 void __init efi_init(void)
-- 
2.43.0


