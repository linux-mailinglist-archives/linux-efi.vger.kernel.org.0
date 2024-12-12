Return-Path: <linux-efi+bounces-2375-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9419F086A
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2024 10:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7ED168B54
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2024 09:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25A91B3934;
	Fri, 13 Dec 2024 09:49:02 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F961AE005;
	Fri, 13 Dec 2024 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083342; cv=none; b=iFUYybASmEekrfxORJ+o3m34S0ScUbrFUqJUtBXkzut44jQjbwE9T5G5sFFkvG5cFez3GjqZbrXN/jl1RjpoXNxWa7NpYNwCwRv2PTT/AIArz3mTGzryX9ydbhf6WJ2E/3hm1GRP4H0COkFqgGgyP52+s0NiQBxSkP1LLPMfxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083342; c=relaxed/simple;
	bh=EohcMsvPiuOLpdxAi+0XNpLKVBcA1aQjf3X9xIKNa+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=vA9khxaWdORcXxOmGg6MdC0JKSkfIJ+PbzYPjqYALP3p3lbY5X5fJa9v6EDo2D9WE7x1xJs6xXXXdfq9KsbCYrujUeQL/HB5ty7z1Xel43D0mhOMzbz8rKgxnOz2a5asvDAEqZj/tonvZIAyXnJ+sKyPoN/sfF2I6mJx4ZWy2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3675c03011a3-eb9e3;
	Fri, 13 Dec 2024 17:48:53 +0800 (CST)
X-RM-TRANSID:2ee3675c03011a3-eb9e3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.96])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea675c02fdbdd-9e0a7;
	Fri, 13 Dec 2024 17:48:52 +0800 (CST)
X-RM-TRANSID:2eea675c02fdbdd-9e0a7
From: Zhou Ding <zhouding@cmss.chinamobile.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Zhou Ding <zhouding@cmss.chinamobile.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] efi: Fix missing `efi_handover_entry` prototype
Date: Fri, 13 Dec 2024 00:15:17 +0800
Message-Id: <20241212161517.443855-1-zhouding@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We get 1 error when building kernel withW=1:
drivers/firmware/efi/libstub/x86-stub.c:1068:6: error: no previous prototype for ‘efi_handover_entry’ [-Werror=missing-prototypes]
 1068 | void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
      |      ^~~~~~~~~~~~~~~~~~

As this function is only used in the file, mark it as 'static'.

Signed-off-by: Zhou Ding <zhouding@cmss.chinamobile.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 188c8000d245..4d152b0df59d 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -1065,7 +1065,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 }
 
 #ifdef CONFIG_EFI_HANDOVER_PROTOCOL
-void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
+static void  efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
 			struct boot_params *boot_params)
 {
 	memset(_bss, 0, _ebss - _bss);
-- 
2.33.0




