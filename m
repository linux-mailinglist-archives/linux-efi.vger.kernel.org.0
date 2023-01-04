Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1BF65D748
	for <lists+linux-efi@lfdr.de>; Wed,  4 Jan 2023 16:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjADPcr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Wed, 4 Jan 2023 10:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239014AbjADPcX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Jan 2023 10:32:23 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF58937525
        for <linux-efi@vger.kernel.org>; Wed,  4 Jan 2023 07:32:20 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pD5kR-0007eN-UP; Wed, 04 Jan 2023 16:32:11 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        emil.renner.berthing@canonical.com, linux-efi@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        alexghiti@rivosinc.com
Subject: Re: [PATCH v3 12/14] efi/riscv: libstub: mark when compiling libstub
Date:   Wed, 04 Jan 2023 16:32:11 +0100
Message-ID: <3495322.aeNJFYEL58@diego>
In-Reply-To: <20230104152153.ae7zki6iofc7ugbs@orel>
References: <20221130225614.1594256-1-heiko@sntech.de> <CAMj1kXGBSLf4ppjA5_F4Ork+ZJ45Sk0w6SnPc3eDcWbTMkj3SQ@mail.gmail.com> <20230104152153.ae7zki6iofc7ugbs@orel>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Am Mittwoch, 4. Januar 2023, 16:21:53 CET schrieb Andrew Jones:
> On Fri, Dec 02, 2022 at 05:37:16PM +0100, Ard Biesheuvel wrote:
> > On Thu, 1 Dec 2022 at 23:39, Heiko Stübner <heiko@sntech.de> wrote:
> > >
> > > Hi Ard,
> > >
> > > Am Donnerstag, 1. Dezember 2022, 21:57:00 CET schrieb Ard Biesheuvel:
> > > > On Thu, 1 Dec 2022 at 20:35, Andrew Jones <ajones@ventanamicro.com> wrote:
> > > > >
> > > > > On Wed, Nov 30, 2022 at 11:56:12PM +0100, Heiko Stuebner wrote:
> > > > > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > > > > >
> > > > > > We may want to runtime-optimize some core functions (str*, mem*),
> > > > > > but not have this leak into libstub and cause build issues.
> > > > > > Instead libstub, for the short while it's running, should just use
> > > > > > the generic implementation.
> > > > > >
> > > > > > So, to be able to determine whether functions, that are used both in
> > > > > > libstub and the main kernel, are getting compiled as part of libstub or
> > > > > > not, add a compile-flag we can check via #ifdef.
> > > > > >
> > > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > > Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > > >
> > > > I think it would be better to update arch/riscv/kernel/image-vars.h so
> > > > that only these generic implementations are exposed to the stub in the
> > > > first place.
> > >
> > 
> > Actually, all references to string and memory functions are going away
> > from the stub. This is already in -next.
> > 
> > EFI now has zboot support, which means you can create a EFI bootable
> > kernel image that carries the actual kernel in compressed form rather
> > than as a hybrid EFI/bare metal image.
> 
> While chatting about EFI stub string functions again in the context of [1]
> we recalled this comment that states the references should be going away
> anyway. I'm just replying here with interested parties on CC to try and
> bring it back to the forefront.
> 
> [1] https://lore.kernel.org/all/20221216162141.1701255-5-alexghiti@rivosinc.com/

I'm currently following Ard's other suggestion and am using a more
traditional model for str* functions (aka non-inline).

One thing I found on the new EFI parts was that while it provides it's own
implementations, it does not provide it's own prototype.

On the real kernel-side all the HAVE_ARCH_* blocks do wrap around
both the generic implementation as well as the prototype in string.h,
and there _are_ other implementations of str* or mem* functions
done as inline, on other arches. So that may be something that might
need fixing on the EFI-side.


Heiko


