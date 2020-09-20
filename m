Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE903271303
	for <lists+linux-efi@lfdr.de>; Sun, 20 Sep 2020 10:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgITI55 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 20 Sep 2020 04:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgITI55 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 20 Sep 2020 04:57:57 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98DFC061755
        for <linux-efi@vger.kernel.org>; Sun, 20 Sep 2020 01:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V0DJGQdiCqgMMv8g1dxHpKExkr4oI5KxtXNezEfLLt4=; b=O7OZQeW3Vq8FAwSNgtFua7lwX
        TiNK3hO0qZIdZKvqFyJsmtxCKb2zBOdLHMtW70Re743EjX+x6KKt3/AbfnqkezG+AOaqicFRUNG2J
        orFO8Kwb6ojZYQ/6/fy4ATIT+xhxrTQX6zjMLqS+fxmJEb3nIbTr0t1+VuYVU1sKZMBtzuVtzsMS3
        IBB4aZ1yncgCGknRkXa96LXiRPpVSI2LVSuhOkfTfQJvgGxWzXSIRN3CweIPUfsf/3CvxsdL/65CJ
        dyADUqv2qzD2NHwHnvo77MJ99aVhcY1+rMHkEmbgGyHFkweS8w0hz3ACReBAyybs53TayaUzsN/t6
        Qkna3ZgCg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35968)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kJvAO-0000TZ-RZ; Sun, 20 Sep 2020 09:57:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kJvAO-0000Bb-Fx; Sun, 20 Sep 2020 09:57:52 +0100
Date:   Sun, 20 Sep 2020 09:57:52 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC/RFT PATCH 0/6] ARM: p2v: reduce min alignment to 2 MiB
Message-ID: <20200920085752.GX1551@shell.armlinux.org.uk>
References: <20200918103102.18107-1-ardb@kernel.org>
 <nycvar.YSQ.7.78.906.2009191937560.1560@knanqh.ubzr>
 <CAMj1kXG3x9j8qKdGRv0uHq-+zZb_OG11qaDy=EJKAHN7hSWtPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG3x9j8qKdGRv0uHq-+zZb_OG11qaDy=EJKAHN7hSWtPQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Sep 20, 2020 at 09:50:30AM +0200, Ard Biesheuvel wrote:
> On Sun, 20 Sep 2020 at 01:49, Nicolas Pitre <nico@fluxnic.net> wrote:
> >
> > On Fri, 18 Sep 2020, Ard Biesheuvel wrote:
> >
> > > This series is inspired by Zhei Len's series [0], which updates the
> > > ARM p2v patching code to optionally support p2v relative alignments
> > > of as little as 64 KiB.
> > >
> > > Reducing this alignment is necessary for some specific Huawei boards,
> > > but given that reducing this minimum alignment will make the boot
> > > sequence more robust for all platforms, especially EFI boot, which
> > > no longer relies on the 128 MB masking of the decompressor load address,
> > > but uses firmware memory allocation routines to find a suitable spot
> > > for the decompressed kernel.
> > >
> > > This series is not based on Zhei Len's code, but addresses the same
> > > problem, and takes some feedback given in the review into account:
> > > - use of a MOVW instruction to avoid two adds/adcs sequences when dealing
> > >   with the carry on LPAE
> > > - add support for Thumb2 kernels as well
> > > - make the change unconditional - it will bit rot otherwise, and has value
> > >   for other platforms as well.
> > >
> > > The first four patches are general cleanup and preparatory changes.
> > > Patch #5 implements the switch to a MOVW instruction without changing
> > > the minimum alignment.
> > > Patch #6 reduces the minimum alignment to 2 MiB.
> > >
> > > Tested on QEMU in ARM/!LPAE, ARM/LPAE, Thumb2/!LPAE and Thumb2/LPAE modes.
> >
> > At this point I think this really ought to be split into a file of its
> > own... and maybe even rewritten in C. Even though I wrote the original
> > code, I no longer understand it without re-investing time into it. But
> > in either cases the whole of head.S would need to have its registers
> > shuffled first to move long lived values away from r0-r3,ip,lr to allow
> > for standard function calls.
> >
> 
> I agree with that in principle, however, running C code with a stack
> with the MMU off is slightly risky.

It's more than "slightly".  C code has literal addresses, which are raw
virtual addresses.  These are meaningless with the MMU off.

I guess one could correct the various pointers the code would read, but
you could not directly access any variable (as that involves
dereferencing a virtual address stored in the function's literal pool.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
