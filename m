Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52713178B69
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 08:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgCDHae (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 02:30:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbgCDHae (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 02:30:34 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64AAB215A4
        for <linux-efi@vger.kernel.org>; Wed,  4 Mar 2020 07:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583307033;
        bh=yXbKC32hYikH+Y6iOqAYkto1iApXG/+ZDVtzPLhDxcM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y+HgJ+wYB6OSCDkLnFFEek3HeTlHH3bkbpiY6/Ecqw6Pqk/usPp4OMy03jycvy2Ul
         So/KPp2c5swCclMeWn3cE9Y08g69jscXXWaqPC0lf5M/1o47R3TvmZyMHKsIn0BlRc
         cPL9kJjWXlYCBpeUZr1uOmI54aemLo3lFJ0Ggms0=
Received: by mail-wm1-f50.google.com with SMTP id g134so720381wme.3
        for <linux-efi@vger.kernel.org>; Tue, 03 Mar 2020 23:30:33 -0800 (PST)
X-Gm-Message-State: ANhLgQ20kh8t50pjzoV4bePx+syMToW6iCANhjm5h0UO+BUPN4dRWDtv
        w3Y7HPGp7TCtW8OhBkDptgj6qeCa2HKAG6qIoq3zmg==
X-Google-Smtp-Source: ADFU+vtLuCOHLk82GA40C/ISCavxvNKBN90/osmseO1/AgH6pFIZrGWN4o3Fj4A2Ssy4f1YSOZnnATZ1Rdd30VKp7zg=
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr2129718wmj.1.1583307031690;
 Tue, 03 Mar 2020 23:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20200301230537.2247550-1-nivedita@alum.mit.edu>
 <20200303221205.4048668-1-nivedita@alum.mit.edu> <20200303221205.4048668-6-nivedita@alum.mit.edu>
 <CAKv+Gu9LON5SeJ7UMTeHxP1OcSkz_eGGunpXx_csjh_fp1PhDA@mail.gmail.com> <20200303233457.GA154112@rani.riverdale.lan>
In-Reply-To: <20200303233457.GA154112@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 08:30:20 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9GLik3VZBZg8VQKFBs3GtV+QB7KQSVfiKcCNtyYjW0XQ@mail.gmail.com>
Message-ID: <CAKv+Gu9GLik3VZBZg8VQKFBs3GtV+QB7KQSVfiKcCNtyYjW0XQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] efi/x86: Don't relocate the kernel unless necessary
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Mar 2020 at 00:35, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Mar 04, 2020 at 12:08:33AM +0100, Ard Biesheuvel wrote:
> > On Tue, 3 Mar 2020 at 23:12, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > Add alignment slack to the PE image size, so that we can realign the
> > > decompression buffer within the space allocated for the image.
> > >
> > > Only relocate the kernel if it has been loaded at an unsuitable address:
> > > * Below LOAD_PHYSICAL_ADDR, or
> > > * Above 64T for 64-bit and 512MiB for 32-bit
> > >
> > > For 32-bit, the upper limit is conservative, but the exact limit can be
> > > difficult to calculate.
> > >
> >
> > Could we get rid of the call to efi_low_alloc_above() in
> > efi_relocate_kernel(), and just allocate top down with the right
> > alignment? I'd like to get rid of efi_low_alloc() et al if we can.
> >
>
> But we don't have a top-down allocator, do we? ALLOCATE_MAX_ADDRESS
> guarantees the maximum, but it doesn't guarantee that you'll be as high
> as possible.

Good point. We do have a top-down allocator in practice, but it is not
guaranteed by the API.
