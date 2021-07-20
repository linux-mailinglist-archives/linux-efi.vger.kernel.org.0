Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B25A3CFE15
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 17:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbhGTPFO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 11:05:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:34270 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239857AbhGTO1q (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 10:27:46 -0400
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 16KE3v9a030589;
        Tue, 20 Jul 2021 09:03:58 -0500
Message-ID: <2e4fb9458e32d2727099a5116c59a6c54e280aad.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] arm64: efi: kaslr: Fix boot failure if
 efi_random_alloc() fails
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org Will Deacon" <will@kernel.org>
Date:   Wed, 21 Jul 2021 00:03:56 +1000
In-Reply-To: <CAMj1kXEwFyTjoERo8KO2jWRYePCOAB2E8_y6jmv9LSfazc2t9g@mail.gmail.com>
References: <161920fc31ec4168290ca31b3e4ac7a75ac1df6b.camel@kernel.crashing.org>
         <CAMj1kXEuuiGELD-9Yruens_jKr7vY=dH3LkuyfhkxTK2SPQZfw@mail.gmail.com>
         <0e1280c9ca789e15a46b65f6796a8c333a9da18a.camel@kernel.crashing.org>
         <CAMj1kXEwFyTjoERo8KO2jWRYePCOAB2E8_y6jmv9LSfazc2t9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2021-07-20 at 15:48 +0200, Ard Biesheuvel wrote:
> 
> You are replacing min_kimg_align() with MIN_KIMG_ALIGN in a place
> where it could return either value: efi_nokaslr will be false by
> default on relocatable kernels

Not exactly:

drivers/firmware/efi/libstub/efi-stub-helper.c:bool efi_nokaslr =
!IS_ENABLED(CONFIG_RANDOMIZE_BASE);

So if CONFIG_RANDOMIZE_BASE is off (KASLR disabled in the config),
efi_nokaslr is true.

If CONFIG_RANDOMIZE_BASE is on, then it depends on the command line
(and the availability of the RNG protocol).

None of this depends on CONFIG_RELOCATABLE which is indeed not entirely
orthogonal, but not particularily relevant in how the code is written
today.

> , in which case min_kimg_align() will
> return EFI_KIMG_ALIGN, unless you specifically request KASLR to be
> disabled.

Nope. See above. It will only be EFI_KIMG_ALIGN if
CONFIG_RANDOMIZE_BASE is on and KASLR isn't otherwise disabled.

> The result is that relocatable kernels that would not require to be
> moved will now be moved to a 2 MB aligned offset before booting them.
> 
> Similarly for the efi_allocate_pages_aligned() call: that call would
> only request 64k alignment before on a relocatable kernel if booting
> without randomization.

I'm not sure I'm following you here. If you look at the changelog for
commit 7c116db24d94, it pretty clearly says:

"Adjust the EFI stub for arm64 so that the minimum Image alignment is
2MB unless KASLR is in use."

Which is also pretty much what is spelled in the comment
above min_kimg_align() (which I moved but kept in my patch).

Basically, what you describe is what the code used to do afaik, but not
what it does since 7c116db24d94.

The current code (prior) to my patch is pretty clear, it uses 64k
alignment if KASLR is on, otherwise 2MB. So the big if (status !=
EFI_SUCCESS) statement with the alignment check & relocation is all
only meant to be used in the !KASLR case, which is always going to want
2MB (again based on the code as written today).

My patch simply ensures that this is also true when KASLR fails to
randomize the kernel address.

Cheers,
Ben.

