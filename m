Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480E06ED2F1
	for <lists+linux-efi@lfdr.de>; Mon, 24 Apr 2023 18:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjDXQ5q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Apr 2023 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjDXQ5p (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Apr 2023 12:57:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386F75592;
        Mon, 24 Apr 2023 09:57:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D279861938;
        Mon, 24 Apr 2023 16:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8227C433D2;
        Mon, 24 Apr 2023 16:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682355457;
        bh=IwUzErAvEsIxyUwV6dzjukx93sULgQiAOKamWXglYUQ=;
        h=From:To:Cc:Subject:Date:From;
        b=JqdGR02vPCKOkvV74LnqaVa1PMRDXMfulxcS05Yfsv4t2NHFyIFM7qG9I3dtguH/z
         cCQWPW5Y++gWS2vzjHflT7GX5gRVFy4eDmhv7wT+zbjNApmVcuRkbz9y1kImbnbW2T
         fkSP3QjDCKlFJv6cCsT2o1FeIQmBikYHE9pxctjbHKah5fMtKdO8+mPsHojcu0Ut5Y
         IAzTqduteM/oWLbmf7EANUc6R98VlVp8QvelDxKCLT6bXkyQtu+UkbCgkmic1cFDiP
         980RdBqRhOJJuyVZZ/vKYJEEXItPhtmo1KwHAZ8iQP3QlJrBQ9JHNKtQjCslUN/rgY
         WeDAvY69eBPDg==
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
Subject: [PATCH 0/6] efi/x86: Avoid legacy decompressor during EFI boot
Date:   Mon, 24 Apr 2023 18:57:20 +0200
Message-Id: <20230424165726.2245548-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3630; i=ardb@kernel.org; h=from:subject; bh=IwUzErAvEsIxyUwV6dzjukx93sULgQiAOKamWXglYUQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcVty9uKxIWFLApzWNRVuC/52UhvvBN/OCndsEawqmVa/ KHmaZ87SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETMVBn+l/85+2em4Y0vJdfn HXyRu4W1cJ3oS+Fy7lXcpcV99yUk8hgZrk2a+NNgj/JHh47p0f9/m0aE9nC9KlcsNT3TcTDuqbE jEwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series is conceptually a combination of Evgeny's series [0] and
mine [1], both of which attempt to make the early decompressor code more
amenable to executing in the EFI environment with stricter handling of
memory permissions.

My series [1] implemented zboot for x86, by getting rid of the entire
x86 decompressor, and replacing it with existing EFI code that does the
same but in a generic way. The downside of this is that only EFI boot is
supported, making it unviable for distros, which need to support BIOS
boot and hybrid EFI boot modes that omit the EFI stub.

Evgeny's series [0] adapted the entire decompressor code flow to allow
it to execute in the EFI context as well as the bare metal context, and
this involves changes to the 1:1 mapping code and the page fault
handlers etc, none of which are really needed when doing EFI boot in the
first place.

So this series attempts to occupy the middle ground here: it makes
minimal changes to the existing decompressor so some of it can be called
from the EFI stub. Then, it reimplements the EFI boot flow to decompress
the kernel and boot it directly, without relying on the trampoline code,
page table code or page fault handling code. This allows us to get rid
of quite a bit of unsavory EFI stub code, and replace it with two clear
invocations of the EFI firmware APIs to clear NX restrictions from
allocations that have been populated with executable code. 

The only code that is being reused is the decompression library itself,
along with the minimal ELF parsing that is required to copy the ELF
segments in place, and the relocation processing that fixes up absolute
symbol references to refer to the correct virtual addresses.

Note that some of Evgeny's changes to clean up the PE/COFF header
generation will still be needed, but I've omitted those here for
brevity.

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

[0] https://lore.kernel.org/all/cover.1678785672.git.baskov@ispras.ru/
[1] https://lore.kernel.org/all/20230416120729.2470762-1-ardb@kernel.org/

Ard Biesheuvel (6):
  x86: decompressor: Move global symbol references to C code
  x86: decompressor: Factor out kernel decompression and relocation
  x86: efistub: Obtain ACPI RSDP address while running in the stub
  x86: efistub: Perform 4/5 level paging switch from the stub
  x86: efistub: Prefer EFI memory attributes protocol over DXE services
  x86: efistub: Avoid legacy decompressor when doing EFI boot

 arch/x86/boot/compressed/efi_mixed.S           |  55 ---
 arch/x86/boot/compressed/head_32.S             |  24 --
 arch/x86/boot/compressed/head_64.S             |  39 +--
 arch/x86/boot/compressed/misc.c                |  44 ++-
 arch/x86/include/asm/efi.h                     |   2 +
 drivers/firmware/efi/libstub/efi-stub-helper.c |   4 +
 drivers/firmware/efi/libstub/x86-stub.c        | 360 +++++++++++++-------
 7 files changed, 279 insertions(+), 249 deletions(-)

-- 
2.39.2

