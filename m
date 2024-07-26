Return-Path: <linux-efi+bounces-1535-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B578949F50
	for <lists+linux-efi@lfdr.de>; Wed,  7 Aug 2024 07:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0721F257C3
	for <lists+linux-efi@lfdr.de>; Wed,  7 Aug 2024 05:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E3B197A97;
	Wed,  7 Aug 2024 05:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huhThRra"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C10197A93;
	Wed,  7 Aug 2024 05:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009504; cv=none; b=A3jQY2CeSdbuFFAHM6Uk1Zen/twb1QlEXH2WvDiDjgU/tR0tFejF5l8AmMGz8tYfNCSxFbybfgeYNBOLOWld9PZfk9j/j511yPk2M3T3GyPMn/qPVvUZeNz73BiEDhOsZBMJCqmXtumbeqPcvODpwDummrgs3iAN48L297T4VZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009504; c=relaxed/simple;
	bh=MHAj2cSWGuZ1s2/7wcsOkxdoSZUTXz0vSwZM9DW/RpY=;
	h=From:To:Cc:Message-Id:Date:Subject:MIME-Version:Content-Type; b=dVyNaF/cdUUSTyDUdylhULmelpUvp6Uu2f/ZwYUXBB5RNmQ0LEcpk36dYndYQwjB50TZ5qUpAQIi9VyFKQaZJOn4WzWs4RqMadGFDJVcjTA0ovO1pcGy+Cqs5BPs0yR+nIhvqw88PCZ+IfTcnuKPQxFj7+BgRdj55qFKz7pMAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huhThRra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0CE3C4AF0B;
	Wed,  7 Aug 2024 05:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723009503;
	bh=MHAj2cSWGuZ1s2/7wcsOkxdoSZUTXz0vSwZM9DW/RpY=;
	h=From:To:Cc:Date:Subject:Reply-To:From;
	b=huhThRra6+GSQKmJ8ywzLZXg9whb+CRin1aAUB+awc3VJ1OwE3N0hKNCHSkMaK06q
	 R/ySf68kc74hQeicyxPA4KN0a/0woFbY/uPofQuP2w0sTubZg9VnaXzRJ8MANJ4lVG
	 VJcTaPWEhN9qUYSiirLHjFXeg57QkvTQOEMHKL9HtY4eqLIypiz96vbhLFM2twGUL8
	 HcRhqmjDu+QCMnQRRTDfT78VWjNsQe5m+APjqWSGPxcTcnnSnbeUPtAFChZJ7aLA1h
	 7w8GoKsEjAVfACvAICAEOa1c8XZiBPBMTMTafpvh/Hu9RHNsjiV+s33k9aDJcc4V50
	 XTk7h299pPVlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7021C3DA7F;
	Wed,  7 Aug 2024 05:45:03 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
To: loongarch@lists.linux.dev, linux-efi@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Ard Biesheuvel <ardb@kernel.org>
Message-Id: b267d460-547f-11ef-a3fb-8fbda124b4d2@innull.com
Date: Fri, 26 Jul 2024 17:17:53 +0800
Subject: [PATCH] loongarch/efi: enable general efi poweroff
X-Developer-Signature: v=1; a=openpgp-sha256; l=801;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=xdT7amiL25/NY3W3LV47NbtJ6xdKD7qZEQCH7VFyDQA=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBmswncjBJ44qRkRgyLM6btDBL6YBI6qAKvUv4Gt
 nPtTJFmuDqJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZrMJ3AAKCRCwMePKe/7Z
 bvDpEACwNcrFx/+gbL3uoIISQ3jsTKx42C4ah4H2rHgUW9xjd6/aJWglVATtDqbnxBWTWrDKVBs
 mC8jqLIH+HBG3LmneJE4QppBYheE03vRCD3osF5EPxiXAtcmxjr1262EAAp9S8FmiWvz2I8klqk
 1sKPZNwwE2MH9KwskIYzDjs7pnND4YYkRLmywsA07nl5Hl55gDCaRsja5joln5isJabmJj7uy/r
 OQ0IFKdQ7eYv3UtwMr0i34WTiPbzT41/PGvUNDzk5Yg4l/zjikxJXpciLh4AAlT3+DjIQU61EzR
 MOstaZ+0KCZ+kAPQq94im6Psw7NJqbYoqlyKUSaZdl4nbJze/NHQGhm9LbF2arpx2hGnnv3OOC6
 FVStG47IpWTD3whTbRTh0OyNljyFoMAMjGb9HvlgWRCpqw5bzkPoQFgYZhhdEQMDV4IcTC3Kgos
 5gjpUUfhpOSpOXr6v7/Z4YGGzPBqB5nv7qA9iTqfrDh9+BF6miWNxHqvTx0eYeOdMo6ZkU5UI7a
 ea5KJ8rInANkMENmnj6gIYgbv/7sN8bOHlh/m2xxUIDjKI3hRvOnAf8pbXcr6ZpvNgVeKtqifvq
 r/S95mQoxRIZVxC5iJ4EPtj/AmhuBFWUzgEDOxmyuPwppjCWHp4nqsmKbCI1YoFkXdreMajJtmK
 Mt5VV37PWt2UEpg==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Miao Wang <shankerwangmiao@gmail.com>

efi_shutdown_init can register a general sys_off handler,
efi_power_off. Enable this by providing efi_poweroff_required,
like arm and x86, since this is also supported on loongarch.

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 arch/loongarch/kernel/efi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index 000825406c1f..df57c2674758 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -73,6 +73,11 @@ struct screen_info screen_info __section(".data");
 EXPORT_SYMBOL_GPL(screen_info);
 #endif
 
+bool efi_poweroff_required(void)
+{
+	return efi_enabled(EFI_RUNTIME_SERVICES);
+}
+
 static void __init init_screen_info(void)
 {
 	struct screen_info *si;
-- 
2.43.0



