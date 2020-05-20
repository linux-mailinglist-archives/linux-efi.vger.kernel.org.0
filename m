Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72C41DBCA0
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 20:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgETSUZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 14:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgETSUY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 May 2020 14:20:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF0DC08C5C1
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 11:20:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k15so2637614ybt.4
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+OgKtLgJsTWHETWzU0D/6Xq9Yh0LN7K9yw3XnE7zkxQ=;
        b=mFgOTfrSHMkzTt8BAkpdAExTTNP7jmpJt7yQnjoTo9VHuMltYO7pOJryolvE/uTslo
         lAQPX3E51unfk/IiFL+hRYtOh2+ndTY8e6eB5Vp1G1CrYPB1oZnYo5Si5DKnocrsIIjX
         KpWpQkWdu9ArI/c9ChX7Pf/cu8x6/x6T/7uDTWEMsRIJ3R9qBa1HZNkt7apk8egei2DU
         zRSI6lAtaWUUTDATLYRK7l7aqOAH13eR2qONIyFeveupLmFi4GuKqPXbEDLh/qpdNGqI
         KGxweMgAElJY/SjaYzmY+h8cyDro0M0e5atnFoDuzlW5bDT8f5TGC/gX3ytZJp2Y1XC2
         ybaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+OgKtLgJsTWHETWzU0D/6Xq9Yh0LN7K9yw3XnE7zkxQ=;
        b=mEJCXg220m2qRM2ZIaxIu3fKrSiWqR5et5INNZqAJNUXpJYjhMWNYxaq0yZq7SsySC
         O5xooLKCCw+O7mcF6yPYzFA8uHLe/0YkHeGlgH02XdlUJeeHN0aQCIHX0qKs/bW+mwfx
         npEoXpQMaevAh/gb6WLO/zWVFhtTQq32EB8HFzFI992znrjPh9Dw6HhV+5VEQlQUrwIH
         31zbz/ubQF6W/61nNHFkAiIlENad9VMmyx0jEcJXnPMadZUO0WNS5wHShRWbl4oD3PTG
         XI0Hl/LJ8BsOD9VwcDfpQqzCGV2QdM5lg7PL/xHVZJnF14YoaOlkH/Vy/kQhhJ4Gg8KC
         DS1Q==
X-Gm-Message-State: AOAM531t3xeAue+9vXBmifYtuD5z6OXCfG5tJ/6x05Y6Uubt1E65CxB+
        17mABW3LAXEAjlyP0fIv6at3c0AXfK19
X-Google-Smtp-Source: ABdhPJxChAh8OSbvoWwuGLPe+W+/t0SKz7P0/s8cNWgkCkA20hD+7yUdXDAn8ZA7yGFYH/MJnvgYrQS5t9X3
X-Received: by 2002:a25:c105:: with SMTP id r5mr8768228ybf.192.1589998823350;
 Wed, 20 May 2020 11:20:23 -0700 (PDT)
Date:   Wed, 20 May 2020 11:20:10 -0700
Message-Id: <20200520182010.242489-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH] x86/boot: Discard .discard.unreachable for arch/x86/boot/compressed/vmlinux
From:   Fangrui Song <maskray@google.com>
To:     x86@kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fangrui Song <maskray@google.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In the latest efi tree, ce5e3f909fc0ed67e58367b9c56a54c20a51080b
"efi/printf: Add 64-bit and 8-bit integer support",
arch/x86/boot/compressed/vmlinux may have an undesired
.discard.unreachable section from drivers/firmware/efi/libstub/vsprintf.stub.o

.discard.unreachable contains an R_X86_64_PC32 relocation, which will be
warned by LLD: a non-SHF_ALLOC section (.discard.unreachable) is not
part of the memory image, thus conceptually the distance between a
non-SHF_ALLOC and a SHF_ALLOC is not a constant which can be resolved at
link time.

% ld.lld -m elf_x86_64 -T arch/x86/boot/compressed/vmlinux.lds ... -o arch/x86/boot/compressed/vmlinux
ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32 against symbol ''

Reuse the DISCARDS macro which includes .discard.* to drop .discard.unreachable

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Fangrui Song <maskray@google.com>
---
 arch/x86/boot/compressed/vmlinux.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 0dc5c2b9614b..8f1025d1f681 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -74,4 +74,6 @@ SECTIONS
 #endif
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
+
+	DISCARDS
 }
-- 
2.26.2.761.g0e0b3e54be-goog

