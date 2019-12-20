Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF7DE12762A
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2019 08:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfLTHHF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Dec 2019 02:07:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53705 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfLTHHF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Dec 2019 02:07:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id m24so7797097wmc.3
        for <linux-efi@vger.kernel.org>; Thu, 19 Dec 2019 23:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ntTwW1huJXk+yCaZll+D+jhzuBWSQqmmrtX9P9U2m0=;
        b=VNGIFVvcp7vpr8RIOH236WiVX6/skrgUPIWjShn1ykLDsXjSbwiR+pBSyC6MTmfvoD
         fqEb1ApFRiZbl2EaLywWeakIpn/PIehh39uyr8DKaxDN5EZLMF5tiaPSPRebvi2cDrYv
         Witg4lXr3GoETk8hZ5t+Q0oVQuV61flNuWXwboVqYhk14jHwq2OLBrejS6j/mPvY720N
         XBvrzZRZkL/3Bw0LmVnt47Rb+ChIKLsqYEY5hBOBWkIXvDMmKF+Xt5suF5RYaN6+fxUs
         AbT3F0fOQeO3ed71CpnwMhIk3rbomz2B30Tte1LOXjnFycco9j7J7M8ZL8R+OEiAP6tR
         Ybkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ntTwW1huJXk+yCaZll+D+jhzuBWSQqmmrtX9P9U2m0=;
        b=cupXXhhmOHscxeLhPz2VYT1GjWzYXltYGYe1qa2HDL0sPhZ0od83aWca5rN4lMQLGE
         CpAqFbjl+NNGpRHcoZLQ/5ehJ3pILTrA/lz4MrMzEPg1I9ZJ5x4Ne25Sc4Fj8OGeVBe+
         t3OOLep4D0wpwCYNC8zuWtAR6SSgD0P5QxAqqFKKyPQ/arMe7ehPRKeA2yi4Ciymh6LB
         oVZAyZ6rdsAanYg5sndtyHnKT7VfbY0eg4I3v+VLJ0So3S+/iJRYccafpNJja/mjr3/K
         hCNMOV7Qol4SEuW7qFwHbaUvVoTzIlugacdqb6AQA7UzWXD15E7S3UUbFnEYR30rPpzz
         2BQA==
X-Gm-Message-State: APjAAAUW210GpCpVWEbHrnF2L5UrZKBY2UCebqiWpeZGwPTyZ1A3/5r4
        0qUYtvHyKCVjicxHY7pnoBzsiCdfGAEA66lZZ/m1RA==
X-Google-Smtp-Source: APXvYqxGy1rcCmEKVDuimNeXhXgp0gYy1kqwFMmyEpF6B9QoJg2GHcFta0ovlnwKhlruHUqDZfqYeI251EbCYmi/mew=
X-Received: by 2002:a1c:a795:: with SMTP id q143mr13784495wme.52.1576825623812;
 Thu, 19 Dec 2019 23:07:03 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-22-ardb@kernel.org>
 <CACdnJusxs_vAMvE_tOX12ZJiEc3__1NimT3aD3r-Oabvx62FtA@mail.gmail.com>
In-Reply-To: <CACdnJusxs_vAMvE_tOX12ZJiEc3__1NimT3aD3r-Oabvx62FtA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 20 Dec 2019 09:06:58 +0200
Message-ID: <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Matthew Garrett <mjg59@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 19 Dec 2019 at 22:05, Matthew Garrett <mjg59@google.com> wrote:
>
> On Wed, Dec 18, 2019 at 9:03 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > +       status = efi_call_early(create_event, EVT_SIGNAL_EXIT_BOOT_SERVICES,
> > +                               TPL_CALLBACK, handle_exit_boot_services_event,
> > +                               NULL, &exit_boot_services_event);
> > +       if (status != EFI_SUCCESS) {
> > +               pr_efi_err("Failed to register for EBS() event\n");
> > +               goto free_handle;
> > +       }
>
> OVMF's SEV implementation appears to tear down AMD's IOMMU mappings at
> EVT_SIGNAL_EXIT_BOOT_SERVICES. How are we ensuring that this happens
> first?

It doesn't, and that is kind of the point. The only guarantee you have
is that this runs before ExitBootServices() returns, but after any
other callbacks that have been registered. I know this is not 100%
what you're after, but it is the only way we can avoid poking devices
behind the backs of their drivers.

So this approach is what i am willing to accept for mainline, and I
would even start out by enabling it by default to get the most
coverage. If you need something stronger, I understand but I don't
think it belongs in mainline.
