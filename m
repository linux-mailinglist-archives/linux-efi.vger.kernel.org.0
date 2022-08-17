Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA78596D4E
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 13:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbiHQLER (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 07:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbiHQLEI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 07:04:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BDE5247F
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 04:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7A16B81C06
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 11:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB94EC433B5;
        Wed, 17 Aug 2022 11:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660734244;
        bh=tr21ngQHYKH/+KaT9/BCJPAMv3B9MW+jQ61wZD38oq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1sC1GM41HVJPjoKxazsK88daA/OqYVa7HD9dQs9Fg1BQc+blcOnAiV1FRYwz4Z3E
         BA3n4pPYKuLHSRvpMUuCshrj2fx6feNnHdV12Z9UHdE+z25LJwJg16tG0pk+EFU9RL
         NerXus0zmbon35A5tFW5fLnhWJ7FcFQ0liPLdOcPOfuY823XkECw1aoJX5y18VeTnh
         G38FQrP+l8bcTyy8VpGIt8G3jdR0khYmnXO1B7FeUcHu2A/czAx0yG2g030XkkihEX
         EHnj8R5o/oeE1gQcmLu5BjFI+RIaWaNH9d4otzVQop4ZJ9/Tmv8fktJBbWXQH8SRhl
         a/HjUxgdNq9qg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 3/6] efi/libstub: move efi_system_table global var into separate object
Date:   Wed, 17 Aug 2022 13:03:42 +0200
Message-Id: <20220817110345.1771267-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220817110345.1771267-1-ardb@kernel.org>
References: <20220817110345.1771267-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=ardb@kernel.org; h=from:subject; bh=tr21ngQHYKH/+KaT9/BCJPAMv3B9MW+jQ61wZD38oq8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/MsIYyGb4oObd/AMa+0Ewhp+ZKIPotQV+jRRBlfH iZs/sAKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvzLCAAKCRDDTyI5ktmPJFjxC/ 9yQquopj3AbKkOTqdNTSRhQP+3KaEfubCxILOrqDHhm51EIEGpjNFX8Kaf/GLbw3HpXeZsQTNp8/tp T6x0OiqfWxDQj0JB39BGFizbd6Yz6wb9kAZNJxT9a1xcqCqxNhy5DI+h3a0NkZmNQqAONlu9EKsy2S l/cM+lOx7zohEX92B5RoLarE5WdIkrOz363t0PCc0DEBz7Wy+wdVcAqJW1/GXwKMua9rJMtOVgqByR 2CZcVaqljjulzxPE0WoK+eg/0jZEQGUHTkyU5/+t8gXOL9fbMqno3XH3WTOJ+QbiPGcTtuGmOqItnc LSbu02SgvvFKR6d6j2Xckoh+taXYSV/xAqCDW/O04loUfK6MLt2KAdUZTyxkN9jVtfjCVv6yAniSpi qxD4VA6QK0uJWQl999NvH8BPSecIMC1U/EKJNhum/siOCgVdlelFOxNI2/Z5CHMzgZ8kd57JlEg+Wo pU5/Yt33TqJBAR7Yg912Y5OiVtu5390JfCI7XkpvXnwnA=
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
 drivers/firmware/efi/libstub/Makefile   | 2 +-
 drivers/firmware/efi/libstub/efi-stub.c | 2 --
 drivers/firmware/efi/libstub/systable.c | 8 ++++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d7303c94b4a7..1406dc78edaa 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -56,7 +56,7 @@ lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
 				   alignedmem.o relocate.o vsprintf.o \
-				   intrinsics.o
+				   intrinsics.o systable.o
 
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

