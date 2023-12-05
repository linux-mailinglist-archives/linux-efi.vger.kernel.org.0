Return-Path: <linux-efi+bounces-116-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4878049B0
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 07:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2A31F21379
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 06:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4105FDDA1;
	Tue,  5 Dec 2023 06:04:45 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFC2C3
	for <linux-efi@vger.kernel.org>; Mon,  4 Dec 2023 22:04:40 -0800 (PST)
X-QQ-mid: bizesmtp80t1701756245twljyij2
Received: from localhost.localdomain ( [222.92.8.138])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 05 Dec 2023 14:04:04 +0800 (CST)
X-QQ-SSF: 01400000000000F0W000000A0000000
X-QQ-FEAT: +ynUkgUhZJlf78YvOoVV/84aGlZNXinW4AgexECViYawbvJaomPBNKuWNSnRL
	iEhzwkcoOfcJHQGZsAGkqY9aNfBMH+DK5zKcUAF3mUWDN5rGAQNSQaIiKk/5v7kU3xi2+HS
	7nAidKRn8DI9yqURQ/BKY+W9falMTv8Z2w10zP1jZLxj3pI4QrVaazctrduXv+4mTrtAWB8
	xoGCygQByJiMdcTqEckyOZjc/YezQGQtCb3v/1rxWSSs603ALm8bJZeslQg/fY+4Mfdy5Br
	a818AkD4a4KGQ98j9fhBfshfT2dKTH+WlUIcvOoCR5WXZRDHK3ELleMxr9h2CYDvF7fny3r
	g3P6cGEdwG/AJayjs2EXlJDAGWwUzW0KNcKBEdJ7Pl5i7a+xWTgi28OYy6a9bGHzIjSyDPT
	zTd9PcgSgrc=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3284024087540081101
From: wangyao@lemote.com
To: ardb@kernel.org,
	chenhuacai@kernel.org,
	wangrui@loongson.cn
Cc: linux-efi@vger.kernel.org,
	ainux.wang@gmail.com,
	Wang Yao <wangyao@lemote.com>
Subject: [PATCH v3 1/2] efi/loongarch: Use load address to calculate kernel entry address
Date: Tue,  5 Dec 2023 14:03:44 +0800
Message-Id: <20231205060345.7742-2-wangyao@lemote.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231205060345.7742-1-wangyao@lemote.com>
References: <20231205060345.7742-1-wangyao@lemote.com>
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

The efi_relocate_kernel() may load the PIE kernel to anywhere, the loaded
address may not be equal to link address or EFI_KIMG_PREFERRED_ADDRESS.

Signed-off-by: Wang Yao <wangyao@lemote.com>
---

v2->v3:
Dropped TO_CACHE:
kernel_addr may be DA/PG address, both access kernel entry.

v1->v2:
Use link address that from DOS header to calculate kernel entry,
corrected by Huacai Chen.

 arch/loongarch/include/asm/efi.h              | 2 +-
 drivers/firmware/efi/libstub/loongarch-stub.c | 4 ++--
 drivers/firmware/efi/libstub/loongarch.c      | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/asm/efi.h
index 091897d40b03..91d81f9730ab 100644
--- a/arch/loongarch/include/asm/efi.h
+++ b/arch/loongarch/include/asm/efi.h
@@ -32,6 +32,6 @@ static inline unsigned long efi_get_kimg_min_align(void)
 
 #define EFI_KIMG_PREFERRED_ADDRESS	PHYSADDR(VMLINUX_LOAD_ADDRESS)
 
-unsigned long kernel_entry_address(void);
+unsigned long kernel_entry_address(unsigned long kernel_addr);
 
 #endif /* _ASM_LOONGARCH_EFI_H */
diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
index 72c71ae201f0..d6ec5d4b8dbe 100644
--- a/drivers/firmware/efi/libstub/loongarch-stub.c
+++ b/drivers/firmware/efi/libstub/loongarch-stub.c
@@ -35,9 +35,9 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	return status;
 }
 
-unsigned long kernel_entry_address(void)
+unsigned long kernel_entry_address(unsigned long kernel_addr)
 {
 	unsigned long base = (unsigned long)&kernel_offset - kernel_offset;
 
-	return (unsigned long)&kernel_entry - base + VMLINUX_LOAD_ADDRESS;
+	return (unsigned long)&kernel_entry - base + kernel_addr;
 }
diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
index 807cba2693fc..0e0aa6cda73f 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -37,9 +37,9 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
 	return EFI_SUCCESS;
 }
 
-unsigned long __weak kernel_entry_address(void)
+unsigned long __weak kernel_entry_address(unsigned long kernel_addr)
 {
-	return *(unsigned long *)(PHYSADDR(VMLINUX_LOAD_ADDRESS) + 8);
+	return *(unsigned long *)(kernel_addr + 8) - VMLINUX_LOAD_ADDRESS + kernel_addr;
 }
 
 efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
@@ -73,7 +73,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
 	csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
 	csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
 
-	real_kernel_entry = (void *)kernel_entry_address();
+	real_kernel_entry = (void *)kernel_entry_address(kernel_addr);
 
 	real_kernel_entry(true, (unsigned long)cmdline_ptr,
 			  (unsigned long)efi_system_table);
-- 
2.27.0


