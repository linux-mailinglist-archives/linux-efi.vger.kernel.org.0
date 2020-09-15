Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6726AE2F
	for <lists+linux-efi@lfdr.de>; Tue, 15 Sep 2020 21:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgIOTxm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Sep 2020 15:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbgIORHd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 15 Sep 2020 13:07:33 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E8E21D7D;
        Tue, 15 Sep 2020 17:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600189652;
        bh=5Fp5cfykaeDbICVYq4SbuTtTgzZPk6JnsRImME2ewcU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=inTX/tKvlO54VF3t0BSeTg2wA5xbqq0eKXacYun18OKfMNoinCeNEOZBsh+wCRc/u
         s3xSJi7ymYzOGbBDi/+379Kbw/NsFjHOyk1HBEA/iKobGgENdqtM+z6lTi3fOfSffm
         aUnthBS99zWh1dJaokhXclWh1tXXWRFH61/fEOLg=
Received: by mail-ot1-f54.google.com with SMTP id m12so3977698otr.0;
        Tue, 15 Sep 2020 10:07:32 -0700 (PDT)
X-Gm-Message-State: AOAM5310PI6II8+KldEq8UXtNbw6lpYuACAeGdavA8H0rpzTjqOwJDfi
        Qs0ev5/RYbkKzNtAUiGsjp6ihKquiJLVBAH4mMQ=
X-Google-Smtp-Source: ABdhPJz1CU09ze6xB5sb5/7jVWw9M7jXq/q/8dfK/HhwsHACCFLCYGQTKpuEO645eLtVkRe4sGRWzQRaD42Ovzmwesg=
X-Received: by 2002:a9d:6193:: with SMTP id g19mr13262833otk.108.1600189651561;
 Tue, 15 Sep 2020 10:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200819143544.155096-1-alex.kluver@hpe.com> <20200819143544.155096-2-alex.kluver@hpe.com>
 <20200915163312.GO14436@zn.tnic>
In-Reply-To: <20200915163312.GO14436@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 15 Sep 2020 20:07:19 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHmVhB88qZc-1mHAD1ovNJQnWRBncmQJTR_4+kV0fXG5w@mail.gmail.com>
Message-ID: <CAMj1kXHmVhB88qZc-1mHAD1ovNJQnWRBncmQJTR_4+kV0fXG5w@mail.gmail.com>
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

On Tue, 15 Sep 2020 at 19:33, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Aug 19, 2020 at 09:35:43AM -0500, Alex Kluver wrote:
> > Memory errors could be printed with incorrect row values since the DIMM
> > size has outgrown the 16 bit row field in the CPER structure. UEFI
> > Specification Version 2.8 has increased the size of row by allowing it to
> > use the first 2 bits from a previously reserved space within the structure.
> >
> > When needed, add the extension bits to the row value printed.
> >
> > Based on UEFI 2.8 Table 299. Memory Error Record
> >
> > Reviewed-by: Kyle Meyer <kyle.meyer@hpe.com>
> > Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
> > Tested-by: Russ Anderson <russ.anderson@hpe.com>
> > Signed-off-by: Alex Kluver <alex.kluver@hpe.com>
> > ---
> >
> > v1 -> v2:
> >    * Add static inline cper_get_mem_extension() to make it
> >     more readable, as suggested by Borislav Petkov.
> >
> >    * Add second patch for bank field, bank group, and chip id.
> >
> > ---
> >  drivers/edac/ghes_edac.c    |  8 ++++++--
> >  drivers/firmware/efi/cper.c |  9 +++++++--
> >  include/linux/cper.h        | 16 ++++++++++++++--
> >  3 files changed, 27 insertions(+), 6 deletions(-)
>
> For the EDAC bits:
>
> Acked-by: Borislav Petkov <bp@suse.de>
>
> Also, I could take both through the EDAC tree, if people prefer.
>

I'll take this via the EFI tree - I was just preparing the branch for
a PR anyways.
