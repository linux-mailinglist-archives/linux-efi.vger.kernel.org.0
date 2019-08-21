Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98A1A9724C
	for <lists+linux-efi@lfdr.de>; Wed, 21 Aug 2019 08:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfHUGf0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Aug 2019 02:35:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37554 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfHUGf0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Aug 2019 02:35:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id d16so897766wme.2
        for <linux-efi@vger.kernel.org>; Tue, 20 Aug 2019 23:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwWUHZYts+drKn/xffO1pjxZ/7naUbutbTGCAceSvTc=;
        b=VgGxw/btw738XPHhp/L0bKvSoT3qPerWAMK1NEHDGjQsBH1c+GvVxVdG+ELKg0a7qw
         Ud1ki2X8s1J6JjgxwBIEYV2QWmXlco5HDzzUcTS82y8EuC7jpBFTPQJ69lu0+gGPnNkg
         NQGo/pF0YwogR6K3YpQamy/tl3ggi/3YpFwf4xcg+jBAIHK0O0Ytt1vcRZYAEWzeD4LS
         E9qAOrvqm7wTxiX1At6+lIRbZTjLB4kwXrBEejCnH6cscYesK60qJGwX1eo5d5LF1TYN
         23j+25p71iaRWc+oXZRpxrAA91j1sesOitH46KYLRalw6iyg8neOC42NukwlFkMe1Y25
         BV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwWUHZYts+drKn/xffO1pjxZ/7naUbutbTGCAceSvTc=;
        b=MEeIEHd/RiMn+2n2m0ctScT1orbh7B84LrMyD33MOTDnmsk/qg/jBF3u+HpQLs/PKS
         A3bhLA/MlMMJGGkuGXWGqdOGgI3IFWZI/O9VavkmjZSY5SnkpvbIZu65iLJ7lYxVUrrP
         lLHlkd917KiwbspUfYCfKLQIhn+8jEV3SApKvqON0FYGkjuRVIJIWZitiQu2r55la+Nl
         gT7LmvDltUlDCeQZtnRTkHCoMXyUzUZoG4ICS2dkOYtCpIk/wfHQZI0LQ2JN3S/SF6jn
         nStJMp5ffqOA9tjGW+lz8GrkuDOTBS+6KN6WdhHy5ARlsrSxZWqBKvdREAO4q+88S6D6
         udtw==
X-Gm-Message-State: APjAAAVmNitKtsO5nA+Uokuzz0t9aYSK4KcOnJJkHxBUd3ytXVYHN+R4
        hiJI1/+N+rEi51p+KjPggoc5+jDu7OcknbwIzTThrg==
X-Google-Smtp-Source: APXvYqxZ9x1njh2u7SKpOiYXOMgCfQHg0eDluyY/KqYAWC54RNdsCDYER6fXRouO6u+k0xWxMeAI98fN8jZY2TrtyN4=
X-Received: by 2002:a7b:c21a:: with SMTP id x26mr3651362wmi.61.1566369324021;
 Tue, 20 Aug 2019 23:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190802053744.5519-1-clin@suse.com> <20190820115645.GP13294@shell.armlinux.org.uk>
 <CAKv+Gu_0wFw5Mjpdw7BEY7ewgetNgU=Ff1uvAsn0iHmJouyKqw@mail.gmail.com> <20190821061027.GA2828@linux-8mug>
In-Reply-To: <20190821061027.GA2828@linux-8mug>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 21 Aug 2019 09:35:16 +0300
Message-ID: <CAKv+Gu8Yny8cVPck3rPwCPvJBvcZKMHti_9bkCTM4H4cZ_43fg@mail.gmail.com>
Subject: Re: [PATCH] efi/arm: fix allocation failure when reserving the kernel base
To:     Chester Lin <clin@suse.com>
Cc:     Juergen Gross <JGross@suse.com>, Joey Lee <JLee@suse.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>, Gary Lin <GLin@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 21 Aug 2019 at 09:11, Chester Lin <clin@suse.com> wrote:
>
> On Tue, Aug 20, 2019 at 03:28:25PM +0300, Ard Biesheuvel wrote:
> > On Tue, 20 Aug 2019 at 14:56, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Fri, Aug 02, 2019 at 05:38:54AM +0000, Chester Lin wrote:
> > > > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > > > index f3ce34113f89..909b11ba48d8 100644
> > > > --- a/arch/arm/mm/mmu.c
> > > > +++ b/arch/arm/mm/mmu.c
> > > > @@ -1184,6 +1184,9 @@ void __init adjust_lowmem_bounds(void)
> > > >               phys_addr_t block_start = reg->base;
> > > >               phys_addr_t block_end = reg->base + reg->size;
> > > >
> > > > +             if (memblock_is_nomap(reg))
> > > > +                     continue;
> > > > +
> > > >               if (reg->base < vmalloc_limit) {
> > > >                       if (block_end > lowmem_limit)
> > > >                               /*
> > >
> > > I think this hunk is sane - if the memory is marked nomap, then it isn't
> > > available for the kernel's use, so as far as calculating where the
> > > lowmem/highmem boundary is, it effectively doesn't exist and should be
> > > skipped.
> > >
> >
> > I agree.
> >
> > Chester, could you explain what you need beyond this change (and my
> > EFI stub change involving TEXT_OFFSET) to make things work on the
> > RPi2?
> >
>
> Hi Ard,
>
> In fact I am working with Guillaume to try booting zImage kernel and openSUSE
> from grub2.04 + arm32-efistub so that's why we get this issue on RPi2, which is
> one of the test machines we have. However we want a better solution for all
> cases but not just RPi2 since we don't want to affect other platforms as well.
>

Thanks Chester, but that doesn't answer my question.

Your fix is a single patch that changes various things that are only
vaguely related. We have already identified that we need to take
TEXT_OFFSET (minus some space used by the swapper page tables) into
account into the EFI stub if we want to ensure compatibility with many
different platforms, and as it turns out, this applies not only to
RPi2 but to other platforms as well, most notably the ones that
require a TEXT_OFFSET of 0x208000, since they also have reserved
regions at the base of RAM.

My question was what else we need beyond:
- the EFI stub TEXT_OFFSET fix [0]
- the change to disregard NOMAP memblocks in adjust_lowmem_bounds()
- what else???


[0] https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=next&id=0eb7bad595e52666b642a02862ad996a0f9bfcc0
