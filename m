Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623FA3CFBBD
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 16:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbhGTNct (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 09:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239144AbhGTN3y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 09:29:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34931611F2
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626790232;
        bh=upwYIZCLw/O4t65pAUvL326KLiCw/rAksUnhvqgrEeY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fQwFHYRrs8RQXKWLb0Dd8+QHPKFoRFBbUjgGMSrcvS5n1R8eA/Pem0F6et+AjcbE3
         g2psmUbX3EaVys1eKugvqGn44sakboxRd8Auild0HTdX2RBJ9lmWJFHJIvKgYk3m+I
         JOUvZXtkWfwiCcSSKi68rPCBIzL9N3K5qd15QN1UHfKHel6iOgRKbs5oKlaIoDP52e
         Za/uX4MqE0mC8PbD3A7NhRX4B7xJO8PX5s7T1+CTwwhQvg8f8nhuXVr/gnPt3N7kmq
         fA++wlYDFpQz3lXQ+tXyHElKibKiJnswznWGG6MfY95CaS+bUuCi+hVVteQEM8UhRP
         /XinqqeF+7acQ==
Received: by mail-oi1-f175.google.com with SMTP id w194so24636912oie.5
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 07:10:32 -0700 (PDT)
X-Gm-Message-State: AOAM531Ut5BtiEsauxyG/7ZSDt+XHZC9W5PurMkaYYyPeEk7Te72PPr+
        WpaxIzEvbghrzK3vlpdeuJQQ3KkwR8DNQX6HNmc=
X-Google-Smtp-Source: ABdhPJyPnpP9+wGGDRWp7X0nBuwgQK6Osxh3OLKH+tG5ZT+wKlo+SLfHmJI+sgPzwzUxe6y6jPU4XvinGAz5qZC6vKY=
X-Received: by 2002:aca:d64d:: with SMTP id n74mr25691371oig.47.1626790231539;
 Tue, 20 Jul 2021 07:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <161920fc31ec4168290ca31b3e4ac7a75ac1df6b.camel@kernel.crashing.org>
 <CAMj1kXEuuiGELD-9Yruens_jKr7vY=dH3LkuyfhkxTK2SPQZfw@mail.gmail.com>
 <0e1280c9ca789e15a46b65f6796a8c333a9da18a.camel@kernel.crashing.org>
 <CAMj1kXEwFyTjoERo8KO2jWRYePCOAB2E8_y6jmv9LSfazc2t9g@mail.gmail.com> <2e4fb9458e32d2727099a5116c59a6c54e280aad.camel@kernel.crashing.org>
In-Reply-To: <2e4fb9458e32d2727099a5116c59a6c54e280aad.camel@kernel.crashing.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 20 Jul 2021 16:10:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH_mgten0R5NpDMzxQPJ1QNX0z3OZNREwH8FCJ5s+4M=w@mail.gmail.com>
Message-ID: <CAMj1kXH_mgten0R5NpDMzxQPJ1QNX0z3OZNREwH8FCJ5s+4M=w@mail.gmail.com>
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

On Tue, 20 Jul 2021 at 16:04, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Tue, 2021-07-20 at 15:48 +0200, Ard Biesheuvel wrote:
> >
> > You are replacing min_kimg_align() with MIN_KIMG_ALIGN in a place
> > where it could return either value: efi_nokaslr will be false by
> > default on relocatable kernels
>
> Not exactly:
>
> drivers/firmware/efi/libstub/efi-stub-helper.c:bool efi_nokaslr =
> !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
>
> So if CONFIG_RANDOMIZE_BASE is off (KASLR disabled in the config),
> efi_nokaslr is true.
>
> If CONFIG_RANDOMIZE_BASE is on, then it depends on the command line
> (and the availability of the RNG protocol).
>
> None of this depends on CONFIG_RELOCATABLE which is indeed not entirely
> orthogonal, but not particularily relevant in how the code is written
> today.
>
> > , in which case min_kimg_align() will
> > return EFI_KIMG_ALIGN, unless you specifically request KASLR to be
> > disabled.
>
> Nope. See above. It will only be EFI_KIMG_ALIGN if
> CONFIG_RANDOMIZE_BASE is on and KASLR isn't otherwise disabled.
>
> > The result is that relocatable kernels that would not require to be
> > moved will now be moved to a 2 MB aligned offset before booting them.
> >
> > Similarly for the efi_allocate_pages_aligned() call: that call would
> > only request 64k alignment before on a relocatable kernel if booting
> > without randomization.
>
> I'm not sure I'm following you here. If you look at the changelog for
> commit 7c116db24d94, it pretty clearly says:
>
> "Adjust the EFI stub for arm64 so that the minimum Image alignment is
> 2MB unless KASLR is in use."
>
> Which is also pretty much what is spelled in the comment
> above min_kimg_align() (which I moved but kept in my patch).
>
> Basically, what you describe is what the code used to do afaik, but not
> what it does since 7c116db24d94.
>
> The current code (prior) to my patch is pretty clear, it uses 64k
> alignment if KASLR is on, otherwise 2MB. So the big if (status !=
> EFI_SUCCESS) statement with the alignment check & relocation is all
> only meant to be used in the !KASLR case, which is always going to want
> 2MB (again based on the code as written today).
>
> My patch simply ensures that this is also true when KASLR fails to
> randomize the kernel address.
>

Fair enough.

The history here is that passing nokaslr on the command line would
force 2M alignment even if KASLR was not enabled to begin with,
without affecting the alignment policy of KASLR capable kernels if
KASLR was not explicitly disabled, but not available on the platform.

I realize now that my commit d32de9130f6c7 has interfered with this:
efi_nokaslr is set to true there so the later code does not complain
about the EFI_RNG_PROTOCOL being unavailable, but it has the side
effect of affecting the alignment policy in the remainder of the
function.

So what I would prefer here is to capture efi_nokaslr at entry, and
use that to decide the alignment. That way, efi_nokaslr can be set to
true without affecting the subsequent allocation logic.
