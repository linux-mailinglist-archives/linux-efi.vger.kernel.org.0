Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98403174824
	for <lists+linux-efi@lfdr.de>; Sat, 29 Feb 2020 17:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgB2Qur (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Feb 2020 11:50:47 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33670 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgB2Qur (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Feb 2020 11:50:47 -0500
Received: by mail-qt1-f195.google.com with SMTP id x8so2316941qts.0;
        Sat, 29 Feb 2020 08:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qukwWikGcINxLygrM52wRnkiMQepoX66/gICPazqEbw=;
        b=WkF9xsc3RCvW89Rdb8UnqX8NATmcWDcQuHsevc3f8UW2bQ2qH2s4ST7k/39ipav6BI
         uDdY3u28Wtabsn4tY6ES19oG19ZlmrmSayYFwpOF0X1C6tpnQQJqMkPCTi/jJew3a5re
         AQdh5fTJIvJSVX3d3fRq524/awTsKbVnEcXUux3vaVLi9ZjyBKEOTygGDY8d9IExqLOE
         BY8RmArtKcsvkWeMy33BrPnGHjkWdyAsOc7JRwCWoo5xkfm221BUOuX1zd7aVZp0ca2h
         5/PL9PJ0tjv620D4I7o+naYWpb0bgdjHeV4BvvIfFT1TsCetY68Ce9vHfPKFI00HvY1B
         IA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qukwWikGcINxLygrM52wRnkiMQepoX66/gICPazqEbw=;
        b=gAxwbnzgP1216aWvkfn8eOQUskqaMUO6U/FGYlz1sA7MwVDYP7TuYlG4tNcL8k4cgR
         PkQwxgWtdoNdYOTJbssKrGIzMDLIEJ8OOyLWU42F/EfbJLJhrYwI+83wBOCouLj3rQwF
         jRuFwPf0e5zTkH74nc6+wHsOsAjikMJCC8XPtGiFyYDfJzsjfE/nbI1YaDkem9YpDsS1
         P+Zpnl7Q8uzLtULp/YAJZjd25eOAm6lDYHvz09pj3R6PWo0p7s1RyyIxcIRXqirS2IGr
         J7BAbE8CYfBLRWjAzzlu8oYTm6xjJ3odFfz1y7hWIiDRkgf4oOTI5s5wy770s2qKnsSL
         kxOw==
X-Gm-Message-State: APjAAAX6EGPPox+ljfDVQnEeTsdx98Sx/x8aMSzaL4gfYb0vJ7CiOGOm
        llrRagnrsqCKgDkuMw66rALPxXdI2Fw=
X-Google-Smtp-Source: APXvYqy8G8TCNGPr1To3wkltVQhap17PH7rYo9xy6m1uhA/V3fEZkrNsvoYRyCBfWU3W0Zmdy/RdlA==
X-Received: by 2002:aed:24b2:: with SMTP id t47mr8856120qtc.337.1582995046272;
        Sat, 29 Feb 2020 08:50:46 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x34sm2776166qta.82.2020.02.29.08.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 08:50:45 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 29 Feb 2020 11:50:44 -0500
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/1] x86/boot/compressed: Fix reloading of GDTR
 post-relocation
Message-ID: <20200229165043.GA703247@rani.riverdale.lan>
References: <20200226204515.2752095-1-nivedita@alum.mit.edu>
 <20200226230031.3011645-2-nivedita@alum.mit.edu>
 <20200227081229.GA29411@gmail.com>
 <20200227151643.GA3498170@rani.riverdale.lan>
 <CAKv+Gu8BiW6P6Xv3EAPUEmbS3GQMJW=eRr-yygRbForaGDQyyw@mail.gmail.com>
 <20200227155421.GA3507597@rani.riverdale.lan>
 <CAKv+Gu-k0c8GzKysv4Z9tYzEvfhJUzuiKx5nfwD0JU8ys=LZdg@mail.gmail.com>
 <20200227180305.GA3598722@rani.riverdale.lan>
 <20200229092425.GB92847@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200229092425.GB92847@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Feb 29, 2020 at 10:24:25AM +0100, Ingo Molnar wrote:
> 
> * Arvind Sankar <nivedita@alum.mit.edu> wrote:
> 
> > On Thu, Feb 27, 2020 at 06:47:55PM +0100, Ard Biesheuvel wrote:
> > > 
> > > Interesting. I am going to rip most of the EFI handover protocol stuff
> > > out of OVMF, since it is mostly unnecessary, and having the PE/COFF
> > > loader put the image in the correct place right away is a nice
> > > complimentary improvement to that. (Note that the OVMF implementation
> > > of the EFI handover protocol does not currently honor the preferred
> > > address from the setup header anyway)
> > 
> > Yeah, for my testing I'm running the image from the EFI shell, which
> > enters via PE entry point and honors the pref address.
> 
> So with KASLR, which is the distro default on most x86 distros, we'll 
> relocate the kernel to another address anyway, right?
> 
> But telling the bootloader the preferred address would avoid any 
> relocation overhead even in this case, right?
> 
> Thanks,
> 
> 	Ingo

If I understand correctly, pref_address was added to try to avoid having
to apply the relocations (vmlinux.relocs) by loading at the link-time
address if possible, and you're saying that with KASLR, we have to do
relocations anyway; and without KASLR the bootloader knows the preferred
address from the setup header already?

The patch I'm working on is meant to address the case when we are loaded
via the EFI LoadImage service, which is a generic PE loader, and hence
doesn't look at the pref_address in the setup header. We currently will
end up with at least 2 copies of the kernel, with 1 additional copy if
KASLR is enabled. The loader puts us somewhere, the EFI stub then makes
a copy trying to move us to pref_address, and then KASLR will allocate
an additional copy (not really a copy, but a buffer of the same size to
decompress into). By telling the PE loader what the preferred address is
I'm trying to avoid the EFI stub creating an additional copy, so we'll
have 1 copy, or 2 with KASLR.

That was the original motivation for the patch. As I've been working on
it, I'm thinking that the copy in the EFI stub can be avoided in more
cases.

AFAICT, pref_address is completely irrelevant on 64-bit, which will have
relocations applied only if KASLR is enabled and changes the virtual
address, but it never cares what physical address it's running out of.
It only requires being above LOAD_PHYSICAL_ADDR and below 2^46 or 2^52.
All we need to do is align the decompression buffer correctly.

For 32-bit, loading at pref_address can avoid relocations being applied,
but if we're not already loaded there in the first place, trying to
allocate a new buffer and copying the whole image is probably not worth
it. It does have more restrictions on physical addresses in that it
can't run at too high a physical address, so it may still be necessary
to relocate to avoid that.

Thanks.
