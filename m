Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF701750B9
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 00:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgCAXDt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 18:03:49 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37958 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgCAXDt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 18:03:49 -0500
Received: by mail-qv1-f68.google.com with SMTP id g16so4040415qvz.5
        for <linux-efi@vger.kernel.org>; Sun, 01 Mar 2020 15:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ZqOPNFVfLyDHzJ0hvD2e4l57CrAH4FTvWsQKCR5ohA=;
        b=kTxAwJzSklvSvq/nUy/YQfbd/mMZHwipTDFPRco5V/t8ey5IBqsgFwrF0fH7WNm6sN
         V8WdYQvrmu+H1o06Fetxc0wpdQVtW7W+jsO7bIoj97+trFcpRCslI99E+aJI+KZIH11B
         5ZOUKLh02LL3J1YzhuSW8Y7+8GC4BJQcHDLtXOATvEA8pxwIALJZvLOSVXOMMtQzShs8
         daDIv29ZDwNyzPFA8FE9oYUnSwGnjy2LndnFePSALEYrTqWXhzNfepDtir7IU1brDXgB
         HlaHXbXLulSHL4ttHNxsatBqJSgt5RpvZTG/Rjf00nrWJcKcWTNt5oNXIeKP0ZwARyEU
         JIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ZqOPNFVfLyDHzJ0hvD2e4l57CrAH4FTvWsQKCR5ohA=;
        b=efX0eifBrMK7p2GTz0/QN8q1flE9bCQk8VnvKSBhaqSOn2IFPuvPwJNsZ41WiwryQL
         bM2HQaVJQiCob8MMO+Ct4GkxlqjrZ2JFvG1+HhRaFhU4Wol92fKxYWF+1oiENuehyKZg
         9FMx05DxMolHFfynDz8Bqo6GzZGN9w43N6e8l2MDQhFecON7QiZSxCsFDXOWoB0BZYQW
         oxHa8chRvKlPmCBB/aYIIFFK5e7RvPpwIGmJrtMON/Jlpyz3br2Gm2M6b2qVzgGg9Zmr
         OH8nQUSLUupdxTPMMVDNcZYEtMf7ir4aH350YsU2hcd0NUY+lrCXnT3ByjJYskbYhTAa
         dmhw==
X-Gm-Message-State: APjAAAVl/R1dtQmZby/NZ8GoajD5bKIvSPwyIb4ET+lhlfW0E0CK/0Fn
        Kex1mc7J60SjLx8cgvOTUXo=
X-Google-Smtp-Source: APXvYqyA8A2GhICZCGZWIiOGJH21THK7AFhzUpCMw5Arjk8kuJz7sKOQkv5tZQNmislLJDkcAVowVg==
X-Received: by 2002:a0c:f6c8:: with SMTP id d8mr13070939qvo.234.1583103828249;
        Sun, 01 Mar 2020 15:03:48 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e88sm1724022qtd.9.2020.03.01.15.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:03:47 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 1 Mar 2020 18:03:46 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 0/6] efi/x86: add support for generic EFI mixed mode
 boot
Message-ID: <20200301230345.GA2227739@rani.riverdale.lan>
References: <20200301172248.GA1851857@rani.riverdale.lan>
 <CAKv+Gu_N3vbea79CAQNZn6DmKBsKOhT9ucQYgBf0_8Pnd+vz2g@mail.gmail.com>
 <20200301200035.GA2031375@rani.riverdale.lan>
 <CAKv+Gu_megM4a26r8AxeVEBrDLcY202K6nEcVxQ5bAeCcDBekw@mail.gmail.com>
 <CAKv+Gu9=p8q3adeRVCbsxfoV17-SbKkeOe8Lx0OQYZAsmja+oQ@mail.gmail.com>
 <CAKv+Gu87vexrXoofKdoFNEcr_Zw1dwe6pXz3DHhJ4NGZG=8SiA@mail.gmail.com>
 <20200301205419.GA2116204@rani.riverdale.lan>
 <CAKv+Gu-sqC4_1ry_D1WCqraFR3bnaMegkJv9SHzXuUY7FLYs2g@mail.gmail.com>
 <20200301220126.GA2204298@rani.riverdale.lan>
 <CAKv+Gu-zqrPSwgFAsamPQzwB_uVv8UaLZyqhOsBPb_m=FccnKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-zqrPSwgFAsamPQzwB_uVv8UaLZyqhOsBPb_m=FccnKg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Mar 01, 2020 at 11:56:44PM +0100, Ard Biesheuvel wrote:
> On Sun, 1 Mar 2020 at 23:01, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Sun, Mar 01, 2020 at 10:36:05PM +0100, Ard Biesheuvel wrote:
> > > On Sun, 1 Mar 2020 at 21:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > I see this in the memory map
> > > > >
> > > > > [    0.000000] efi: mem47: [Conventional Memory|   |  |  |  |  |  |  |
> > > > >  |   |WB|WT|WC|UC] range=[0x0000000100000000-0x000000013fffffff]
> > > > > (1024MB)
> > > > >
> > > > > so it looks like qemu-system-x86_64 puts the memory in a weird place?
> > > > > Or is this expected?
> > > >
> > > > Mine ended here:
> > > > [    0.000000] efi: mem45: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000ffc00000-0x00000000ffffffff] (4MB)
> > > > are you running with -m 3072 or more?
> > > >
> > >
> > > That is not memory, it's some mmio region
> > >
> >
> > Right, but it's the last (highest) range in my memory map. It was just
> > to illustrate that I have no addresses above 4Gb, unlike the mapping you
> > got, although I now see that the MMIO range is the last one printed
> > regardless of where RAM ends, so that wasn't quite enough. I only get
> > the 4g-5g mapping range if I run it with -m 4096.
> >
> > This is the tail end of the mapping I got.
> >
> > [    0.000000] efi: mem38: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfe00000-0x00000000bfe89fff] (0MB)
> > [    0.000000] efi: mem39: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfe8a000-0x00000000bfea9fff] (0MB)
> > [    0.000000] efi: mem40: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfeaa000-0x00000000bfeccfff] (0MB)
> > [    0.000000] efi: mem41: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfecd000-0x00000000bfed5fff] (0MB)
> > [    0.000000] efi: mem42: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfed6000-0x00000000bfef3fff] (0MB)
> > [    0.000000] efi: mem43: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfef4000-0x00000000bff77fff] (0MB)
> > [    0.000000] efi: mem44: [ACPI Memory NVS    |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bff78000-0x00000000bfffffff] (0MB)
> > [    0.000000] efi: mem45: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000ffc00000-0x00000000ffffffff] (4MB)
> 
> Looks like it's the difference in machine type - I was using q35, and
> when I switch to the default, I can reproduce the early boot crash you
> sent the patch for. I don't see the other issue though.

So you can boot successfully without hanging in SetVirtualAddressMap?
Weird. I'm using QEMU 4.2.0 in case that matters.
