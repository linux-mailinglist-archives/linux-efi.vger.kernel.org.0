Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504321439A5
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jan 2020 10:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgAUJjS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jan 2020 04:39:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUJjS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 21 Jan 2020 04:39:18 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67F92217F4;
        Tue, 21 Jan 2020 09:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579599558;
        bh=by1NOeU1Q5IktSBhyHEM7pGePHA9GLl6aFkJWgkvpvE=;
        h=From:To:Cc:Subject:Date:From;
        b=ekfbgNOLIk0eDs+lM9zD/tMGpNpV1yWg9p+8oINIQDggcuN9tGkOM+63KXSgZRptB
         4YukOu2QtZA+GTGCZo+a6F/brit+lf5x00qEgZQGLUjKL89QV0F4K57UjTKOGmDjKm
         62jPZgw3/GzUU2aW3a/m2QxvEThDc9f4ts26WbbQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     mingo@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/x86: disable instrumentation in EFI runtime handling code
Date:   Tue, 21 Jan 2020 10:39:12 +0100
Message-Id: <20200121093912.5246-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We already disable KASAN instrumentation specifically for the
EFI routines that are known to dereference memory addresses that
KASAN does not know about, avoiding false positive KASAN splats.

However, as it turns out, having GCOV or KASAN instrumentation enabled
interferes with the compiler's ability to optimize away function calls
that are guarded by IS_ENABLED() checks that should have resulted in
those references to have been const-propagated out of existence. But
with instrumenation enabled, we may get build errors like

   ld: arch/x86/platform/efi/efi_64.o: in function `efi_thunk_set_virtual_address_map':
>> arch/x86/platform/efi/efi_64.c:560: undefined reference to `__efi64_thunk'
   ld: arch/x86/platform/efi/efi_64.o: in function `efi_set_virtual_address_map':
>> arch/x86/platform/efi/efi_64.c:902: undefined reference to `efi_uv1_memmap_phys_prolog'
>> ld: arch/x86/platform/efi/efi_64.c:921: undefined reference to `efi_uv1_memmap_phys_epilog'

in builds where CONFIG_EFI=y but CONFIG_EFI_MIXED or CONFIG_X86_UV are not
defined, even though the invocations are conditional on IS_ENABLED() checks
against the respective Kconfig symbols.

So let's disable instrumentation entirely for this subdirectory, which
isn't that useful here to begin with.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index 7ec3a8b31f8b..84b09c230cbd 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD_efi_thunk_$(BITS).o := y
+KASAN_SANITIZE := n
+GCOV_PROFILE := n
 
 obj-$(CONFIG_EFI) 		+= quirks.o efi.o efi_$(BITS).o efi_stub_$(BITS).o
 obj-$(CONFIG_EFI_MIXED)		+= efi_thunk_$(BITS).o
-- 
2.17.1

