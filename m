Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 486B31282D9
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2019 20:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfLTTmB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Dec 2019 14:42:01 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34010 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfLTTmB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Dec 2019 14:42:01 -0500
Received: by mail-qk1-f196.google.com with SMTP id j9so8963573qkk.1
        for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2019 11:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ymRUQbDdCUcuu0cU6u+C2nze4mkNunhHizjWleA+I5A=;
        b=n2fGEZLDSX/LK5E8D/26NbFGs9IseQIG18rS429FYLXCx3fsDlpbzTMyrzQnnJ2IiV
         bFUhISmFIDjsY37kMc+cOgWyHGkevRNgG7O7t57NbZUCtlKDOMmJuysuQKJt1yfEliZD
         h6GgSGh6ESieSslg7CQo9JrSnkIRUT89Oknc+bvn3dprgVZKtmSfQ+OwvCM+CccF9cLZ
         3/nNJJgV39hRUSAzdbTbIdCUyPR2OiZs9SCcyT22/oxdqtrdrnhlr+nmSlxp74ZWyiHk
         rx471KE0CfHz0chdhHlBO1sMQgGJGKPUJQxnWnIEwHgnF0fbV21iqUPxyR8Sdb24etg3
         EsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ymRUQbDdCUcuu0cU6u+C2nze4mkNunhHizjWleA+I5A=;
        b=FvzaWCqaub86FIpstfwr0VK3kMvwcfVNRtE/m+/M84v13QsEsdAvEA8RVoiCfPYjI8
         oRYdkMR+m7cN3aISxw/LaTsZGVCBOjhzpHP9VEAnxSCWO78ayeRBQDdPL86ImVWXoS1M
         el/7qaVXXsWPj4HosMugi9Z3oi7iLHGrrG4Mv4Kx499k3rPlwZIEsHcuQ4A22KhWfzHG
         4VZp6WeYctHidxEqEme+27kanXLk5cQVFTj2UHTxvrXvCh9LodO/x2NUm3mrTum1O4kr
         oL42ClmPF+DvMidTqM6M3N5KxzagR9Q3W2IwrJ2LtEuk7lNk2Lmwno21cFNKgOdlg4as
         DKbQ==
X-Gm-Message-State: APjAAAXGl6mzu014vKfkgiS/cRyRs4g7SBdiTiUPNKvN7wsklEG4HGfH
        phgf+8UPF92atVhhWthz/ognKXmhCK0=
X-Google-Smtp-Source: APXvYqys3aQonmd9tfYimIkc9hkGmo2sPw/MedHdWXXvSsR+MaAuhbVD9s+fPh8TmmEQkqtpUeDlLA==
X-Received: by 2002:a05:620a:134f:: with SMTP id c15mr14692372qkl.115.1576870919767;
        Fri, 20 Dec 2019 11:41:59 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j185sm3110660qkc.96.2019.12.20.11.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 11:41:59 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 20 Dec 2019 14:41:57 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on
 bridges during boot
Message-ID: <20191220194157.GA251736@rani.riverdale.lan>
References: <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com>
 <F25F57AE-15C5-4240-99D6-F6C93CFDA447@amacapital.net>
 <CAKv+Gu8g8=yMXMNdHee7rsMWNwkhk43ZgbDEwAPHUX6Fj1jscA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKv+Gu8g8=yMXMNdHee7rsMWNwkhk43ZgbDEwAPHUX6Fj1jscA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 20, 2019 at 10:11:00AM +0200, Ard Biesheuvel wrote:
