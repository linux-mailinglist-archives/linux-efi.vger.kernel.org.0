Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75094D103C
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2019 15:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfJINfi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Oct 2019 09:35:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42077 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbfJINfi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Oct 2019 09:35:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so3005137wrw.9
        for <linux-efi@vger.kernel.org>; Wed, 09 Oct 2019 06:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aekLAqw/SyFzluuZiv2f7cjxSmW6M4TksSOK9MFHyds=;
        b=GNKbqmw/Ez/9tL9tN5+uFGJyaucl9FtnIu+vsfpWGJLyFz6iK0DF0Y6MtHVaTloJpd
         Mo339XSUn/o7Axz/n+N9e+IkkI78vszz5BD9V0DN4rmIsGxwO+UZJ2MaJDLoVXp+ApUv
         P4WbnHWKt+PuXtX12OFZok5yCbMKnwM4KzTMifygJDG7P7qvJ/2/zhfOx+2DNxbDBnEd
         RFtQC7AiqDrw8yakcBSXvwmXdKHHPnYTdybqPXFh49DEgzcyO6+Z6msiiFYs/KJ6Zdwe
         PW9JDu/v4ck142AiqMDCUYZ2mgXO178ShgqbJO1xbUgwbknXTDKcOjs/BoE26yalNZOZ
         gVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aekLAqw/SyFzluuZiv2f7cjxSmW6M4TksSOK9MFHyds=;
        b=IO5/pa4Z1QFypoObr9ltdOPp25XZQkh8WshoSPgYHO68nh3++EpF0vvwnAEEqHklv4
         pdpKNzpjCp9YgT2HiNKoPgwWF/NRNifaIhNWv/NS7iquy7HvnkO84dMVAYLUj3fB1RVB
         dR6Gz39iHf1nP+pj/E6vARwonU804FnbgqTdah4LJf8FMXc+SPYTLTrCPBhZWcNXBjO8
         Lx22qT0vaPevSKMsuo0ARIWuxEzhij5LGi/cvrnTH9lLFxTlsRxHePH3gJ1vtHCJiF5B
         IA0uispgDMHLj7jOPTVAycGZNv75YlYuuIc4+z+JcMRq9yR5DXgfgyboiVfmIaw3Gzme
         u9mA==
X-Gm-Message-State: APjAAAUjWsAhAA2VOzz2ipp27tUeJ6mJrrqKFRCS84qyQFGy+Mu2RGb0
        KuDQacfSoB+88sQ5nmNsQCmvsts2gg+56lGNS4yw7w==
X-Google-Smtp-Source: APXvYqxxCoAS7hYRFHPfYs76Tb409aHh+6XfZ+16gKSnc9u/XR3xEJcwmzQrsK4r3505PJyIjEp9Hw1AiyMl9V14elc=
X-Received: by 2002:a5d:6449:: with SMTP id d9mr3149794wrw.246.1570628136354;
 Wed, 09 Oct 2019 06:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191004145056.43267-1-hdegoede@redhat.com> <20191004145056.43267-2-hdegoede@redhat.com>
 <CAKv+Gu9OU3rS-j+L+pxpK7HZi41XtQZTq9BDs6VpUC8RCq5X6g@mail.gmail.com> <c0256726-0aa3-b005-0a18-7b6a41533a0b@redhat.com>
In-Reply-To: <c0256726-0aa3-b005-0a18-7b6a41533a0b@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 9 Oct 2019 15:35:24 +0200
Message-ID: <CAKv+Gu9YLesC1abXAcUMe+0BE8Vv52Y_BhN-1Ps+h161Q00KKQ@mail.gmail.com>
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

