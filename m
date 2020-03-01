Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412AB1750B1
	for <lists+linux-efi@lfdr.de>; Sun,  1 Mar 2020 23:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgCAW46 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 17:56:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgCAW46 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 1 Mar 2020 17:56:58 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 282B4246A1
        for <linux-efi@vger.kernel.org>; Sun,  1 Mar 2020 22:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583103417;
        bh=ZAR6DG/xIXFH+HJzLERm/+SQZhk1lgeTe9aeC06s9ho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eBemsADLLDlt89gJDdxE/T+i1S+BSUx6kBn9mE3LOhZLToYY6klh/x02jZw4reLVn
         eJNTN2IVRRG5TUdTdb3AvDsmqqUXLx2V9lX6zrQoYnfsLuRl4Bt0odzAwamfZnOCuf
         nd3w7MNmd/co+2i5B6zSkp6LtGNvLVZjVJy9iGX0=
Received: by mail-wm1-f47.google.com with SMTP id a5so9176703wmb.0
        for <linux-efi@vger.kernel.org>; Sun, 01 Mar 2020 14:56:57 -0800 (PST)
X-Gm-Message-State: APjAAAVQs+1DCrGSo0C5pJ5uPu292yraoyJLV/z+/mhwETivh7616wJJ
        EXnCG1FOI1k/W7xsNVwQ6VPRq2kkOVSNLdnp9bbbYQ==
X-Google-Smtp-Source: APXvYqw2jLDXuo/iBPjt4NV6/gY5+sgWFP5zDgH4lIkOldrhRp+HGvuS6hrRmG/nxgsyWDC+eE1m6xBIB2pszTMGzT8=
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr15926175wmj.1.1583103415601;
 Sun, 01 Mar 2020 14:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20200222155519.23550-1-ardb@kernel.org> <20200301171509.GA1845222@rani.riverdale.lan>
 <20200301172248.GA1851857@rani.riverdale.lan> <CAKv+Gu_N3vbea79CAQNZn6DmKBsKOhT9ucQYgBf0_8Pnd+vz2g@mail.gmail.com>
 <20200301200035.GA2031375@rani.riverdale.lan> <CAKv+Gu_megM4a26r8AxeVEBrDLcY202K6nEcVxQ5bAeCcDBekw@mail.gmail.com>
 <CAKv+Gu9=p8q3adeRVCbsxfoV17-SbKkeOe8Lx0OQYZAsmja+oQ@mail.gmail.com>
 <CAKv+Gu87vexrXoofKdoFNEcr_Zw1dwe6pXz3DHhJ4NGZG=8SiA@mail.gmail.com>
 <20200301205419.GA2116204@rani.riverdale.lan> <CAKv+Gu-sqC4_1ry_D1WCqraFR3bnaMegkJv9SHzXuUY7FLYs2g@mail.gmail.com>
 <20200301220126.GA2204298@rani.riverdale.lan>
In-Reply-To: <20200301220126.GA2204298@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 1 Mar 2020 23:56:44 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-zqrPSwgFAsamPQzwB_uVv8UaLZyqhOsBPb_m=FccnKg@mail.gmail.com>
Message-ID: <CAKv+Gu-zqrPSwgFAsamPQzwB_uVv8UaLZyqhOsBPb_m=FccnKg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] efi/x86: add support for generic EFI mixed mode boot
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 1 Mar 2020 at 23:01, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sun, Mar 01, 2020 at 10:36:05PM +0100, Ard Biesheuvel wrote:
> > On Sun, 1 Mar 2020 at 21:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > I see this in the memory map
> > > >
> > > > [    0.000000] efi: mem47: [Conventional Memory|   |  |  |  |  |  |  |
> > > >  |   |WB|WT|WC|UC] range=[0x0000000100000000-0x000000013fffffff]
> > > > (1024MB)
> > > >
> > > > so it looks like qemu-system-x86_64 puts the memory in a weird place?
> > > > Or is this expected?
> > >
> > > Mine ended here:
> > > [    0.000000] efi: mem45: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000ffc00000-0x00000000ffffffff] (4MB)
> > > are you running with -m 3072 or more?
> > >
> >
> > That is not memory, it's some mmio region
> >
>
> Right, but it's the last (highest) range in my memory map. It was just
> to illustrate that I have no addresses above 4Gb, unlike the mapping you
> got, although I now see that the MMIO range is the last one printed
> regardless of where RAM ends, so that wasn't quite enough. I only get
> the 4g-5g mapping range if I run it with -m 4096.
>
> This is the tail end of the mapping I got.
>
> [    0.000000] efi: mem38: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfe00000-0x00000000bfe89fff] (0MB)
> [    0.000000] efi: mem39: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfe8a000-0x00000000bfea9fff] (0MB)
> [    0.000000] efi: mem40: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfeaa000-0x00000000bfeccfff] (0MB)
> [    0.000000] efi: mem41: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfecd000-0x00000000bfed5fff] (0MB)
> [    0.000000] efi: mem42: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfed6000-0x00000000bfef3fff] (0MB)
> [    0.000000] efi: mem43: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfef4000-0x00000000bff77fff] (0MB)
> [    0.000000] efi: mem44: [ACPI Memory NVS    |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bff78000-0x00000000bfffffff] (0MB)
> [    0.000000] efi: mem45: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000ffc00000-0x00000000ffffffff] (4MB)

Looks like it's the difference in machine type - I was using q35, and
when I switch to the default, I can reproduce the early boot crash you
sent the patch for. I don't see the other issue though.
