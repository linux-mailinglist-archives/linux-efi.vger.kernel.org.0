Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42746ADCA7
	for <lists+linux-efi@lfdr.de>; Tue,  7 Mar 2023 11:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjCGK6K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Mar 2023 05:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjCGK5h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Mar 2023 05:57:37 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80DC757D2C;
        Tue,  7 Mar 2023 02:57:35 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dx_5eeGAdkF1MJAA--.12142S3;
        Tue, 07 Mar 2023 18:57:34 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxtOWdGAdk1vFNAA--.36843S2;
        Tue, 07 Mar 2023 18:57:33 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Xuerui Wang <kernel@xen0n.name>, linux-efi@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH] efistub: LoongArch: Reimplement kernel_entry_address()
Date:   Tue,  7 Mar 2023 18:57:33 +0800
Message-Id: <1678186653-27659-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8BxtOWdGAdk1vFNAA--.36843S2
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXryftw1rCrWkXr48Xw1kZrb_yoW5Aw47pa
        s0yrsxCF4ft3yfCaykAw15uFy5X3Z7KFyagF9Fk34F93W3XF1DZrWFgr98WFyDZ3y0q3ya
        qr1YyFnFk3WUJw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
        4UYxBIdaVFxhVjvjDU0xZFpf9x07jYSoJUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When EFI_KIMG_PREFERRED_ADDRESS is not equal to PHYS_LINK_KADDR, we
should not jump to the link address but the actual load address, so
fix the processing of kernel_entry_address().

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
- EFI_KIMG_PREFERRED_ADDRESS = PHYS_LINK_KADDR:
/ # cat /proc/iomem 
00000000-0fffffff : System RAM
  00000000-001fffff : Reserved
  00200000-0113ffff : Kernel code
  01140000-01a0e5ff : Kernel data
  01a0e600-01b0b337 : Kernel bss

- EFI_KIMG_PREFERRED_ADDRESS = PHYS_LINK_KADDR + 0x4000000 (Enable CONFIG_RELOCATABLE):
 # cat /proc/iomem 
00000000-0fffffff : System RAM
  00000000-041fffff : Reserved
  04200000-0513ffff : Kernel code
  05140000-05a0e5ff : Kernel data
  05a0e600-05b0b337 : Kernel bss

 arch/loongarch/include/asm/efi.h              |  2 --
 drivers/firmware/efi/libstub/loongarch-stub.c |  7 -------
 drivers/firmware/efi/libstub/loongarch.c      | 14 ++++++++++++--
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/asm/efi.h
index 091897d40b03..eddc8e79b3fa 100644
--- a/arch/loongarch/include/asm/efi.h
+++ b/arch/loongarch/include/asm/efi.h
@@ -32,6 +32,4 @@ static inline unsigned long efi_get_kimg_min_align(void)
 
 #define EFI_KIMG_PREFERRED_ADDRESS	PHYSADDR(VMLINUX_LOAD_ADDRESS)
 
-unsigned long kernel_entry_address(void);
-
 #endif /* _ASM_LOONGARCH_EFI_H */
diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
index eee7ed43cdfb..71d178f87274 100644
--- a/drivers/firmware/efi/libstub/loongarch-stub.c
+++ b/drivers/firmware/efi/libstub/loongarch-stub.c
@@ -44,10 +44,3 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 
 	return status;
 }
-
-unsigned long kernel_entry_address(void)
-{
-	unsigned long base = (unsigned long)&kernel_offset - kernel_offset;
-
-	return (unsigned long)&kernel_entry - base + VMLINUX_LOAD_ADDRESS;
-}
diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
index 807cba2693fc..79fa16a765ce 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -37,9 +37,19 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
 	return EFI_SUCCESS;
 }
 
-unsigned long __weak kernel_entry_address(void)
+/*
+ * Get the offset of EFI_KIMG_PREFERRED_ADDRESS relative to the physical
+ * link address.
+ */
+static long get_kernel_offset(void)
+{
+	return EFI_KIMG_PREFERRED_ADDRESS - PHYS_LINK_KADDR;
+}
+
+unsigned long kernel_entry_address(void)
 {
-	return *(unsigned long *)(PHYSADDR(VMLINUX_LOAD_ADDRESS) + 8);
+	return *(unsigned long *)(EFI_KIMG_PREFERRED_ADDRESS + 8) +
+		get_kernel_offset();
 }
 
 efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
-- 
2.37.3

