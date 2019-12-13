Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 593BC11EBC1
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 21:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfLMUQw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 15:16:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54759 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbfLMUQw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 15:16:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id b19so73360wmj.4
        for <linux-efi@vger.kernel.org>; Fri, 13 Dec 2019 12:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=A+jyCI430TlszbsB8SpVgZEyoxncE+axZ3B8T5+dQAw=;
        b=bXVIOCN+UJq13mxaAw1cXYpNicm3ec28BfiCIzBCm1PUZE5KC0ZuQ4GTic8RTQxiZR
         6ALsd0BsoJtX0LttPQ1X2SjY7Fx9ow8w3t47K7FK8+VETRMXcRQZP6BzWkMBpsaXL6R7
         hHZqpSbmSin+eucjda89g9PBMUbyv91ldFZJVEGv2qlBwzGEtkpuU4rBPgPb1ogCfRgB
         K2NnWlL98eXniJ2/mHxCafjpe4u2RQ7FT0Kp3PiNUepK/27joVqcle9Y5PiEL3DN3I+V
         rI1SdrzzfV7qAxVIAnG/6H8rgXtTRjmXLBt8W9iZNXxga3pZp7xNarhYhLkvezBTLS3z
         Qn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=A+jyCI430TlszbsB8SpVgZEyoxncE+axZ3B8T5+dQAw=;
        b=aaImG6PkXDOMX7O2N5gmGi7fY6BHlOWr1FOt8Wu2N//CqVj6I8fv1df+ZX3bf76jIe
         A20FJV+BSyumoP05QU3AZ7Z/8yhvtT84nYqirJIVRQIbuOQwWzhje4IqYPx81D1khXLY
         dRrU5w8ejr78EWgalbmusXXLOT6Zbm81po6je5SccOybPKHQ0D5FzY7jcvn8QYKgBcud
         pgdMeGLFNPiF51jw5rI8pOBm3lZyilBVovY5HU6x7tkNYEiAm1ofk/ABLfRKpkuO4maL
         Q0qUy/ZA3SJTKfhbA7xdf6HPSDaXzAzbAky0NwH/YtvaW739UVfF90/ZTjTuhzqDv3fv
         hRDQ==
X-Gm-Message-State: APjAAAXzJpRz3hadJZDJB6dQ7paz+dmga3Tv650EBDcT1C00tbSSDukU
        CZAAJJZ6vAVIw0QM/8kH4wi1dxebN7VEc6euipYruw==
X-Google-Smtp-Source: APXvYqwSHBR1KbkViEhxeNuFdQctfETYI850gBRnD8XNV2A+O9R9itLZrpkUD63gNCMSxLewFqft5O+tQ9fYG04lWEg=
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr6751839wme.148.1576268209088;
 Fri, 13 Dec 2019 12:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20191213091115.567-1-ardb@kernel.org> <69f21816-6dab-5abc-25f1-b2f5faf6f9e4@redhat.com>
 <CAKv+Gu9yFqtcbKa5RO_m=t2JQEaVyscBruQYSYMJpKE1JcAieA@mail.gmail.com>
 <d5917bef-929b-ee36-58b6-a8309d52f5bf@redhat.com> <CAKv+Gu8vWem-jTv_K3KEqkqOVDDte9QOXco2pLA999u7hxH_Yg@mail.gmail.com>
 <f276df9f-83b4-e404-bcfc-91f0212a5fc0@redhat.com>
In-Reply-To: <f276df9f-83b4-e404-bcfc-91f0212a5fc0@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Dec 2019 20:16:47 +0000
Message-ID: <CAKv+Gu_cyf5AssySDmrzKjWDN+Wa0JMnyQocKJrqj3uZKO6jQQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: disable file loading and page deallocation
 in mixed mode
