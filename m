Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83CA211F2E7
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 18:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfLNRHp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 12:07:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40401 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfLNRHp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Dec 2019 12:07:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so2158275wrn.7
        for <linux-efi@vger.kernel.org>; Sat, 14 Dec 2019 09:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rk4GjxPYF8SVR1jcvPnUrKGFUR5lCEHGS1xJPS1KlI0=;
        b=UQiU75OSVtVcHYbGtN/tp5rcTioHonHg7A+6ny5G3hZf1S7CPFHDCmMop02ZwzZQ5e
         +cB16Q7r4b2ZUvNmFhZd9A8CUi4MEJSqVq7qJ1/sADyeSRKGBT/cvPlpFwy3No0eo2Nm
         6KObk1OCfx9lYeYMbidWcactTnv3pCn2vww3NwpdkQo6d8f4GbUauK3dEt56kqpSEY57
         rthrdeqs0g4+n+TA1PpdxJcAFoWVOZIo4hoNBLsEbq+VRNn3WI2sMhtQhXHOZ8Esrg80
         uyV2eEEjoeuWpBDdx5T7WloZIvqsShcLaodhYxFQ1m7o4NTuUrw6qFokLe3czs/2Vv6V
         IdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rk4GjxPYF8SVR1jcvPnUrKGFUR5lCEHGS1xJPS1KlI0=;
        b=Vc1R/+JNUgPC5rzsO+TXwxMIkSXq9S4LIjPvPODUm839+Iq9PdCY7krEhqkdplC4oa
         y3pcD11UL6cbK/5R6i8u37Wyi8RLbnVNQN497hQSx5sVGqTasl0k4bVrd+uOU8nCz6W1
         UAjyvVoU8H/dfVCPebEVFouzkxWStaIBYhpjeDarOJftRH88yhphJ5AFrbYQU+d8E0Xv
         AMvO/gBSeE9XEM2HbbUkWtTOMYO+deRwsMVoqQaW2Uv/M4Uj7UHptYbDLrLQXBFIbdLw
         RB+H76Q3eWqOyTnSqJba2j4fQR72+k8YevE3gtEmoF/QSyCZm6cgx+nyIm0D9JEZnMWh
         4ZeQ==
X-Gm-Message-State: APjAAAW0hgW3Uej7fB1pSBPatki0JKxkGGiE+afXrSWuEalqN4hFogUk
        5i7Mpi6qpRrojvb1WClfxyDuXNy6iQpbDGAvk+3Y0w==
X-Google-Smtp-Source: APXvYqxubyZ9qK5azYNR+O+1vf5Exj02G1s1sHlXgkUo0m5SPkIi/EkvIPUjxGYH0xrDM89iWp15VdGOMSbRNXzQ0Lg=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr18957932wrj.325.1576343262102;
 Sat, 14 Dec 2019 09:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20191213091115.567-1-ardb@kernel.org> <69f21816-6dab-5abc-25f1-b2f5faf6f9e4@redhat.com>
 <CAKv+Gu9yFqtcbKa5RO_m=t2JQEaVyscBruQYSYMJpKE1JcAieA@mail.gmail.com>
 <d5917bef-929b-ee36-58b6-a8309d52f5bf@redhat.com> <CAKv+Gu8vWem-jTv_K3KEqkqOVDDte9QOXco2pLA999u7hxH_Yg@mail.gmail.com>
 <f276df9f-83b4-e404-bcfc-91f0212a5fc0@redhat.com> <CAKv+Gu_cyf5AssySDmrzKjWDN+Wa0JMnyQocKJrqj3uZKO6jQQ@mail.gmail.com>
 <e216a9bd-6e37-c87a-5b14-d0cea31bfc60@redhat.com>
