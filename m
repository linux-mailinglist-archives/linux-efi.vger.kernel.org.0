Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE717162B94
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2020 18:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgBRRJC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Feb 2020 12:09:02 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56352 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgBRRJB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Feb 2020 12:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IGz8HiBKV8GPc9x5Tjh3QfaDxcV2W+0HKrO2mldOop0=; b=XypT6y9JFaV9u8bzZaCG++ylB
        Cu86duu9a8l7bc5uSKJn2j/330y6qRRGEG50hMKoGmD+I1SiHQppg476kmXiwULsV9qaEd6rvtMY0
        Hmazy4pFgL+gtXdZGaumCi2+IScu5Fdw5/mu/fs9WdnY5XzrM5WARYf3DJ6Ks1y4F2hQdhH0YfSbr
        82zUq9NmnqWUNQuGev11Y+fWHAln3skcjDMDw43Ngyr1ANoUCDBKu6ngt5bsb1/TAvCZnSot8GunN
        EQHwjoOoR/DivUC3BFnJQT2W8LYZc46/AR7LMzKLr44OwQJuK4NOpOQpXBbTF75fJ1yeSGzFCqCPd
        bfc4YRfzg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:49580)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1j46Mj-0008TE-M3; Tue, 18 Feb 2020 17:08:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1j46Mi-0000b9-LF; Tue, 18 Feb 2020 17:08:56 +0000
Date:   Tue, 18 Feb 2020 17:08:56 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/2] ARM: decompressor: prepare cache_clean_flush for
 doing by-VA maintenance
Message-ID: <20200218170856.GL25745@shell.armlinux.org.uk>
References: <20200218164430.32671-1-ardb@kernel.org>
 <20200218164430.32671-2-ardb@kernel.org>
 <20200218165149.GK25745@shell.armlinux.org.uk>
 <CAKv+Gu_90hPPupcPCkURqBe2xFO0Zv96egytOPcqLF5XLf-rbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_90hPPupcPCkURqBe2xFO0Zv96egytOPcqLF5XLf-rbQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 18, 2020 at 05:56:52PM +0100, Ard Biesheuvel wrote:
> On Tue, 18 Feb 2020 at 17:52, Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Feb 18, 2020 at 05:44:29PM +0100, Ard Biesheuvel wrote:
> > > In preparation of turning the decompressor's cache clean/flush
> > > operations into proper by-VA maintenance for v7 cores, pass the
> > > start and end addresses of the regions that need cache maintenance
> > > into cache_clean_flush in registers r0 and r1.
> >
> > Where's the documentation of the new calling convention?  This is
> > assembly code, it needs such things documented as there's no
> > function prototypes to give that information.
> >
> 
> Would something like
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index df93c9f0a19a..e4c779a89db1 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -1207,6 +1207,9 @@ __armv7_mmu_cache_off:
>  /*
>   * Clean and flush the cache to maintain consistency.
>   *
> + * On entry,
> + *  r0 = start address
> + *  r1 = end address (exclusive)
>   * On exit,
>   *  r1, r2, r3, r9, r10, r11, r12 corrupted
>   * This routine must preserve:
> 
> work for you?

Definitely what is required, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
