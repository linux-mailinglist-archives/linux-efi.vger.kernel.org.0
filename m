Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7554327FF
	for <lists+linux-efi@lfdr.de>; Mon, 18 Oct 2021 21:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhJRTzb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Oct 2021 15:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231811AbhJRTz3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 18 Oct 2021 15:55:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8C2961002
        for <linux-efi@vger.kernel.org>; Mon, 18 Oct 2021 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634586797;
        bh=sOl+VurdbRQlMDN5zvi4+bH/zAZBoEz/ciiXSk0TZl8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kc5rgd0uvQ7Z+Dl0Q4ZQgrU82u0EakfU+KcdSn9FzDPOoA2RWs7G1k2xC+gfkhf/x
         +Y618ppaYOMPAkImWF7IkR6X/KnmR7DFTHTj1zPfEhvhwkZAkUpAOKriOHMrSSdp9n
         lTqc5AxrqcThTOLUCJdhO8LfP9O6yLTEvw/kdJ1YE6klj7xFSPp9GKT05zjS4JhDb7
         WED/fCXa2UByba+jKv9d7wxF2vRGbt8VrP7MoR6hbNzvq5ln3rUpm5nNPYIdE00Zan
         vwI7e77RlW/QmJESJHi475l9lI6tPOM9qkAtKIAyiqI/wH+bucm/5A7smtpQTwj034
         Xy0t57ZG6TLQw==
Received: by mail-ot1-f46.google.com with SMTP id l10-20020a056830154a00b00552b74d629aso1237825otp.5
        for <linux-efi@vger.kernel.org>; Mon, 18 Oct 2021 12:53:17 -0700 (PDT)
X-Gm-Message-State: AOAM531WluKzWTYt0nkQNxybTVIAuie2eW5S4L9SDdy2JSJb0m3XrLNd
        5Wll3WhfQpu2nT4EMNgQawwwzn2gH2ANBb3L5GA=
X-Google-Smtp-Source: ABdhPJxcE1/MgEYuZ8y+pzscG1g02Nk5pCtsQvl38iMinFwhdqwUoVEY5Wo76yAT+/8tq7JF+sHe3cYUl4BCRXWV65Y=
X-Received: by 2002:a05:6830:561:: with SMTP id f1mr1619816otc.30.1634586797226;
 Mon, 18 Oct 2021 12:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgze5ZZoqOjWrLap4gHPKMgAqeW5YYd=g25GKUiEQx6rjB7SQ@mail.gmail.com>
In-Reply-To: <CAKgze5ZZoqOjWrLap4gHPKMgAqeW5YYd=g25GKUiEQx6rjB7SQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 18 Oct 2021 21:53:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEt3M81QkrQjrFPrP5wQHOD95gRpaUJNXRJxU7Q6cU+xg@mail.gmail.com>
Message-ID: <CAMj1kXEt3M81QkrQjrFPrP5wQHOD95gRpaUJNXRJxU7Q6cU+xg@mail.gmail.com>
Subject: Re: Can EFI memory descriptors overlap? [PING v1]
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 18 Oct 2021 at 20:49, Martin Fernandez
<martin.fernandez@eclypsium.com> wrote:
>
> Hi, I'm working on the rework of
> https://lore.kernel.org/linux-efi/CAMj1kXEqjHVRNV131=o_aO3TX+58xhYzgfaVDrd0RngAqqtrVg@mail.gmail.com/T/
> and I wanted to know if the memory map given by EFI have any guarantee
> that the regions don't overlap.
>

Please don't ask people to refer to postings that are legally dubious.
I understand that this may sound exaggerated to you, but it is the
reality of open source.

> I couldn't find anything in the UEFI spec, but there is a piece of
> code in the kernel that seems to "doesn't care" and assumes that the
> regions given by EFI are sorted and don't overlap.
>

In my experience with EDK2 based UEFI firmware, the entries covering
system DRAM are usually sorted, with additional MMIO entries appearing
unordered. This is because the UEFI memory map is constructed from the
GCD memory map, which is seeded with the DRAM regions at boot, and
allocations are created by splitting them up.

> https://elixir.bootlin.com/linux/latest/source/arch/x86/platform/efi/efi.c#L502
>
> static void __init efi_merge_regions(void)
> {
>     efi_memory_desc_t *md, *prev_md = NULL;
>
>     for_each_efi_memory_desc(md) {
>         u64 prev_size;
>
>         if (!prev_md) {
>             prev_md = md;
>             continue;
>         }
>
>         if (prev_md->type != md->type ||
>             prev_md->attribute != md->attribute) {
>             prev_md = md;
>             continue;
>         }
>
>         prev_size = prev_md->num_pages << EFI_PAGE_SHIFT;
>
>         if (md->phys_addr == (prev_md->phys_addr + prev_size)) {
>             prev_md->num_pages += md->num_pages;
>             md->type = EFI_RESERVED_TYPE;
>             md->attribute = 0;
>             continue;
>         }
>         prev_md = md;
>     }
> }
>
> Is this a bug or in practice EFI always gives a "nice" memory map?

I agree that this practice has no basis in the spec.

> I
> think that if there is no overlap then the sorting (EFI doesn't give
> me a sorted memory map on my machine) is a kind of easy problem to
> solve, but if there is overlap involved then we need to decide for the
> type and the attributes of those overlaps, which can be tricky.
>
> I'm working on x86 and with the master branch of the kernel.

Overlap is another matter, though. Overlap means that the EFI memory
map is ambiguous, and contains more than one description of the same
memory region. Since the spec does not describe this case, I will pull
the 'undefined behavior' card, and propose that we pretend that those
can never occur.

-- 
Ard.
