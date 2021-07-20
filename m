Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11DD3CFCE6
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbhGTOXI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 10:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239979AbhGTN7l (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 09:59:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F17F6101E
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626792019;
        bh=0svNeulWDtZSBXCy3gTGL2vqJj/8SC0F4typBUqFsB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pg9YgCgq+8qt+xK9x0mMcFXGGHSOwxpqnREjWlSyqZzAS5XizO9Mywo4RnxdYrYRm
         RTMhaFni1FM03EnhcRy9vf7217Y0a87UFo1P4abjtBRMRJy8keKqmtkNP6LDjgbRoZ
         lVj2d+v+Z6ikK7Clo6jgWmx0UE+GZc8+jrCvIAYSrAQJdsxUO2FbXkPpMZEfo4XG6d
         xj3nWW5KKQEAL+MVooc0c09EsvgN7DnHQB/e8Y5TOQjCxHPon5D6GyL9nnlgEStCwk
         LDvbKrANBCTRswctmlKQBMcygs3030JdLyYRyEmaxEAXwgRZQ3WfvqLb2XpyJ6DsuH
         hBpE3WOP2UEjQ==
Received: by mail-ot1-f54.google.com with SMTP id t4-20020a05683014c4b02904cd671b911bso13656697otq.1
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 07:40:19 -0700 (PDT)
X-Gm-Message-State: AOAM531zvbXsYYUasTFHkLlviSPrrN3bBtCwqiEGmaqbUqMtGH7SjCSU
        f2mkkJ5R5RnFNNBDxMjpC0Mt3lhrdhc6p2WDDUw=
X-Google-Smtp-Source: ABdhPJwaP8Jcg14bUt4VtZt9Ld2ugI0PHQnqHbE+hmvo3VnYpGI/HsVgbNr67zPTTnjm6UhTIsPzLdz20jv9B6fLm7E=
X-Received: by 2002:a05:6830:34a6:: with SMTP id c38mr9697856otu.108.1626792018921;
 Tue, 20 Jul 2021 07:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <161920fc31ec4168290ca31b3e4ac7a75ac1df6b.camel@kernel.crashing.org>
 <CAMj1kXEuuiGELD-9Yruens_jKr7vY=dH3LkuyfhkxTK2SPQZfw@mail.gmail.com>
 <0e1280c9ca789e15a46b65f6796a8c333a9da18a.camel@kernel.crashing.org>
 <CAMj1kXEwFyTjoERo8KO2jWRYePCOAB2E8_y6jmv9LSfazc2t9g@mail.gmail.com>
 <2e4fb9458e32d2727099a5116c59a6c54e280aad.camel@kernel.crashing.org>
 <CAMj1kXH_mgten0R5NpDMzxQPJ1QNX0z3OZNREwH8FCJ5s+4M=w@mail.gmail.com> <dcd3d434697bd15da1297ed1074acaa52003c683.camel@kernel.crashing.org>
In-Reply-To: <dcd3d434697bd15da1297ed1074acaa52003c683.camel@kernel.crashing.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 20 Jul 2021 16:40:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH16NfN-N-QAfxtzpeYyfG6ij0+XNE6+yNgYu1hPyX+aQ@mail.gmail.com>
Message-ID: <CAMj1kXH16NfN-N-QAfxtzpeYyfG6ij0+XNE6+yNgYu1hPyX+aQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: efi: kaslr: Fix boot failure if
 efi_random_alloc() fails
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org Will Deacon" <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 20 Jul 2021 at 16:25, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Tue, 2021-07-20 at 16:10 +0200, Ard Biesheuvel wrote:
> >
> > > My patch simply ensures that this is also true when KASLR fails to
> > > randomize the kernel address.
> > >
> >
> > Fair enough.
> >
> > The history here is that passing nokaslr on the command line would
> > force 2M alignment even if KASLR was not enabled to begin with,
> > without affecting the alignment policy of KASLR capable kernels if
> > KASLR was not explicitly disabled, but not available on the platform.
> >
> > I realize now that my commit d32de9130f6c7 has interfered with this:
> > efi_nokaslr is set to true there so the later code does not complain
> > about the EFI_RNG_PROTOCOL being unavailable, but it has the side
> > effect of affecting the alignment policy in the remainder of the
> > function.
> >
> > So what I would prefer here is to capture efi_nokaslr at entry, and
> > use that to decide the alignment. That way, efi_nokaslr can be set to
> > true without affecting the subsequent allocation logic.
>
> So interestingly, the bug I am trying to fix with this patch seems to
> indicate that this doesn't work (though I would need to debug further
> as to why) on my systems (EC2 c6g.metal instances).
>
> IE, in my case what happens is:
>
>  - kernel has CONFIG_RANDOMIZE_BASE and CONFIG_RELOCATABLE both enabled
>  - RNG protocol exists, it gets a random seed, but due to the other
> bug, efi_random_alloc() fails. It thus falls back to the "normal"
> alignment check & relocation case (the big if (status != EFI_SUCCESS))
>  - That alignment check uses 64K and not 2M however. In my case it
> passes (_text is already 64K aligned) and we boot...
>  - And nothing happens. IE, it dies somewhere in/after exit boot
> services, I haven't had a chance to figure out in more details why,
> those machines take 20mn to reboot.
>
> So *something* is wrong when we stick to a 64K alignment and don't
> randomize the kernel base.
>

Interesting. Could this be related to caching? If EFI loads Image and
it remains in place, we boot the image that we are executing from, and
if your ExitBootServices() implementation plays tricks with
[non-architected] caches, this could cause problems, I suppose. Just
guessing ...


> Interestingly we don't set nokaslr in that case, so we should still be
> hitting all the kaslr path in the main kernel. The problem could relate
> to running from that initial address. I'll have to debug further, maybe
> try a repro-case in qemu.
>
> In the meantime, please apply patch 1 which solves the main issue and
> I'll continue digging.
>

OK

> Note (in case this is relevant): This was all tested/debugged on 5.10.y
>
> Cheers,
> Ben.
>
>
