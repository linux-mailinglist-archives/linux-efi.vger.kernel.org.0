Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 794B9E6E94
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2019 09:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733214AbfJ1I5L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Oct 2019 04:57:11 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:38266 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730954AbfJ1I5L (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Oct 2019 04:57:11 -0400
Received: by mail-wr1-f42.google.com with SMTP id v9so8924311wrq.5
        for <linux-efi@vger.kernel.org>; Mon, 28 Oct 2019 01:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85vYeLkpPqjzgvpRj7PI0GsInQhNVyY07vVcFaFq98w=;
        b=dfHu22tD74BT2Osexc3BWnyLgxis0oKB3k3nY20AXttH1gWkLxYlm4AIcpI/x9nO9L
         CNEn3JdcRHhJujOkOib0UZ3mFp+DSz+D/fTX8cLk4NIgzMhlijcG1lmCIz3bZ79NZ8KW
         rcUUTxsYlHFpT/H4om0MxzEGD02RXC5Fteqweacg2cqbUVQQmmzvmnd2hYmnHvlowhpr
         AbieHLeeibCTGuYXDs/llc8I8tJzLPzmUEB6Fh4fQF/J4cUTxZJkYaipqi6MOHpBgcZk
         X6nS5ouuEoWLY9I59go1AuzDIunQlg8jUyf/eBSU4NbUgnPgCbFl9JyT4OHi5S+8RLYc
         SSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85vYeLkpPqjzgvpRj7PI0GsInQhNVyY07vVcFaFq98w=;
        b=RiczZchoSxWSO8o93MSH6mtBTNTXqP/U/v4xwIjU49Jv/XOYnEBWafKnqXm1G6LJJf
         UZCjq3Vdu09qiiChIiUQ+BW9lzlAyfiWv8TMfcC2oc7lrklxsUHqELej1pTRKE2SGtB3
         BUgqP6KTiV3T8tGxu6i6u8jZzcfswulVIwRDtEY8doGqY7rkMMGxe8ecYU/C4kwnPY9A
         sK1I5ZFLifSQ/ADVlgPRNI9ngfFEaP7LbVKsC6x5BzQDfYkQqJrBTrttQygK7AUfKpV+
         rFtAihnt0BIhd567f0i2bPnDJDtEF8edtwWT73lWmAzEMnYcPIWoLyq/QorWZfU/Uucc
         J9ng==
X-Gm-Message-State: APjAAAX0gUaimVxBWx1j22edCHE3ZetM/uj6hhhsaq8YvUlRGxLO+OPy
        U7nJJkd2Mvn+TtDLiOjvSbRSRVRDRrQpI5ei9IY2/w==
X-Google-Smtp-Source: APXvYqzbR486nmkkVqhfzJKu0i4SfZzyAlAT2+wddL0syHYfPEC/hS3i4HE7NTXv5Pyc2Ba/E+x1IUl6LpmdtVYzq5k=
X-Received: by 2002:adf:8289:: with SMTP id 9mr14968383wrc.0.1572253029271;
 Mon, 28 Oct 2019 01:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191005113753.GA77634@light.dominikbrodowski.net>
 <20191028072036.GA113601@owl.dominikbrodowski.net> <CAKv+Gu-RcHfupXzZaK3UK1x+fkffGind8JP_4fZ95wBXuasJoQ@mail.gmail.com>
 <20191028084019.GA2392@owl.dominikbrodowski.net>
In-Reply-To: <20191028084019.GA2392@owl.dominikbrodowski.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 28 Oct 2019 09:56:58 +0100
Message-ID: <CAKv+Gu9gp+BUhf3KJMCTFuon9o1mUGv9UxWQ=A==-gLiAjRNNQ@mail.gmail.com>
Subject: Re: efistub: EFI_RNG_PROTOCOL on Dell Inc. Latitude 7390
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 28 Oct 2019 at 09:42, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Hello Ard,
>
> On Mon, Oct 28, 2019 at 08:46:28AM +0100, Ard Biesheuvel wrote:
> > Hello Dominik,
> >
> > On Mon, 28 Oct 2019 at 08:30, Dominik Brodowski
> > <linux@dominikbrodowski.net> wrote:
> > >
> > > Ard, Mario,
> > >
> > > in theory, invoking EFI_RNG_PROTOCOL on a Dell Inc. Latitude 7390/09386V,
> > > BIOS 1.9.2 04/03/2019, should work fine as the system provides EFI v2.60.
> > > Using my patch from a few weeks ago[1], efi_random_get_seed() is called from
> > > arch/x86/boot/compressed/eboot.c::efi_main(). In efi_random_get_seed(), the
> > > calls to
> > >
> > >         status = efi_call_early(locate_protocol, &rng_proto, NULL,
> > >                                 (void **)&rng);
> > >
> > > and
> > >
> > >         status = efi_call_early(allocate_pool, EFI_RUNTIME_SERVICES_DATA,
> > >                                 sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
> > >                                 (void **)&seed);
> > >
> > > succeed. However,
> > >
> > >         status = rng->get_rng(rng, &rng_algo_raw, EFI_RANDOM_SEED_SIZE,
> > >                               seed->bits);
> > >
> > > returns EFI_INVALID_PARAMETER, though I can't see why one of these
> > > parameters is invalid.
> >
> > The UEFI spec defines the conditions under which this function may
> > return EFI_INVALID_PARAMETER as
> >
> > """
> > RNGValue is null or RNGValueLength is zero.
> >
> > """
> >
> >
> > > When trying to use the default rng algorithm (by
> > > modifying the test to "(status != EFI_SUCCESS)"),
> > >
> > >                 status = rng->get_rng(rng, NULL, EFI_RANDOM_SEED_SIZE,
> > >                                       seed->bits);
> > >
> > > the call doesn't seem to return.
> > >
> > > Any ideas?
> > >
> >
> > Try running this from the UEFI shell:
> >
> > http://people.linaro.org/~ard.biesheuvel/RngTest-X64.efi
>
> Interestingly, this succeeds -- with the default algorithm, SP800-90-CTR-256
> and RAW. So I am more confused than before on why the call to ->get_rng()
> fails in efi_random_get_seed().
>

It might be an issue with the size of the output.

The original RDRAND based driver in EDK2 contains an apparent
misconception that, due to the fact that certain SP800-90-CTR-256
DRBGs require 32 bytes of raw entropy as a seed, it is only valid for
the RAW algorithm to be called with an output size of 32.

So in this case, it might be that 32 is treated as a magic number too,
and any other size is rejected by the RAW algorithm.

Not sure why the other one fails, though, but the fact that RAW and
SP800-90-CTR-256 are the only supported algorithms suggests that your
implementation is at least similar to the RDRAND based RngDxe
implementation in EDK2.
