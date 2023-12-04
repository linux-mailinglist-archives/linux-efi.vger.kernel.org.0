Return-Path: <linux-efi+bounces-108-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 165A4802A81
	for <lists+linux-efi@lfdr.de>; Mon,  4 Dec 2023 04:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D7A1C20837
	for <lists+linux-efi@lfdr.de>; Mon,  4 Dec 2023 03:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC217F4;
	Mon,  4 Dec 2023 03:20:52 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Dec 2023 19:20:49 PST
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278B4F3
	for <linux-efi@vger.kernel.org>; Sun,  3 Dec 2023 19:20:48 -0800 (PST)
X-QQ-mid: bizesmtp72t1701659952tyhci721
Received: from localhost.localdomain ( [222.92.8.138])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Dec 2023 11:19:11 +0800 (CST)
X-QQ-SSF: 01400000000000F0W000000A0000000
X-QQ-FEAT: U4uNK7LTfdrdME8slBzAErEkRqpIjPeZBoXveiytGAhDu/o9sloYKEeAMobRL
	RVsESDW8eGaiE4BziYKv6gOYjsFyHKeLakjo6Ts213MmPlWvdJ/nOikKGcmrETXD9e+hSgJ
	8t1n7d7N3u0hZSu94MIIJhN5EfK3YB4FsOfHpu/ODNJdCSquchu/sTZbPAMkhWmgf2TjoUl
	3oacdAw8heuFAWnDsA9OIVy0zVDmUnIfUUqSAnQTNhicvfM7Y7U2uU7ZMW8BOqm0O/h3mdu
	SexRSU1VJvTBLIlzug+I+3wq1dKQDAycyQRXZQfcsKemBPcT6PORT48NVS2S6dBCX0IMiDQ
	zS01TqP3+k/Ul/U4pVMEIrBOzBH4z0EwpMczQ5WG95fXQ6H7PtjorbhSJuIG8YmfD61cDmZ
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 197488599124749065
From: wangyao@lemote.com
To: ardb@kernel.org,
	chenhuacai@kernel.org,
	wangrui@loongson.cn
Cc: linux-efi@vger.kernel.org,
	ainux.wang@gmail.com,
	Wang Yao <wangyao@lemote.com>
Subject: [PATCH] efi/loongarch: Use relocate address to calculate kernel entry address
Date: Mon,  4 Dec 2023 11:18:53 +0800
Message-Id: <20231204031853.6379-1-wangyao@lemote.com>
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

The efi_relocate_kernel() may relocate the PIE kernel to anywhere, the relocated
address may not be equal to link address or EFI_KIMG_PREFERRED_ADDRESS.

Signed-off-by: Wang Yao <wangyao@lemote.com>
---
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
index 807cba2693fc..d7ec9381f8ea 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -37,9 +37,9 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
 	return EFI_SUCCESS;
 }
 
-unsigned long __weak kernel_entry_address(void)
+unsigned long __weak kernel_entry_address(unsigned long kernel_addr)
 {
-	return *(unsigned long *)(PHYSADDR(VMLINUX_LOAD_ADDRESS) + 8);
+	return *(unsigned long *)(PHYSADDR(kernel_addr) + 8);
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


