Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBEA419FACF
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 18:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgDFQwr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Apr 2020 12:52:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43800 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbgDFQwr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Apr 2020 12:52:47 -0400
Received: by mail-qk1-f193.google.com with SMTP id 13so4623285qko.10;
        Mon, 06 Apr 2020 09:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kUFTINxY0J+AJDEkYeQlbkaSmRAtfjNqncCfu7j55wA=;
        b=dKSpNuaATcx3mYuSOs8e3rofkdfCBjXOXmBkGKcgji8SN8Nyy16u2sLNbQHa6UG/jd
         XpkAAcOgoeKOKrDIWeXKpLIF6IiSF9f7TY4fsKad6fyvJBzBE278OR3lGk9lZUWd/2MO
         RrOjYbqPURYyUneDXBAX5AioJ3rmolf3d49KjfiKXTC9Msm06SxLurypqPoShifEziw6
         MgNI+1I0LRKVf/lZkf4A6IOBmVVxw80B7NF+PIK8GPQeUj94YVN56kngTdI7UsohGORy
         nGB8FEsNYUnxkvQ+CFBYTzkBIKhSoBdU1MTEE4KRTwC4uldNU+TDm4meep/5AcnItHzn
         vw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kUFTINxY0J+AJDEkYeQlbkaSmRAtfjNqncCfu7j55wA=;
        b=cPCgeD7dYRa6r0dct0ERlSqetEEk+0SYoh+9q1cAJuEziWaYtG7a+CFR9v9UUFLQdz
         3f1gd+uqwvJA7sqis6leZn67vkz7L9khYVIAXjh3gZz3vvBwxEqMcoNryni5K7DY5vOV
         QDrSSXJBKOgKNby4SqZx4dxfA9/j6ZPXpnNyFtLFDEZ0IXAqnRdbDERnCSd6ID4sTqkw
         X0iZp9Vfi1YaCFw6ZRjLjuX4NZX3xCYk9pEWh9NOpC0dhBuLNPf72y9WjynqQaA5P/3D
         0MaZYmGthsvDHsWYCaA0fR93laDBp0SAFVd/wWsvVu1GWyheG9VmjP1C9wXt+gbIQn8q
         oIJA==
X-Gm-Message-State: AGi0Pubif5J3KSTD/LJwn1DWF5kyaY1yzd36vPCou/JRNmvb2z4GS47q
        Jt3HRp0jOfsyrfZRUrkv0nE=
X-Google-Smtp-Source: APiQypLG+N0+0eHCnvXI+vRC+MTlszBZR60uTTpgG8AhX3Uzt/8vd2aBAE3kfyMkNz/uyR0az++i3Q==
X-Received: by 2002:a37:5903:: with SMTP id n3mr22753933qkb.332.1586191965924;
        Mon, 06 Apr 2020 09:52:45 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t23sm16047838qtj.63.2020.04.06.09.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:52:45 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 6 Apr 2020 12:52:43 -0400
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
Message-ID: <20200406165243.GA303819@rani.riverdale.lan>
References: <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
 <20200406035110.GA3241052@rani.riverdale.lan>
 <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
 <20200406084738.GA2520@zn.tnic>
 <CAMj1kXHAieZDvPKfjF=J+G=QVS+=XS-b4RP_=mjCEFEB_E_+Qw@mail.gmail.com>
 <20200406112042.GC2520@zn.tnic>
 <20200406132215.GA113388@rani.riverdale.lan>
 <CAMj1kXG+34-bK1XuxX5VopkRt1SV1ewUAEmif+aQj5cJQ=9vbA@mail.gmail.com>
 <20200406160148.GB113388@rani.riverdale.lan>
 <CAMj1kXFKDWB9n0kWhXHLH0XP0O1v_0b=bFJad=kBvx2qVxqDcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFKDWB9n0kWhXHLH0XP0O1v_0b=bFJad=kBvx2qVxqDcQ@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 06, 2020 at 06:22:33PM +0200, Ard Biesheuvel wrote:
> 
> > We could just pull the stub's bss section all into data with objcopy
> > similar to what ARM64 does [1]? i.e. rename .bss to .bss.efistub and
> > then pull that into .data in the linker script for the compressed
> > kernel?
> >
> 
> I don't follow. I'm not aware of arm64 doing anything out of the
> ordinary with .bss? Note that arm64 does not have a separate
> decompressor, so the EFI stub is part of the kernel proper. This is
> why sections are renamed to start with .init

ARM64 renames the stub sections prefixing them with .init, and that
includes .bss. The ARM64 linker script then puts .init.bss into the
.init.data section. So I was suggesting doing something similar with the
x86 stub, renaming .bss to .bss.efistub, and then putting that into
.data via linker script.

Anyway, I'll do the section annotation for now as that will be less
churn and we can revisit this after that.

> 
> > There is also this scary looking comment in gnu-efi's linker script:
> >         /* the EFI loader doesn't seem to like a .bss section, so we stick
> >            it all into .data: */
> > I don't know what the history of that is.
> >
> 
> I don't remember, to be honest, but I'm pretty sure I copy-pasted that
> from elsewhere at the time.
> 
> > [1] As an aside, why doesn't ARM do this as well rather than using the
> > section(.data) annotation?
> >
> 
> The ARM decompressor has this hideous hack, where text [and rodata]
> executes straight from flash, and BSS is relocated into DRAM. In order
> for this to work, it actually *requires* GOT indirections for BSS
> items, to ensure that all BSS references use absolute addresses, which
> can be relocated independently from the rest of the kernel image. This
> is the reason ARM does not permit a .data section in the decompressor.
> However, the EFI stub does not support execute in place from flash,
> and so we can permit a .data section there. At the same time, we don't
> support GOT indirections in the EFI stub, so we cannot use the BSS
> section. So instead, we just put the few BSS pieces we have into .data
> instead.
> 

I see, thanks.
