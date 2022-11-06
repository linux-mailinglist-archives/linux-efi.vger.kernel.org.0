Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00A961E1BD
	for <lists+linux-efi@lfdr.de>; Sun,  6 Nov 2022 11:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKFKv1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Nov 2022 05:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKFKvZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Nov 2022 05:51:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFE79FE7
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 02:51:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D13A960C07
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 10:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE01C43141
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 10:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667731883;
        bh=DXMCd7iosMKdKvWkFiI5Q17zPtxYXjXyucEr2upsacw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FA5chc+WEiZtAx7TbEm355CXpi4n94gF4l9sokf4gBDswDIBoIoS7kv2gIKaVgG2v
         3epMhEkUgPswiqaOo9osWoTx+aOmip2e699mTFtPogBzUDnriCt7qF4PmuI6kEnaL6
         eaVFIovG0ZB9TMkfujELagOPRnghc+fO4y7x8ruR5eRfld5YKTTP6C0BEVds1sOc7i
         i0rGsWQj4/TKexpkAhnK/0dA+Fdk3D7W3A6Z0DVNDRgnY+qp3+Ox+SfSrIelrZYEwE
         cG4xep3GxPpikQIG3qNuoCv3JLJ43n96hv+whsWHLzNhNvylLEwC1E2qxMvrdI10Re
         87JsTdXP3wyBQ==
Received: by mail-lj1-f169.google.com with SMTP id a15so12234420ljb.7
        for <linux-efi@vger.kernel.org>; Sun, 06 Nov 2022 02:51:23 -0800 (PST)
X-Gm-Message-State: ACrzQf0r+t4TNqyrN+Dj+Yh49pHns7+0P1/zNVjgPDVoO9Jot+XlgzD7
        iDasor2pAETFmU5iLn8Im78lqP5adXUcWYm7pfw=
X-Google-Smtp-Source: AMsMyM4HXlnXrkVKgwjO0fqo+PZZxYznJPNfZdWmYtDUEInXrmTaIx8EER0H74FNkdjS8WBMGyicvTSE+ZyEidoE5NA=
X-Received: by 2002:a2e:6119:0:b0:277:593e:c2af with SMTP id
 v25-20020a2e6119000000b00277593ec2afmr13226779ljb.516.1667731881078; Sun, 06
 Nov 2022 02:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20221105225234.3089177-1-ardb@kernel.org> <86e2cd39-630a-da76-bbfd-99815a8c2753@canonical.com>
 <467c7858-305f-8a98-d974-d5dea8b84101@canonical.com> <CAMj1kXHX3rZ=jEA-AFqSAkVQbmtFkWCPk1XxMaQB7c8xutPVbw@mail.gmail.com>
 <37dfb84c-dcf1-a78e-0895-ab3e8b21f554@canonical.com>
In-Reply-To: <37dfb84c-dcf1-a78e-0895-ab3e8b21f554@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 6 Nov 2022 11:51:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHNA_NVoJBt9afBmt6wWS7HPhPfUWwfMScmPKBujTu6ew@mail.gmail.com>
Message-ID: <CAMj1kXHNA_NVoJBt9afBmt6wWS7HPhPfUWwfMScmPKBujTu6ew@mail.gmail.com>
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

