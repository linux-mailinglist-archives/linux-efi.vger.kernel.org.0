Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBC51DF704
	for <lists+linux-efi@lfdr.de>; Sat, 23 May 2020 14:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgEWMAj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 23 May 2020 08:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728749AbgEWMAj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 23 May 2020 08:00:39 -0400
Received: from localhost.localdomain (82-64-249-211.subs.proxad.net [82.64.249.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E29206C3;
        Sat, 23 May 2020 12:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590235238;
        bh=a1EfeTlX8OqgAm4kNKi5ia4j9VRX69XYnUu6nE/MoiI=;
        h=From:To:Cc:Subject:Date:From;
        b=bHFXmpuCwMc3PgK8aXtgTzlOCn9DMagXiavppfZ2J9d17sdFhBPu5vvaVjO4tf/Iy
         Dde4pvvfFfr9IR+uepbOX5hkDma0SXAIbeu34uEDc3a8w0r+cBXPaDGkAF7Ma23bvO
         lRpzr2osX3ecrGGNzu/7vWH6c6tKh+5vgQIJ5hd8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH v2 0/3] x86/boot: get rid of GOT entries and associated fixup code
Date:   Sat, 23 May 2020 14:00:18 +0200
Message-Id: <20200523120021.34996-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Building position independent code using GCC by default results in references
to symbols with external linkage to be resolved via GOT entries, which
carry the absolute addresses of the symbols, and thus need to be corrected
if the load time address of the executable != the link time address.

For fully linked binaries, such GOT indirected references are completely
useless, and actually make the startup code more complicated than necessary,
since these corrections may need to be applied more than once. In fact, we
have been very careful to avoid such references in the EFI stub code, since
it would require yet another [earlier] pass of GOT fixups which we currently
don't implement.

Older GCCs were quirky when it came to overriding this behavior using symbol
visibility, but now that we have increased the minimum GCC version to 4.6,
we can actually start setting the symbol visibility to 'hidden' globally for
all symbol references in the decompressor, getting rid of the GOT entirely.
This means we can get rid of the GOT fixup code right away, and we can start
using ordinary external symbol references in the EFI stub without running the
risk of boot regressions. (v2 note: we have already started doing this)

CC'ing Linus and Maarten, who were involved in diagnosing an issue related
to GOT entries emitted from the EFI stub ~5 years ago. [0] [1]

Many thanks to Arvind for the suggestions and the help in testing these
changes. Tested on GCC 4.6 + binutils 2.24 (Ubuntu 14.04), and GCC 8 +
binutils 2.31 (Debian Buster)

Changes since v1 [2]:
Rebase only - recent EFI changes have moved all the C code into
drivers/firmware/efi/libstub/, which is also built with hidden
visibility, and contains an additional objdump pass to detect (and
reject) absolute symbol references.

Unless anyone objects, I'd like to incorporate these changes into my
late EFI PR for v5.8, which will go out in a day or two.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>

[0] https://lore.kernel.org/lkml/5405E186.2080406@canonical.com/
[1] https://lore.kernel.org/lkml/CA+55aFxW9PmtjOf9nUQwpU8swsFqJOz8whZXcONo+XFmkSwezg@mail.gmail.com/
[2] https://lore.kernel.org/linux-efi/20200108102304.25800-1-ardb@kernel.org/

Ard Biesheuvel (3):
  x86/boot/compressed: move .got.plt entries out of the .got section
  x86/boot/compressed: force hidden visibility for all symbol references
  x86/boot/compressed: get rid of GOT fixup code

 arch/x86/boot/compressed/Makefile      |  1 +
 arch/x86/boot/compressed/head_32.S     | 22 ++------
 arch/x86/boot/compressed/head_64.S     | 57 --------------------
 arch/x86/boot/compressed/hidden.h      | 19 +++++++
 arch/x86/boot/compressed/vmlinux.lds.S | 16 ++++--
 5 files changed, 36 insertions(+), 79 deletions(-)
 create mode 100644 arch/x86/boot/compressed/hidden.h

-- 
2.20.1

