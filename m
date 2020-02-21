Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B070116825F
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2020 16:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgBUPyw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 10:54:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgBUPyv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 21 Feb 2020 10:54:51 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AC392465D
        for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2020 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582300490;
        bh=d7tniPqVuCgYodFudF2UEkt6ItbAby2BJD3sVoiz6sM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MH6IKySalHiwzsOkR4Uv48+m8aWlGc9FCsmS8JG8pWhmpPat9s4stpQk/ZN6X3feE
         8uyUlvF/ykBU/sn22BA7mUc8HiAnovrwPOHBp9A5GH/O1wSJxoMvgEydmDJmpcUuMl
         tGCZIdKU46dZpThMNN1P0hQ/Ge1C98cnP0HevVTg=
Received: by mail-wm1-f52.google.com with SMTP id a6so2437554wme.2
        for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2020 07:54:50 -0800 (PST)
X-Gm-Message-State: APjAAAVQm5mplI0qAPbjn1JXsUiehqqaxv3rSGNbmUO2VjzLgJNsRIL6
        0u+FbjceZCOIzTdSe/yrdJ5kiVeZLCBNnZF+zFwN4g==
X-Google-Smtp-Source: APXvYqxaM1bvUuTrhSNBWekJbeff9q1JUzwFFi3SVvt+xnxY4850Oo6CJeaPcmPwpM8hqJvnGAdNmxiPsH0dCUnF6mQ=
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr4464293wmf.40.1582300488929;
 Fri, 21 Feb 2020 07:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20200219094340.16597-1-ardb@kernel.org> <CAKv+Gu_aL_=W7qMuLwu+427=DSgj5Kmg7Qm0ujooxS9s=zDT2g@mail.gmail.com>
 <fa6aa783-0b01-9d29-03be-3ec8d352f373@arm.com> <CAKv+Gu8g_fb-Xq3XcyZivG5405jypHnkBy6gnWMWy4Oz8763XA@mail.gmail.com>
In-Reply-To: <CAKv+Gu8g_fb-Xq3XcyZivG5405jypHnkBy6gnWMWy4Oz8763XA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 21 Feb 2020 16:54:38 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-FGL3J9fuY3V4GTaqdLTVLfeErN1GPd5nWL4McjMj_Hg@mail.gmail.com>
Message-ID: <CAKv+Gu-FGL3J9fuY3V4GTaqdLTVLfeErN1GPd5nWL4McjMj_Hg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] ARM: decompressor: use by-VA cache maintenance for
 v7 cores
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 21 Feb 2020 at 14:42, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 21 Feb 2020 at 14:35, Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 20/02/2020 6:08 pm, Ard Biesheuvel wrote:
> > > (+ Arnd)
> > >
> > > On Wed, 19 Feb 2020 at 10:43, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >>
> > >> While making changes to the EFI stub startup code, I noticed that we are
> > >> still doing set/way maintenance on the caches when booting on v7 cores.
> > >> This works today on VMs by virtue of the fact that KVM traps set/way ops
> > >> and cleans the whole address space by VA on behalf of the guest, and on
> > >> most v7 hardware, the set/way ops are in fact sufficient when only one
> > >> core is running, as there usually is no system cache. But on systems
> > >> like SynQuacer, for which 32-bit firmware is available, the current cache
> > >> maintenance only pushes the data out to the L3 system cache, where it
> > >> is not visible to the CPU once it turns the MMU and caches off.
> > >>
> > >> So instead, switch to the by-VA cache maintenance that the architecture
> > >> requires for v7 and later (and ARM1176, as a side effect).
> > >>
> > >> Changes since v1:
> > >> - include the EFI patch that was sent out separately before (#1)
> > >> - split the preparatory work to pass the region to clean in r0/r1 in a EFI
> > >>    specific one and one for the decompressor - this way, the first two patches
> > >>    can go on a stable branch that is shared between the ARM tree and the EFI
> > >>    tree
> > >> - document the meaning of the values in r0/r1 upon entry to cache_clean_flush
> > >> - take care to treat the region end address as exclusive
> > >> - switch to clean+invalidate to align with the other implementations
> > >> - drop some code that manages the stack pointer value before calling
> > >>    cache_clean_flush(), which is no longer necessary
> > >> - take care to clean the entire region that is covered by the relocated zImage
> > >>    if it needs to relocate itself before decompressing
> > >>
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=arm32-efi-cache-ops
> > >>
> > >
> > > Adding my own data point here: with these patches, I can reproducibly
> > > boot on the SynQuacer platform (24x Cortex-A53 + GICv3 + L3 system
> > > cache) until the point where /init is loaded, after which it hangs
> > > (see below), whereas without them, it always crashes early with weird,
> > > unreproducible errors, if it even makes it far enough through the
> > > decompressor to produce any earlycon output.
> > >
> > > There is some other weird stuff going on, but this is unlikely to be
> > > related to cache maintenance:
> > > - multiple occurrences of
> > >     OF: translation of DMA address(0) to CPU address failed node(...)
> >
> > FWIW that implies a "dma-ranges" property in the wrong place in the DT -
> > if you copied the now-gone Juno example of placing one directly in the
> > root node, that was bogus, sorry.
> >
>
> OK, so where should it be instead? Are you saying it is now required
> to have a /soc or /smb node that contains all the device nodes?
>

Never mind - I'll just drop "dma-ranges" from the root node entirely.
