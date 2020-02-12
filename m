Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3340A15B27B
	for <lists+linux-efi@lfdr.de>; Wed, 12 Feb 2020 22:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgBLVI0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Feb 2020 16:08:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbgBLVI0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 Feb 2020 16:08:26 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90993217F4
        for <linux-efi@vger.kernel.org>; Wed, 12 Feb 2020 21:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581541705;
        bh=e5bSv3/7jdW2C373QBgrlB0zdKk6zEmqziwXOTZNqtc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2nxJDY1k2FMQ61u+VQSztv0rBqxjZRw8SemE1ZXuuLvBERuH75x4DubxfE8xz0vPK
         dSJ7Vk9nCAMCalVbm0qXLYiC6gIaFlT1Zgj275WlflTbBriFSqFsvuHh18ELi4b3kQ
         cYwA4v3f5WV0KyTcu/akvLSsOb6DqqwyvDsD24F8=
Received: by mail-wm1-f48.google.com with SMTP id c84so4230774wme.4
        for <linux-efi@vger.kernel.org>; Wed, 12 Feb 2020 13:08:25 -0800 (PST)
X-Gm-Message-State: APjAAAVZK8RS6/ZZXVhHEMOqT1t9h8jJb0Eh9PBb5hT1/AFxvXlx//yH
        +OcUOHPpUVII9/hhC8rFt+OoekjrHOgdUnTFE8cqJQ==
X-Google-Smtp-Source: APXvYqyIoSTXgHcWxkN41CL04I7QE1F9Gu86qcHND/6DUhO3HXosyOV8w041ZHL9UhXvHzMyldkd81WaSxLR/zy6Kpg=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr1123893wmk.68.1581541703944;
 Wed, 12 Feb 2020 13:08:23 -0800 (PST)
MIME-Version: 1.0
References: <aaf658ab-82ff-4a35-2984-77150924d3a7@redhat.com>
 <CAKv+Gu9fh_reYp65QXCeL4X3iovrCQFGNZWS3jMkpveZLgre-A@mail.gmail.com> <ab45ebd9-b2c3-d2f9-8947-be95aaab80bd@redhat.com>
