Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC98515BC9C
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2020 11:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgBMKSb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 05:18:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgBMKSa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 Feb 2020 05:18:30 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE08D24650
        for <linux-efi@vger.kernel.org>; Thu, 13 Feb 2020 10:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581589110;
        bh=9M6nuPOdZ1d3D0M534ZlPehZgoBRsrCzN65Cpx6Ze20=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KGHH6nPQPlu7VNAuubmywrvGU4S9OhHLsuY9uGC80TiCI5JvRnq8Xu9iFDD0evJjc
         LyONdr5n5BKXtKeio7LWpL35S2Nuui60SdPBBVB0qgz/xYJvHlcOXx8IitPL6KE6u1
         CGagLH4k6w23ZjeIzgIV3cvfjIbn0F34NbCI0enU=
Received: by mail-wm1-f54.google.com with SMTP id m10so6749931wmc.0
        for <linux-efi@vger.kernel.org>; Thu, 13 Feb 2020 02:18:29 -0800 (PST)
X-Gm-Message-State: APjAAAU6LAZzEOGpJ1kRYKDqvADkV9ApHaYqqzZvCEMbhXpxmbvJflYR
        vrRcG2fBq2GhCtVI6YhD9th1sMNQT8OB2oV1dmXFlA==
X-Google-Smtp-Source: APXvYqwlOPP5vFsSGlu1ZZcfPLME4OW4U6k5H7XgbuemlRqDSmfYC+mJomr6RAKaxJR5TtjRZCHHsSKmj782lSnyT0c=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr5291397wmf.133.1581589107984;
 Thu, 13 Feb 2020 02:18:27 -0800 (PST)
MIME-Version: 1.0
References: <aaf658ab-82ff-4a35-2984-77150924d3a7@redhat.com>
 <CAKv+Gu9fh_reYp65QXCeL4X3iovrCQFGNZWS3jMkpveZLgre-A@mail.gmail.com>
 <ab45ebd9-b2c3-d2f9-8947-be95aaab80bd@redhat.com> <CAKv+Gu8GmNaS3vffDHcrCvKrbz5YLaVuZ_JoX0nNHBg3Tu0yhQ@mail.gmail.com>
 <fcfc69c7-7f29-9415-9f33-b46cf29b0118@redhat.com> <CAKv+Gu9S02grcMdZckicO2PwQK0XQi0iCNR_W+XXedSAHskW5Q@mail.gmail.com>
 <CAKv+Gu9b7O9XMWBTyyU4aEY0n4CW+XZ=872kqMKHfPwt1GdpXw@mail.gmail.com> <9521badf-0753-01a4-95a9-99881bdec7ca@redhat.com>
