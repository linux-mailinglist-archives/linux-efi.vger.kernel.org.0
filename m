Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03295EBDE4
	for <lists+linux-efi@lfdr.de>; Tue, 27 Sep 2022 10:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiI0I7E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Sep 2022 04:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiI0I7C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Sep 2022 04:59:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84137E814
        for <linux-efi@vger.kernel.org>; Tue, 27 Sep 2022 01:59:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8504561628
        for <linux-efi@vger.kernel.org>; Tue, 27 Sep 2022 08:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3785DC433D7;
        Tue, 27 Sep 2022 08:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664269140;
        bh=2WDjuWY8H6VhypnxzBZn90dgORVmAVV9szyeN7i9MmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SAlRbhqH7Ro71yDXynzwyxh3pGkipy+xf6EA5d0ooU6EqQOgh7r7QSwR0P13gjsfN
         HtUkUJ/J41BO7vkrWEDuQICUdZY1BlvLRFBxSJHI44I8cktBlBh9Vfrofu7Edsmf87
         1c/S6tt7NOjv6kQ4FfeYBP8rbshIdSONws09NhFlhFM/dkxOSsOcGj0JzwdG3LEysp
         USLut1QUB+3c+SY59yGYXyTfaEnNs/NVn7XZK9THqD8eAE0dh00GSqTeST9Yl5ZAv/
         MlGjkCHM1pycW9fFkolLMtwATxuXdq3f/SuqEtKg6+JsUoJdhkEBiC4Qr04aeVzrII
         fjaI5PFUflIAA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Atish Patra <atishp@atishpatra.org>,
        Lennart Poettering <lennart@poettering.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 4/4] efi: libstub: Undeprecate the command line initrd loader
Date:   Tue, 27 Sep 2022 10:58:42 +0200
Message-Id: <20220927085842.2860715-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927085842.2860715-1-ardb@kernel.org>
References: <20220927085842.2860715-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002; i=ardb@kernel.org; h=from:subject; bh=2WDjuWY8H6VhypnxzBZn90dgORVmAVV9szyeN7i9MmA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjMrtCjfsTB5WZt0VCWFWtBGI58slNUjv3m1GaeLqb H3OURlmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYzK7QgAKCRDDTyI5ktmPJFvvDA CQ9lhXJmW/sQit4UtoJcK7L3WXnvlNg1NiaXTmUwO9gE5WeS0qhc1VG0yJ9bL3gIxz6Ef/3aiaA3I7 Hr56A0HapdYFjGA2jPHOsNxmKJjlDeGa+lPf9qn1EfTnA6el8jB9qIodtyAYaWadDLwTD2FdBjl8n/ SoJlGGQFMuZpTJw087qt+s55l/46twcf9VSUl7wbqKmEpsQm02SxAAVsLuPO9LcffU2d9xEHh632GM lVrh9XDHb2uDldC34wBrVe5WmWGsq/SO9cjH7zrMHp2VVUsUW/hi6s9ZKur8TPPXfeNPpUa7Jeg1WE wYWFCjJZGcpcoi5vdOV4ZUicKAU4OHUq41rj9lS5dgU0CNSPptTyLHGO4h7iu9bBT2vYBqfw60Pj7/ O050RJIHak3A5Wb27e/GAqHF+FeO6rrN1biH+zefXx5pkotPU/0VOPHU5TqxZAcQ9Bz7RYOyxnauow U+bFIdMq46xDeJRbausxxNOkmONSYOXtmB/rbgKHBu9yw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The initrd= command line loader can be useful for development, but it
was limited to loading files from the same file system as the loaded
kernel (and it didn't work on x86 mixed mode).

As both issues have been fixed, and the initrd= can now be used with
files residing on any simply file system exposed by the EFI firmware,
let's permit it to be enabled on RISC-V and LoongArch, which did not
support it up to this point.

Note that LoadFile2 remains the preferred option, as it is much simpler
to use and implement, but generic loaders (including the UEFI shell) may
not implement this so there, initrd= can now be used as well (if enabled
in the build)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 5b79a4a4a88d..4f7e65293297 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -165,13 +165,16 @@ config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
 	bool "Enable the command line initrd loader" if !X86
 	depends on EFI_STUB && (EFI_GENERIC_STUB || X86)
 	default y if X86
-	depends on !RISCV && !LOONGARCH
 	help
 	  Select this config option to add support for the initrd= command
-	  line parameter, allowing an initrd that resides on the same volume
-	  as the kernel image to be loaded into memory.
-
-	  This method is deprecated.
+	  line parameter, allowing an initrd to be loaded into memory that
+	  resides on a file system backed by an implementation of
+	  EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
+
+	  This method has been superseded by the simpler LoadFile2 based
+	  initrd loading method, but the initrd= loader is retained as it
+	  can be used from the UEFI Shell or other generic loaders that
+	  don't implement the Linux specific LoadFile2 method.
 
 config EFI_BOOTLOADER_CONTROL
 	tristate "EFI Bootloader Control"
-- 
2.35.1

