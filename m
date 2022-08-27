Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BADF5A3603
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 10:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiH0IjT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 04:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiH0IjQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 04:39:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FD0C00D9
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 01:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7524C61306
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF344C4347C;
        Sat, 27 Aug 2022 08:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661589552;
        bh=UBp2rsf+kAYyhi4UTfKRx+3XtvgjAWXJSN1PjteFpa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJh+RIMj2yHv5usj+e7kSp2UNb9l8iRHV2YojKri/zn1OJJy2V1UM1D01mVXJeY0Q
         lbIch9uwZNKKOSks36nRvEsQ83HQaKHEDnlxB2g8kk3fau4fm2f3gAqLU6W85CQVe3
         Ws6KqkK3ggWa0bJ568EAqcH7i8Y1IeRQfumCMCoKpunN/AU0cLlL8D23XgkBWYHqls
         bRJMqCNwo2xNp+wAdW5/FiWRHfSaLqZr7/vcPszn73u1csjMWEgrfMzybO7/PdcKuJ
         ep96bpj3n+Syuxk8WZI4k++WduB+js4j0K5j7dt71FgPQAZyCR8MF8je8KAwNt1fFN
         ILxqbzGw2cPCA==
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
Subject: [PATCH v4 1/9] efi: name the ARCH-stub.c files uniformly
Date:   Sat, 27 Aug 2022 10:38:42 +0200
Message-Id: <20220827083850.2702465-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827083850.2702465-1-ardb@kernel.org>
References: <20220827083850.2702465-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=ardb@kernel.org; h=from:subject; bh=UBp2rsf+kAYyhi4UTfKRx+3XtvgjAWXJSN1PjteFpa0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCdgMJ+OTI3g3MW65ksCNSsGYFYf3xucYV1AaZnYt V0tkkf+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwnYDAAKCRDDTyI5ktmPJHr6DA CGE1MLFtM3JEBNaUraczdMjavnW77GeexWClyvombsh5GkWHA17x398PlsmqmD3U60qYETig5ul/4I Dsx8voo0yXNiu9luLZFns69k8y0fST45Pg3jYJKLp/z+NkpanpuA7S905/WlFyIXca5Bd7BFYPPgSo MbHjFKIgE2xTlpT/NwIaHiJsky7eTtzLPRscboCaTXXN40epQiWS4k90S0qdHI6weZ03B8ZnzG5EXj XP+VdMmmIy+PYh/PgPdEtNodZ6LqYVSSQkL2U9oYXUraWI9nPsgipYTWWr97/41FWxpSitMg+w95gn cg6zCoscsKZrvtj5x/ZuTBIt9rSs49gS5AEJH8pgw87cXmZp0yc5AeJp49aLnX2V99vG1cUU5I7Yry 0Ak1j+yLc1xtePMONRWkcy+qxK7qy+NUW3dhgRwEEZWqovcfgx0hgJ1FQcHwxKa8dlCOfR3MGiF+oC nTGdAH5b/dz8HQPKH3rAU+KPA2q1X2YLTk40AG/fWp8Dw=
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

Rename arm32-stub.c to arm-stub.c so that we can refer to all of them as
$(ARCH)-stub.c

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile                     | 9 ++-------
 drivers/firmware/efi/libstub/{arm32-stub.c => arm-stub.c} | 0
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index a4915cc499f3..68c181dcb8cf 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -68,13 +68,8 @@ $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o fdt.o string.o \
 				   $(patsubst %.c,lib-%.o,$(efi-deps-y))
 
-lib-$(CONFIG_ARM)		+= arm32-stub.o
-lib-$(CONFIG_ARM64)		+= arm64-stub.o
-lib-$(CONFIG_X86)		+= x86-stub.o
-lib-$(CONFIG_RISCV)		+= riscv-stub.o
-lib-$(CONFIG_LOONGARCH)		+= loongarch-stub.o
-
-CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
+lib-y				+= $(ARCH)-stub.o
+CFLAGS_arm-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
 # Even when -mbranch-protection=none is set, Clang will generate a
 # .note.gnu.property for code-less object files (like lib/ctype.c),
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
similarity index 100%
rename from drivers/firmware/efi/libstub/arm32-stub.c
rename to drivers/firmware/efi/libstub/arm-stub.c
-- 
2.35.1

