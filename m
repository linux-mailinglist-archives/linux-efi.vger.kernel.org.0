Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA40B5B4529
	for <lists+linux-efi@lfdr.de>; Sat, 10 Sep 2022 10:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIJIMk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 10 Sep 2022 04:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiIJIMb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 10 Sep 2022 04:12:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF6C861DB;
        Sat, 10 Sep 2022 01:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 439F8B80906;
        Sat, 10 Sep 2022 08:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D78CC43470;
        Sat, 10 Sep 2022 08:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662797545;
        bh=g/I6o9WvdVeu651t6tHQYfn5T0sdMdzkuDqxO4VZTTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6BDG4zuXErcAex2A+ofxL0X2YoAXmMkHlazxWcCc70Jn0zA+t00UK2NYdKI3q5fr
         huspjjJZDDRC9W1AORn+WZz7JxO8FHOP/aZQB4mvr3BVK0W2O7xwprzhVl9q2haAKG
         wWgRtZnRu5SzQ8c5J4o2oIl6RThQfY8mj2PWs3jv5TPpCaSNF/GFIRSB/xMegkjmo5
         HsmZo1jypL99TYN2zazsAhP23URzrA90mPcwAn1er1LSWBZtri2Z/dL0nNpO/O1ORx
         54E2WF7X6z4P3lQ2n2TRErMcSVthEskjgi6E9TmEpMc0Cz2uywWRRyEIDRXQC9T5sG
         R1e5kvL6QmqGw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v5 4/8] efi/libstub: move efi_system_table global var into separate object
Date:   Sat, 10 Sep 2022 10:11:48 +0200
Message-Id: <20220910081152.2238369-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910081152.2238369-1-ardb@kernel.org>
References: <20220910081152.2238369-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2060; i=ardb@kernel.org; h=from:subject; bh=g/I6o9WvdVeu651t6tHQYfn5T0sdMdzkuDqxO4VZTTI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjHEbCNL1atc4I2i0tRtLuRVST/HeZTmrvSg+het3P F6fdon6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYxxGwgAKCRDDTyI5ktmPJN7YC/ 9d9a5dml0iPwavL1S9T1eoDHB+HjhSEklW8IifC+Xym1/vbziUDkCUv99qCpw7pF4cEoOfOglg9Or3 Y0tKzFNlr6ZmmpiUmFUbzIjairVQnJ7GHGrd/ApSwbEilP6+gTJAqAWkjzMKo4kHrEAOweQjFfYfRx RB9KUvetl4EU0bwjrFXScnD4Exk7NUCstgdXlEry+n1LOsePBxM7ipv+OQ23i2rOji0mguMyJLtH2X qWSY+wLj2hvv0VqlE+sft2duWdcOrXrtQIlN4SkowSs7n+OobfexmmklH1t2hW76Yv2QplpD/1dZWy jRTlbogkTyO9yRO+h32B4MA3gUUZsuwxyO+RaTklZ26AFtkRetObAg8vyb32RZ8I5qgLPNHx7OQHcb YtsGJKIqGldWJETSbAGTT23I3S+cu3MeAPOdPLUFvdef4Zvv/7W91L5ohhcBGfmmcbyCrLyzzXXLfx K6EaATEeutHflepm5Wx53Xm/Ik2rDmH1C4O3TceUb/ckk=
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
index 98045cfa46dc..8d98efcf4473 100644
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

