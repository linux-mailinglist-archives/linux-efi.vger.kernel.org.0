Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9B86E66C4
	for <lists+linux-efi@lfdr.de>; Tue, 18 Apr 2023 16:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjDROKo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Apr 2023 10:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjDROKn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Apr 2023 10:10:43 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC85813FBB;
        Tue, 18 Apr 2023 07:10:41 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 7C13240737BF;
        Tue, 18 Apr 2023 14:10:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7C13240737BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1681827037;
        bh=Oivj3VZiDr7OozgU0T+dW3I+LSNU/5BoOrTbq2uN6ZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l8S7t/HmJ/KyXMJsDZQGY6jXlmZvDUSTfBhSbH5DCuwCSbbzEd4+Jjj4BwTEFe2iA
         aU6FHHZKm9yuRxAe+Dg/joDAq9vACj5zJkxyZl4ZXcVQoH6cQXmAfgtH7wEAh+6qIt
         Cl9ICCkwDhIfCvx1hH9VgAWkQiGgyFpfyRlG7z7g=
MIME-Version: 1.0
Date:   Tue, 18 Apr 2023 17:10:37 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [RFC PATCH 0/3] efi: Implement generic zboot support
In-Reply-To: <20230416120729.2470762-1-ardb@kernel.org>
References: <20230416120729.2470762-1-ardb@kernel.org>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <620de8eecdc255f11313bb96e32b5b89@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2023-04-16 15:07, Ard Biesheuvel wrote:
> This series is a proof-of-concept that implements support for the EFI
> zboot decompressor for x86. It replaces the ordinary decompressor, and
> instead, performs the decompression, KASLR randomization and the 4/5
> level paging switch while running in the execution context of EFI.
> 
> This simplifies things substantially, and makes it straight-forward to
> abide by stricter future requirements related to the use of writable 
> and
> executable memory under EFI, which will come into effect on x86 systems
> that are certified as being 'more secure', and ship with an even 
> shinier
> Windows sticker.
> 
> This is an alternative approach to the work being proposed by Evgeny 
> [0]
> that makes rather radical changes to the existing decompressor, which
> has accumulated too many features already, e.g., related to 
> confidential
> compute etc.
> 
> EFI zboot images can be booted in two ways:
> - by EFI firmware, which loads and starts it as an ordinary EFI
>   application, just like the existing EFI stub (with which it shares
>   most of its code);
> - by a non-EFI loader that parses the image header for the compression
>   metadata, and decompresses the image into memory and boots it.
> 
> Realistically, the second option is unlikely to ever be used on x86,
> given that it already has its existing bzImage, but the first option is
> a good choice for distros that target EFI boot only (and some distros
> switched to this format already for arm64). The fact that EFI zboot is
> implemented in the same way on arm64, RISC-V, LoongArch and [shortly]
> ARM helps with maintenance, not only of the kernel itself, but also the
> tooling around it relating to kexec, code signing, deployment, etc.
> 
> Series can be pulled from [1], which contains some prerequisite patches
> that are only tangentially related.

I've considered using similar approach when I was writing my series.
That looks great if you look at subject without considering backwards
compatibility, especially due to the increased code sharing and the 
usage
of the code path without all the legacy stuff. But, I think, that zboot
approach have two downsides:

* Most distros won't use it, due to backward compatibility, so they 
won't
   benefit the improvements.
* Those distros that would potentially use it, have to be either
   DIY-ish like Gentoo, or provide both kernels during installation.
   So it either complicates installation process or installer logic.

It might work for UEFI-only distros, but those won't be a majority for a
little while for x86, I think. Because it's very likely that a lot of 
people
will complain if distro provides zboot-only kernel (considering that the
same story with the handover protocol). Backward compatibility is evil.

So, I think, at least for now, it would still be better to change 
existing
extraction code and stay compatible, despite it being harder and less 
clean...

(zboot also lacks the support for some kernel options, like ones used 
for
tweaking memory map; mixed mode support and probably the handling of
CONFIG_MEMORY_HOTREMOVE, but that's an RFC, so this comment is largely
irrelevant for now.)

Thanks,
Evgeniy Baskov

> 
> [0] https://lore.kernel.org/all/cover.1678785672.git.baskov@ispras.ru/
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-x86-zboot
> 
> Cc: Evgeniy Baskov <baskov@ispras.ru>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> 
> Ard Biesheuvel (3):
>   efi/libstub: x86: Split off pieces shared with zboot
>   efi/zboot: x86: Implement EFI zboot support
>   efi/zboot: x86: Clear NX restrictions on populated code regions
> 
>  arch/x86/Makefile                              |  18 +-
>  arch/x86/include/asm/efi.h                     |  10 +
>  arch/x86/kernel/head_64.S                      |  15 +
>  arch/x86/zboot/Makefile                        |  29 +
>  drivers/firmware/efi/Kconfig                   |   2 +-
>  drivers/firmware/efi/libstub/Makefile          |  15 +-
>  drivers/firmware/efi/libstub/Makefile.zboot    |   2 +-
>  drivers/firmware/efi/libstub/efi-stub-helper.c |   3 +
>  drivers/firmware/efi/libstub/x86-stub.c        | 592 
> +------------------
>  drivers/firmware/efi/libstub/x86-zboot.c       | 322 ++++++++++
>  drivers/firmware/efi/libstub/x86.c             | 612 
> ++++++++++++++++++++
>  drivers/firmware/efi/libstub/zboot.c           |   3 +-
>  drivers/firmware/efi/libstub/zboot.lds         |   5 +
>  13 files changed, 1031 insertions(+), 597 deletions(-)
>  create mode 100644 arch/x86/zboot/Makefile
>  create mode 100644 drivers/firmware/efi/libstub/x86-zboot.c
>  create mode 100644 drivers/firmware/efi/libstub/x86.c
