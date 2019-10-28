Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54C34E6FE8
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2019 11:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbfJ1KvO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Oct 2019 06:51:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50679 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388297AbfJ1KvO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Oct 2019 06:51:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so8922896wmk.0
        for <linux-efi@vger.kernel.org>; Mon, 28 Oct 2019 03:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XYMO/hf8Dlsj7ZLUCB+PJ6yrQLezVUUgzCEjs1w7e0=;
        b=MSJSV8IkQu4YY/6Xd8QLvGuT7aFArrpZ8b/4FVhtXF0FaUNCXkXK/9qrPLXZXM4JrQ
         2VOa0nzaI+L1YMlyIvjFxvokdK18Uzz0Y8cTubqn1J1r/yonIl/TisJO4R/dmgLaAroz
         wfIIQMqLDb29CPG5yjbqfIQZc4nw8SkTNjE2HVFSsmz84YoNABEo2hZTNTZ/a+6hYc5R
         kvYo18MQP2B9+jhkkKEOUo7bc9zol0C6BQ1/auTUIN8Px1lgMbGXFKL/gUUUzs9N+hXX
         UWdPyCRz1mYjLtljjqDO0pi2a61Zesj3C+8h7P2DaWxa6kOgW3YcXaW+6D/eLzg07SQh
         IHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XYMO/hf8Dlsj7ZLUCB+PJ6yrQLezVUUgzCEjs1w7e0=;
        b=bSEwkIc9naD4Xit9b7xr9V3URIfYesgbIxlxAbRkPJi+z+lSaxiv14+CC9MFQX+7hL
         noBowjVO8XelmBx2YjOchmhZUs0CdmK19QK5NmUa1BpXV7uHzyhyvDv3HfWfbUG8DGZA
         PZ9fWC7nLDtbJq+URfXPK8sOFByt31L7AGqvQBblLG3UYOeG5/fJtS6vR9/kQXI9MM0g
         m+EBNnkWQCU7kdfGSQUxOf5LEmLV6gOLcZeGTrqB96LJbcJe2Lkp6dCEjtf3F62A9WA9
         Az1rV3EQ+mQ0EQJExkwiV1+cfXmGn8Bh9F7UygnPSYErYLDCvzPi54wwycEERmr3WtNJ
         DiNQ==
X-Gm-Message-State: APjAAAWUdSyFxI8I4PW4+Z12S0q++0uB1fASF0pKHJ996KDRiyCqXT9O
        PrJuorhcBtGXchvLucnDuCkddEEboKG0qP3CPo6vVQ==
X-Google-Smtp-Source: APXvYqxR7KC7fdkks306kUfnln7+RaDci2HiVLkSyGTkIxd2CTR0odPeIEDjuvacVMc+tGq6vTUAuiAyCS08dNSHM5c=
X-Received: by 2002:a7b:c925:: with SMTP id h5mr13695979wml.61.1572259872330;
 Mon, 28 Oct 2019 03:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191005113753.GA77634@light.dominikbrodowski.net>
 <20191028072036.GA113601@owl.dominikbrodowski.net> <CAKv+Gu-RcHfupXzZaK3UK1x+fkffGind8JP_4fZ95wBXuasJoQ@mail.gmail.com>
 <20191028084019.GA2392@owl.dominikbrodowski.net> <CAKv+Gu9gp+BUhf3KJMCTFuon9o1mUGv9UxWQ=A==-gLiAjRNNQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9gp+BUhf3KJMCTFuon9o1mUGv9UxWQ=A==-gLiAjRNNQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 28 Oct 2019 11:51:01 +0100
Message-ID: <CAKv+Gu-D4uvf5iyBKoRkantFVx4292da4BD8wuqC1uOZOhWegQ@mail.gmail.com>
Subject: Re: efistub: EFI_RNG_PROTOCOL on Dell Inc. Latitude 7390
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 28 Oct 2019 at 09:56, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Mon, 28 Oct 2019 at 09:42, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> >
> > Hello Ard,
> >
> > On Mon, Oct 28, 2019 at 08:46:28AM +0100, Ard Biesheuvel wrote:
> > > Hello Dominik,
> > >
> > > On Mon, 28 Oct 2019 at 08:30, Dominik Brodowski
> > > <linux@dominikbrodowski.net> wrote:
> > > >
> > > > Ard, Mario,
> > > >
> > > > in theory, invoking EFI_RNG_PROTOCOL on a Dell Inc. Latitude 7390/09386V,
> > > > BIOS 1.9.2 04/03/2019, should work fine as the system provides EFI v2.60.
> > > > Using my patch from a few weeks ago[1], efi_random_get_seed() is called from
> > > > arch/x86/boot/compressed/eboot.c::efi_main(). In efi_random_get_seed(), the
> > > > calls to
> > > >
> > > >         status = efi_call_early(locate_protocol, &rng_proto, NULL,
> > > >                                 (void **)&rng);
> > > >
> > > > and
> > > >
> > > >         status = efi_call_early(allocate_pool, EFI_RUNTIME_SERVICES_DATA,
> > > >                                 sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
> > > >                                 (void **)&seed);
> > > >
> > > > succeed. However,
> > > >
> > > >         status = rng->get_rng(rng, &rng_algo_raw, EFI_RANDOM_SEED_SIZE,
> > > >                               seed->bits);
> > > >
> > > > returns EFI_INVALID_PARAMETER, though I can't see why one of these
> > > > parameters is invalid.
> > >
> > > The UEFI spec defines the conditions under which this function may
> > > return EFI_INVALID_PARAMETER as
> > >
> > > """
> > > RNGValue is null or RNGValueLength is zero.
> > >
> > > """
> > >
> > >
> > > > When trying to use the default rng algorithm (by
> > > > modifying the test to "(status != EFI_SUCCESS)"),
> > > >
> > > >                 status = rng->get_rng(rng, NULL, EFI_RANDOM_SEED_SIZE,
> > > >                                       seed->bits);
> > > >
> > > > the call doesn't seem to return.
> > > >
> > > > Any ideas?
> > > >
> > >
> > > Try running this from the UEFI shell:
> > >
> > > http://people.linaro.org/~ard.biesheuvel/RngTest-X64.efi
> >
> > Interestingly, this succeeds -- with the default algorithm, SP800-90-CTR-256
> > and RAW. So I am more confused than before on why the call to ->get_rng()
> > fails in efi_random_get_seed().
> >
>
> It might be an issue with the size of the output.
>
> The original RDRAND based driver in EDK2 contains an apparent
> misconception that, due to the fact that certain SP800-90-CTR-256
> DRBGs require 32 bytes of raw entropy as a seed, it is only valid for
> the RAW algorithm to be called with an output size of 32.
>
> So in this case, it might be that 32 is treated as a magic number too,
> and any other size is rejected by the RAW algorithm.
>
> Not sure why the other one fails, though, but the fact that RAW and
> SP800-90-CTR-256 are the only supported algorithms suggests that your
> implementation is at least similar to the RDRAND based RngDxe
> implementation in EDK2.

I've updated the RngTest-X64.efi binary with a version that invokes
both the RAW and the default algorithm twice with a request for 64
bytes of entropy, like we do in the kernel. It runs fine on my
Thinkpad, can you check whether it works on your Dell system as well?
