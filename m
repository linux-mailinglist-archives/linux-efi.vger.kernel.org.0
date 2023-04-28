Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE80C6F1948
	for <lists+linux-efi@lfdr.de>; Fri, 28 Apr 2023 15:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjD1NXC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Apr 2023 09:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346079AbjD1NXB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Apr 2023 09:23:01 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A092112;
        Fri, 28 Apr 2023 06:22:59 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 26B7340755C4;
        Fri, 28 Apr 2023 13:22:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 26B7340755C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1682688173;
        bh=Sz2xgXPEAPP0QMGNv5a+ztrATbNnm4ydM0og+e9Nf0Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tlOULNMFWzSJmrrmvvxR6Osg5VhrHUSnWNC8/fBfs0nC6A4oJHBF99A/RU703wDA9
         XshQ4mkljezXVJI2FvAL1InXsF3KA3oEzajZiMWEqPSXBVHcuThrrA71D3fIafFite
         GU4cpM1yZhsOtkx3rTNMCoxcOqXnejh6btzZHnk4=
MIME-Version: 1.0
Date:   Fri, 28 Apr 2023 16:22:53 +0300
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
Subject: Re: [PATCH 0/6] efi/x86: Avoid legacy decompressor during EFI boot
In-Reply-To: <20230424165726.2245548-1-ardb@kernel.org>
References: <20230424165726.2245548-1-ardb@kernel.org>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <1d8389c7c4fb6efac18cc38c004f49ca@ispras.ru>
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

On 2023-04-24 19:57, Ard Biesheuvel wrote:
> This series is conceptually a combination of Evgeny's series [0] and
> mine [1], both of which attempt to make the early decompressor code 
> more
> amenable to executing in the EFI environment with stricter handling of
> memory permissions.
> 
> My series [1] implemented zboot for x86, by getting rid of the entire
> x86 decompressor, and replacing it with existing EFI code that does the
> same but in a generic way. The downside of this is that only EFI boot 
> is
> supported, making it unviable for distros, which need to support BIOS
> boot and hybrid EFI boot modes that omit the EFI stub.
> 
> Evgeny's series [0] adapted the entire decompressor code flow to allow
> it to execute in the EFI context as well as the bare metal context, and
> this involves changes to the 1:1 mapping code and the page fault
> handlers etc, none of which are really needed when doing EFI boot in 
> the
> first place.
> 
> So this series attempts to occupy the middle ground here: it makes
> minimal changes to the existing decompressor so some of it can be 
> called
> from the EFI stub. Then, it reimplements the EFI boot flow to 
> decompress
> the kernel and boot it directly, without relying on the trampoline 
> code,
> page table code or page fault handling code. This allows us to get rid
> of quite a bit of unsavory EFI stub code, and replace it with two clear
> invocations of the EFI firmware APIs to clear NX restrictions from
> allocations that have been populated with executable code.
> 
> The only code that is being reused is the decompression library itself,
> along with the minimal ELF parsing that is required to copy the ELF
> segments in place, and the relocation processing that fixes up absolute
> symbol references to refer to the correct virtual addresses.
> 
> Note that some of Evgeny's changes to clean up the PE/COFF header
> generation will still be needed, but I've omitted those here for
> brevity.

My series also implements W^X for both UEFI and non-UEFI boot paths, but 
I
agree that we can just consider non-UEFI code legacy and it would be 
better
to avoid touching it and encourage everyone to use UEFI code path on x86
instead. If PE format will also get fixed with either my patches or some
others, I do like your approach more than mine, as it removes a lot of 
old
cruft but does not break things (as far as I see). Seems like a perfect
compromise between [1] and my approach.

I've briefly tested the patches and looked through them and they look 
good
to me. Two things I've noticed:
  * there's one TSC-related TODO;
  * probably we want to clear .bss in efi32_stub_entry and 
efi64_stub_entry
    for UEFI handover protocol, since it's unfortunately still present 
and
    .bss will contain garbage.
I'll probably do some more testing on the weekend and let you know if I
find something.

Please tell me if/when you are going to merge these or similar, and I 
will
clean up and rebase PE-related patches on top of these.

I'd also like to send W^X patches for EFISTUB (omitting the non-UEFI 
boot
path) as a follow up after the PE file header will get fixed. They will 
be
considerably smaller with this approach and will not touch legacy code.

Thanks,
Evgeniy Baskov

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
> [0] https://lore.kernel.org/all/cover.1678785672.git.baskov@ispras.ru/
> [1] 
> https://lore.kernel.org/all/20230416120729.2470762-1-ardb@kernel.org/
> 
> Ard Biesheuvel (6):
>   x86: decompressor: Move global symbol references to C code
>   x86: decompressor: Factor out kernel decompression and relocation
>   x86: efistub: Obtain ACPI RSDP address while running in the stub
>   x86: efistub: Perform 4/5 level paging switch from the stub
>   x86: efistub: Prefer EFI memory attributes protocol over DXE services
>   x86: efistub: Avoid legacy decompressor when doing EFI boot
> 
>  arch/x86/boot/compressed/efi_mixed.S           |  55 ---
>  arch/x86/boot/compressed/head_32.S             |  24 --
>  arch/x86/boot/compressed/head_64.S             |  39 +--
>  arch/x86/boot/compressed/misc.c                |  44 ++-
>  arch/x86/include/asm/efi.h                     |   2 +
>  drivers/firmware/efi/libstub/efi-stub-helper.c |   4 +
>  drivers/firmware/efi/libstub/x86-stub.c        | 360 
> +++++++++++++-------
>  7 files changed, 279 insertions(+), 249 deletions(-)
