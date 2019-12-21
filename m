Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2AD128A78
	for <lists+linux-efi@lfdr.de>; Sat, 21 Dec 2019 17:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfLUQob (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 21 Dec 2019 11:44:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40622 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfLUQob (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 21 Dec 2019 11:44:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so12332777wrn.7
        for <linux-efi@vger.kernel.org>; Sat, 21 Dec 2019 08:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNCHrGB6mtIBPQoye3jw0lrLYPnaowwzhA50Yfy0/2k=;
        b=UVEwj/EoFgU22SvBsCsyVapHdByPplgZ7A+NuAFR8wcrCt1M/xwPUzgQFzMgJ8QOpW
         8/phRRVnpB4LIIkYW9EoruUDyCjKfVWuiq7Jq7zLwUx8jA+fBLFhpA3/ztnt0Gp2bVI5
         KKBVF5fvBgd2nv542eJU3uUjoailMleXfflIDGJNIRRgtWiXYePhquo5LAR1gztjV1N/
         j8T1/WLxJgn49RFoKFX7XTlX/I68W3GpY4O6Afl+YJ4yMSUAM8pCebaY4VEByMYAIVts
         tvPU+bHmepSniX3AVniIJs8eZJ0h/DNS7QED6oYM4i6Cn10NkDkSOr4hlIzaLxdVjd0u
         SciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNCHrGB6mtIBPQoye3jw0lrLYPnaowwzhA50Yfy0/2k=;
        b=owiz2AujK7iTiA9yQ5HS46nb0KJLarGKlcg3ZViYnGyQlls8xKU1MJSMuWegc2zd9a
         EAaeP4vCd2QIxYEjhtZVwvDvCQ0HOBdRfsTx72C7y310yDSwh2d4n4T05GZ2an6svevd
         gvRhXu+HQ+ftRFR0KLWyc8e66ZQQ+71OzoDkAsDBuTc2nwvdDt1MPb0y7oNEAW2s2+rS
         usD5i/p1KTZLESYdZ4mV8GZykCFs0SXS6vKElrqVfcHzDLSWfGFuEsDpvNt3YgXqvEel
         D64TJJzIEMygPrYk2e2KTwbGjwJoTKd0CvT2NyDnr+g/+wMZaBWX7296OrPiGZg2eRg6
         m5/A==
X-Gm-Message-State: APjAAAV2hSbf2xpuQApu0zap7Lw5T8Ew2d+lv/j8qVSa+g/qTllIBlWS
        vr2/scpvlfIcDwcsBmWMjb5/x0SnuwKLB/TixfveThQ1Ail2dw==
X-Google-Smtp-Source: APXvYqz1yO9t3ErMICETt0E2nt4zY8qUEWrdpbJDnfPwrQHUEyXtyZUji+YAbeti1lXRxMJAfBcpu/a/5CYJQb6P83o=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr20085421wrr.32.1576946668625;
 Sat, 21 Dec 2019 08:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-22-ardb@kernel.org>
 <CACdnJusxs_vAMvE_tOX12ZJiEc3__1NimT3aD3r-Oabvx62FtA@mail.gmail.com>
 <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com> <CACdnJuucz5CC=LVA5589t0SByH6NHfxbjqm1ONv1nArnUEaHoA@mail.gmail.com>
In-Reply-To: <CACdnJuucz5CC=LVA5589t0SByH6NHfxbjqm1ONv1nArnUEaHoA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 21 Dec 2019 18:44:24 +0200
Message-ID: <CAKv+Gu_ofVxDKBoe8cRFCRfwHtxN1UNYtYjb0AggXOSTOegtPA@mail.gmail.com>
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

On Fri, 20 Dec 2019 at 22:43, Matthew Garrett <mjg59@google.com> wrote:
>
> On Thu, Dec 19, 2019 at 11:07 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Thu, 19 Dec 2019 at 22:05, Matthew Garrett <mjg59@google.com> wrote:
> > >
> > > On Wed, Dec 18, 2019 at 9:03 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > +       status = efi_call_early(create_event, EVT_SIGNAL_EXIT_BOOT_SERVICES,
> > > > +                               TPL_CALLBACK, handle_exit_boot_services_event,
> > > > +                               NULL, &exit_boot_services_event);
> > > > +       if (status != EFI_SUCCESS) {
> > > > +               pr_efi_err("Failed to register for EBS() event\n");
> > > > +               goto free_handle;
> > > > +       }
> > >
> > > OVMF's SEV implementation appears to tear down AMD's IOMMU mappings at
> > > EVT_SIGNAL_EXIT_BOOT_SERVICES. How are we ensuring that this happens
> > > first?
> >
> > It doesn't, and that is kind of the point. The only guarantee you have
> > is that this runs before ExitBootServices() returns, but after any
> > other callbacks that have been registered. I know this is not 100%
> > what you're after, but it is the only way we can avoid poking devices
> > behind the backs of their drivers.
>
> Hm. In that case, I think this version fails to match the patch
> description - there's potentially still a window where DMA-capable PCI
> devices can attack the kernel, it's just smaller. If disconnecting
> drivers from the device would give us the same expectations then that
> seems like a better approach, but I think I probably wouldn't add my
> signed-off-by to this version.

Point taken. I like Arvind's suggestion but we need to take care not
to disable the device producing the GOP. Beyond that, it should be
possible to disable all devices that are behind PCI bridges. It does
mean we need to decode the secondary/subordinate bus values from the
config space and take them into account when iterating over the PCI
handle list.
