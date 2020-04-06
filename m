Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9670919F98B
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 18:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgDFQBw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Apr 2020 12:01:52 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36147 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgDFQBw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Apr 2020 12:01:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id l25so8632344qkk.3;
        Mon, 06 Apr 2020 09:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v8sY9Xkdl7Zpf9zVZC6h28QfbTQvTzqE7X+PThoReM4=;
        b=MqZtb3hME1C/jw7Y/Z8Ei7/63dsMUiVXrCQJJGb2Wn5vs9bYJSGvbgaH04f1HLKTnf
         WBhMe4uP527R4DbNStmAQTvWck7QvMLj4Ce6N49a4YOCN153ZMSIEGNGjf4b2YkDH6Ub
         eevQdIHJSjSPwUgjbNmY7Tv0A6kgVLyS4u7Gu+EcpT8VWU/PyjSWJolYuIDo28Q3d6PA
         6r79bIFXJQ1C1whIZne+HikrpeQGBerDHrSRrtthHutgGG2gT8yKKLc9Zn2X4igEFH7e
         8Aww2mp33LHk9bsZpRxfc/F01vQAcUWxR7yVe3siTbT7ImfA1jt3SDSbZRWkE5NRowzx
         /dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=v8sY9Xkdl7Zpf9zVZC6h28QfbTQvTzqE7X+PThoReM4=;
        b=KeXbMlnUtN8E3YrDd6fx1t9GzE1xxj5BEBoRsXtwj2EXgOK04lMvmGDvl4tR9CB1DF
         FManuMlTnJ/UmIHEGOjiW9BTJoiP6VQ+EJgBLm8qng7QvzTbwkTGrehFVnlZGhTr+Wel
         3zywOgPGzHpZRn3r5Bz3Ny1MOo+ZT19OrTceMXb7WIxBkeQ6lU/BP0n73naLfqvJklz5
         BEGYg3yS4OrxiVytJfNPmJ1SLbdxqXNk7meHcyBjMbAIJhOe1X2ZHmmT/Qjjjl+7xpPJ
         q7azLg5TnQfTVgbvIHabYUGmLI9+Q7RajMclWFc9U12I77mxaQzRBrR18wCy3GK9h5dd
         g97g==
X-Gm-Message-State: AGi0Pua6LfMG8WqIc/6r3hJkGn1Z7HSBJHJM7v7YyxJsdF+EsMTBEMBy
        r21EB+O2D/As+3LcFroXhcM=
X-Google-Smtp-Source: APiQypKxMNsxaiVsWaEOK9tvQ0sUTI3D+DHfY2UbWcUYsjW7uUurZJglzqKLSCLeYl7/a833O+NSjg==
X-Received: by 2002:a37:9d14:: with SMTP id g20mr7334650qke.166.1586188910814;
        Mon, 06 Apr 2020 09:01:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g10sm15356471qkb.9.2020.04.06.09.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:01:49 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 6 Apr 2020 12:01:48 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>, Sergey Shatunov <me@prok.pw>,
        hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Donovan Tremura <neurognostic@protonmail.ch>,
        Harald Hoyer <harald@hoyer.xyz>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Message-ID: <20200406160148.GB113388@rani.riverdale.lan>
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
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 06, 2020 at 03:29:18PM +0200, Ard Biesheuvel wrote:
> > >
> > > > Actually, it may be sufficient to #define __efistub_global to
> > > > __section(.data) like we already do for ARM, to ensure that these
> > > > global flags are always initialized correctly. (I'll wait for Sergey
> > > > to confirm that the spurious enabling of the PCI DMA protection
> > > > resulting from this BSS issue is causing the boot regression)
> >
> > Yeah I thought of that as the easiest fix, but it might be safer to
> > explicitly zero-init in efi_main to avoid future problems in case
> > someone adds another variable in bss and isn't aware of this obscure
> > requirement. We actually already have sys_table in bss, but that one is
> > always initialized. There's also other globals that aren't annotated
> > (but not in bss by virtue of having initializers). What do you think?
> >
> 
> *If* we zero init BSS, I'd prefer for it to be done in the EFI
> handover protocol entrypoint only. But does that fix the issue that
> BSS lives outside of the memory footprint of the kernel image?
> 

Yes, I was thinking of only doing it if we didn't come through the
pe_entry. We could also avoid re-parsing the command line if we add a
global flag to indicate that.

Regarding the memory footprint, if there's no initrd that might be a
problem, since in that case ImageSize will only cover the actual data
from the bzImage, so it would be safer to move them to data (including
sys_table).

We could just pull the stub's bss section all into data with objcopy
similar to what ARM64 does [1]? i.e. rename .bss to .bss.efistub and
then pull that into .data in the linker script for the compressed
kernel?

There is also this scary looking comment in gnu-efi's linker script:
	/* the EFI loader doesn't seem to like a .bss section, so we stick
	   it all into .data: */
I don't know what the history of that is.

[1] As an aside, why doesn't ARM do this as well rather than using the
section(.data) annotation?

> 
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
