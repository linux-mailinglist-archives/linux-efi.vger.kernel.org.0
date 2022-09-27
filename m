Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC705EBDE1
	for <lists+linux-efi@lfdr.de>; Tue, 27 Sep 2022 10:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiI0I65 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Sep 2022 04:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiI0I6z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Sep 2022 04:58:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCADD7D1FB
        for <linux-efi@vger.kernel.org>; Tue, 27 Sep 2022 01:58:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 930C4B81A93
        for <linux-efi@vger.kernel.org>; Tue, 27 Sep 2022 08:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B85C433B5;
        Tue, 27 Sep 2022 08:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664269132;
        bh=PVJxLOqpZBxsmMsKxfPCc+uqjaTrlP9wSUJensoC7NA=;
        h=From:To:Cc:Subject:Date:From;
        b=EK9AVjpkik4F/GSSVjBOIvfFGB24vWhRlw/mPaJYrEsgvUIr8uciCP4PtYcLujOlH
         Osd6VchQwXSRzPMNR2Zx8Uf9yCsfPlk2s1H13Qz9QM/BHOp/OE+FpDscLqxZBzyQYK
         kkOFS9xSQu4y8wVRCQXJ1KDRPJCZod56B/TOJ+nV75Ids7/dsOFloP7jPkJVKLBjdX
         I+JUBdf22t6uKci5g/6U86nrFnWw4kZRLtjrQKvgxkO6SmhoLHczOQAAPkm9OM1jrN
         Tlif6rpLcOzzTzWz1sMesrTRbVMODwuCtLw8ocmcf8yheqagsmsOL58IDXzfJAXnvx
         alcJKZxFwRFfg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Atish Patra <atishp@atishpatra.org>,
        Lennart Poettering <lennart@poettering.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 0/4] efi: Improve command line initrd loader support
Date:   Tue, 27 Sep 2022 10:58:38 +0200
Message-Id: <20220927085842.2860715-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3023; i=ardb@kernel.org; h=from:subject; bh=PVJxLOqpZBxsmMsKxfPCc+uqjaTrlP9wSUJensoC7NA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjMrs86XZw9ZQYOLyTdf8/6dnYLS3nQlhOe2ts8v/1 9XrDlbOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYzK7PAAKCRDDTyI5ktmPJHe/C/ 0a+9hr7S+OdXxD257eUZl2JtsX5WHKuWy5K4BokpLo6b8WF10M7MBT6MOmCPaXeXvtJI3G2Ehg9ccJ GTsOhX71s33l1dsMaTcAHmB9NnIPBtLZ2T7dG99UA/eTiDDFmpYTpU6P0Xu1bS7O+wg40hY4NnGKt0 E8mS8oGcbypJl9JcxypXh7TwuiumM81oHSVZzduQy8G8Rv/GmEHLGdCY5Ng7AIhQGC8i3zs/c7mu+k 055Rw5FluLzLcePfBWa/VtPE4neb5+gXRO5ndnBmrr3UYp1wLbzBp7OXwNSCA5Cy0iiHop7X/YEdvh RMOi8thzPvzb8iN3a3Y8eEj2E6hSrclnmzNin6nZG0xBXHUAbKoyMPKRP53epbT//vMMLcUrVrNQ3K GN8eOsP9sTUdUfN4AGqmcEv66shqN948pIBfMVWIQjn03Sn3Oikf2HJ0izAwawkaAfaqVhbxmIT8MZ CPgieluMNooA/zZzZ0VoAI0z5MWOnwImUHumO73v4SWUY=
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

Given that the command line initrd loader can only load files from the
same simple FS volume from which the kernel itself was loaded, it was
not flexible enough for use in loaders such as GRUB that don't even
implement the FS volume abstraction, and load images as anonymous
buffers in memory. As x86 mixed mode was based on a GRUB specific EFI
handover protocol, and the simple FS protocol method prototypes were not
mixed mode safe, the initrd command line loader did not work for mixed
mode at all.

For this reason, we support arch specific methods (bootparam, DT) as
well, and have added support for a generic method based on the LoadFile2
protocol, which is much easier to implement and use.

However, there are cases where the command line loader is useful,
especially when using fully generic loaders such as the UEFI shell.
Here, it is generally not possible to use Linux specific structs or data
structures, or implement the Linux specific LoadFile2 protocol
implementation for initrd loading.

So let's fix the issues with the initrd command line loader:
- add the ability to use fully qualified device paths as the initrd=
  argument, so that the initrd image can reside on any simple FS volume,
  even if the kernel itself was not loaded from one;
- fix the mixed mode issues, by using the mixed mode wrappers for the
  protocol invocations, and defining some recipes for the prototypes
  that cannot be marshalled 1:1

The above means that mixed mode loaders that boot via the compat entry
point (e.g., systemd-boot) can use the initrd= command line option as
before to pass the initrd, if desired.

With those fixes in place, let's remove the deprecation notice, and
permit the feature to be enabled on LoongArch and RISC-V as well.

Note that LoadFile2 is still preferred, and will continue to take
precedence. It is also the only generic method that cannot be compiled
out.

Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Atish Patra <atishp@atishpatra.org>
Cc: Lennart Poettering <lennart@poettering.net>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Ard Biesheuvel (4):
  efi: libstub: Implement devicepath support for initrd commandline
    loader
  efi: libstub: Permit mixed mode return types other than efi_status_t
  efi: libstub: Add mixed mode support to command line initrd loader
  efi: libstub: Undeprecate the command line initrd loader

 arch/x86/boot/compressed/efi_thunk_64.S        |   6 --
 arch/x86/include/asm/efi.h                     |  49 +++++----
 drivers/firmware/efi/Kconfig                   |  13 ++-
 drivers/firmware/efi/libstub/efi-stub-helper.c |   2 +-
 drivers/firmware/efi/libstub/efistub.h         | 112 ++++++++++++++------
 drivers/firmware/efi/libstub/file.c            | 105 +++++++++++++-----
 include/linux/efi.h                            |   6 ++
 7 files changed, 202 insertions(+), 91 deletions(-)

-- 
2.35.1

