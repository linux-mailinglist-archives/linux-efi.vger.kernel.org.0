Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B263C58D52E
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 10:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiHIIK6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 04:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiHIIK4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 04:10:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFCEB7D1
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 01:10:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE170612EC
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 08:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64894C43470;
        Tue,  9 Aug 2022 08:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660032655;
        bh=osc5+6bshM/GKgDoemiFn7nxKi4gTqJbJp+7vmhIG8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KniEunSfVTupAv5zA0MJgjHi2cmlKq4iG7owntJc56HAZEAyIG0xWPEefaZpgrsGu
         JnPdfqdHTxybZM5xhiXKxr6Ub1ezHvBcxQneykuK8Ht9tZSkNYC8mEqQc+0Fp4OjSb
         8hyf9yjwEi+BQ0b62uJCTNi1V1P5NYYjnq/rd/l/W/7MjhwJu0ExPpRWSvdvdq2arK
         cXSNry8NxTx9ve4Njxict7T2Iqc2SJVaL41l1rioOv0jM4JW4DNkSnDRwQIDEkiNhv
         Cv6sHdFrJH672OmsVX2F0wXDtmhxmaOsbnCcVRWWRVDZIPBF7u48NQsHO5blmQPtKV
         x542+Pyr4B19Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
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
        Lennart Poettering <lennart@poettering.net>
Subject: [PATCH v2 3/6] efi: stub: move efi_system_table global var into separate object
Date:   Tue,  9 Aug 2022 10:09:41 +0200
Message-Id: <20220809080944.1119654-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220809080944.1119654-1-ardb@kernel.org>
References: <20220809080944.1119654-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2047; i=ardb@kernel.org; h=from:subject; bh=osc5+6bshM/GKgDoemiFn7nxKi4gTqJbJp+7vmhIG8w=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi8hZAmHfnVpMFN8Yq1XZ3Wrk6VajesPmWOdZmWW+Z f2DsQB+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvIWQAAKCRDDTyI5ktmPJE/GC/ wL64pVb/NAUncAME7nAieHMOSaGjvG5eXOlIRL+Gog0WRDwar642ZTIcU5j6bzhy0zux38/FVEOZ+a LSgt9URctnpd37MG2Cg+MbPDdh8hYBhPh1v4VUoPTKua3wCIPYHNGNBNvM51ZQ47/ork1rnBojq34Z a7quYeXEFcJE8U158ayb+5O6IIQ8w1yZvM8pxXywNMSycaXP9N+XUV4sVy4QWrVXe14eBOcFwPiAbv bIXDvKNRCR3JHHoQgf2C+SQuKOAEGd4gtW6K5Iobwf+g4fQo6qmskqwWRUMj7hRt12TIBXhgxseiA1 8Q3FLhfKsAmXD+Vs20GOuhSV4EfVjdko7FT8fYernSw9bHTgPpoUFR1EPvt0JssnVbCZBRtGyZHvMV d5E74Ijm7Z3Qoe8vw7bgLBH75xt4A4Bdz5481P1HS3pCASjX3mlwkBD3GNfbaC9KBwPUeiTo60Easf Ppknhleb6x7P6FOiIT69pfQ4bLlEeGpwBZlcMX5lYo4hs=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 475224be08e1..a8e26d5a1d14 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -55,7 +55,8 @@ KCOV_INSTRUMENT			:= n
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
-				   alignedmem.o relocate.o vsprintf.o printk.o
+				   alignedmem.o relocate.o vsprintf.o printk.o \
+				   systable.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index f515394cce6e..ad179632f99f 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -49,8 +49,6 @@
 static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
 static bool flat_va_mapping;
 
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

