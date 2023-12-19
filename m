Return-Path: <linux-efi+bounces-245-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B9581843A
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 10:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE01BB221A7
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 09:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAB412B92;
	Tue, 19 Dec 2023 09:15:15 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BED12B8F
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lemote.com
X-QQ-mid: bizesmtp64t1702977259t2970dd0
Received: from localhost.localdomain ( [222.92.8.138])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 Dec 2023 17:14:17 +0800 (CST)
X-QQ-SSF: 01400000000000F0W000000A0000000
X-QQ-FEAT: 3M0okmaRx3gI68gvm5PC//sdR7TLjWe8IEPWlqj3mH2om/oXzliO0Ig6agW1a
	TBjiw0jVz0x8M8LGp3gEQO8XV0AbYIsea4kbXWeeQXrchDa/jD/4oaFI88Op5JtnW8UBf11
	Nmqw8RvYIfcDf+2on3C4KZ41tMJfisJRi38zJTuaET/zs5mkRiGsrzl7CgtULNPRTcFlWVn
	6dBC58OySHIjDKljrj9sdls3K0y582YnTBsbGYU13TWSTYmECSZA6qTHz5ARH0dKnKhJJCU
	wfbVZF06dlzBWAc6kHAg79/nEzUmV0j6nqmNrPO21Hkvne9ePFt+MCHK2YZoPdwNnFfoXki
	8JOoy5HSbHWGwpGM/H3qRk8warfM6jJjnuUBagNoVungvg+YtmRF5N6S1ojkjAgf+IhJt1f
	dgumg8PR0us=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1808519183388347091
From: wangyao@lemote.com
To: ardb@kernel.org,
	chenhuacai@kernel.org,
	wangrui@loongson.cn
Cc: linux-efi@vger.kernel.org,
	loongarch@lists.linux.dev,
	ainux.wang@gmail.com,
	Wang Yao <wangyao@lemote.com>
Subject: [PATCH v2] efi/loongarch: Directly position the loaded image file
Date: Tue, 19 Dec 2023 17:14:05 +0800
Message-Id: <20231219091405.39867-1-wangyao@lemote.com>
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

The use of the 'kernel_offset' variable to position the image file that
has been loaded by UEFI or GRUB is unnecessary, because we can directly
position the loaded image file through using the image_base field of the
efi_loaded_image struct provided by UEFI.

Replace kernel_offset with image_base to positon the image file that has
been loaded by UEFI or GRUB.

Signed-off-by: Wang Yao <wangyao@lemote.com>
---

v1->v2:
Rewrite the commit log include 'why', not just include 'how'.

 arch/loongarch/include/asm/efi.h              | 2 --
 arch/loongarch/kernel/head.S                  | 1 -
 arch/loongarch/kernel/image-vars.h            | 1 -
 arch/loongarch/kernel/vmlinux.lds.S           | 1 -
 drivers/firmware/efi/libstub/loongarch-stub.c | 9 +++++----
 drivers/firmware/efi/libstub/loongarch-stub.h | 4 ++++
 drivers/firmware/efi/libstub/loongarch.c      | 6 ++++--
 7 files changed, 13 insertions(+), 11 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.h

diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/asm/efi.h
index 91d81f9730ab..eddc8e79b3fa 100644
--- a/arch/loongarch/include/asm/efi.h
+++ b/arch/loongarch/include/asm/efi.h
@@ -32,6 +32,4 @@ static inline unsigned long efi_get_kimg_min_align(void)
 
 #define EFI_KIMG_PREFERRED_ADDRESS	PHYSADDR(VMLINUX_LOAD_ADDRESS)
 
-unsigned long kernel_entry_address(unsigned long kernel_addr);
-
 #endif /* _ASM_LOONGARCH_EFI_H */
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 53b883db0786..0ecab4216392 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -34,7 +34,6 @@ pe_header:
 
 SYM_DATA(kernel_asize, .long _kernel_asize);
 SYM_DATA(kernel_fsize, .long _kernel_fsize);
