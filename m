Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC165B4522
	for <lists+linux-efi@lfdr.de>; Sat, 10 Sep 2022 10:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiIJIMR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 10 Sep 2022 04:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIJIMQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 10 Sep 2022 04:12:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D106985AB7;
        Sat, 10 Sep 2022 01:12:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E4326115A;
        Sat, 10 Sep 2022 08:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E441FC43470;
        Sat, 10 Sep 2022 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662797533;
        bh=gNcwlKIVMSZfaRxtUZW3gfM7EluuDUlm60FCTCj34rE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D2GkVOyJJ4TmTz26zUDLg3zWi3uNNBnOhGOHPPaQILh2UIk9ISRL10Tpwo7QHsay8
         khIfi/NKlm3tnW1eNlcQU4A7xcSjqAstz91/j6geiVmSCpzfvFxWJQl9G44Tjhcsts
         u1usu5Xnm75rGT0jZzUgzww2mDPheqz7KW0xvauhJ+t4L+j5CygXt/3BuqqHzoJ5+w
         txBhyr14i2Pho87xnnmt5KmcA76YdsjRmQgRRmUSVLcP63YqFZTuIsOIU5vvg4Y64W
         xEMhNkthW1DfyI/CBjjgdUxxT863iH66avfxy6ML4SqybFBmUUcwgICUv0bGyHNyCR
         MXmOuwQXG6/yQ==
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
Subject: [PATCH v5 1/8] efi: name the ARCH-stub.c files uniformly
Date:   Sat, 10 Sep 2022 10:11:45 +0200
Message-Id: <20220910081152.2238369-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910081152.2238369-1-ardb@kernel.org>
References: <20220910081152.2238369-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=ardb@kernel.org; h=from:subject; bh=gNcwlKIVMSZfaRxtUZW3gfM7EluuDUlm60FCTCj34rE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjHEa+z9X/T/GOAznoKPIT6uoDaQJNbhOzMgOEz7ph 5xJ4tRGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYxxGvgAKCRDDTyI5ktmPJMEXC/ 99eDZ7kRFLw7hQyIb10TxQTamZSmkqWEwDYdj8pxDYIY5k9SY965Nh+4a1YVT3drhfIjMkpcpr+6dJ l6ljnqRtl+j7We/awK2fbJKsG1R3xmFNK+VI+HyoT59qw9EYzL0n7nO85xTUYLIth8rZ86sw48D+rO IFcD+D9FfvtpX6UWm4fDrKtsdkkncFX1PrGlZyHbH0y3cMbgDVx4c+lFfEWcZAq4QDtcAP0gDOJbOt LEl2zPjS86/NUWaX4sVk9GSPoneIhA3m1f56jB1dUJq3laxuLuAbIO5JOvF7UHBwKfCskfNSyQyuLZ t+x7N2iiMpQ42WXMW8ycSA5q6w8aj2UW8DSrEdV9PJFA4DOkAjoq4l/UeMIK1/tYmNuWuVxYp5G0tG R3UYpdmHVJ4Vi+NOAQXt7wjEEg7IuzjOyQhyw96DB6ev7EYSsAeidhGeo93Z17jbOzkyQ6ZSGD7fJu cJ8XfOvLaEZ5V3rr7QdE/GtaeYvyK7tbK6zPkZknnT14k=
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
index ec2a7ba9364f..39478fb30b2a 100644
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

