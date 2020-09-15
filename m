Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B9926AA48
	for <lists+linux-efi@lfdr.de>; Tue, 15 Sep 2020 19:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgIORPy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Sep 2020 13:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgIORPe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 15 Sep 2020 13:15:34 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B09820936;
        Tue, 15 Sep 2020 17:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600189962;
        bh=StDm87/zyOd2umJ/sexVghFCRbZDPQt3dL4BEakYh40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GzcLW9Y77a4vDzQijYHwWGzMS+XnNp0YArQ3N9OD55f1SyTYjZ7GCxlE1fq1cr35O
         8e1+K+v8r+oMkaCF+f4E7f7MpT80Dlw1UbjGvDhNKM+fSH/WIs0fXqVB2TInUNo109
         1Qtz+MdBfF2WHY94jZxG7VAMma+cV5xguhDnkLwU=
Received: by mail-oi1-f176.google.com with SMTP id a3so4734107oib.4;
        Tue, 15 Sep 2020 10:12:42 -0700 (PDT)
X-Gm-Message-State: AOAM531p6fe45OCYN3yUJjHAl4qVLe0ZswI9jB7wr7Oc4xWRuMiCeIcO
        wRtupMzBkBm+5XLLM3cMVOidUqieYvFGp6rMSko=
X-Google-Smtp-Source: ABdhPJwphFyJiA6ONEAftklqagXUydttPtaS/St/C72DhZIjAxdr6tPs+g71Yc+C35YTfy4TfqaIa+nI1jOWU5h5I1w=
X-Received: by 2002:aca:d845:: with SMTP id p66mr274454oig.47.1600189961908;
 Tue, 15 Sep 2020 10:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200819143544.155096-1-alex.kluver@hpe.com> <20200819143544.155096-2-alex.kluver@hpe.com>
 <20200915163312.GO14436@zn.tnic> <CAMj1kXHmVhB88qZc-1mHAD1ovNJQnWRBncmQJTR_4+kV0fXG5w@mail.gmail.com>
In-Reply-To: <CAMj1kXHmVhB88qZc-1mHAD1ovNJQnWRBncmQJTR_4+kV0fXG5w@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 15 Sep 2020 20:12:31 +0300
X-Gmail-Original-Message-ID: <CAMj1kXGvfiqZz-j5=LU0Z6yYCkr24pCz6aJS62QL8cBYUP_S=w@mail.gmail.com>
Message-ID: <CAMj1kXGvfiqZz-j5=LU0Z6yYCkr24pCz6aJS62QL8cBYUP_S=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] edac,ghes,cper: Add Row Extension to Memory Error Record
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alex Kluver <alex.kluver@hpe.com>, linux-edac@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mchehab@kernel.org, russ.anderson@hpe.com,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        kluveralex@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 15 Sep 2020 at 20:07, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 15 Sep 2020 at 19:33, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Wed, Aug 19, 2020 at 09:35:43AM -0500, Alex Kluver wrote:
> > > Memory errors could be printed with incorrect row values since the DIMM
> > > size has outgrown the 16 bit row field in the CPER structure. UEFI
> > > Specification Version 2.8 has increased the size of row by allowing it to
> > > use the first 2 bits from a previously reserved space within the structure.
> > >
> > > When needed, add the extension bits to the row value printed.
> > >
> > > Based on UEFI 2.8 Table 299. Memory Error Record
> > >
> > > Reviewed-by: Kyle Meyer <kyle.meyer@hpe.com>
> > > Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
> > > Tested-by: Russ Anderson <russ.anderson@hpe.com>
> > > Signed-off-by: Alex Kluver <alex.kluver@hpe.com>
> > > ---
> > >
> > > v1 -> v2:
> > >    * Add static inline cper_get_mem_extension() to make it
> > >     more readable, as suggested by Borislav Petkov.
> > >
> > >    * Add second patch for bank field, bank group, and chip id.
> > >
> > > ---
> > >  drivers/edac/ghes_edac.c    |  8 ++++++--
> > >  drivers/firmware/efi/cper.c |  9 +++++++--
> > >  include/linux/cper.h        | 16 ++++++++++++++--
> > >  3 files changed, 27 insertions(+), 6 deletions(-)
> >
> > For the EDAC bits:
> >
> > Acked-by: Borislav Petkov <bp@suse.de>
> >
> > Also, I could take both through the EDAC tree, if people prefer.
> >
>
> I'll take this via the EFI tree - I was just preparing the branch for
> a PR anyways.

Alex - these patches do not apply cleanly. Could you please respin
them on top of the next branch in
https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git?

Boris - do you anticipate any conflicts? If so, please take these via
the EDAC tree - the CPER code is mostly self contained so I don't
expect any conflicts with the EFI tree in that case.
