Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D583B349D38
	for <lists+linux-efi@lfdr.de>; Fri, 26 Mar 2021 01:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhCZAFd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Mar 2021 20:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhCZAFC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 25 Mar 2021 20:05:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EA7C61A36;
        Fri, 26 Mar 2021 00:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616717102;
        bh=9/29N/4yLblEnOYYfPpTSkMrTA51czELTdv1FroKk14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aB1LzYuEPu8fVe1jy4nf23gaZvjSO/LqgsDj9GjIHg0j7vlEYUJqBjzkFoX/E42Sj
         4PvO42XhIEcB/okZVfaDGGd92F9SeTDeXL6HzOqQso/BN4sSRqgVoxjm5d6XHrUbrX
         QpWfg5CEX648X5IAozxW8CUAuQIINXytnL/wadfsUDQYkGqpNfxBW51u+zeE2hvYJN
         KlGxOYwuXDtygNl3Zh7FivikovMQ9V34f5U32ChpASgZFu+Qj+LY56wdoo/MoU0B+X
         h5HqPPQIUElcgvoHTC0OhXUJrprNO2BomAAs7gv8L0meoaqWK9yI/Qml1+9h9dfIwH
         bK9woXfXsfWag==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/3] x86/boot: Add $(CLANG_FLAGS) to compressed KBUILD_CFLAGS
Date:   Thu, 25 Mar 2021 17:04:34 -0700
Message-Id: <20210326000435.4785-3-nathan@kernel.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326000435.4785-1-nathan@kernel.org>
References: <20210326000435.4785-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When cross compiling x86 on an ARM machine with clang, there are several
errors along the lines of:

arch/x86/include/asm/string_64.h:27:10: error: invalid output constraint
'=&c' in asm

This happens because the compressed boot Makefile reassigns KBUILD_CFLAGS
and drops the clang flags that set the target architecture ('--target=')
and the path to the GNU cross tools ('--prefix='), meaning that the host
architecture is targeted.

These flags are available as $(CLANG_FLAGS) from the main Makefile so
add them to the compressed boot folder's KBUILD_CFLAGS so that cross
compiling works as expected.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index e0bc3988c3fa..6e5522aebbbd 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -46,6 +46,7 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 # Disable relocation relaxation in case the link is not PIE.
 KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
+KBUILD_CFLAGS += $(CLANG_FLAGS)
 
 # sev-es.c indirectly inludes inat-table.h which is generated during
 # compilation and stored in $(objtree). Add the directory to the includes so
-- 
2.31.0

