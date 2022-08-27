Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062635A3605
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 10:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiH0Ij2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 04:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiH0Ij1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 04:39:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD81ABCCE2
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 01:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FA75B80E6F
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5130CC433C1;
        Sat, 27 Aug 2022 08:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661589563;
        bh=BgNwH7xfBPv6l1sHY7W8lv62pNdIUhlpLRWtnyMfKTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HZTVkKz+1FlZx1gaSXop7eGIQZi8rzBg2kr33mDB3b+WrGTfTo5tbzhERJvqyACWj
         4GGzOyG3YPTm8mcX4bla83cGLUadK2uPa89xkmjhWlA4iEmdrCdjWA5YrIVQpXyH4L
         YMWtsBnkuqYu/BeJtJfELLW5PY5Er2Ldxo/treMfdkFSm4pibPaLc4IxpCiTz7/xGY
         CKokkvM8/Yc5KIXqkiFcS1/TY4KlVs2PuBIQ6zP6ZzNnxfZEby4h9JRWFaz+pEjCuu
         dfFx4QKQcUgCmTEGIvRdAIXE4SCgiD0cKTHUaxSfukVH8lVHEDD890cjX4H4owzI3+
         jkORFiTx+5F3A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 4/9] efi/libstub: move efi_system_table global var into separate object
Date:   Sat, 27 Aug 2022 10:38:45 +0200
Message-Id: <20220827083850.2702465-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827083850.2702465-1-ardb@kernel.org>
References: <20220827083850.2702465-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2060; i=ardb@kernel.org; h=from:subject; bh=BgNwH7xfBPv6l1sHY7W8lv62pNdIUhlpLRWtnyMfKTQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCdgRYrCMeBKPNkBsfxIIEhlW6FxbWiIJTYHw4tIJ y7Qs+5mJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwnYEQAKCRDDTyI5ktmPJJ3PC/ sGUEpWe63Hgzpvf9nGzGNA+f99uF7hln570rqVzyJFdGH8L+mOE7jCuUOzIZGMkLsgLmYMmCBUjF2V JNyAlsnRUFMoprwfwwm90hvyENy/LCUXGSZToZZUt3CeO0BsaSuY3dp4/FVVH1LlDEfU3zxQKmrdCg ZpuKMZfTTXHULFvllfHjruAifDnaB/SHlBYV3hvKhSPXjWxT/TZ3W+sH/xnnpPQioSd3fXPBwB42Cx xnfcsUCMIigdA0a1ONR88CCjwKUkPFz1tkrcRsXEws0JFqoTG9vW4R1rJPC/EnlbvrCot5PTg2o2zj HHG+KfSJ0jVQaykOprKDFCj8gRHSw638G1F3GcBoY2Kj5dReqJBoXudktqUuoo6yWJIfBgUVKnliNr C7+ljb7Wn37ubVe6cSxHutzhXnAeJMWjPRT2+Ee5w2ZJxrYlipNR/s8cdt0yRPR6sZ4bthurwAWSrz swj38uMrgLDd2d3J9jtqJVWwqXfSpy2S3GBj7zH0dfsmw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

To avoid pulling in the wrong object when using the libstub static
library to build the decompressor, define efi_system_table in a separate
compilation unit.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile   | 3 ++-
 drivers/firmware/efi/libstub/efi-stub.c | 2 --
 drivers/firmware/efi/libstub/systable.c | 8 ++++++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 498ea6f7a92a..fbe1900f47c4 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -57,7 +57,8 @@ KCOV_INSTRUMENT			:= n
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
-				   alignedmem.o relocate.o vsprintf.o
+				   alignedmem.o relocate.o vsprintf.o \
+				   systable.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 4bf751484e8b..57ea04378087 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -57,8 +57,6 @@
 static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
 static bool flat_va_mapping = (EFI_RT_VIRTUAL_OFFSET != 0);
 
-const efi_system_table_t *efi_system_table;
-
 static struct screen_info *setup_graphics(void)
 {
 	efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
diff --git a/drivers/firmware/efi/libstub/systable.c b/drivers/firmware/efi/libstub/systable.c
new file mode 100644
index 000000000000..91d016b02f8c
--- /dev/null
+++ b/drivers/firmware/efi/libstub/systable.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+const efi_system_table_t *efi_system_table;
-- 
2.35.1

