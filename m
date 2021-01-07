Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F902EE8CF
	for <lists+linux-efi@lfdr.de>; Thu,  7 Jan 2021 23:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbhAGWfN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Jan 2021 17:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbhAGWfL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 7 Jan 2021 17:35:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE003233FB;
        Thu,  7 Jan 2021 22:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610058871;
        bh=YxWPwsnnRjlrhr4yxPjg93gIGIM1hNu7MQw7OLs3KDI=;
        h=From:To:Cc:Subject:Date:From;
        b=nMU3CXGiXfYZYNwQR0pp5xAhCezD0B0HarZZ/6Pu6ZNPIb4aO+XBZvh6JBf3Do0eG
         p+yJYETgNWkbTO7EvZB3u1lhJ/p9dW2M5kUUAN7ZAmGw/RKfdaofmAgdfDkX6DUXRq
         FehZrcoJitZXPRPMvZX/NOwZPNW2Zwtptz9PocTxCMheK7jJDTXj7phMEO9U8xCTqb
         GhJLvhFPBcrjVrZP8sKIB2ktNNRSQnc77bVfC5dEpn+3vR4Tm53MAc1rAT9eLjjJFj
         6iwnn+yefEYQ/Thm/rWLT6U1FHgcnOcPCCO/qzur2iXeQQhQ4jGhc1VA82FcNJv4Id
         GsWHy1fhkz0Xg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Date:   Thu,  7 Jan 2021 23:34:15 +0100
Message-Id: <20210107223424.4135538-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When 5-level page tables are enabled, clang triggers a BUILD_BUG_ON():

x86_64-linux-ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
efi_64.c:(.text+0x22c): undefined reference to `__compiletime_assert_354'

Use the same method as in commit c65e774fb3f6 ("x86/mm: Make PGDIR_SHIFT
and PTRS_PER_P4D variable") and change it to MAYBE_BUILD_BUG_ON(),
so it only triggers for constant input.

Link: https://github.com/ClangBuiltLinux/linux/issues/256
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/platform/efi/efi_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e1e8d4e3a213..62bb1616b4a5 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -137,8 +137,8 @@ void efi_sync_low_kernel_mappings(void)
 	 * As with PGDs, we share all P4D entries apart from the one entry
 	 * that covers the EFI runtime mapping space.
 	 */
-	BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
-	BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
+	MAYBE_BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
+	MAYBE_BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
 
 	pgd_efi = efi_pgd + pgd_index(EFI_VA_END);
 	pgd_k = pgd_offset_k(EFI_VA_END);
-- 
2.29.2

