Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382ED6E37DF
	for <lists+linux-efi@lfdr.de>; Sun, 16 Apr 2023 14:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjDPMH7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Apr 2023 08:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPMH7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 16 Apr 2023 08:07:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCF540E9;
        Sun, 16 Apr 2023 05:07:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 547D360ED7;
        Sun, 16 Apr 2023 12:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48450C433D2;
        Sun, 16 Apr 2023 12:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681646876;
        bh=sy+ObN4smYcFEbKUs0id0D8hm8sqTWwnEcjdBo0cxsA=;
        h=From:To:Cc:Subject:Date:From;
        b=dZDd+E8+gdFsHASdqCVYFPPc0eXkv1ERoDxqG5ZDKnr7yKRcrE4sI/0rWjtXgF2M7
         4wAhjZHbLicB2XtAX+bpjQdF++NsnTYP7LeKfE6elVLSEpH6gGk9o/MaLP/vUdiVHZ
         hn7oFrJ95tI83HIWm7AFG+zKj6Fgxu8oGtGVfdpOgdvXgGRYQbHkNeB2oq7f51G2bq
         9yam4LRB3tllGgtnrmMUAQWjq6aB6lC67RHYzRzGJHEMnjC+iq6tdRqja/uc///Gtc
         oWWInl77H4vIDPT3RfCy+Rq6cbUjIuZ+RYXWPSqlgUKuqyhnrj7cyW0ypzTbkHUo6I
         sfuDKic24mDow==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH 0/3] efi: Implement generic zboot support
Date:   Sun, 16 Apr 2023 14:07:26 +0200
Message-Id: <20230416120729.2470762-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3857; i=ardb@kernel.org; h=from:subject; bh=sy+ObN4smYcFEbKUs0id0D8hm8sqTWwnEcjdBo0cxsA=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcX6yd/FnxwaVu2Z+O2c7ObCjXHiWW9ifjz85HvtXKb9D A+To9eZO0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBENoox/E+TO3T910+/WZKL Nx5dOunrm/NrOW73yPzwb6ir//9q7/+tDP+jTep338wvS3l44OK2rND8p1UmLhoFjNP+Kh590a+ fNI0VAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series is a proof-of-concept that implements support for the EFI
zboot decompressor for x86. It replaces the ordinary decompressor, and
instead, performs the decompression, KASLR randomization and the 4/5
level paging switch while running in the execution context of EFI.

This simplifies things substantially, and makes it straight-forward to
abide by stricter future requirements related to the use of writable and
executable memory under EFI, which will come into effect on x86 systems
that are certified as being 'more secure', and ship with an even shinier
Windows sticker.

This is an alternative approach to the work being proposed by Evgeny [0]
that makes rather radical changes to the existing decompressor, which
has accumulated too many features already, e.g., related to confidential
compute etc.

EFI zboot images can be booted in two ways:
- by EFI firmware, which loads and starts it as an ordinary EFI
  application, just like the existing EFI stub (with which it shares
  most of its code);
- by a non-EFI loader that parses the image header for the compression
  metadata, and decompresses the image into memory and boots it.

Realistically, the second option is unlikely to ever be used on x86,
given that it already has its existing bzImage, but the first option is
a good choice for distros that target EFI boot only (and some distros
switched to this format already for arm64). The fact that EFI zboot is
implemented in the same way on arm64, RISC-V, LoongArch and [shortly]
ARM helps with maintenance, not only of the kernel itself, but also the
tooling around it relating to kexec, code signing, deployment, etc.

Series can be pulled from [1], which contains some prerequisite patches
that are only tangentially related.

[0] https://lore.kernel.org/all/cover.1678785672.git.baskov@ispras.ru/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-x86-zboot

Cc: Evgeniy Baskov <baskov@ispras.ru>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Peter Jones <pjones@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>

Ard Biesheuvel (3):
  efi/libstub: x86: Split off pieces shared with zboot
  efi/zboot: x86: Implement EFI zboot support
  efi/zboot: x86: Clear NX restrictions on populated code regions

 arch/x86/Makefile                              |  18 +-
 arch/x86/include/asm/efi.h                     |  10 +
 arch/x86/kernel/head_64.S                      |  15 +
 arch/x86/zboot/Makefile                        |  29 +
 drivers/firmware/efi/Kconfig                   |   2 +-
 drivers/firmware/efi/libstub/Makefile          |  15 +-
 drivers/firmware/efi/libstub/Makefile.zboot    |   2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c |   3 +
 drivers/firmware/efi/libstub/x86-stub.c        | 592 +------------------
 drivers/firmware/efi/libstub/x86-zboot.c       | 322 ++++++++++
 drivers/firmware/efi/libstub/x86.c             | 612 ++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.c           |   3 +-
 drivers/firmware/efi/libstub/zboot.lds         |   5 +
 13 files changed, 1031 insertions(+), 597 deletions(-)
 create mode 100644 arch/x86/zboot/Makefile
 create mode 100644 drivers/firmware/efi/libstub/x86-zboot.c
 create mode 100644 drivers/firmware/efi/libstub/x86.c

-- 
2.39.2

