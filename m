Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB22D19F6CD
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 15:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgDFNWT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Apr 2020 09:22:19 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40582 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgDFNWS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Apr 2020 09:22:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id y25so12736061qtv.7;
        Mon, 06 Apr 2020 06:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cuhjb+a9vABf0xMYhIXhtlft1e/hgk3xK+XP54N7ens=;
        b=sJzMZufcD34AmiyiMprFJO0RFheJcLI4hyj6FwC+Nj7e0iIU15QOznCGvz5MOFuRQd
         Q3XUDXrjd9vzgPVSQqV2ruw+LDckTqbR5t8UxdpWE6zCqKDPE9SF2rGOYsfW/0qB2K37
         WefY6hCzrEmRb4t+XLEXV/uxe8zsYNA2EBY+ZV88HEusUxVwcXTFz12pS+O2Dmph0Cm7
         Hl3Moy5a+2/FfVnahvtgNTt5p0G/ZT/uMAMCOqwWQgJmKPGRm0W5Yljugi1BJodcp0qi
         ROdXgM7s6DHFfHDe65AAFyRnd6NG+Xve6w8kggsG2lbjj0YoC/tHLXsKAt5krgcDa16l
         53AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cuhjb+a9vABf0xMYhIXhtlft1e/hgk3xK+XP54N7ens=;
        b=ZBatNGsGHB48MuYWry69HVF04PUNuZQf51V3YvSYVWPCRt99wk2EVYGbv5muJML/aZ
         daxh3293vX2bEtUrla5JxJlR/0Q/kF5h0MWY6Rd6Ij5dPm/7JqAv1Ft9jG3qQZXXZu/2
         pkcWCZTcMWvQXPkPpFC5514zkLHzwXXo0bLjFdrTrR0qJqAmt9k7h6RTgpk/brfMJ2WJ
         Ii+ZvQH7qAD39nJUSeJxTdGx9XwSdl+xXW3EswhL96JTuNgtr8iawkPefGu2LJIZXfYe
         QltjDx7uwQWg48HMe4xu+rweIz7yGbx/oebEYsRUe6UC5sG6OTfJvmrcWyYUSto4/Zyb
         NPzw==
X-Gm-Message-State: AGi0PuZuVo7hLPgv8S1DHTqSEuyX9Jh5CB3DHAQXUcnplBOYazN+/Sxc
        1tkp8XYcIHtTreNWdmfK2lg=
X-Google-Smtp-Source: APiQypJkNNDNbGckSvNXDGUJp5nz2ma3aJvvAsdXKUmeZQcZGIZMZ7/kd70KM7NyMhqsErkUMNffAg==
X-Received: by 2002:ac8:4f43:: with SMTP id i3mr20739565qtw.102.1586179337510;
        Mon, 06 Apr 2020 06:22:17 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o18sm6895029qkk.52.2020.04.06.06.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 06:22:16 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 6 Apr 2020 09:22:15 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Sergey Shatunov <me@prok.pw>, hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Donovan Tremura <neurognostic@protonmail.ch>,
        Harald Hoyer <harald@hoyer.xyz>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Message-ID: <20200406132215.GA113388@rani.riverdale.lan>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200405154245.11972-1-me@prok.pw>
 <20200405231845.GA3095309@rani.riverdale.lan>
 <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
 <20200406035110.GA3241052@rani.riverdale.lan>
 <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
 <20200406084738.GA2520@zn.tnic>
 <CAMj1kXHAieZDvPKfjF=J+G=QVS+=XS-b4RP_=mjCEFEB_E_+Qw@mail.gmail.com>
 <20200406112042.GC2520@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406112042.GC2520@zn.tnic>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 06, 2020 at 01:20:42PM +0200, Borislav Petkov wrote:
> On Mon, Apr 06, 2020 at 11:11:21AM +0200, Ard Biesheuvel wrote:
> > Yes, it is in the PE/COFF specification. [0]
> > 
> > The whole problem is that we are conflating 'loading a PE/COFF image'
> > with 'copying a PE/COFF image into memory', which are not the same
> > thing. It is not just the layout issue, we are running into other
> > problems with things like UEFI secure boot and TPM-based measured
> > boot, where the fact that omitting the standard LoadImage() boot
> > service (which takes care of these things under the hood) means that
> > you now have to do your own checks and measurements. These things are
> > literally all over the place at the moment, shim, GRUB, systemd-boot
> > etc, with no authoritative spec that describes which component should
> > be doing what.
> 
> Sounds to me like what LoadImage() does is what the authoritative spec
> should be. Perhaps we should write it down as "Do what LoadImage()
> does... " and then enumerate the requirements.
> 
> > Commit ec93fc371f014a6fb483e3556061ecad4b40735c has the background, but ...
> 
> Nice, I like the aspect of letting firmware do only a minimum amount of
> work. :)
> 
> > ... I'll look into updating the documentation as well.
> 
> Thanks!
> 
> > Note that this stuff is hot off the press, so there may be some issues
> > lurking (like this one) that we hadn't thought of yet.
> 
> Right.
> 
> > Actually, it may be sufficient to #define __efistub_global to
> > __section(.data) like we already do for ARM, to ensure that these
> > global flags are always initialized correctly. (I'll wait for Sergey
> > to confirm that the spurious enabling of the PCI DMA protection
> > resulting from this BSS issue is causing the boot regression)

Yeah I thought of that as the easiest fix, but it might be safer to
explicitly zero-init in efi_main to avoid future problems in case
someone adds another variable in bss and isn't aware of this obscure
requirement. We actually already have sys_table in bss, but that one is
always initialized. There's also other globals that aren't annotated
(but not in bss by virtue of having initializers). What do you think?

What do you think of the other problem -- that's actually worse to fix,
as it won't just be when kaslr is disabled, the startup_64 code will do
relocation to the end of init_size and clobber the initrd before getting
to the kaslr code, so it will break as soon as the firmware loads the
"unified kernel image" at a 2Mb-aligned address. The only thing I can
think of is to just unconditionally call efi_relocate_kernel if we were
entered via handover_entry?

> 
> Cool, but let's not jinx it. :-)
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
