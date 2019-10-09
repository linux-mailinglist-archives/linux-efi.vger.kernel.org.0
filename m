Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0CF9D10C1
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2019 16:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbfJIOCJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Oct 2019 10:02:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40396 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731339AbfJIOCJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Oct 2019 10:02:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so3158676wrv.7
        for <linux-efi@vger.kernel.org>; Wed, 09 Oct 2019 07:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGDUmf8vQElxXW6jlDEJJ26hKrxEvdzngHjwzVdydCI=;
        b=MV7CRBzotQ1VCRustpsQe1/OamCkR6/QHzmRMP9C1rqyIGQQBMUsKMaH6R4yksGlFC
         wTuer6mkSjer8uPDRDhDyq0gopJLuz8qQhBBtJTz+HEUFf8/G8g9qrYQbE45vyTg0Egv
         FY1DRqmw53YVZvszSbwqeZOBRMNdw637nZNQelAOB/Sc5iW8NHI7/s2YqKT3PJS5vf10
         ow1YVlxUleDtCxbb4tR/16B6MlRqkLZ8GjW3G+9u+bBRm6GyWGRuoWWBW2id2cCD9Pxs
         eTt9WU9BrU+lcsHxEyOk0prD9pvx506E/DGYNaI2JRUpIHXSgYR0F2FPTainkwtfOisC
         vtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGDUmf8vQElxXW6jlDEJJ26hKrxEvdzngHjwzVdydCI=;
        b=sxVYflv42PNUFU79G3CwzFcpabF/xUo0da8Dyl3NHrxT0z1Q5TCS1TxKJE5cCKsPAr
         1noBbh0gPeslXAbL1d9vSiuSuV2L+vmgvZpeHmbX0Z1AZ4KVwtlpZj6jlrFZuJoaK2v4
         FzKF6bpQUvGi2OVCigNFKc5F4CsEkDIRt+cmwQjDu9PVRVFokLbYg/Y/Rjy9qqIQJMX8
         AmOsAyfvSMmUxiYP5nPM3zih2o9geydVk9CoZggkdGokCNiOcLkxqh+xgQmFTFSG8x7n
         bGibtLEXL/5zEnKrXF/EnCyZ9zkouSp+9oh2AebkWOb8bMp6q+ax3uSGpGCp3KDCuFvQ
         P0SA==
X-Gm-Message-State: APjAAAWIH6GwkQqKhi4Euj0iF6xAxCSTug7e8mFrpPnqqaROPEM+2BRW
        AKXbi9snmojSTZ+oxXcezkrJWeQEx0syfZohv9YOHw==
X-Google-Smtp-Source: APXvYqxXsXcxHW2JT3gu+25BnBOo2zJYevT1fUUUiXoZf/pfeoaZAGuBbvOTwiv9z1XVkFvK7IgN305kAzNL96RO0Dg=
X-Received: by 2002:adf:f5c2:: with SMTP id k2mr3313430wrp.0.1570629724936;
 Wed, 09 Oct 2019 07:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191004145056.43267-1-hdegoede@redhat.com> <20191004145056.43267-2-hdegoede@redhat.com>
 <CAKv+Gu9OU3rS-j+L+pxpK7HZi41XtQZTq9BDs6VpUC8RCq5X6g@mail.gmail.com>
 <c0256726-0aa3-b005-0a18-7b6a41533a0b@redhat.com> <CAKv+Gu9YLesC1abXAcUMe+0BE8Vv52Y_BhN-1Ps+h161Q00KKQ@mail.gmail.com>
 <81c648d6-428e-d978-246b-9a87d43c5d21@redhat.com>
