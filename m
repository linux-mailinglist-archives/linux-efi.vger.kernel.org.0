Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24F6E6E68
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2019 09:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbfJ1Im3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Oct 2019 04:42:29 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:35494 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbfJ1Im2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Oct 2019 04:42:28 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl-tcp.brodo.linta [10.1.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 3D5762009FC;
        Mon, 28 Oct 2019 08:42:27 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 4CC4980065; Mon, 28 Oct 2019 09:40:19 +0100 (CET)
Date:   Mon, 28 Oct 2019 09:40:19 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: efistub: EFI_RNG_PROTOCOL on Dell Inc. Latitude 7390
Message-ID: <20191028084019.GA2392@owl.dominikbrodowski.net>
References: <20191005113753.GA77634@light.dominikbrodowski.net>
 <20191028072036.GA113601@owl.dominikbrodowski.net>
 <CAKv+Gu-RcHfupXzZaK3UK1x+fkffGind8JP_4fZ95wBXuasJoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-RcHfupXzZaK3UK1x+fkffGind8JP_4fZ95wBXuasJoQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Ard,

On Mon, Oct 28, 2019 at 08:46:28AM +0100, Ard Biesheuvel wrote:
> Hello Dominik,
> 
> On Mon, 28 Oct 2019 at 08:30, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> >
> > Ard, Mario,
> >
> > in theory, invoking EFI_RNG_PROTOCOL on a Dell Inc. Latitude 7390/09386V,
> > BIOS 1.9.2 04/03/2019, should work fine as the system provides EFI v2.60.
> > Using my patch from a few weeks ago[1], efi_random_get_seed() is called from
> > arch/x86/boot/compressed/eboot.c::efi_main(). In efi_random_get_seed(), the
> > calls to
> >
> >         status = efi_call_early(locate_protocol, &rng_proto, NULL,
> >                                 (void **)&rng);
> >
> > and
> >
> >         status = efi_call_early(allocate_pool, EFI_RUNTIME_SERVICES_DATA,
> >                                 sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
> >                                 (void **)&seed);
> >
> > succeed. However,
> >
> >         status = rng->get_rng(rng, &rng_algo_raw, EFI_RANDOM_SEED_SIZE,
> >                               seed->bits);
> >
> > returns EFI_INVALID_PARAMETER, though I can't see why one of these
> > parameters is invalid.
> 
> The UEFI spec defines the conditions under which this function may
> return EFI_INVALID_PARAMETER as
> 
> """
> RNGValue is null or RNGValueLength is zero.
> 
> """
> 
> 
> > When trying to use the default rng algorithm (by
> > modifying the test to "(status != EFI_SUCCESS)"),
> >
> >                 status = rng->get_rng(rng, NULL, EFI_RANDOM_SEED_SIZE,
> >                                       seed->bits);
> >
> > the call doesn't seem to return.
> >
> > Any ideas?
> >
> 
> Try running this from the UEFI shell:
> 
> http://people.linaro.org/~ard.biesheuvel/RngTest-X64.efi

Interestingly, this succeeds -- with the default algorithm, SP800-90-CTR-256
and RAW. So I am more confused than before on why the call to ->get_rng()
fails in efi_random_get_seed().

Best,
	Dominik
