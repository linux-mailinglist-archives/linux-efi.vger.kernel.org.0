Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E410E61E1B3
	for <lists+linux-efi@lfdr.de>; Sun,  6 Nov 2022 11:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiKFKlJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Nov 2022 05:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiKFKlI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Nov 2022 05:41:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2618AAE66
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 02:41:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAD73B80925
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 10:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED4BC433D7
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 10:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667731264;
        bh=JqIgag7SJQ4u5uTKrLiq6o9T9t/fS85OmG6OPq/epqk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=beNHZuPAekUZq9/ShHT8sPDmfS00HeiaDqV/DizQSH3zJB97aI/fAlajkS0HH44ox
         XQklOP0RZKXQmjZYmGU2rlABqfU1dKliZ6gwKhFcIGRIRL8oy9kzsFlEO51YxACNEx
         dH9r1i/ncWS35mU86dDidA0HMwBIIahHICKqBv0/fQgXtfbM/0nEz2bQoAGOS5NdWt
         g7epmrNwOx1HUW3s+MpV6xTdsjVKqBseIaSPr5QHb6RUsWHXttPfrG9BP2DrcdbmSf
         vn8Frga6mo7KGPw6R2LNl5sL70LhBW2l4kPdcGmMdLrvxJso0dY1q7zyIVpcCbGkDR
         gNbnC160aB/gA==
Received: by mail-lj1-f178.google.com with SMTP id s24so12201128ljs.11
        for <linux-efi@vger.kernel.org>; Sun, 06 Nov 2022 02:41:04 -0800 (PST)
X-Gm-Message-State: ACrzQf0DQY3z5HX7WLxXNqqd9nmGe1iZ7yo9OcMmn2zgZoat+BVhi0a4
        8VK2vO4ObBJP1ZQIz7vM/a1dOyTB+ZTnnsDGGRg=
X-Google-Smtp-Source: AMsMyM6v7i5/n6tyZ1jNZqvls0+LHMGyRRrQ/3PSJG1goMHZJj0rnsFTeaKIOTurvf8mq6+jlZbQSnP91yStYlhHjnc=
X-Received: by 2002:a05:651c:516:b0:277:2428:3682 with SMTP id
 o22-20020a05651c051600b0027724283682mr4387239ljp.291.1667731262251; Sun, 06
 Nov 2022 02:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20221105225234.3089177-1-ardb@kernel.org> <86e2cd39-630a-da76-bbfd-99815a8c2753@canonical.com>
 <467c7858-305f-8a98-d974-d5dea8b84101@canonical.com> <CAMj1kXHX3rZ=jEA-AFqSAkVQbmtFkWCPk1XxMaQB7c8xutPVbw@mail.gmail.com>