To:     Hans de Goede <hdegoede@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 13 Dec 2019 at 21:12, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12/13/19 9:08 PM, Ard Biesheuvel wrote:
> > On Fri, 13 Dec 2019 at 20:56, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 12/13/19 7:49 PM, Ard Biesheuvel wrote:
> >>> On Fri, 13 Dec 2019 at 13:29, Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 13-12-2019 10:11, Ard Biesheuvel wrote:
> >>>>> EFI mixed mode is a nice hack, since it allows us to run 64-bit Linux
> >>>>> on low end x86_64 machines that shipped with 32-bit UEFI as they were
> >>>>> built to run 32-bit Windows only.
> >>>>>
> >>>>> Mixed mode relies on the ability to convert calls made using the
> >>>>> 64-bit calling convention into calls using the 32-bit one. This
> >>>>> involves pushing a 32-bit word onto the stack for each argument
> >>>>> passed in a 64-bit register, relying on the fact that all quantities
> >>>>> that are the native size or smaller (including pointers) can be safely
> >>>>> truncated to 32 bits. (In the pointer case, we rely on the fact that
> >>>>> we are still executing in the firmware context, which uses a 1:1
> >>>>> mapping that can only access the lower 4 GB of the address space)
> >>>>>
> >>>>> For types that are explicitly 64 bits wide, such as EFI_PHYSICAL_ADDRESS
> >>>>> or UINT64, this assumption doesn't hold. The correct way to marshall
> >>>>> such a call would be to push two consecutive 32-bit words onto the
> >>>>> stack, but given that the naive thunking code has no knowledge
> >>>>> whatsoever of the prototype of the function it is invoking, all we can
> >>>>> do is avoid calling such functions altogether.
> >>>>>
> >>>>> The FreePages() boot service is affected by this, so we should not call
> >>>>> that at all in mixed mode. In practice, this doesn't change much, since
> >>>>> in the past, these calls would have been made with a bogus address, and
> >>>>> so we were leaking this memory already. Note that the scope of this leak
> >>>>> is the EFI execution context only, so it makes no difference for Linux.
> >>>>>
> >>>>> The other piece of functionality that we need to disable is loading files
> >>>>> passed via file=xxxx on the command line, given that the Open() method
> >>>>> takes two UINT64s as well.
> >>>>>
> >>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>>>
> >>>> Just ignoring the file= arguments is fine with me, as you say this has
> >>>> been broken on mixed-mode since forever so likely no-one is using it:
> >>>>
> >>>> Acked-by: Hans de Goede <hdegoede@redhat.com>
> >>>>
> >>>
> >>> Thanks.
> >>>
> >>> Do you have any recommendations on how to test this? Are you using GRUB to boot?
> >>>
> >>> I am trying to test the random.c failure using QEMU+OVMF, which
> >>> implements the EFI_RNG_PROTOCOL on top of virtio-rng-pci, but I cannot
> >>> reproduce the failure.
> >>
> >> I hit the random.c issue when testing a 5.5-rc1 x86_64 kernel on a Bay Trail
> >> tablet. Almost any Bay Trail hw will come with 32 bit uefi because when Bay
> >> Trail tablets (and 2-in-1s) first hit the market the 64 bit Windows drivers
> >> were not ready yet and running 32 bit Windows requires a 32 bit UEFI
> >> (Bay Trail devices do not have a classic bios mode / CSM).
> >>
> >> A popular model example machine of such a setup is The Asus T100TA 2-in-1.
> >>
> >> I'm using a standard Fedora install on these machines which goes:
> >> UEFI -> 32-bit-secureboot-shim -> 32-bit-uefi-grub -> 64 bit kernel
> >>
> >
> > And after applying the fix, do you now get a RNG=0x.... on the line
> > that has ACPI, SMBIOS etc?
>
> No I get:
>
> [    0.000000] efi:  ACPI=0x3b71f000  ACPI 2.0=0x3b71f014  ESRT=0x3b6ed000  SMBIOS=0x3baa8310  TPMEventLog=0x37e95010
>
> No RNG there. Note this is on a slightly different Bay Trail device.
>

It is slightly surprising that this mixed mode bug gets tickled even
though the protocol in question doesn't even exist.

efi_random_get_seed() should give up as soon as it notices that the
protocol cannot be found.
