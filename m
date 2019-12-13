Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C9D11EB87
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 21:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfLMUIF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 15:08:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51859 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfLMUIF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 15:08:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so64524wmd.1
        for <linux-efi@vger.kernel.org>; Fri, 13 Dec 2019 12:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rRJZHRg1blBVFDS8N46D5goEZ981jiuxP98DIwEQOI=;
        b=AuH+Zci6WpGtz8fbB9f6TKMtxGQzoD1CPVhJ7oL6vvsrSTHTmrN0MNp9J5WN/hRzZ7
         ZpFARU1SxEBaRrBHx9AyPBWN9HTQ+g3frXV+8HD14EBs19jJc4Eai2Brk38534hzswMn
         yaetiIeknCq/MgaZRYqWSQbuLKxNIYRdqf1xUuD1kxHrMOxjDhV/81AoC7cS8MNACQCs
         HulLmGrUIXO0gmT+7kmGcPd8AH/qpM/02Dj3e4eKPzG7a3mo9+1GM0BUL0tZlq52szdV
         9YJrocvGFhPCsv+mCyg7/iqRe48VCcBEEpoQPgI5wtNZhra9e89eZgQcoW7upNEwTfMI
         sqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rRJZHRg1blBVFDS8N46D5goEZ981jiuxP98DIwEQOI=;
        b=Yd8rA5I5PESm/uuldRMOJItdrSMDR34pJByIff2WXYqCTC8lrDZ6ajlD0gz+XYG8Bz
         qLvTfDO4tsrMF5slTxHK3jBv6gZwRjCogHLYYQh6yns3CfgqcS7AhR05doVqKRdlSobz
         mK8hLNdaYHt6HtybOM38qMpuiaB1KnCZ2IjN6IZvOJqFB2eRwwfNawNGRVB5K4r+CZcs
         rAaoBWcjQa+ROyyuxGNgqcCvv/0lrii8zdQryRmM8ZDAjg36q9tY4PhdlMf1JMGFwpGy
         gc4jkkLUdgODOllAizDpyIwJY1GCck3Vc9ZBthL2JQxHKXxX/VsnZG71zS8tYLV1aciy
         NgoA==
X-Gm-Message-State: APjAAAXaXh44hdrnaHXTpekIqUbF7vVTwECXufbj4dpZ+vkJZ7u37sHP
        +buJ0869gCEVlZHcVxhHmKrVzxYbuoQLELCSjRxgcg==
X-Google-Smtp-Source: APXvYqzLF6yC6FqHTtv8HoT9sIzduTx0SqpEU+jrKmCrLd+JFatyy3wUCbz0hWfM7geud1QvEaS42n2k9h88/E68ytk=
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr5432143wma.95.1576267683012;
 Fri, 13 Dec 2019 12:08:03 -0800 (PST)
MIME-Version: 1.0
References: <20191213091115.567-1-ardb@kernel.org> <69f21816-6dab-5abc-25f1-b2f5faf6f9e4@redhat.com>
 <CAKv+Gu9yFqtcbKa5RO_m=t2JQEaVyscBruQYSYMJpKE1JcAieA@mail.gmail.com> <d5917bef-929b-ee36-58b6-a8309d52f5bf@redhat.com>
In-Reply-To: <d5917bef-929b-ee36-58b6-a8309d52f5bf@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Dec 2019 20:08:01 +0000
Message-ID: <CAKv+Gu8vWem-jTv_K3KEqkqOVDDte9QOXco2pLA999u7hxH_Yg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: disable file loading and page deallocation
 in mixed mode
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 13 Dec 2019 at 20:56, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12/13/19 7:49 PM, Ard Biesheuvel wrote:
> > On Fri, 13 Dec 2019 at 13:29, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 13-12-2019 10:11, Ard Biesheuvel wrote:
> >>> EFI mixed mode is a nice hack, since it allows us to run 64-bit Linux
> >>> on low end x86_64 machines that shipped with 32-bit UEFI as they were
> >>> built to run 32-bit Windows only.
> >>>
> >>> Mixed mode relies on the ability to convert calls made using the
> >>> 64-bit calling convention into calls using the 32-bit one. This
> >>> involves pushing a 32-bit word onto the stack for each argument
> >>> passed in a 64-bit register, relying on the fact that all quantities
> >>> that are the native size or smaller (including pointers) can be safely
> >>> truncated to 32 bits. (In the pointer case, we rely on the fact that
> >>> we are still executing in the firmware context, which uses a 1:1
> >>> mapping that can only access the lower 4 GB of the address space)
> >>>
> >>> For types that are explicitly 64 bits wide, such as EFI_PHYSICAL_ADDRESS
> >>> or UINT64, this assumption doesn't hold. The correct way to marshall
> >>> such a call would be to push two consecutive 32-bit words onto the
> >>> stack, but given that the naive thunking code has no knowledge
> >>> whatsoever of the prototype of the function it is invoking, all we can
> >>> do is avoid calling such functions altogether.
> >>>
> >>> The FreePages() boot service is affected by this, so we should not call
> >>> that at all in mixed mode. In practice, this doesn't change much, since
> >>> in the past, these calls would have been made with a bogus address, and
> >>> so we were leaking this memory already. Note that the scope of this leak
> >>> is the EFI execution context only, so it makes no difference for Linux.
> >>>
> >>> The other piece of functionality that we need to disable is loading files
> >>> passed via file=xxxx on the command line, given that the Open() method
> >>> takes two UINT64s as well.
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>
> >> Just ignoring the file= arguments is fine with me, as you say this has
> >> been broken on mixed-mode since forever so likely no-one is using it:
> >>
> >> Acked-by: Hans de Goede <hdegoede@redhat.com>
> >>
> >
> > Thanks.
> >
> > Do you have any recommendations on how to test this? Are you using GRUB to boot?
> >
> > I am trying to test the random.c failure using QEMU+OVMF, which
> > implements the EFI_RNG_PROTOCOL on top of virtio-rng-pci, but I cannot
> > reproduce the failure.
>
> I hit the random.c issue when testing a 5.5-rc1 x86_64 kernel on a Bay Trail
> tablet. Almost any Bay Trail hw will come with 32 bit uefi because when Bay
> Trail tablets (and 2-in-1s) first hit the market the 64 bit Windows drivers
> were not ready yet and running 32 bit Windows requires a 32 bit UEFI
> (Bay Trail devices do not have a classic bios mode / CSM).
>
> A popular model example machine of such a setup is The Asus T100TA 2-in-1.
>
> I'm using a standard Fedora install on these machines which goes:
> UEFI -> 32-bit-secureboot-shim -> 32-bit-uefi-grub -> 64 bit kernel
>

And after applying the fix, do you now get a RNG=0x.... on the line
that has ACPI, SMBIOS etc?
