Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92294780CBE
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 15:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbjHRNou (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 09:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357417AbjHRNoo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 09:44:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58CB3589;
        Fri, 18 Aug 2023 06:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5473666572;
        Fri, 18 Aug 2023 13:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC4BC433C8;
        Fri, 18 Aug 2023 13:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366281;
        bh=m4kdhoIm71fqmT8MrBnTq3U3pdgSRr+oKh3NxokiMAc=;
        h=From:To:Cc:Subject:Date:From;
        b=X54fwvXA11/su1VMB+pIIHIaiTlfQa+hG4io26pTGccAhG7M8zkzpGZSZVKJD9DeL
         679APaqelPYvNZxQWb5c/MNee+eILwVO5A9RZtnLJTJDfpXsxH4T3XlowLmDcaL7fA
         J43j0DlQ5T4RIhwc8iq/dp5L1zEtLP8UZm1WYyhcICK4jd+A6NVkrywhoPLF0mBvk2
         bSkOxlHv335ClkS9ls/Dyn/LP7CPgmL1ZLOG4DnKgQ5H8t4BUG3N0wks45VGiCp9tA
         lCSVcO3EguFwdz0yDT9aDpts3Ow8LK+eATBkK1DndOXMOwcx2cAsyAmp3MWoiec09E
         32TVNpMU2hnxQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Marvin=20H=C3=A4user?= <mhaeuser@posteo.de>
Subject: [PATCH 00/17] x86/boot: Rework PE header generation
Date:   Fri, 18 Aug 2023 15:44:05 +0200
Message-Id: <20230818134422.380032-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4106; i=ardb@kernel.org; h=from:subject; bh=m4kdhoIm71fqmT8MrBnTq3U3pdgSRr+oKh3NxokiMAc=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV+6ZQ/+w5YTjl2+95+u2sXM5nteLyTPzxj7xO8xce0b auN8Iy0jlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRPSEM/xPEptc+KnzStkiX uS8t9kPql+33P/JovXbIZpX6VzT5pQojw/3zQmkqoVl5i5+LVq+e9fXE0tI7Uz7XJeQn6/znlQ5 +wAcA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now that the EFI stub boot flow no longer relies on memory that is
executable and writable at the same time, we can reorganize the PE/COFF
view of the kernel image and expose the decompressor binary's code and
r/o data as a .text section and data/bss as a .data section, using 4k
alignment and limited permissions.

Doing so is necessary for compatibility with hardening measures that are
being rolled out on x86 PCs built to run Windows (i.e., the majority of
them). The EFI boot environment that the Linux EFI stub executes in is
especially sensitive to safety issues, given that a vulnerability in the
loader of one OS can be abused to attack another.

In true x86 fashion, this is more complicated than on other
architectures, which have implemented this code/data split with 4k
alignment from the beginning. The complicating factor here is that the
boot image consists of two different parts, which are stitched together
and fixed up using a special build tool.

The first three patches simplify the x86 EFI stub code so it does not
even bother reading the setup header from the image - passing arguments
this way is not supported by EFI boot anyway.

Then, the bzImage is simplified and reorganized, primarily by:
- dropping the ancient 'bugger off' message occupying much of the header
  space
- using a fixed size of 16k for the setup block
- setting header values from asm instead of via the build tool

Finally, the payload is split into .text and .data, and the section and
file alignment increased to 4k/512 respectively.

The only remaining task performed by the build tool is generating the
CRC-32 that is fundamentally broken in practice and never used, so that
is dropped entirely at the end.

This supersedes the work proposed by Evgeniy last year, which did a
major rewrite of the build tool in order to clean it up, before updating
it to generate the new 4k aligned image layout. As this series proves,
the build tool is mostly unnecessary, and we have too many of those
already.

Cc: Evgeniy Baskov <baskov@ispras.ru>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Jones <pjones@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Marvin Häuser <mhaeuser@posteo.de>

Ard Biesheuvel (17):
  x86/efi: Drop EFI stub .bss from .data section
  x86/efi: Disregard setup header of loaded image
  x86/efi: Drop alignment flags from PE section headers
  x86/boot: Remove the 'bugger off' message
  x86/boot: Omit compression buffer from PE/COFF image memory footprint
  x86/boot: Drop redundant code setting the root device
  x86/boot: Grab kernel_info offset from zoffset header directly
  x86/boot: Drop references to startup_64
  x86/boot: Set EFI handover offset directly in header asm
  x86/boot: Drop workaround for binutils 2.14 in linker script ASSERTs
  x86/boot: Use fixed size of 16k for setup block
  x86/boot: Derive file size from _edata symbol
  x86/boot: Construct PE/COFF .text section from assembler
  x86/boot: Drop PE/COFF .reloc section
  x86/boot: Split off PE/COFF .data section
  x86/boot: Increase section and file alignment to 4k/512
  x86/boot: Drop CRC-32 checksum and the build tool that generates it

 Documentation/arch/x86/boot.rst         |  10 -
 arch/x86/boot/Makefile                  |  12 +-
 arch/x86/boot/compressed/vmlinux.lds.S  |   5 +-
 arch/x86/boot/header.S                  | 217 ++++-----
 arch/x86/boot/setup.ld                  |  21 +-
 arch/x86/boot/tools/.gitignore          |   2 -
 arch/x86/boot/tools/build.c             | 502 --------------------
 drivers/firmware/efi/libstub/Makefile   |   7 -
 drivers/firmware/efi/libstub/x86-stub.c |  46 +-
 9 files changed, 113 insertions(+), 709 deletions(-)
 delete mode 100644 arch/x86/boot/tools/.gitignore
 delete mode 100644 arch/x86/boot/tools/build.c

-- 
2.39.2