In-Reply-To: <e216a9bd-6e37-c87a-5b14-d0cea31bfc60@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 14 Dec 2019 17:07:40 +0000
Message-ID: <CAKv+Gu_Fm9+mhKOeU3Gqgp_mDPUp0d3Gd4_E3KFSC+kDeu8mBQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: disable file loading and page deallocation
 in mixed mode
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 14 Dec 2019 at 16:21, Hans de Goede <hdegoede@redhat.com> wrote:
>
> HI,
>
> On 13-12-2019 21:16, Ard Biesheuvel wrote:
> > On Fri, 13 Dec 2019 at 21:12, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 12/13/19 9:08 PM, Ard Biesheuvel wrote:
> >>> On Fri, 13 Dec 2019 at 20:56, Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 12/13/19 7:49 PM, Ard Biesheuvel wrote:
> >>>>> On Fri, 13 Dec 2019 at 13:29, Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 13-12-2019 10:11, Ard Biesheuvel wrote:
> >>>>>>> EFI mixed mode is a nice hack, since it allows us to run 64-bit Linux
> >>>>>>> on low end x86_64 machines that shipped with 32-bit UEFI as they were
> >>>>>>> built to run 32-bit Windows only.
> >>>>>>>
> >>>>>>> Mixed mode relies on the ability to convert calls made using the
> >>>>>>> 64-bit calling convention into calls using the 32-bit one. This
> >>>>>>> involves pushing a 32-bit word onto the stack for each argument
> >>>>>>> passed in a 64-bit register, relying on the fact that all quantities
> >>>>>>> that are the native size or smaller (including pointers) can be safely
> >>>>>>> truncated to 32 bits. (In the pointer case, we rely on the fact that
> >>>>>>> we are still executing in the firmware context, which uses a 1:1
> >>>>>>> mapping that can only access the lower 4 GB of the address space)
> >>>>>>>
> >>>>>>> For types that are explicitly 64 bits wide, such as EFI_PHYSICAL_ADDRESS
> >>>>>>> or UINT64, this assumption doesn't hold. The correct way to marshall
> >>>>>>> such a call would be to push two consecutive 32-bit words onto the
> >>>>>>> stack, but given that the naive thunking code has no knowledge
> >>>>>>> whatsoever of the prototype of the function it is invoking, all we can
> >>>>>>> do is avoid calling such functions altogether.
> >>>>>>>
> >>>>>>> The FreePages() boot service is affected by this, so we should not call
> >>>>>>> that at all in mixed mode. In practice, this doesn't change much, since
> >>>>>>> in the past, these calls would have been made with a bogus address, and
> >>>>>>> so we were leaking this memory already. Note that the scope of this leak
> >>>>>>> is the EFI execution context only, so it makes no difference for Linux.
> >>>>>>>
> >>>>>>> The other piece of functionality that we need to disable is loading files
> >>>>>>> passed via file=xxxx on the command line, given that the Open() method
> >>>>>>> takes two UINT64s as well.
> >>>>>>>
> >>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>>>>>
> >>>>>> Just ignoring the file= arguments is fine with me, as you say this has
> >>>>>> been broken on mixed-mode since forever so likely no-one is using it:
> >>>>>>
> >>>>>> Acked-by: Hans de Goede <hdegoede@redhat.com>
> >>>>>>
> >>>>>
> >>>>> Thanks.
> >>>>>
> >>>>> Do you have any recommendations on how to test this? Are you using GRUB to boot?
> >>>>>
> >>>>> I am trying to test the random.c failure using QEMU+OVMF, which
> >>>>> implements the EFI_RNG_PROTOCOL on top of virtio-rng-pci, but I cannot
> >>>>> reproduce the failure.
> >>>>
> >>>> I hit the random.c issue when testing a 5.5-rc1 x86_64 kernel on a Bay Trail
> >>>> tablet. Almost any Bay Trail hw will come with 32 bit uefi because when Bay
> >>>> Trail tablets (and 2-in-1s) first hit the market the 64 bit Windows drivers
> >>>> were not ready yet and running 32 bit Windows requires a 32 bit UEFI
> >>>> (Bay Trail devices do not have a classic bios mode / CSM).
> >>>>
> >>>> A popular model example machine of such a setup is The Asus T100TA 2-in-1.
> >>>>
> >>>> I'm using a standard Fedora install on these machines which goes:
> >>>> UEFI -> 32-bit-secureboot-shim -> 32-bit-uefi-grub -> 64 bit kernel
> >>>>
> >>>
> >>> And after applying the fix, do you now get a RNG=0x.... on the line
> >>> that has ACPI, SMBIOS etc?
> >>
> >> No I get:
> >>
> >> [    0.000000] efi:  ACPI=0x3b71f000  ACPI 2.0=0x3b71f014  ESRT=0x3b6ed000  SMBIOS=0x3baa8310  TPMEventLog=0x37e95010
> >>
> >> No RNG there. Note this is on a slightly different Bay Trail device.
> >>
> >
> > It is slightly surprising that this mixed mode bug gets tickled even
> > though the protocol in question doesn't even exist.
>
> As mentioned I was testing on a differtent model mixed mode Bay Trail tablet
> as I did not have the tablet where I originally hit this at hand.
>
> I've just tested this on the tablet where I originally hit this; and the RNG=
> bit is there:
>
> [    0.000000] efi:  ACPI=0x39178000  ACPI 2.0=0x39178014  ESRT=0x3914f000  SMBI
> OS=0x39b79290  RNG=0x39b79190  TPMEventLog=0x31847010
>
> I've added some debugging pr_efi_error calls and on the tablet I was testing with
> yesterday the locate_protocol call indeed fails on that one.
>
> I've done quick comparison of the FW versions, both use AMI AptIO as a BIOS,
> With identical core versions; and on the model *without* the RNG support the TXE FW
> version is newer:
>
> Model without RNG proto support:
> TXE FW Version  01.01.00.1115
>
> Model with RNG proto support:
> TXE FW Version  01.00.04.1090
>
> So no idea why some of these devices have RNG support and others do not,
> anyways the good news is that between these 2 devices both paths have now
> been tested in mixed-mode and with my fix in place both paths work.
>

Thanks for testing. That explains the boot hang, indeed.