-SYM_DATA(kernel_offset, .long _kernel_offset);
 
 #endif
 
diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
index 5087416b9678..41ddcf56d21c 100644
--- a/arch/loongarch/kernel/image-vars.h
+++ b/arch/loongarch/kernel/image-vars.h
@@ -11,7 +11,6 @@ __efistub_strcmp		= strcmp;
 __efistub_kernel_entry		= kernel_entry;
 __efistub_kernel_asize		= kernel_asize;
 __efistub_kernel_fsize		= kernel_fsize;
-__efistub_kernel_offset		= kernel_offset;
 #if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
 __efistub_screen_info		= screen_info;
 #endif
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index bb2ec86f37a8..a5d0cd2035da 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -143,7 +143,6 @@ SECTIONS
 	_kernel_fsize = _edata - _text;
 	_kernel_vsize = _end - __initdata_begin;
 	_kernel_rsize = _edata - __initdata_begin;
-	_kernel_offset = kernel_offset - _text;
 #endif
 
 	.gptab.sdata : {
diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
index d6ec5d4b8dbe..736b6aae323d 100644
--- a/drivers/firmware/efi/libstub/loongarch-stub.c
+++ b/drivers/firmware/efi/libstub/loongarch-stub.c
@@ -8,10 +8,10 @@
 #include <asm/efi.h>
 #include <asm/addrspace.h>
 #include "efistub.h"
+#include "loongarch-stub.h"
 
 extern int kernel_asize;
 extern int kernel_fsize;
-extern int kernel_offset;
 extern int kernel_entry;
 
 efi_status_t handle_kernel_image(unsigned long *image_addr,
@@ -24,7 +24,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	efi_status_t status;
 	unsigned long kernel_addr = 0;
 
-	kernel_addr = (unsigned long)&kernel_offset - kernel_offset;
+	kernel_addr = (unsigned long)image->image_base;
 
 	status = efi_relocate_kernel(&kernel_addr, kernel_fsize, kernel_asize,
 		     EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_align(), 0x0);
@@ -35,9 +35,10 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	return status;
 }
 
-unsigned long kernel_entry_address(unsigned long kernel_addr)
+unsigned long kernel_entry_address(unsigned long kernel_addr,
+		efi_loaded_image_t *image)
 {
-	unsigned long base = (unsigned long)&kernel_offset - kernel_offset;
+	unsigned long base = (unsigned long)image->image_base;
 
 	return (unsigned long)&kernel_entry - base + kernel_addr;
 }
diff --git a/drivers/firmware/efi/libstub/loongarch-stub.h b/drivers/firmware/efi/libstub/loongarch-stub.h
new file mode 100644
index 000000000000..cd015955a015
--- /dev/null
+++ b/drivers/firmware/efi/libstub/loongarch-stub.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+unsigned long kernel_entry_address(unsigned long kernel_addr,
+		efi_loaded_image_t *image);
diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
index 0e0aa6cda73f..684c9354637c 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -8,6 +8,7 @@
 #include <asm/efi.h>
 #include <asm/addrspace.h>
 #include "efistub.h"
+#include "loongarch-stub.h"
 
 typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
 					  unsigned long systab);
@@ -37,7 +38,8 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
 	return EFI_SUCCESS;
 }
 
-unsigned long __weak kernel_entry_address(unsigned long kernel_addr)
+unsigned long __weak kernel_entry_address(unsigned long kernel_addr,
+		efi_loaded_image_t *image)
 {
 	return *(unsigned long *)(kernel_addr + 8) - VMLINUX_LOAD_ADDRESS + kernel_addr;
 }
@@ -73,7 +75,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
 	csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
 	csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
 
-	real_kernel_entry = (void *)kernel_entry_address(kernel_addr);
+	real_kernel_entry = (void *)kernel_entry_address(kernel_addr, image);
 
 	real_kernel_entry(true, (unsigned long)cmdline_ptr,
 			  (unsigned long)efi_system_table);
-- 
2.27.0


