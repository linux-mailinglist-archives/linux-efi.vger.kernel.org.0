Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7ED1A4792
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 16:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgDJOi0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 10:38:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33755 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgDJOiZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Apr 2020 10:38:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id x2so1588728qtr.0;
        Fri, 10 Apr 2020 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NqTgJgoFcWZbfgL4/2jfGGaFchCV3KhCua+Z4Yrr4+c=;
        b=hm+zyPGC2pA8P0J0T3OF281shf1QMUfPT1IN5hzlMc9i5A660/wYCUQts1ZKNuy2OH
         H78V/ckjUu0dq/QqtnGZFbe2K2rc46NMVqGbh1RCVjcI8BAoOv5E8oa1nrO9nBmYyHEL
         XkxUgV0szYQaS2hDFKinq4nTq5zFds7fVE63MmSYKRtX4utGRs8p1WLS3eraFC6awvzr
         8pRUtSkjPYKpQFqJ7Y1PailsxbbpXwJEwM336KNIW1Htmp84Gn0mNywpugFJ+ye1+sVG
         3nJA3mnoOLEPh1mdczLaCTntweattJTnaGZNPxEUczEnJ/kDJk5l1KyJm5KkOdg2eK2w
         ttKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NqTgJgoFcWZbfgL4/2jfGGaFchCV3KhCua+Z4Yrr4+c=;
        b=BaAZ1Q+MPhn5BUeq1LiXP/vjG7oJQrXAzVN2Qqsh6Baj2sXpn6D80VHbzgEDqPaR/S
         /BS9axmnQevq3LsK9KtXP+Rh70VBFbeaiqSpRuk0QuTA4f1aznG6HNBFiUDFcL88do9C
         imsyoeQPpFhX/XjO9xA1V6vQMabs6j9BU1h2YN1zhSo848VjFhXOZk8w3f880Bb2qBav
         WIYkloWLqo5j3SG57D2wbJ//EyZl7PuXFeSLtwBmV5wdKNmHuNvTTkLVOOo5CuC6hdrZ
         CTwaMeTn89VN83A3mpUe75uyXjD/dLzasxQnLXGzL7wkIzoj3uPEgHxvBzH0swcZEz/0
         aMIg==
X-Gm-Message-State: AGi0PuaZGBZDXjyKV2Ymam/7rMEpmTtDhkiE5jm6daooTEh5jLCFY1vC
        luSWteN6787+5QTdHEH0//k=
X-Google-Smtp-Source: APiQypKKRS01bxorhNYqVjDfr/jkl1Naig3EQeHWNAS87LrGoMEKiLN5XAlkjSAwd9SVuxZy3IrYvg==
X-Received: by 2002:aed:2625:: with SMTP id z34mr4669835qtc.70.1586529503527;
        Fri, 10 Apr 2020 07:38:23 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t13sm614960qkt.62.2020.04.10.07.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 07:38:22 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 10 Apr 2020 10:38:21 -0400
To:     Thomas Meyer <thomas@m3y3r.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Sergey Shatunov <me@prok.pw>,
        hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Donovan Tremura <neurognostic@protonmail.ch>,
        Harald Hoyer <harald@hoyer.xyz>
Subject: Re: [PATCH 1/2] efi/x86: Move efi stub globals from .bss to .data
Message-ID: <20200410143821.GB936997@rani.riverdale.lan>
References: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
 <20200406180614.429454-1-nivedita@alum.mit.edu>
 <20200410112605.GA3344@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200410112605.GA3344@localhost.localdomain>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 10, 2020 at 01:26:05PM +0200, Thomas Meyer wrote:
> On Mon, Apr 06, 2020 at 02:06:13PM -0400, Arvind Sankar wrote:
> 
> Hi,
> 
> I did write an email to x86@kernel.org, which sadly seems to have no
> mailing list archive, I wonder if my problem has anything to do with the
> patches you are discussing here:
> 
> I found this reply, which contains my original email in my inbox:
> 
> Subject: Kernel v5.5 doesn't boot on my x86 laptop
> 
> Hi,
> 
> I'm using an old MacBookPro1,1 to run Fedora 30 (the last one to support
> x86) and a upstream up-to-date kernel, currently 5.4.16.
> 
> I'm using sd-boot to boot into an EFI-enabled kernel which contains
> an embedded initram cpio image (because loading the image from kernel's
> EFI stub doesn't seem to work for some unknown reason, I tried to debug
> this but my early debugging foo is too weak).
> 
> Kernel 5.4.x works correctly with this setup (but resuming from disk
> seems to have broken in 5.4.x or maybe even earlier - when resuming from
> disk I get all kind of funky OOPSes/errors, but that's another story, hopefully
> 5.5.x was fixed in this regards).
> 
> So I did have a look at the commits under arch/x86/boot and "x86/boot:
> Introduce setup_indirect" (b3c72fc9a78e74161f9d05ef7191706060628f8c) did
> talk about "bump setup_header version in arch/x86/boot/header.S", so I
> did revert above commit and I was finally able to boot into v5.5 kernel!
> 
> So either sd-boot also needs an upgrade or this commit does break
> something.
> Any help is welcome, don't hesitate to get in contact with me if you
> have any questions.
> 
> mfg
> thomas
>  

If it is a problem with 5.5, it would be unrelated to this thread, which
is about problems introduced by patches for the upcoming 5.7.

Thanks.
