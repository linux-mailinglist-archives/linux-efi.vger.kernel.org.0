Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5824A19FB4D
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 19:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgDFRVI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Apr 2020 13:21:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49906 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbgDFRVI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Apr 2020 13:21:08 -0400
Received: from zn.tnic (p200300EC2F04F600C1A00E803BF5BF5B.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:f600:c1a0:e80:3bf5:bf5b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EECE81EC0CDB;
        Mon,  6 Apr 2020 19:21:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586193667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SvlsLYjk7+N+Zi3Q2er0ZEj5L9OiCRt8VPcz7ScDZKE=;
        b=mfypNZvvlyY+r+up9ukE9DGjblAgXh2d30KFKbtusE5t1QOSN8uHnxvS6f0NExmxrAj7cY
        fdeOi/I5GNxEg2h/n4TBzcJe6muphSe662lGoK7/wC8xUyqebdUuwvzbX+Rrr5M+l+aDVs
        2RkQ8rhtcnNd25eNI8HzVWqZeQV98ts=
Date:   Mon, 6 Apr 2020 19:21:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Sergey Shatunov <me@prok.pw>, hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Donovan Tremura <neurognostic@protonmail.ch>,
        Harald Hoyer <harald@hoyer.xyz>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Message-ID: <20200406172102.GF2520@zn.tnic>
References: <20200405154245.11972-1-me@prok.pw>
 <20200405231845.GA3095309@rani.riverdale.lan>
 <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
 <20200406035110.GA3241052@rani.riverdale.lan>
 <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
 <20200406084738.GA2520@zn.tnic>
 <CAMj1kXHAieZDvPKfjF=J+G=QVS+=XS-b4RP_=mjCEFEB_E_+Qw@mail.gmail.com>
 <20200406112042.GC2520@zn.tnic>
 <20200406132215.GA113388@rani.riverdale.lan>
 <CAMj1kXG+34-bK1XuxX5VopkRt1SV1ewUAEmif+aQj5cJQ=9vbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXG+34-bK1XuxX5VopkRt1SV1ewUAEmif+aQj5cJQ=9vbA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 06, 2020 at 03:29:18PM +0200, Ard Biesheuvel wrote:
> > What do you think of the other problem -- that's actually worse to fix,
> > as it won't just be when kaslr is disabled, the startup_64 code will do
> > relocation to the end of init_size and clobber the initrd before getting
> > to the kaslr code, so it will break as soon as the firmware loads the
> > "unified kernel image" at a 2Mb-aligned address. The only thing I can
> > think of is to just unconditionally call efi_relocate_kernel if we were
> > entered via handover_entry?
> >
> 
> Yes, that seems to be the most robust approach.

The commit in question is this one:

d5cdf4cfeac9 ("efi/x86: Don't relocate the kernel unless necessary")

I presume?

I'm guessing it can simply be reverted as it doesn't fix a bug but it is
just an optimization... provided I'm not missing something, of course.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