In-Reply-To: <ab45ebd9-b2c3-d2f9-8947-be95aaab80bd@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 Feb 2020 21:08:12 +0000
X-Gmail-Original-Message-ID: <CAKv+Gu8GmNaS3vffDHcrCvKrbz5YLaVuZ_JoX0nNHBg3Tu0yhQ@mail.gmail.com>
Message-ID: <CAKv+Gu8GmNaS3vffDHcrCvKrbz5YLaVuZ_JoX0nNHBg3Tu0yhQ@mail.gmail.com>
Subject: Re: New EFI thunk alignment WARN_ON in 5.6 triggers multiple times
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 12 Feb 2020 at 16:00, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/12/20 12:53 PM, Ard Biesheuvel wrote:
> > On Wed, 12 Feb 2020 at 12:44, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi Ard,
> >>
> >> While booting 5.6-rc1 on one of my test machines I noticed the WARN_ON
> >> on line 198 of arch/x86/platform/efi/efi_64.c trigger many times.
> >>
> >> I've done some debugging on this an this is caused by the following
> >> call path:
> >>
> >> drivers/firmware/efi/vars.c: efivar_init():
> >>
> >>           unsigned long variable_name_size = 1024;
> >>           efi_char16_t *variable_name;
> >>           efi_guid_t vendor_guid;
> >>
> >>           variable_name = kzalloc(variable_name_size, GFP_KERNEL);
> >>           if (!variable_name) {
> >>                   printk(KERN_ERR "efivars: Memory allocation failed.\n");
> >>                   return -ENOMEM;
> >>           }
> >>
> >>          ...
> >>
> >>
> >>           do {
> >>                   variable_name_size = 1024;
> >>
> >>                   status = ops->get_next_variable(&variable_name_size,
> >>                                                   variable_name,
> >>                                                   &vendor_guid);
> >>          ...
> >>
> >> arch/x86/platform/efi/efi_64.c: efi_thunk_get_next_variable()
> >>
> >>          ...
> >>           phys_vendor = virt_to_phys_or_null(vendor);
> >>          ...
> >>
> >> arch/x86/platform/efi/efi_64.c: virt_to_phys_or_null_size()
> >>
> >>          ...
> >>          WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
> >>          ...
> >>
> >> Specifically the problem is that the efi_guid_t vendor_guid has an 8 bytes
> >> aligned address and the WARN_ON checks for it being aligned to\
> >> sizeof(efi_guid_t) which is 16 bytes.
> >>
> >> I've fixed this for now with the following local fix, but I'm not sure
> >> what the alignment rules actually are so I'm not sure this is correct:
> >>
> >> --- a/arch/x86/platform/efi/efi_64.c
> >> +++ b/arch/x86/platform/efi/efi_64.c
> >> @@ -181,6 +181,7 @@ static inline phys_addr_t
> >>    virt_to_phys_or_null_size(void *va, unsigned long size)
> >>    {
> >>          bool bad_size;
> >> +       int alignment;
> >>
> >>          if (!va)
> >>                  return 0;
> >> @@ -195,7 +196,8 @@ virt_to_phys_or_null_size(void *va, unsigned long size)
> >>           */
> >>          bad_size = size > PAGE_SIZE || !is_power_of_2(size);
> >>
> >> -       WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
> >> +       alignment = size > 8 ? 8 : size;
> >> +       WARN_ON(!IS_ALIGNED((unsigned long)va, alignment) || bad_size);
> >>
> >>          return slow_virt_to_phys(va);
> >>    }
> >>
> >>
> >> I have a feeling that this is the right thing to do, but as said I'm not 100%
> >> sure. If you can confirm that this is the right fix, then I can submit this
> >> upstream.
> >>
> >
> >
> > It seems that the purpose of the alignment check is to ensure that the
> > data does not cross a page boundary, so that the data is guaranteed to
> > be contiguous in the physical address space as well.
> >
> > So in that light, the fix is most definitely wrong, although I am not
> > sure how this is supposed to work generally.
>
> I'm not sure that is what it is trying to check, if that is what it is
> trying to check then the code is certainly wrong.
>
> Let me first quote the entire check:
>
>          /*
>           * A fully aligned variable on the stack is guaranteed not to
>           * cross a page bounary. Try to catch strings on the stack by
>           * checking that 'size' is a power of two.
>           */
>          bad_size = size > PAGE_SIZE || !is_power_of_2(size);
>
>          WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
>
> AFAIK EFI is using the identity map, and the kernel stack is
> physically contiguous, so crossing a page boundary should not a
> problem.

CONFIG_HAVE_ARCH_VMAP_STACK=y means the kernel stack may not be
contiguous in physical memory, which is why this was added in the
first place.

We do allocate a special stack for mixed mode, but we only switch to
it in the .S thunking code, so at this point, we are still running
from the vmap'ed stack

> Also notice how the bad_size thing is talking about
> page boundary crossing, but the thing triggering is the
> IS_ALIGNED check. AFAIK there is no requirement for a struct, e.g.
> an UUID (which is the problem here) to be aligned to its size,
> it just needs to be 8 byte / 64 bit aligned, which it is yet
> the IS_ALIGNED check is failing because it is checking for
> a larger, in this case twice as large, but possibly it will
> end up checking for a much larger alignment.
>

The idea is that a data structure of size < PAGE_SIZE is guaranteed
not to cross a page boundary if it is aligned to a power-of-2 upper
bound of its size. This has nothing to do with the data type or the
minimal alignment of any of its constituent parts.

> As said I'm not exactly familiar with the alignment requirements
> but the current check certainly seems wrong.
>
> It seems that we have had this around for a while, it stems from:
>
> ###
>  From f6697df36bdf0bf7fce984605c2918d4a7b4269f Mon Sep 17 00:00:00 2001
> From: Matt Fleming <matt@codeblueprint.co.uk>
> Date: Sat, 12 Nov 2016 21:04:24 +0000
> Subject: [PATCH v3] x86/efi: Prevent mixed mode boot corruption with
>   CONFIG_VMAP_STACK=y
>
> Booting an EFI mixed mode kernel has been crashing since commit:
>
>    e37e43a497d5 ("x86/mm/64: Enable vmapped stacks (CONFIG_HAVE_ARCH_VMAP_STACK=y
>
> The user-visible effect in my test setup was the kernel being unable
> to find the root file system ramdisk. This was likely caused by silent
> memory or page table corruption.
>
> Enabling CONFIG_DEBUG_VIRTUAL=y immediately flagged the thunking code as
> abusing virt_to_phys() because it was passing addresses that were not
> part of the kernel direct mapping.
>
> Use the slow version instead, which correctly handles all memory
> regions by performing a page table walk.
>
> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
> ###
>
> But I guess the recent changes are triggering the alignment check now.
>
> Alternatively we could make the GUID kalloc-ed instead of having it
> on the stack, but that seems unnecessary.
>
> Andy, Matt, do you have any input on this?
>
> Regards,
>
> Hans
>
>
