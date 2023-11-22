Return-Path: <linux-efi+bounces-77-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1033A7F408D
	for <lists+linux-efi@lfdr.de>; Wed, 22 Nov 2023 09:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419B71C20754
	for <lists+linux-efi@lfdr.de>; Wed, 22 Nov 2023 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609711DA53;
	Wed, 22 Nov 2023 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D38198
	for <linux-efi@vger.kernel.org>; Wed, 22 Nov 2023 00:50:20 -0800 (PST)
X-QQ-mid: bizesmtp85t1700642948tx7gpque
Received: from localhost.localdomain ( [222.92.8.138])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Nov 2023 16:49:07 +0800 (CST)
X-QQ-SSF: 01400000000000F0W000000A0000000
X-QQ-FEAT: cvpDInk2tjUSz/CLefbREwnv7FUNP/GZytj+ox3ViHxjM3/htuGGpovxfA4m4
	jsMZE4ISEXUKywEDoof7+NqNMm/ZCxWh34ModylygZ9wNnBxbpWvkliNj6EyjCFpOTVJelR
	RZxeUegmrvcgi9IlRQS+7H465UOmdxCJRiOupKiUWHOApGL/J3suuL/UOyA4d0/dBKSH9u8
	d95Fzgnl1VQj/8KBv3zGviuM1tBgcoXJww6HHfksMsjZQU4r4hNBih97F9B6cjKBmHJ9F03
	Sq1kKel/bQ2T+Xh6TeqFo6zOC7NDUgx0oESmmp8oH0MDCA2K5OqXjmGKwGniSG/oGjjJ4n2
	sk6r9tfBMmy8btvyg/21+siu+i40ln8FIn9+WZ3riGULLElwfUgQ8yFlOGYU30DpFcsN13J
	i4Rpw6z81Lg=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8641457709918031096
From: wangyao@lemote.com
To: ardb@kernel.org,
	chenhuacai@kernel.org,
	wangrui@loongson.cn
Cc: linux-efi@vger.kernel.org,
	ainux.wang@gmail.com,
	Wang Yao <wangyao@lemote.com>
Subject: [PATCH] efi/loongarch: Change MMU translation mode
Date: Wed, 22 Nov 2023 16:49:06 +0800
Message-Id: <20231122084906.12476-1-wangyao@lemote.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lemote.com:qybglogicsvrgz:qybglogicsvrgz5a-2

From: Wang Yao <wangyao@lemote.com>

Refer ot UEFI spec v2.10 section 2.3.8 LoongArch Platforms:

The processor is in the following execution mode during boot service:
    ...
    The memory is in physical addressing mode. LoongArch architecture
    defines two memory access mode, namely direct address translation
    mode and mapped address translation mode.

So need to change MMU translation mode before config direct mapping.

Signed-off-by: Wang Yao <wangyao@lemote.com>
---
 drivers/firmware/efi/libstub/loongarch.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
index 807cba2693fc..4c0a84c58f5b 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -49,7 +49,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
 	struct exit_boot_struct priv;
 	unsigned long desc_size;
 	efi_status_t status;
-	u32 desc_ver;
+	u32 desc_ver, val;
 
 	status = efi_alloc_virtmap(&priv.runtime_map, &desc_size, &desc_ver);
 	if (status != EFI_SUCCESS) {
@@ -69,6 +69,12 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
 		    priv.runtime_entry_count * desc_size, desc_size,
 		    desc_ver, priv.runtime_map);
 
+	/* Change address translation mode */
+	val = csr_read32(LOONGARCH_CSR_CRMD);
+	val &= ~CSR_CRMD_DA;
+	val |= CSR_CRMD_PG;
+	csr_write32(val, LOONGARCH_CSR_CRMD);
+
 	/* Config Direct Mapping */
 	csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
 	csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
-- 
2.27.0