On Wed, 9 Oct 2019 at 15:18, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 09-10-2019 15:07, Ard Biesheuvel wrote:
> > On Fri, 4 Oct 2019 at 16:51, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Sometimes it is useful to be able to dump the efi boot-services code and
> >> data. This commit adds these as debugfs-blobs to /sys/kernel/debug/efi,
> >> but only if efi=debug is passed on the kernel-commandline as this requires
> >> not freeing those memory-regions, which costs 20+ MB of RAM.
> >>
> >> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >> Changes in v5:
> >> -Rename the EFI_BOOT_SERVICES flag to EFI_PRESERVE_BS_REGIONS
> >>
> >> Changes in v4:
> >> -Add new EFI_BOOT_SERVICES flag and use it to determine if the boot-services
> >>   memory segments are available (and thus if it makes sense to register the
> >>   debugfs bits for them)
> >>
> >> Changes in v2:
> >> -Do not call pr_err on debugfs call failures
> >> ---
> >>   arch/x86/platform/efi/efi.c    |  1 +
> >>   arch/x86/platform/efi/quirks.c |  4 +++
> >>   drivers/firmware/efi/efi.c     | 53 ++++++++++++++++++++++++++++++++++
> >>   include/linux/efi.h            |  1 +
> >>   4 files changed, 59 insertions(+)
> >>
> >> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> >> index c202e1b07e29..847730f7e74b 100644
> >> --- a/arch/x86/platform/efi/efi.c
> >> +++ b/arch/x86/platform/efi/efi.c
> >> @@ -232,6 +232,7 @@ int __init efi_memblock_x86_reserve_range(void)
> >>               efi.memmap.desc_version);
> >>
> >>          memblock_reserve(pmap, efi.memmap.nr_map * efi.memmap.desc_size);
> >> +       set_bit(EFI_PRESERVE_BS_REGIONS, &efi.flags);
> >
> > Should we add a Kconfig symbol to opt into this behavior [set by the
> > driver in question], instead of always preserving all boot services
> > regions on all x86 systems?
>
> This bit does not control anything, it merely signals that the arch early
> boot EFI code keeps the boot-services code around, which is something
> which the x86 code already does. Where as e.g. on arm / aarch64 this is
> freed early on, this ties in with the other bits:
>
> >
> >>
> >>          return 0;
> >>   }
> >> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> >> index 3b9fd679cea9..fab12ebf0ada 100644
> >> --- a/arch/x86/platform/efi/quirks.c
> >> +++ b/arch/x86/platform/efi/quirks.c
> >> @@ -411,6 +411,10 @@ void __init efi_free_boot_services(void)
> >>          int num_entries = 0;
> >>          void *new, *new_md;
> >>
> >> +       /* Keep all regions for /sys/kernel/debug/efi */
> >> +       if (efi_enabled(EFI_DBG))
> >> +               return;
> >> +
>
> This is the point where normally on x86 we do actually free the boot-services
> code which is a lot later then on other arches. And this new code actually
> does change things to keep the boot-services code *forever* but only
> if EFI debugging is enabled on the kernel commandline.
>

I get this part. But at some point, your driver is going to expect
this memory to be preserved even if EFI_DBG is not set, right? My
question was whether we should only opt into that if such a driver is
enabled in the first place.

> This ties in with the next bit:
>
> >>          for_each_efi_memory_desc(md) {
> >>                  unsigned long long start = md->phys_addr;
> >>                  unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
> >> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> >> index 8d3e778e988b..abba49c4c46d 100644
> >> --- a/drivers/firmware/efi/efi.c
> >> +++ b/drivers/firmware/efi/efi.c
>
> <snip>
>
> >> @@ -370,6 +420,9 @@ static int __init efisubsys_init(void)
> >>                  goto err_remove_group;
> >>          }
> >>
> >> +       if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
> >> +               efi_debugfs_init();
> >> +
> >>          return 0;
> >>
> >>   err_remove_group:
>
> Here we register the debugfs dir + files, but only when the
> boot services code has been kept around, so only if the
> EFI_PRESERVE_BS_REGIONS arch feature flag has been set and
> EFI debugging has been requested on the kernel commandline.
>
> IOW this patch already offers to configurability you ask for, but instead
> of through a Kconfig option (which IMHO would be cumbersome) the decision
> is made runtime based on the presence of efi=debug on the kernel commandline.
>
> Regards,
>
> Hans
>
>
>
>
> >> diff --git a/include/linux/efi.h b/include/linux/efi.h
> >> index bd3837022307..2a30a1bd8bdf 100644
> >> --- a/include/linux/efi.h
> >> +++ b/include/linux/efi.h
> >> @@ -1202,6 +1202,7 @@ extern int __init efi_setup_pcdp_console(char *);
> >>   #define EFI_DBG                        8       /* Print additional debug info at runtime */
> >>   #define EFI_NX_PE_DATA         9       /* Can runtime data regions be mapped non-executable? */
> >>   #define EFI_MEM_ATTR           10      /* Did firmware publish an EFI_MEMORY_ATTRIBUTES table? */
> >> +#define EFI_PRESERVE_BS_REGIONS        11      /* Are EFI boot-services memory segments available? */
> >>
> >>   #ifdef CONFIG_EFI
> >>   /*
> >> --
> >> 2.23.0
> >>
