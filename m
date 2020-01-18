Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A6914188C
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2020 17:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgARQ5i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Jan 2020 11:57:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgARQ5i (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 18 Jan 2020 11:57:38 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1D572469E;
        Sat, 18 Jan 2020 16:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579366657;
        bh=4PAmXQWXyYLpA7XxN42bu+/WuorRm2NHzkeiTXHfDmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HmBaOjBSCHZwA2i7vEOCIvpVwdGwOJDw5BjhzdMwCRyS0Z5L+B/eeE2Sb7okcEHqe
         5LleHE/RXBgzpeQDQwGPA6PMOAK+3bPpLyeNOeFaxAd+Q5NybEC4KOqSgfndOnN145
         gWEzYy9fQ7XqOzpaBjI2Tg2dzbRGy3ktDpK4Khss=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     mingo@kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 2/3] x86/boot/compressed: relax sed symbol type regex for LLVM ld.lld
Date:   Sat, 18 Jan 2020 17:57:04 +0100
Message-Id: <20200118165705.16544-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118165705.16544-1-ardb@kernel.org>
References: <20200118165705.16544-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The final build stage of the x86 kernel captures some symbol
addresses from the decompressor binary and copies them into zoffset.h.
It uses sed with a regular expression that matches the address, symbol
type and symbol name, and mangles the captured addresses and the names
of symbols of interest into #define directives that are added to
zoffset.h

The symbol type is indicated by a single letter, which we match
strictly: only letters in the set 'ABCDGRSTVW' are matched, even
though the actual symbol type is relevant and therefore ignored.

Commit bc7c9d620 ("efi/libstub/x86: Force 'hidden' visibility for
extern declarations") made a change to the way external symbol
references are classified, resulting in 'startup_32' now being
emitted as a hidden symbol. This prevents the use of GOT entries to
refer to this symbol via its absolute address, which recent toolchains
(including Clang based ones) already avoid by default, making this
change a no-op in the majority of cases.

However, as it turns out, the LLVM linker classifies such hidden
symbols as symbols with static linkage in fully linked ELF binaries,
causing tools such as NM to output a lowercase 't' rather than an upper
case 'T' for the type of such symbols. Since our sed expression only
matches upper case letters for the symbol type, the line describing
startup_32 is disregarded, resulting in a build error like the following

  arch/x86/boot/header.S:568:18: error: symbol 'ZO_startup_32' can not be
                                        undefined in a subtraction expression
  init_size: .long (0x00000000008fd000 - ZO_startup_32 +
                    (((0x0000000001f6361c + ((0x0000000001f6361c >> 8) + 65536)
                     - 0x00000000008c32e5) + 4095) & ~4095)) # kernel initialization size

Given that we are only interested in the value of the symbol, let's match
any character in the set 'a-zA-Z' instead.

Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 95410d6ee2ff..748b6d28a91d 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -88,7 +88,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
-- 
2.17.1

