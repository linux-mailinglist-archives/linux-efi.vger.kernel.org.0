Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEF5197600
	for <lists+linux-efi@lfdr.de>; Mon, 30 Mar 2020 09:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgC3HvZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Mar 2020 03:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbgC3HvY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Mar 2020 03:51:24 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC2520774
        for <linux-efi@vger.kernel.org>; Mon, 30 Mar 2020 07:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585554684;
        bh=Y8iozU+3Uxa2Bhwk87vv3a4C+Xj6+XHJpWVgFKneD3w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OG0SSX0NEbTTX+RjrsSju52zT65Alrient5Pcy7VznCyf2tnAOmJbWbPD9FFHOjQz
         qjXNdCXkSRxdy8peqmT0E5/CG9tVaBr7zhcWkzz9StuxUeW39J1A2+OYKP+d619ZbW
         VlozX+T30/3hMhj9PFAwjZOQgNFk+DuFM/ARFJ90=
Received: by mail-io1-f52.google.com with SMTP id h131so16722955iof.1
        for <linux-efi@vger.kernel.org>; Mon, 30 Mar 2020 00:51:24 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3w48oPOSk8ohxwOrJqL9zc/0rJKC6wd8wNF9JIgkGoeyGHrcYU
        7Yrw8i6PTeQw2dt4cSbibWXCquemUCqdhuiYugw=
X-Google-Smtp-Source: ADFU+vtM6+Nn+/IjEoVFqOuexbxH6OIOgiutPqTBcyosryYk8TDDw3LTxT6L93nYf9LVEPa+uut3+OR1ktd8ljcCycE=
X-Received: by 2002:a02:a1c2:: with SMTP id o2mr9476970jah.98.1585554683858;
 Mon, 30 Mar 2020 00:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200328205809.23825-1-ardb@kernel.org> <20200330074721.GV22097@bivouac.eciton.net>
 <CAMj1kXFPtY20afbAZgXT3As4TUuAqi3=pG8u19hjMjFxgN6HWA@mail.gmail.com>
In-Reply-To: <CAMj1kXFPtY20afbAZgXT3As4TUuAqi3=pG8u19hjMjFxgN6HWA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 30 Mar 2020 09:51:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEf5rT1pmDNQoOd5Tx9xQ=fUMT0xo4JXZNfz=VDY9268Q@mail.gmail.com>
Message-ID: <CAMj1kXEf5rT1pmDNQoOd5Tx9xQ=fUMT0xo4JXZNfz=VDY9268Q@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub/arm64: avoid image_base value from efi_loaded_image
To:     Leif Lindholm <leif@nuviainc.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 30 Mar 2020 at 09:50, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 30 Mar 2020 at 09:47, Leif Lindholm <leif@nuviainc.com> wrote:
> >
> > On Sat, Mar 28, 2020 at 21:58:09 +0100, Ard Biesheuvel wrote:
> > > Commit 9f9223778ef3 ("efi/libstub/arm: Make efi_entry() an ordinary
> > > PE/COFF entrypoint") did some code refactoring to get rid of the
> > > EFI entry point assembler code, and in the process, it got rid of the
> > > assignment of image_addr to the value of _text. Instead, it switched
> > > to using the image_base field of the efi_loaded_image struct provided
> > > by UEFI, which should contain the same value.
> > >
> > > However, Michael reports that this is not the case: older GRUB builds
> > > corrupt this value in some way, and since we can easily switch back to
> > > referring to _text to discover this value, let's simply do that.
> >
> > It is not clear to me how "older GRUB builds" would differ here.
> > I think more investigation is needed before making that claim.
> > My suspicion is that some (old) version of non-upstream, shim-enabled
> > distro-specific build is playing a part.
> >
> > So, do we have the option for more detailed investigations, or can we
> > vague the claim up to say "some GRUB builds seen in the wild, based
> > on an upstream 2.02" or suchlike?
> >
>
> I've queued a fix that prints a nastygram if the value deviates from
> the expected one. Let's see if this triggers any reports.

(/me looks at context)

*This* is the fix that prints a nastygram.
