Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26D55890F0
	for <lists+linux-efi@lfdr.de>; Wed,  3 Aug 2022 19:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiHCRDl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Aug 2022 13:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbiHCRDj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Aug 2022 13:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ABE52DF1
        for <linux-efi@vger.kernel.org>; Wed,  3 Aug 2022 10:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD43960A07
        for <linux-efi@vger.kernel.org>; Wed,  3 Aug 2022 17:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0421BC433C1;
        Wed,  3 Aug 2022 17:03:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BSaV1PZu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659546211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=69WTcPpPrQe8MyOqXz8PgBTwssGQx5PrbKPNu3PNmMg=;
        b=BSaV1PZu1nDcGthl02n+oTezfVKBMclAfYW3x1XFHatC7sl1AdtUM1R4uF2GCY94tqfEv/
        ogFv3ivNOlrMr5iUH3jd58jkW2CDLXSB9evq7T8xqPXcNr3d38ljaYeRUtQ+f0Bi9VjFyk
        Hx/ld69OIXEIDLQ1lSg+ow2EA0qDllo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9b336194 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 Aug 2022 17:03:30 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     qemu-devel@nongnu.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH RFC v1] hw/i386: place setup_data at fixed place in memory
Date:   Wed,  3 Aug 2022 19:02:35 +0200
Message-Id: <20220803170235.1312978-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The boot parameter header refers to setup_data at an absolute address,
and each setup_data refers to the next setup_data at an absolute address
too. Currently QEMU simply puts the setup_datas right after the kernel
image, and since the kernel_image is loaded at prot_addr -- a fixed
address knowable to QEMU apriori -- the setup_data absolute address
winds up being just `prot_addr + a_fixed_offset_into_kernel_image`.

This mostly works fine, so long as the kernel image really is loaded at
prot_addr. However, OVMF doesn't load the kernel at prot_addr, and
generally EFI doesn't give a good way of predicting where it's going to
load the kernel. So when it loads it at some address != prot_addr, the
absolute addresses in setup_data now point somewhere bogus, causing
crashes when EFI stub tries to follow the next link.

Fix this by placing setup_data at some fixed place in memory, not as
part of the kernel image, and then pointing the setup_data absolute
address to that fixed place in memory. This way, even if OVMF or other
chains relocate the kernel image, the boot parameter still points to the
correct absolute address.

=== NOTE NOTE NOTE NOTE NOTE ===
This commit is currently garbage! It fixes the boot test case, but it
just picks the address 0x10000000. That's probably not a good idea. If
somebody with some x86 architectural knowledge could let me know a
better reserved place to put this, that'd be very appreciated.

Fixes: 3cbeb52467 ("hw/i386: add device tree support")
Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 hw/i386/x86.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 050eedc0c8..0b0083b345 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -773,9 +773,9 @@ void x86_load_linux(X86MachineState *x86ms,
     bool linuxboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
     uint16_t protocol;
     int setup_size, kernel_size, cmdline_size;
-    int dtb_size, setup_data_offset;
+    int dtb_size, setup_data_item_len, setup_data_total_len = 0;
     uint32_t initrd_max;
-    uint8_t header[8192], *setup, *kernel;
+    uint8_t header[8192], *setup, *kernel, *setup_datas = NULL;
     hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0, first_setup_data = 0;
     FILE *f;
     char *vmode;
@@ -1048,6 +1048,8 @@ void x86_load_linux(X86MachineState *x86ms,
     }
     fclose(f);
 
+#define SETUP_DATA_PHYS_BASE 0x10000000
+
     /* append dtb to kernel */
     if (dtb_filename) {
         if (protocol < 0x209) {
@@ -1062,34 +1064,36 @@ void x86_load_linux(X86MachineState *x86ms,
             exit(1);
         }
 
-        setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
-        kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
-        kernel = g_realloc(kernel, kernel_size);
-
-
-        setup_data = (struct setup_data *)(kernel + setup_data_offset);
+        setup_data_item_len = sizeof(struct setup_data) + dtb_size;
+        setup_datas = g_realloc(setup_datas, setup_data_total_len + setup_data_item_len);
+        setup_data = (struct setup_data *)(setup_datas + setup_data_total_len);
         setup_data->next = cpu_to_le64(first_setup_data);
-        first_setup_data = prot_addr + setup_data_offset;
+        first_setup_data = SETUP_DATA_PHYS_BASE + setup_data_total_len;
+        setup_data_total_len += setup_data_item_len;
         setup_data->type = cpu_to_le32(SETUP_DTB);
         setup_data->len = cpu_to_le32(dtb_size);
-
         load_image_size(dtb_filename, setup_data->data, dtb_size);
     }
 
     if (!legacy_no_rng_seed) {
-        setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
-        kernel_size = setup_data_offset + sizeof(struct setup_data) + RNG_SEED_LENGTH;
-        kernel = g_realloc(kernel, kernel_size);
-        setup_data = (struct setup_data *)(kernel + setup_data_offset);
+        setup_data_item_len = sizeof(struct setup_data) + SETUP_RNG_SEED;
+        setup_datas = g_realloc(setup_datas, setup_data_total_len + setup_data_item_len);
+        setup_data = (struct setup_data *)(setup_datas + setup_data_total_len);
         setup_data->next = cpu_to_le64(first_setup_data);
-        first_setup_data = prot_addr + setup_data_offset;
+        first_setup_data = SETUP_DATA_PHYS_BASE + setup_data_total_len;
+        setup_data_total_len += setup_data_item_len;
         setup_data->type = cpu_to_le32(SETUP_RNG_SEED);
         setup_data->len = cpu_to_le32(RNG_SEED_LENGTH);
         qemu_guest_getrandom_nofail(setup_data->data, RNG_SEED_LENGTH);
     }
 
-    /* Offset 0x250 is a pointer to the first setup_data link. */
-    stq_p(header + 0x250, first_setup_data);
+    if (first_setup_data) {
+            /* Offset 0x250 is a pointer to the first setup_data link. */
+            stq_p(header + 0x250, first_setup_data);
+            rom_add_blob("setup_data", setup_datas, setup_data_total_len, setup_data_total_len,
+                         SETUP_DATA_PHYS_BASE, NULL, NULL, NULL, NULL, false);
+    }
+
 
     /*
      * If we're starting an encrypted VM, it will be OVMF based, which uses the
-- 
2.35.1

