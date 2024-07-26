Return-Path: <linux-efi+bounces-1497-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B449D93D2F6
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jul 2024 14:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6061828530E
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jul 2024 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAC217B4E9;
	Fri, 26 Jul 2024 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsjeyn54"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B4017B4E5;
	Fri, 26 Jul 2024 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996934; cv=none; b=Ne/zLAig/Nnh28tdxNP46r7tpcixy6WeFrZrSopmSXQnspUsUrubS0+eEskBwiz/rBKwcdorPgk0Cww81CFdY7cZdTzn04rDw1IK9kg4NSNmisgv/BGnuqWUpErfeJqbCZF/UONrYGPHzCk5v4/9AwBwGJGRfmeX4NohR3V15ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996934; c=relaxed/simple;
	bh=ltBSZmUJBJ6e/NJRHLoBmaLpPFhDGB99tH6MPZY5+4E=;
	h=From:Date:To:Cc:Subject:Message-Id:MIME-Version:Content-Type; b=anuMkWHZjOg198u2564C5JMgdQkW/xH7nyxtT7XDdlHvpjj0QoNgMiH5Dx4/4Rs3Sh72cWIACZZ6UCs3TbtgTk3cSCucu8lmAlTqYUfArF1+7ydjQ6oYmbYeLyv5muDcfkKovPtsNTX0kOCvWPFRGGVmgvDqMs1QXxoxf0zuoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsjeyn54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB43AC32782;
	Fri, 26 Jul 2024 12:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721996933;
	bh=ltBSZmUJBJ6e/NJRHLoBmaLpPFhDGB99tH6MPZY5+4E=;
	h=From:Date:To:Cc:Subject:Reply-To:From;
	b=dsjeyn54xdndmodhbg7ryYKfJn9ayZtykFLwaS/Hfd9zwdHsNlWadtK0QHS6Ox0Cz
	 axUcn4KZe7esbKuGeJ08bzOoYay4oZz5r2Lud/mH0nxPT/VrPGufhlV16QMt8ok/In
	 R7ZyQ/5C4hxwN2LoobwBRzQl+uHLmuFWMS8tiDp7T5l4eEh9ls39HGeyhtL253p+e/
	 n82fABLeYq+THZim4rBKikUGDljA2UvCmka984qDjY4ckbNGnAfntJdtbFwkwV/f0A
	 PB39dwZxJEdYi+RS3H6oeO+ehir7rU4hUMnjIupdUw+wZVg1CWD+GY98yMJvhrZFok
	 QODVLOoYrHd3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B26C3DA49;
	Fri, 26 Jul 2024 12:28:53 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Fri, 26 Jul 2024 17:17:53 +0800
To: loongarch@lists.linux.dev, linux-efi@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] loongarch/reset: use general efi poweroff
Message-Id: 4113cec4-4b4a-11ef-9897-937fbcdc8b5d@innull.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1434;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=XDs3wdvu3+QYu/+for1RcDYAw7kto4GBLMR2VGI+QJ4=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBmo5aEhzIJM0G8rZsR1UIC3sNm/MGdt3NT1aeFf
 c8TsarVlhSJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZqOWhAAKCRCwMePKe/7Z
 bqQoD/4qq6ob78WkErORRW3NXLffROp2/L38MynBBt+tXRVSwoLrzQNfaP/NEBhE3qAxlyupAT7
 X3kZ01peKpwnEibEPYhg6XTKkdREqanXvQKY1CaoLz0LOJ92g5l3d8mPKggCaN/RyjrN3pTDnIV
 o4cvMdZcaVuJ4y9LqXY2kSv9diTacx/NeaGnr09BhVZTYrD+kvfSO+jFU8e9/5Ug5kh2qiHOb7z
 k/7jyI3izMaUDeq9M6x/2M8NWTPrmvYFFxnEjttnPn9ohHXRr22cfjzKI0kaE/rwfWt/Mg3Hcqx
 fBoFOGOnuBYf+Sf9sHV/D6Ktmy2dS/dHBOfeiqz7vhEGBjWKpRzKZJiN2PVAsk1EXQTBLZBsvp5
 8kvymfQLU6F4RzADaDL/VZlfrLtC3p0UNh2i13cP/EIN1Zc7vcFcAOFVTO/2UXc/DSKtM2Yw5PD
 5D63Pdkc9qu0Dx6/jIPK3g07Zj72USdJDiR4+M74EfQNe2B+lNh97lq81PHnMgiBqYdN1cijayV
 2Nfl/0fjquz7qYgHnpFQouLm8wNSnsx5xJkcY3HNg6DkKW8RTjRhfJ3U1VTFUsC/fUrpx+xCgWO
 sZOa4hoclrv7w7QpwEJpCd6FMA82xsKmRIHP/AYzj/4wMJ8bfkRlZnfUayjNgKuwgET23AMu6yr
 nVhd9SpgflHFKuw==
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

Currently efi_shutdown_init can register a general sys_off handler,
efi_power_off, which will be called during do_kernel_power_off and shut
the machine off via efi runtime services. So enable this by providing
efi_poweroff_required, like arm and x86, and prevent directly calling
efi.reset_system in machine_power_off.

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 arch/loongarch/kernel/efi.c   | 5 +++++
 arch/loongarch/kernel/reset.c | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

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
diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
index 1ef8c6383535..9c8156798e8d 100644
--- a/arch/loongarch/kernel/reset.c
+++ b/arch/loongarch/kernel/reset.c
@@ -48,9 +48,6 @@ void machine_power_off(void)
 		enable_pci_wakeup();
 #endif
 	do_kernel_power_off();
-#ifdef CONFIG_EFI
-	efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
-#endif
 
 	while (true) {
 		__arch_cpu_idle();
-- 
2.39.2



