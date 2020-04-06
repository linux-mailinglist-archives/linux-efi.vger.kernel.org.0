Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D859919F479
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 13:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgDFLUs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Apr 2020 07:20:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51610 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbgDFLUs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Apr 2020 07:20:48 -0400
Received: from zn.tnic (p200300EC2F04F6003429D1D3918D2B85.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:f600:3429:d1d3:918d:2b85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C73A61EC0985;
        Mon,  6 Apr 2020 13:20:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586172046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mSBY02R5H9nBmCTjq2Il3qFMSY21p0ZEMvW/qkGc8UM=;
        b=qssMpFUq4EwfQolq4WjiBir2F2H3hcsAnbGJHyAh3x+bO/QI9cBC//xIX/GoKFWynvq6dq
        AyeeGgEuBJag/3o7V78r4loh2QXbMpvFUyweVJk5AaCfF+H8tOuqGj6N/5CbGcFLWavqIn
        tsoKCrlJ6OF5kibzOlZ0cTj1L+phbVk=
Date:   Mon, 6 Apr 2020 13:20:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Sergey Shatunov <me@prok.pw>, hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Donovan Tremura <neurognostic@protonmail.ch>,
        Harald Hoyer <harald@hoyer.xyz>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Message-ID: <20200406112042.GC2520@zn.tnic>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200405154245.11972-1-me@prok.pw>
 <20200405231845.GA3095309@rani.riverdale.lan>
 <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
 <20200406035110.GA3241052@rani.riverdale.lan>
 <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
 <20200406084738.GA2520@zn.tnic>
 <CAMj1kXHAieZDvPKfjF=J+G=QVS+=XS-b4RP_=mjCEFEB_E_+Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHAieZDvPKfjF=J+G=QVS+=XS-b4RP_=mjCEFEB_E_+Qw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 06, 2020 at 11:11:21AM +0200, Ard Biesheuvel wrote:
> Yes, it is in the PE/COFF specification. [0]
> 
> The whole problem is that we are conflating 'loading a PE/COFF image'
> with 'copying a PE/COFF image into memory', which are not the same
> thing. It is not just the layout issue, we are running into other
> problems with things like UEFI secure boot and TPM-based measured
> boot, where the fact that omitting the standard LoadImage() boot
> service (which takes care of these things under the hood) means that
> you now have to do your own checks and measurements. These things are
> literally all over the place at the moment, shim, GRUB, systemd-boot
> etc, with no authoritative spec that describes which component should
> be doing what.

Sounds to me like what LoadImage() does is what the authoritative spec
should be. Perhaps we should write it down as "Do what LoadImage()
does... " and then enumerate the requirements.

> Commit ec93fc371f014a6fb483e3556061ecad4b40735c has the background, but ...

Nice, I like the aspect of letting firmware do only a minimum amount of
work. :)

> ... I'll look into updating the documentation as well.

Thanks!

> Note that this stuff is hot off the press, so there may be some issues
> lurking (like this one) that we hadn't thought of yet.

Right.

> Actually, it may be sufficient to #define __efistub_global to
> __section(.data) like we already do for ARM, to ensure that these
> global flags are always initialized correctly. (I'll wait for Sergey
> to confirm that the spurious enabling of the PCI DMA protection
> resulting from this BSS issue is causing the boot regression)

Cool, but let's not jinx it. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