In-Reply-To: <81c648d6-428e-d978-246b-9a87d43c5d21@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 9 Oct 2019 16:01:53 +0200
Message-ID: <CAKv+Gu-Mj4+nqmAeKGSAzLPpnqOO=yDug_S4MVUQ7B+Sw6WBYQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] efi: Export boot-services code and data as debugfs-blobs
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 9 Oct 2019 at 15:59, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 09-10-2019 15:35, Ard Biesheuvel wrote:
> > On Wed, 9 Oct 2019 at 15:18, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 09-10-2019 15:07, Ard Biesheuvel wrote:
> >>> On Fri, 4 Oct 2019 at 16:51, Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>
> >>>> Sometimes it is useful to be able to dump the efi boot-services code and
> >>>> data. This commit adds these as debugfs-blobs to /sys/kernel/debug/efi,
> >>>> but only if efi=debug is passed on the kernel-commandline as this requires
> >>>> not freeing those memory-regions, which costs 20+ MB of RAM.
> >>>>
> >>>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>> ---
> >>>> Changes in v5:
> >>>> -Rename the EFI_BOOT_SERVICES flag to EFI_PRESERVE_BS_REGIONS
> >>>>
> >>>> Changes in v4:
> >>>> -Add new EFI_BOOT_SERVICES flag and use it to determine if the boot-services
> >>>>    memory segments are available (and thus if it makes sense to register the
> >>>>    debugfs bits for them)
> >>>>
> >>>> Changes in v2:
> >>>> -Do not call pr_err on debugfs call failures
> >>>> ---
> >>>>    arch/x86/platform/efi/efi.c    |  1 +
> >>>>    arch/x86/platform/efi/quirks.c |  4 +++
> >>>>    drivers/firmware/efi/efi.c     | 53 ++++++++++++++++++++++++++++++++++
> >>>>    include/linux/efi.h            |  1 +
> >>>>    4 files changed, 59 insertions(+)
> >>>>
> >>>> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> >>>> index c202e1b07e29..847730f7e74b 100644
> >>>> --- a/arch/x86/platform/efi/efi.c
> >>>> +++ b/arch/x86/platform/efi/efi.c
> >>>> @@ -232,6 +232,7 @@ int __init efi_memblock_x86_reserve_range(void)
> >>>>                efi.memmap.desc_version);
> >>>>
> >>>>           memblock_reserve(pmap, efi.memmap.nr_map * efi.memmap.desc_size);
> >>>> +       set_bit(EFI_PRESERVE_BS_REGIONS, &efi.flags);
> >>>
> >>> Should we add a Kconfig symbol to opt into this behavior [set by the
> >>> driver in question], instead of always preserving all boot services
> >>> regions on all x86 systems?
> >>
> >> This bit does not control anything, it merely signals that the arch early
> >> boot EFI code keeps the boot-services code around, which is something
> >> which the x86 code already does. Where as e.g. on arm / aarch64 this is
> >> freed early on, this ties in with the other bits:
> >>
> >>>
> >>>>
> >>>>           return 0;
> >>>>    }
> >>>> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> >>>> index 3b9fd679cea9..fab12ebf0ada 100644
> >>>> --- a/arch/x86/platform/efi/quirks.c
> >>>> +++ b/arch/x86/platform/efi/quirks.c
> >>>> @@ -411,6 +411,10 @@ void __init efi_free_boot_services(void)
> >>>>           int num_entries = 0;
> >>>>           void *new, *new_md;
> >>>>
> >>>> +       /* Keep all regions for /sys/kernel/debug/efi */
> >>>> +       if (efi_enabled(EFI_DBG))
> >>>> +               return;
> >>>> +
> >>
> >> This is the point where normally on x86 we do actually free the boot-services
> >> code which is a lot later then on other arches. And this new code actually
> >> does change things to keep the boot-services code *forever* but only
> >> if EFI debugging is enabled on the kernel commandline.
> >>
> >
> > I get this part. But at some point, your driver is going to expect
> > this memory to be preserved even if EFI_DBG is not set, right? My
> > question was whether we should only opt into that if such a driver is
> > enabled in the first place.
>
> Ah, I see. No even with CONFIG_EFI_EMBEDDED_FIRMWARE selected, the
> boot-services code still gets free-ed. The efi_get_embedded_fw()
> function from drivers/firmware/efi/embedded-firmware.c runs before
> efi_free_boot_services() and it memdup-s any found firmwares, so it
> does not cause the EFI boot-services code to stick around longer
> then usual.
>
> The only thing which does cause it to stick around is enabling
> EFI debugging with efi=debug, so that the various efi segments
> (not only the code-services ones) can be inspected as debugfs
> blobs.
>
> Basically this first patch of the series is independent of the
> rest. It is part of the series, because adding new
> efi_embedded_fw_desc structs to the table of firmwares to check
> for becomes a lot easier when we can easily inspect the efi
> segments and see if they contain the firmware we want.
>
>
> As for Kconfig options, the compiling of
> drivers/firmware/efi/embedded-firmware.c is controlled by
> CONFIG_EFI_EMBEDDED_FIRMWARE which is a hidden option, which
> can be selected by code which needs this. currently this is
> only selected by CONFIG_TOUCHSCREEN_DMI which is defined
> in drivers/platform/x86/Kconfig.
>

OK, thanks for clearing that up.