In-Reply-To: <9521badf-0753-01a4-95a9-99881bdec7ca@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 13 Feb 2020 10:18:16 +0000
X-Gmail-Original-Message-ID: <CAKv+Gu8A-cYVBdN6FWVOTAepp1Dix3Wy7v=swBjG9LxFFN-+1A@mail.gmail.com>
Message-ID: <CAKv+Gu8A-cYVBdN6FWVOTAepp1Dix3Wy7v=swBjG9LxFFN-+1A@mail.gmail.com>
Subject: Re: New EFI thunk alignment WARN_ON in 5.6 triggers multiple times
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 13 Feb 2020 at 11:03, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/13/20 9:55 AM, Ard Biesheuvel wrote:
> > On Thu, 13 Feb 2020 at 09:03, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> On Thu, 13 Feb 2020 at 08:36, Hans de Goede <hdegoede@redhat.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On 2/12/20 10:08 PM, Ard Biesheuvel wrote:
> >>>> On Wed, 12 Feb 2020 at 16:00, Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> On 2/12/20 12:53 PM, Ard Biesheuvel wrote:
> >>>>>> On Wed, 12 Feb 2020 at 12:44, Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>>>>
> >>>>>>> Hi Ard,
> >>>>>>>
> >>>>>>> While booting 5.6-rc1 on one of my test machines I noticed the WARN_ON
> >>>>>>> on line 198 of arch/x86/platform/efi/efi_64.c trigger many times.
> >>>>>>>
> >>>>>>> I've done some debugging on this an this is caused by the following
> >>>>>>> call path:
> >>>>>>>
> >>>>>>> drivers/firmware/efi/vars.c: efivar_init():
> >>>>>>>
> >>>>>>>             unsigned long variable_name_size = 1024;
> >>>>>>>             efi_char16_t *variable_name;
> >>>>>>>             efi_guid_t vendor_guid;
> >>>>>>>
> >>>>>>>             variable_name = kzalloc(variable_name_size, GFP_KERNEL);
> >>>>>>>             if (!variable_name) {
> >>>>>>>                     printk(KERN_ERR "efivars: Memory allocation failed.\n");
> >>>>>>>                     return -ENOMEM;
> >>>>>>>             }
> >>>>>>>
> >>>>>>>            ...
> >>>>>>>
> >>>>>>>
> >>>>>>>             do {
> >>>>>>>                     variable_name_size = 1024;
> >>>>>>>
> >>>>>>>                     status = ops->get_next_variable(&variable_name_size,
> >>>>>>>                                                     variable_name,
> >>>>>>>                                                     &vendor_guid);
> >>>>>>>            ...
> >>>>>>>
> >>>>>>> arch/x86/platform/efi/efi_64.c: efi_thunk_get_next_variable()
> >>>>>>>
> >>>>>>>            ...
> >>>>>>>             phys_vendor = virt_to_phys_or_null(vendor);
> >>>>>>>            ...
> >>>>>>>
> >>>>>>> arch/x86/platform/efi/efi_64.c: virt_to_phys_or_null_size()
> >>>>>>>
> >>>>>>>            ...
> >>>>>>>            WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
> >>>>>>>            ...
> >>>>>>>
> >>>>>>> Specifically the problem is that the efi_guid_t vendor_guid has an 8 bytes
> >>>>>>> aligned address and the WARN_ON checks for it being aligned to\
> >>>>>>> sizeof(efi_guid_t) which is 16 bytes.
> >>>>>>>
> >>>>>>> I've fixed this for now with the following local fix, but I'm not sure
> >>>>>>> what the alignment rules actually are so I'm not sure this is correct:
> >>>>>>>
> >>>>>>> --- a/arch/x86/platform/efi/efi_64.c
> >>>>>>> +++ b/arch/x86/platform/efi/efi_64.c
> >>>>>>> @@ -181,6 +181,7 @@ static inline phys_addr_t
> >>>>>>>      virt_to_phys_or_null_size(void *va, unsigned long size)
> >>>>>>>      {
> >>>>>>>            bool bad_size;
> >>>>>>> +       int alignment;
> >>>>>>>
> >>>>>>>            if (!va)
> >>>>>>>                    return 0;
> >>>>>>> @@ -195,7 +196,8 @@ virt_to_phys_or_null_size(void *va, unsigned long size)
> >>>>>>>             */
> >>>>>>>            bad_size = size > PAGE_SIZE || !is_power_of_2(size);
> >>>>>>>
> >>>>>>> -       WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
> >>>>>>> +       alignment = size > 8 ? 8 : size;
> >>>>>>> +       WARN_ON(!IS_ALIGNED((unsigned long)va, alignment) || bad_size);
> >>>>>>>
> >>>>>>>            return slow_virt_to_phys(va);
> >>>>>>>      }
> >>>>>>>
> >>>>>>>
> >>>>>>> I have a feeling that this is the right thing to do, but as said I'm not 100%
> >>>>>>> sure. If you can confirm that this is the right fix, then I can submit this
> >>>>>>> upstream.
> >>>>>>>
> >>>>>>
> >>>>>>
> >>>>>> It seems that the purpose of the alignment check is to ensure that the
> >>>>>> data does not cross a page boundary, so that the data is guaranteed to
> >>>>>> be contiguous in the physical address space as well.
> >>>>>>
> >>>>>> So in that light, the fix is most definitely wrong, although I am not
> >>>>>> sure how this is supposed to work generally.
> >>>>>
> >>>>> I'm not sure that is what it is trying to check, if that is what it is
> >>>>> trying to check then the code is certainly wrong.
> >>>>>
> >>>>> Let me first quote the entire check:
> >>>>>
> >>>>>            /*
> >>>>>             * A fully aligned variable on the stack is guaranteed not to
> >>>>>             * cross a page bounary. Try to catch strings on the stack by
> >>>>>             * checking that 'size' is a power of two.
> >>>>>             */
> >>>>>            bad_size = size > PAGE_SIZE || !is_power_of_2(size);
> >>>>>
> >>>>>            WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
> >>>>>
> >>>>> AFAIK EFI is using the identity map, and the kernel stack is
> >>>>> physically contiguous, so crossing a page boundary should not a
> >>>>> problem.
> >>>>
> >>>> CONFIG_HAVE_ARCH_VMAP_STACK=y means the kernel stack may not be
> >>>> contiguous in physical memory, which is why this was added in the
> >>>> first place.
> >>>>
> >>>> We do allocate a special stack for mixed mode, but we only switch to
> >>>> it in the .S thunking code, so at this point, we are still running
> >>>> from the vmap'ed stack
> >>>>
> >>>>> Also notice how the bad_size thing is talking about
> >>>>> page boundary crossing, but the thing triggering is the
> >>>>> IS_ALIGNED check. AFAIK there is no requirement for a struct, e.g.
> >>>>> an UUID (which is the problem here) to be aligned to its size,
> >>>>> it just needs to be 8 byte / 64 bit aligned, which it is yet
> >>>>> the IS_ALIGNED check is failing because it is checking for
> >>>>> a larger, in this case twice as large, but possibly it will
> >>>>> end up checking for a much larger alignment.
> >>>>>
> >>>>
> >>>> The idea is that a data structure of size < PAGE_SIZE is guaranteed
> >>>> not to cross a page boundary if it is aligned to a power-of-2 upper
> >>>> bound of its size. This has nothing to do with the data type or the
> >>>> minimal alignment of any of its constituent parts.
> >>>
> >>> Ok, so I guess that the correct fix is to switch to kmalloc-ing
> >>> "efi_guid_t vendor_guid" in efivar_init() instead of declaring it on
> >>> the stack?
> >>>
> >>
> >> I'd prefer it if we updated the efi_thunk_* routines to use a
> >> efi_guid_t on its stack that is naturally aligned, along the lines of
> >>
> >> --- a/arch/x86/platform/efi/efi_64.c
> >> +++ b/arch/x86/platform/efi/efi_64.c
> >> @@ -658,6 +658,7 @@ static efi_status_t
> >>   efi_thunk_get_variable(efi_char16_t *name, efi_guid_t *vendor,
> >>                         u32 *attr, unsigned long *data_size, void *data)
> >>   {
> >> +       efi_guid_t guid __aligned(sizeof(efi_guid_t)) = *vendor;
> >>          efi_status_t status;
> >>          u32 phys_name, phys_vendor, phys_attr;
> >>          u32 phys_data_size, phys_data;
> >> @@ -666,7 +667,7 @@ efi_thunk_get_variable(efi_char16_t *name,
> >> efi_guid_t *vendor,
> >>          spin_lock_irqsave(&efi_runtime_lock, flags);
> >>
> >>          phys_data_size = virt_to_phys_or_null(data_size);
> >> -       phys_vendor = virt_to_phys_or_null(vendor);
> >> +       phys_vendor = virt_to_phys_or_null(&guid);
> >>          phys_name = virt_to_phys_or_null_size(name, efi_name_size(name));
> >>          phys_attr = virt_to_phys_or_null(attr);
> >>          phys_data = virt_to_phys_or_null_size(data, *data_size);
> >>
> >>
> >> As for the crashes with >4 GB memory size: I suppose we should just
> >> cap the memory to 4GB when mixed mode is detected, although I think
> >> this is mostly a theoretical case.
> >
> > Hmm, actually, I don't think we can rely on alignment == 16, given
> > that the compiler assumes that RSP is 16 byte aligned already, which
> > is not the case in reality.
> >
> > So we'll probably have to add some compiler foo as well.
>
> It really seems easier to me to just kmalloc everything which is
> bigger then 8 bytes? I see you are modifying the efi_thunk_get_variable
> function, my idea was to do the kmalloc in efivar_init(), that already
> kmalloc's the variable_name, so doing the same for the vendor guid inside
> efi_init() seems like an ok solution to me?
>

No, I really don't want these mixed mode constraints to leak into other code.

I'll have some patches out in a minute.
