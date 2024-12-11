Return-Path: <linux-efi+bounces-2368-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 301819ED514
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 19:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4627283D55
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 18:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D36623A1B8;
	Wed, 11 Dec 2024 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abKh4clN"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECAB23A1B1;
	Wed, 11 Dec 2024 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943064; cv=none; b=iwV3ZAYiR8sZga0HSvTE4gpot37m/llg34WAf0yvkcbPu4qd3vtHWXZxlr6LSdhr9EDdv3hQ0BW4JzTyIIhLPeibnb5YekE2hoS8nbQaG2D/9OpNPXtMDSXv9K4Q+sNSvgOds7IYs/iiWODJT1mtG2FjJkV4KJCx98/MW+iDreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943064; c=relaxed/simple;
	bh=XpjM7a+7izOGlFclTN59w0Ey+CkM7rqzLdE0f8idMNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nt7vJs82osF+rdlCaFJoy5sEeA4lYyU6C/AuK6EYdqfbQAnGqwFW/W3h03xRKJ1lf9gM9n4UHkfrb7mqGmeClKEQsZyQ05n/6y9uyPb0aSV2emHK2t8fSzbPm1XQVJD9HoyJpP4fTFsgSR9wWgpcEgrLOoxPaTnTyb+DnO4qxXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abKh4clN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DE8C4CED4;
	Wed, 11 Dec 2024 18:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943063;
	bh=XpjM7a+7izOGlFclTN59w0Ey+CkM7rqzLdE0f8idMNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abKh4clNNnlpW4MsBsHero2ZTK/YqZLZqlZAGKEkqgWZrRMF4pn2fODlK7n813/WE
	 /dtLsj3sqv07KIpwcVtW9KEiS6MIwkKlyISkMaep39tfYn/xoAeiGOSydAAfjn3Nos
	 M+mHE9mrj9tAK3lHtEz+yBOc8oQViLTIElqlb6bzGQ0/etYoMS7yENg25IcgIbS6l+
	 bno61RayjTIRUN5D+5u5IbkfLGWglpfvV4IUqiZ8FurtXLtMw8C7e0etoUztyx0UD0
	 peH0wcxdJOrotERLVbRUXXzaldJahbwtomB7JkxZ9Fy1CdOvy8nQ2O8y5ykjK59ceq
	 POJqj1Uv7IcnA==
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
Subject: [PATCH AUTOSEL 6.12 17/36] LoongArch: Fix reserving screen info memory for above-4G firmware
Date: Wed, 11 Dec 2024 13:49:33 -0500
Message-ID: <20241211185028.3841047-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
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
index 2bf86aeda874c..de21e72759eeb 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -95,7 +95,7 @@ static void __init init_screen_info(void)
 	memset(si, 0, sizeof(*si));
 	early_memunmap(si, sizeof(*si));
 
-	memblock_reserve(screen_info.lfb_base, screen_info.lfb_size);
+	memblock_reserve(__screen_info_lfb_base(&screen_info), screen_info.lfb_size);
 }
 
 void __init efi_init(void)
-- 
2.43.0


