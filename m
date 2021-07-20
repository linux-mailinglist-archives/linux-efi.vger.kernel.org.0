Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06FA3CFC54
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 16:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbhGTNsz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 09:48:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:49015 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239330AbhGTNq7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 09:46:59 -0400
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 16KEPTp6032188;
        Tue, 20 Jul 2021 09:25:29 -0500
Message-ID: <dcd3d434697bd15da1297ed1074acaa52003c683.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] arm64: efi: kaslr: Fix boot failure if
 efi_random_alloc() fails
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org Will Deacon" <will@kernel.org>
Date:   Wed, 21 Jul 2021 00:25:28 +1000
In-Reply-To: <CAMj1kXH_mgten0R5NpDMzxQPJ1QNX0z3OZNREwH8FCJ5s+4M=w@mail.gmail.com>
References: <161920fc31ec4168290ca31b3e4ac7a75ac1df6b.camel@kernel.crashing.org>
         <CAMj1kXEuuiGELD-9Yruens_jKr7vY=dH3LkuyfhkxTK2SPQZfw@mail.gmail.com>
         <0e1280c9ca789e15a46b65f6796a8c333a9da18a.camel@kernel.crashing.org>
         <CAMj1kXEwFyTjoERo8KO2jWRYePCOAB2E8_y6jmv9LSfazc2t9g@mail.gmail.com>
         <2e4fb9458e32d2727099a5116c59a6c54e280aad.camel@kernel.crashing.org>
         <CAMj1kXH_mgten0R5NpDMzxQPJ1QNX0z3OZNREwH8FCJ5s+4M=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2021-07-20 at 16:10 +0200, Ard Biesheuvel wrote:
> 
> > My patch simply ensures that this is also true when KASLR fails to
> > randomize the kernel address.
> > 
> 
> Fair enough.
> 
> The history here is that passing nokaslr on the command line would
> force 2M alignment even if KASLR was not enabled to begin with,
> without affecting the alignment policy of KASLR capable kernels if
> KASLR was not explicitly disabled, but not available on the platform.
> 
> I realize now that my commit d32de9130f6c7 has interfered with this:
> efi_nokaslr is set to true there so the later code does not complain
> about the EFI_RNG_PROTOCOL being unavailable, but it has the side
> effect of affecting the alignment policy in the remainder of the
> function.
> 
> So what I would prefer here is to capture efi_nokaslr at entry, and
> use that to decide the alignment. That way, efi_nokaslr can be set to
> true without affecting the subsequent allocation logic.

So interestingly, the bug I am trying to fix with this patch seems to
indicate that this doesn't work (though I would need to debug further
as to why) on my systems (EC2 c6g.metal instances).

IE, in my case what happens is:

 - kernel has CONFIG_RANDOMIZE_BASE and CONFIG_RELOCATABLE both enabled
 - RNG protocol exists, it gets a random seed, but due to the other
bug, efi_random_alloc() fails. It thus falls back to the "normal"
alignment check & relocation case (the big if (status != EFI_SUCCESS))
 - That alignment check uses 64K and not 2M however. In my case it
passes (_text is already 64K aligned) and we boot...
 - And nothing happens. IE, it dies somewhere in/after exit boot
services, I haven't had a chance to figure out in more details why,
those machines take 20mn to reboot.

So *something* is wrong when we stick to a 64K alignment and don't
randomize the kernel base.

Interestingly we don't set nokaslr in that case, so we should still be
hitting all the kaslr path in the main kernel. The problem could relate
to running from that initial address. I'll have to debug further, maybe
try a repro-case in qemu.

In the meantime, please apply patch 1 which solves the main issue and
I'll continue digging.

Note (in case this is relevant): This was all tested/debugged on 5.10.y

Cheers,
Ben.