In-Reply-To: <CAMj1kXHX3rZ=jEA-AFqSAkVQbmtFkWCPk1XxMaQB7c8xutPVbw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 6 Nov 2022 11:40:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEGQj_QgRtxUinNc_SuwxdNFGy_gdhjYZ+wMjTj9pCjWg@mail.gmail.com>
Message-ID: <CAMj1kXEGQj_QgRtxUinNc_SuwxdNFGy_gdhjYZ+wMjTj9pCjWg@mail.gmail.com>
Subject: Re: [PATCH] arm64: efi: Make runtime region misalignment warning less noisy
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 6 Nov 2022 at 10:48, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 6 Nov 2022 at 03:27, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> >
> >
> > On 11/6/22 00:24, Heinrich Schuchardt wrote:
> > > On 11/5/22 23:52, Ard Biesheuvel wrote:
> > >> The EFI spec requires that on arm64 systems, all runtime code and data
> > >> regions that share a 64k page can be mapped with the same memory type
> > >> attributes. Unfortunately, this does not take permission attributes into
> > >> account, and so the firmware is permitted to expose runtime code and
> > >> data regions that share 64k pages, and this may prevent the OS from
> > >> using restricted permissions in such cases, e.g., map data regions with
> > >> non-exec attributes.
> > >
> > > This is the relevant paragraph in the UEFI specification:
> > >
> > > <cite>
> > > The ARM architecture allows mapping pages at a variety of granularities,
> > > including 4KiB and 64KiB. If a 64KiB physical page contains any 4KiB
> > > page with any of the following types listed below, then all 4KiB pages
> > > in the 64KiB page must use identical ARM Memory Page Attributes (as
> > > described in Map EFI Cacheability Attributes to AArch64 Memory Types):
> > >
> > > - EfiRuntimeServicesCode
> > > - EfiRuntimeServicesData
> > > - EfiReserved
> > > - EfiACPIMemoryNVS
> > >
> > > Mixed attribute mappings within a larger page are not allowed.
> > > </cite>
> > >
> > > It remains unclear if only EFI Cacheability of also other page
> > > attributes are meant. The UEFI specification should be clarified in this
> > > respect.
> > >
> > >>
> > >> We currently emit a warning when hitting this at boot, but the warning
> > >> is problematic for a number of reasons:
> > >> - it uses WARN() which spews a lot of irrelevant information into the
> > >>    log about the execution context where the issue was detected;
> > >> - it only takes the start of the region into account and not the size
> > >
> > > Is the occurrence of the warning specific to U-Boot or do you see the
> > > warning with EDK II too?
> > >
> > >>
> > >> Let's just drop the warning, as the condition does not strictly violate
> > >> the spec (although it only occurs with U-Boot), and fix the check to
> > >> take both the start and the end addresses into account.
> > >>
> > >> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >> ---
> > >>   arch/arm64/kernel/efi.c | 4 ++--
> > >>   1 file changed, 2 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> > >> index e1be6c429810d0d5..3dd6f0c66f8aeb78 100644
> > >> --- a/arch/arm64/kernel/efi.c
> > >> +++ b/arch/arm64/kernel/efi.c
> > >> @@ -25,8 +25,8 @@ static __init pteval_t
> > >> create_mapping_protection(efi_memory_desc_t *md)
> > >>       if (type == EFI_MEMORY_MAPPED_IO)
> > >>           return PROT_DEVICE_nGnRE;
> > >> -    if (WARN_ONCE(!PAGE_ALIGNED(md->phys_addr),
> > >> -              "UEFI Runtime regions are not aligned to 64 KB -- buggy
> > >> firmware?"))
> > >> +    if (!PAGE_ALIGNED(md->phys_addr) ||
> > >> +        !PAGE_ALIGNED(md->num_pages * EFI_PAGE_SIZE))
> > >
> > > Enhancing the check is correct.
> >
> > The UEFI requirement is that within a 64 KiB page all memory descriptors
> > shall use the same page attributes if any 4 KiB sub-page is of one of
> > the following types.
> >
> > - EfiRuntimeServicesCode
> > - EfiRuntimeServicesData
> > - EfiReserved
> > - EfiACPIMemoryNVS
> >
> > It is not required that memory descriptors shall be aligned to 64 KiB
> > boundaries.
> >
>
> Indeed, this is what I misremembered.
>
> > So the following map should not pose any problem:
> >
> > 00000-00fff - EfiBootServicesData (not used at runtime)
> > 01000-13fff - EfiRuntimeServicesData
> > 14000-1ffff - EfiRuntimeServicesData
> > 20000-24fff - EfiRuntimeServicesCode
> > 25000-27fff - EfiBootServicesCode (not used at runtime)
> > 28000-3ffff - EfiRuntimeServicesCode
> >
> > Evaluating each memory descriptor individually looks wrong. You first
> > have to extend each memory descriptor of one of the four aforementioned
> > memory types to the next 64 KiB boundary or within a 64 KiB boundary to
> > the next descriptor of one of the aforementioned memory types. Next you
> > have to merge adjacent descriptors with same attributes within the same
> > 64 KiB page.
> >
>
> So now we have to look at adjacent descriptors, which means we have to
> sort the memory map, as there is no guarantee that the descriptors
> appear in order.
>
> > So the map for which you set attributes would become
> >
> > 00000-1ffff - EfiRuntimeServicesData
> > 20000-3ffff - EfiRuntimeServicesCode
> >
> > I guess all that alignment and merging should go into efi_virtmap_init().
> >
>
> U-boot does not provide a memory attributes table either, so we don't
> know which parts of the code regions should be mapped R-X and which
> parts RW- (Firmware implementations such as EDK2 that are based on
> PE/COFF images internally use code descriptors for each executable,
> which means they cover both the .text/.rodata and .data/.bss sections
> of the image. The data descriptors are used for dynamic allocations).
>
> This is why we use RWX for RTcode and RW- for RTdata in absence of the
> RO/XP attributes (which are passed via the memory attributes table
> usually).
>
> So in summary, I think the patch is fine. The warning is spurious
> given that the condition in question is actually permitted by the
> spec.
>
> On the uboot side, which already seems to align and round up RTcode
> sections to 64k, we might set the EFI_MEMORY_RO attribute on such
> regions if they really only contain .text and .rodata segments, and
> can tolerate being mapped without writable permissions. That way, the
> kernel will understand that it does not need to provide RWX
> permissions, which is really what all this code is trying to prevent.
>

OK, this is not entirely true. Setting EFI_MEMORY_RO on sufficiently
aligned RTcode descriptors that don't require read-write permissions
would definitely be an improvement, but the current code would still
use RWX for RTdata sections that are not aligned to 64k (on 16k or 64k
pagesize OS builds) because otherwise, we'd have to go over the EFI
memory map again to check whether setting RW- on the RTdata region in
question would not result in an adjacent RTcode region losing its
executable permissions.

So what we might do is detect this condition, and if it triggers, go
over the memory map again and map all misaligned RTcode descriptors
again. I'll go and code this up and send a v2.
