Return-Path: <linux-efi+bounces-125-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30946806364
	for <lists+linux-efi@lfdr.de>; Wed,  6 Dec 2023 01:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF5D1F216C9
	for <lists+linux-efi@lfdr.de>; Wed,  6 Dec 2023 00:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3000D360;
	Wed,  6 Dec 2023 00:25:16 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC70AFA
	for <linux-efi@vger.kernel.org>; Tue,  5 Dec 2023 16:25:10 -0800 (PST)
X-QQ-mid: bizesmtp86t1701822269t3ll3ndp
Received: from localhost.localdomain ( [222.92.8.138])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 06 Dec 2023 08:24:28 +0800 (CST)
X-QQ-SSF: 01400000000000F0W000000A0000000
X-QQ-FEAT: VbOeDQvtdXOrpd9aicjQImh02BSBbiTkafwz0lSQn/1r8gbJcSqJNU1wh6q25
	zvpVeiUR1eJD1LLYOGE35jy1pRN9lJ9yKNG2V+MNpBJPESsDHinyklK9xafLULbDC7Vm5S9
	8LoGPRnIqCir9iUTpShUng2wjVhlVQenMFldk4z0EytWcZuAtCcXp1w6YEKBvgoe4nWILZR
	S70F33csDhBwBOV4kDDCUFqav86BIH/JDrjVsZE+Q33EjyQy+1jvnoX1cPLyigdK13suNHT
	Vtpik6fAWzFTaPYkW7d9jFKcq56Xc+YXZW3YAyiOb8AjSEVVNSgyuP5jx70QnlynQBfkQc4
	oMxp/kKynV2PDKRyCQ+WV43DPI3UgOAUmBLejOTS/Bzzv1jC6y/WaOeLDzlyw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 428872662590024513
From: wangyao@lemote.com
To: ardb@kernel.org,
	chenhuacai@kernel.org,
	wangrui@loongson.cn
Cc: linux-efi@vger.kernel.org,
	ainux.wang@gmail.com,
	Wang Yao <wangyao@lemote.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v4] efi/loongarch: Use load address to calculate kernel entry address
Date: Wed,  6 Dec 2023 08:24:27 +0800
Message-Id: <20231206002427.25480-1-wangyao@lemote.com>
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

The efi_relocate_kernel() may load the PIE kernel to anywhere, the loaded
address may not be equal to link address or EFI_KIMG_PREFERRED_ADDRESS.

Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Wang Yao <wangyao@lemote.com>
---

v3->v4:
Add Acked-by: Huacai Chen <chenhuacai@loongson.cn>

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


