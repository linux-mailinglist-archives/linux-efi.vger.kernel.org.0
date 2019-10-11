Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBA7D3D2B
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 12:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfJKKSx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 06:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfJKKSw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Oct 2019 06:18:52 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83A108125C
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2019 10:18:52 +0000 (UTC)
Received: by mail-io1-f71.google.com with SMTP id i2so14038601ioo.10
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2019 03:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ezldw/W3yEUUaRQBM2UsDlZ+1NBlrPJRQgRQBE4bfow=;
        b=tG10uWVirp+fDW81TSB6Q077WsEPlSyQsXWWDVwsIjA46G956h2zDESSYMe7P/3lrA
         y/kFwQhF1dxj8XsYZ+gdS5oAvIVJ0CZY26lI1fmtSUJ9wBzgFUttcDjmEULL0ZsetkHi
         OGFno0rqh4KUESM3b6B6XHzMk+KwP2e7b3w9Dfc1RJx5V5HE6y2hfZso9NFyMpjZJWIw
         7YMusYq4ZHj6/ddYWSGAQbge+AxOckdu6gJCB80a9E/+NhQ91bxMaxJc965lvVDix2Gs
         Bw7/hRI55IZ5Qa7xcpprAfl2ps/G+BojpCFN65nydYBM41JerNCfO5aVKHGZa4k8L/XI
         Zv6A==
X-Gm-Message-State: APjAAAVhDtfO92YwA1Vb3tMh0DVgvr1s0HY1gKmPmGcD1eb9uacdl7fJ
        dXHRxvGc2qeoMu4t2RIfVB73Jo3QX8zAD4r+8rvm5emDRpEUvdxFt9NJuLjcJMXclc7D9nNtJZQ
        UFn1Ily0qdAslECG8gBF/Nz7uDmeuj3VnwaLN
X-Received: by 2002:a6b:ee1a:: with SMTP id i26mr1250927ioh.202.1570789131886;
        Fri, 11 Oct 2019 03:18:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxMBTtYTtzqHW6IhTVWq3xS7QTn71g8GWmBZ0Svz/a1YAShKUhbb/aYerCE+8iT34WwAPUSfQvd49bQufhMra0=
X-Received: by 2002:a6b:ee1a:: with SMTP id i26mr1250893ioh.202.1570789131530;
 Fri, 11 Oct 2019 03:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190919160521.13820-1-kasong@redhat.com> <CAKv+Gu95NGPF7m9_K-0MDmti7XN++cfyYWRj6WEXqpYzDM9Btg@mail.gmail.com>
 <CACPcB9c=DzGrqnm1WrEtr85v5f_F41NQ-di5NV-F2ukbbrpTTw@mail.gmail.com>
In-Reply-To: <CACPcB9c=DzGrqnm1WrEtr85v5f_F41NQ-di5NV-F2ukbbrpTTw@mail.gmail.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 11 Oct 2019 18:18:40 +0800
Message-ID: <CACPcB9cdKR-t+jNsYYzZBVqr3pGSkO7Yq7xTS6Oi-h7VX+pkFw@mail.gmail.com>
Subject: Re: [PATCH v2] x86, efi: never relocate kernel below lowest
 acceptable address
To:     "the arch/x86 maintainers" <x86@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 26, 2019 at 1:36 AM Kairui Song <kasong@redhat.com> wrote:
>
> On Wed, Sep 25, 2019 at 11:25 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Thu, 19 Sep 2019 at 18:06, Kairui Song <kasong@redhat.com> wrote:
> > >
> > > Currently, kernel fails to boot on some HyperV VMs when using EFI.
> > > And it's a potential issue on all platforms.
> > >
> > > It's caused a broken kernel relocation on EFI systems, when below three
> > > conditions are met:
> > >
> > > 1. Kernel image is not loaded to the default address (LOAD_PHYSICAL_ADDR)
> > >    by the loader.
> > > 2. There isn't enough room to contain the kernel, starting from the
> > >    default load address (eg. something else occupied part the region).
> > > 3. In the memmap provided by EFI firmware, there is a memory region
> > >    starts below LOAD_PHYSICAL_ADDR, and suitable for containing the
> > >    kernel.
> > >
> > > Efi stub will perform a kernel relocation when condition 1 is met. But
> > > due to condition 2, efi stub can't relocate kernel to the preferred
> > > address, so it fallback to query and alloc from EFI firmware for lowest
> > > usable memory region.
> > >
> > > It's incorrect to use the lowest memory address. In later stage, kernel
> > > will assume LOAD_PHYSICAL_ADDR as the minimal acceptable relocate address,
> > > but efi stub will end up relocating kernel below it.
> > >
> > > Then before the kernel decompressing. Kernel will do another relocation
> > > to address not lower than LOAD_PHYSICAL_ADDR, this time the relocate will
> > > over write the blockage at the default load address, which efi stub tried
> > > to avoid, and lead to unexpected behavior. Beside, the memory region it
> > > writes to is not allocated from EFI firmware, which is also wrong.
> > >
> > > To fix it, just don't let efi stub relocate the kernel to any address
> > > lower than lowest acceptable address.
> > >
> > > Signed-off-by: Kairui Song <kasong@redhat.com>
> > >
> >
> > Hello Kairui,
> >
> > This patch looks correct to me, but it needs an ack from the x86
> > maintainers, since the rules around LOAD_PHYSICAL_ADDR are specific to
> > the x86 architecture.
> >
> >
>
> Thanks for the review, Ard.
>
> Can any x86 maintainer help provide some review?
>
> --
> Best Regards,
> Kairui Song

Ping? Any comments?

--
Best Regards,
Kairui Song