On Sun, 6 Nov 2022 at 11:44, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> On 11/6/22 10:48, Ard Biesheuvel wrote:
> > On Sun, 6 Nov 2022 at 03:27, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >>
> >>
> >> On 11/6/22 00:24, Heinrich Schuchardt wrote:
> >>> On 11/5/22 23:52, Ard Biesheuvel wrote:
> >>>> The EFI spec requires that on arm64 systems, all runtime code and data
> >>>> regions that share a 64k page can be mapped with the same memory type
> >>>> attributes. Unfortunately, this does not take permission attributes into
> >>>> account, and so the firmware is permitted to expose runtime code and
> >>>> data regions that share 64k pages, and this may prevent the OS from
> >>>> using restricted permissions in such cases, e.g., map data regions with
> >>>> non-exec attributes.
> >>>
> >>> This is the relevant paragraph in the UEFI specification:
> >>>
> >>> <cite>
> >>> The ARM architecture allows mapping pages at a variety of granularities,
> >>> including 4KiB and 64KiB. If a 64KiB physical page contains any 4KiB
> >>> page with any of the following types listed below, then all 4KiB pages
> >>> in the 64KiB page must use identical ARM Memory Page Attributes (as
> >>> described in Map EFI Cacheability Attributes to AArch64 Memory Types):
> >>>
> >>> - EfiRuntimeServicesCode
> >>> - EfiRuntimeServicesData
> >>> - EfiReserved
> >>> - EfiACPIMemoryNVS
> >>>
> >>> Mixed attribute mappings within a larger page are not allowed.
> >>> </cite>
> >>>
> >>> It remains unclear if only EFI Cacheability of also other page
> >>> attributes are meant. The UEFI specification should be clarified in this
> >>> respect.
> >>>
> >>>>
> >>>> We currently emit a warning when hitting this at boot, but the warning
> >>>> is problematic for a number of reasons:
> >>>> - it uses WARN() which spews a lot of irrelevant information into the
> >>>>     log about the execution context where the issue was detected;
> >>>> - it only takes the start of the region into account and not the size
> >>>
> >>> Is the occurrence of the warning specific to U-Boot or do you see the
> >>> warning with EDK II too?
> >>>
> >>>>
> >>>> Let's just drop the warning, as the condition does not strictly violate
> >>>> the spec (although it only occurs with U-Boot), and fix the check to
> >>>> take both the start and the end addresses into account.
> >>>>
> >>>> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> >>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>>> ---
> >>>>    arch/arm64/kernel/efi.c | 4 ++--
> >>>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> >>>> index e1be6c429810d0d5..3dd6f0c66f8aeb78 100644
> >>>> --- a/arch/arm64/kernel/efi.c
> >>>> +++ b/arch/arm64/kernel/efi.c
> >>>> @@ -25,8 +25,8 @@ static __init pteval_t
> >>>> create_mapping_protection(efi_memory_desc_t *md)
> >>>>        if (type == EFI_MEMORY_MAPPED_IO)
> >>>>            return PROT_DEVICE_nGnRE;
> >>>> -    if (WARN_ONCE(!PAGE_ALIGNED(md->phys_addr),
> >>>> -              "UEFI Runtime regions are not aligned to 64 KB -- buggy
> >>>> firmware?"))
> >>>> +    if (!PAGE_ALIGNED(md->phys_addr) ||
> >>>> +        !PAGE_ALIGNED(md->num_pages * EFI_PAGE_SIZE))
> >>>
> >>> Enhancing the check is correct.
> >>
> >> The UEFI requirement is that within a 64 KiB page all memory descriptors
> >> shall use the same page attributes if any 4 KiB sub-page is of one of
> >> the following types.
> >>
> >> - EfiRuntimeServicesCode
> >> - EfiRuntimeServicesData
> >> - EfiReserved
> >> - EfiACPIMemoryNVS
> >>
> >> It is not required that memory descriptors shall be aligned to 64 KiB
> >> boundaries.
> >>
> >
> > Indeed, this is what I misremembered.
> >
> >> So the following map should not pose any problem:
> >>
> >> 00000-00fff - EfiBootServicesData (not used at runtime)
> >> 01000-13fff - EfiRuntimeServicesData
> >> 14000-1ffff - EfiRuntimeServicesData
> >> 20000-24fff - EfiRuntimeServicesCode
> >> 25000-27fff - EfiBootServicesCode (not used at runtime)
> >> 28000-3ffff - EfiRuntimeServicesCode
> >>
> >> Evaluating each memory descriptor individually looks wrong. You first
> >> have to extend each memory descriptor of one of the four aforementioned
> >> memory types to the next 64 KiB boundary or within a 64 KiB boundary to
> >> the next descriptor of one of the aforementioned memory types. Next you
> >> have to merge adjacent descriptors with same attributes within the same
> >> 64 KiB page.
> >>
> >
> > So now we have to look at adjacent descriptors, which means we have to
> > sort the memory map, as there is no guarantee that the descriptors
> > appear in order.
> >
> >> So the map for which you set attributes would become
> >>
> >> 00000-1ffff - EfiRuntimeServicesData
> >> 20000-3ffff - EfiRuntimeServicesCode
> >>
> >> I guess all that alignment and merging should go into efi_virtmap_init().
> >>
> >
> > U-boot does not provide a memory attributes table either, so we don't
> > know which parts of the code regions should be mapped R-X and which
> > parts RW- (Firmware implementations such as EDK2 that are based on
> > PE/COFF images internally use code descriptors for each executable,
> > which means they cover both the .text/.rodata and .data/.bss sections
> > of the image. The data descriptors are used for dynamic allocations).
> >
> > This is why we use RWX for RTcode and RW- for RTdata in absence of the
> > RO/XP attributes (which are passed via the memory attributes table
> > usually).
> >
> > So in summary, I think the patch is fine. The warning is spurious
> > given that the condition in question is actually permitted by the
> > spec.
> >
> > On the uboot side, which already seems to align and round up RTcode
> > sections to 64k, we might set the EFI_MEMORY_RO attribute on such
> > regions if they really only contain .text and .rodata segments, and
> > can tolerate being mapped without writable permissions. That way, the
> > kernel will understand that it does not need to provide RWX
> > permissions, which is really what all this code is trying to prevent.
>
> Shouldn't EFI_MEMORY_RO only be set if the UEFI firmware actually sets
> up the MMU to make the corresponding memory read only?
>

No. The EFI_MEMORY_RO and XP attributes describe the nature of the
contents of the regions, i.e., if they support being mapped with
read-only resp. non-executable permissions. The same applies to the
memory type attributes, btw: on bare metal, the memory is usually
described as WC|WT|WB and it is up to the OS to choose between memory
types when it creates the mapping - how the firmware maps it is
irrelevant.

In general, the OS does not care or even tries to determine how the
firmware has programmed the MMU and the page tables.
