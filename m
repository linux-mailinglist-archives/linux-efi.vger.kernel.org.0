Return-Path: <linux-efi+bounces-111-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B3180448A
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 03:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718202813D4
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 02:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D1D4689;
	Tue,  5 Dec 2023 02:17:30 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
X-Greylist: delayed 82662 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 18:17:24 PST
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63E1A0
	for <linux-efi@vger.kernel.org>; Mon,  4 Dec 2023 18:17:24 -0800 (PST)
X-QQ-mid: bizesmtp87t1701742608te8bn6we
Received: from localhost.localdomain ( [222.92.8.138])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 05 Dec 2023 10:16:46 +0800 (CST)
X-QQ-SSF: 01400000000000F0W000000A0000000
X-QQ-FEAT: znfcQSa1hKbaTMdMuhJmUJCY/O3ft48KsgOP+SEg1ZGPiRy6EuHNbwcuJk7BQ
	l/6KgNtZxqEXtK55vAwRbCuBv2Y3bp/m95TpjItzZY9jWnlF5ERkUunjMleFYutChnQFMoD
	94wkpM7hvYTJdb1Fk4HLzWW9SfVeR/LOhzoXQmTPtRoeO/sPusSApLNFN/9GhdepBd+1VHr
	K8AEPSdHQjBs2BDQtlfR9NYWLqLdPv9rIdkBG+aqtgUPPZPR0+LxDhVDe0fbttTE4vQk1Qi
	BGl/AO1wgmziY1RJmWJlNhgHRtrwDh25vay9fq1jMRrQ/a/P5Io+6mcGRBAhfMUAtlqbquM
	CzDukbL7mlc5nXQXXYwEv7hm7L+Uk3Jmd2nvwWwtpZlK7gog5K69TJcnyvPOA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2008412575398817450
From: wangyao@lemote.com
To: ardb@kernel.org,
	chenhuacai@kernel.org,
	wangrui@loongson.cn
Cc: linux-efi@vger.kernel.org,
	ainux.wang@gmail.com,
	Wang Yao <wangyao@lemote.com>
Subject: [PATCH v2] efi/loongarch: Use load address to calculate kernel entry address
Date: Tue,  5 Dec 2023 10:16:35 +0800
Message-Id: <20231205021635.11663-1-wangyao@lemote.com>
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

The efi_relocate_kernel() may load the PIE kernel to anywhere, the load
address may not be equal to link address or EFI_KIMG_PREFERRED_ADDRESS.

Signed-off-by: Wang Yao <wangyao@lemote.com>
---

v1->v2:
Use link address that from DOS header to calculate kernel entry,
corrected by Huacai Chen.

 arch/loongarch/include/asm/efi.h              | 2 +-
 drivers/firmware/efi/libstub/loongarch-stub.c | 4 ++--
 drivers/firmware/efi/libstub/loongarch.c      | 7 ++++---
 3 files changed, 7 insertions(+), 6 deletions(-)

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
index 72c71ae201f0..4d52f1dc5258 100644
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
+	return (unsigned long)&kernel_entry - base + TO_CACHE(kernel_addr);
 }
diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
index 807cba2693fc..f17f3db55199 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -37,9 +37,10 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
 	return EFI_SUCCESS;
 }
 
-unsigned long __weak kernel_entry_address(void)
+unsigned long __weak kernel_entry_address(unsigned long kernel_addr)
 {
-	return *(unsigned long *)(PHYSADDR(VMLINUX_LOAD_ADDRESS) + 8);
+	return *(unsigned long *)(TO_CACHE(kernel_addr) + 8) -
+		VMLINUX_LOAD_ADDRESS + TO_CACHE(kernel_addr);
 }
 
 efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
@@ -73,7 +74,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
 	csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
 	csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
 
-	real_kernel_entry = (void *)kernel_entry_address();
+	real_kernel_entry = (void *)kernel_entry_address(kernel_addr);
 
 	real_kernel_entry(true, (unsigned long)cmdline_ptr,
 			  (unsigned long)efi_system_table);
-- 
2.27.0