> On Fri, 20 Dec 2019 at 09:17, Andy Lutomirski <luto@amacapital.net> wrote:
> >
> >
> >
> > > On Dec 20, 2019, at 3:07 PM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > >
> > > ﻿On Thu, 19 Dec 2019 at 22:05, Matthew Garrett <mjg59@google.com> wrote:
> > >>
> > >>> On Wed, Dec 18, 2019 at 9:03 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >>> +       status = efi_call_early(create_event, EVT_SIGNAL_EXIT_BOOT_SERVICES,
> > >>> +                               TPL_CALLBACK, handle_exit_boot_services_event,
> > >>> +                               NULL, &exit_boot_services_event);
> > >>> +       if (status != EFI_SUCCESS) {
> > >>> +               pr_efi_err("Failed to register for EBS() event\n");
> > >>> +               goto free_handle;
> > >>> +       }
> > >>
> > >> OVMF's SEV implementation appears to tear down AMD's IOMMU mappings at
> > >> EVT_SIGNAL_EXIT_BOOT_SERVICES. How are we ensuring that this happens
> > >> first?
> > >
> > > It doesn't, and that is kind of the point. The only guarantee you have
> > > is that this runs before ExitBootServices() returns, but after any
> > > other callbacks that have been registered. I know this is not 100%
> > > what you're after, but it is the only way we can avoid poking devices
> > > behind the backs of their drivers.
> > >

Could we add a comment to describe why we have the two-step event
notification, i.e. to ensure the ordering?

Regarding SEV, from what Laszlo had said [1] I had understood that the
SEV driver left everything blacklisted -- is this necessary at all for
SEV or did I misunderstand his comment?

[1] https://lore.kernel.org/lkml/9c58f2d2-5712-0972-6ea7-092500f37cf9@redhat.com/

> >
> > Can you clarify (in the changelog or a comment perhaps) why you’re doing this instead of turning off busmastering before calling ExitBootServices()?  Maybe this was covered in this thread, but I missed it.
> >
> 
> Sure. The problem is that EBS() is the place where drivers tear down
> rings etc and gracefully take down the device. So killing DMA for all
> of them by clearing the BM bit of every bridge is likely to cause
> problems, because the teardown code wasn't written with the idea in
> mind that DMA is no longer possible. On arm64 at least, it may result
> in the kernel being entered with a pending SError which will kill the
> OS as soon as they are unmasked. But the UEFI drivers themselves may
> simply hang or timeout on some DMA access.
> 

As I understand it, the order in which we want the bus-mastering
disable to happen is
- all PCI device drivers are stopped
- bus mastering is disabled
- depending on firmware, iommu might get disabled (probably out of our
  control)

Instead of using the event notifier, could we not explicitly call
DisconnectController() for all the PCI devices, then disable
bus-mastering, and only then call ExitBootServices()?

> > Also, surely this whole mess is a a design error in EFI, at least when SEV is involved, and there should be an EFI extension to keep IOMMU enabled.  Or a specified way to *guarantee* that DMA is off when we exit boot services without hackery.
> 
> The UEFI spec requires that all devices stop doing DMA at
> ExitBootServices() time, which is why they register for this event and
> disable DMA in their drivers. So from this pov, the state of the IOMMU
> is irrelevant since no device should be doing DMA anyway. The UEFI
> spec does not reason at all about IOMMUs.
> 
> But indeed, the whole idea that the IOMMU is a 'feature' that you can
> ignore if you want since it will be in passthrough mode otherwise is
> misguided, but I'm not sure this is a firmware problem. The desire to
> be able to run yesterday's OS on today's hardware, especially in the
> Windows world, resulted in a situation where many security and
> hardening features are opt-in rather than opt-out, with the adoption
> you might expect.

Looking at the intel iommu driver [2] there is a PCD entry to control
whether to leave the IOMMU enabled. Is it possible to check its value to
see whether the bus-master disabling is necessary -- ie IOMMU was
enabled during boot and its going to get turned off during
ExitBootServices, or even check whether it's settable and if so set it
to leave the IOMMU enabled?

[2] https://github.com/tianocore/edk2-platforms/blob/0d4d661b5a7cf3114a7d81e1c59e5cb57ceaf139/Silicon/Intel/IntelSiliconPkg/Feature/VTd/IntelVTdDxe/DmaProtection.c#L601

