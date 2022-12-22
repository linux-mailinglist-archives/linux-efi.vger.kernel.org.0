Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2621A654821
	for <lists+linux-efi@lfdr.de>; Thu, 22 Dec 2022 23:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiLVWBo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Dec 2022 17:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiLVWBo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Dec 2022 17:01:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7FBDEFE;
        Thu, 22 Dec 2022 14:01:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3EF2B81F68;
        Thu, 22 Dec 2022 22:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0F5C433EF;
        Thu, 22 Dec 2022 22:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671746499;
        bh=0AHFrmtAkzUY8TmraN3K72lLEpI4eao1ncPI5QWPLq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EkelR5Yf6MJK35i2G7HbiRdwiWSrGDls5wzM68w0OZYqUqEzJdcfcVtq3GkYePakY
         C7a35OYyTNCzLvJb5RwjRW0aFz5jQcalCNY/E8Foz88MNHX/oV9mmNsYrZpBSPM2Vg
         KaiTe352DbYEpYnoDXedqBS/SBSYWRxioRoUKOjjOMHB4rRLNUkes2H/AKCgfLlw7A
         rOnsOSqLO9gPuo4xJkCdcESXKiwQuE1PTqRLd2u991OMYnpqZEE/3HwaC3EC400SKu
         3GbdX3vPiYVM89RulVx6nbBsTPN1BbbEinYYuYUvpjXHbfYR92lbdRR3KDUymRfHUV
         vL4xjcshiRTiQ==
Date:   Thu, 22 Dec 2022 22:01:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Subject: Re: [PATCH 0/6] RISC-V kasan rework
Message-ID: <Y6TTvku/yuSjm42j@spud>
References: <20221216162141.1701255-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TCn4u6SoH/sj16af"
Content-Disposition: inline
In-Reply-To: <20221216162141.1701255-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--TCn4u6SoH/sj16af
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alex!

On Fri, Dec 16, 2022 at 05:21:35PM +0100, Alexandre Ghiti wrote:
> As described in patch 2, our current kasan implementation is intricate,
> so I tried to simplify the implementation and mimic what arm64/x86 are
> doing.

I'm not sure that I am going to have much to contribute for this series,
but I did notice some difficulty actually applying it. At whatever point
you sent it, the pwbot did actually give it a shakedown - but it doesn't
apply any of the "usual suspects" tree wise.
It looks like multiple patches interact with commit 9f2ac64d6ca6 ("riscv:
mm: add missing memcpy in kasan_init"), which caused me some difficulty
that was not just a trivial resolution.
A rebase on top of v6.2-rc1 is (I would imagine) a good idea for this
series?

For the future, perhaps using the base-commit arg would be useful for
stuff like this :)

> In addition it fixes UEFI bootflow with a kasan kernel and kasan inline
> instrumentation: all kasan configurations were tested on a large ubuntu
> kernel with success with KASAN_KUNIT_TEST and KASAN_MODULE_TEST.
>=20
> inline ubuntu config + uefi:
>  sv39: OK
>  sv48: OK
>  sv57: OK
>=20
> outline ubuntu config + uefi:
>  sv39: OK
>  sv48: OK
>  sv57: OK
>=20
> Actually 1 test always fails with KASAN_KUNIT_TEST that I have to check:
> # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan__test.c:1020
> KASAN failure expected in "set_bit(nr, addr)", but none occurrred
>=20
> Note that Palmer recently proposed to remove COMMAND_LINE_SIZE from the
> userspace abi
> https://lore.kernel.org/lkml/20221211061358.28035-1-palmer@rivosinc.com/T/
> so that we can finally increase the command line to fit all kasan kernel
> parameters.
>=20
> All of this should hopefully fix the syzkaller riscv build that has been
> failing for a few months now, any test is appreciated and if I can help
> in any way, please ask.
>=20
> Alexandre Ghiti (6):
>   riscv: Split early and final KASAN population functions
>   riscv: Rework kasan population functions
>   riscv: Move DTB_EARLY_BASE_VA to the kernel address space
>   riscv: Fix EFI stub usage of KASAN instrumented string functions
>   riscv: Fix ptdump when KASAN is enabled
>   riscv: Unconditionnally select KASAN_VMALLOC if KASAN
>=20
>  arch/riscv/Kconfig                    |   1 +
>  arch/riscv/kernel/image-vars.h        |   8 -
>  arch/riscv/mm/init.c                  |   2 +-
>  arch/riscv/mm/kasan_init.c            | 511 ++++++++++++++------------
>  arch/riscv/mm/ptdump.c                |  24 +-
>  drivers/firmware/efi/libstub/Makefile |   7 +-
>  drivers/firmware/efi/libstub/string.c | 133 +++++++
>  7 files changed, 435 insertions(+), 251 deletions(-)
>=20
> --=20
> 2.37.2
>=20
>=20

--TCn4u6SoH/sj16af
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6TTvgAKCRB4tDGHoIJi
0orbAP9JIVPQo+hgzKfF1ShcT+6Ln7xErm9HazmhbtqIG0D61gEA5NgEVxpsOv3f
J9oJpI8UCyLrfCOHSx5LFudR2RhlJgs=
=WKhG
-----END PGP SIGNATURE-----

--TCn4u6SoH/sj16af--
