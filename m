Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EA463FAAC
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 23:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiLAWjj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 17:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiLAWji (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 17:39:38 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08794BEC4A
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 14:39:35 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p0sDF-0004Fj-8b; Thu, 01 Dec 2022 23:39:25 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andrew Jones <ajones@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        emil.renner.berthing@canonical.com, linux-efi@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 12/14] efi/riscv: libstub: mark when compiling libstub
Date:   Thu, 01 Dec 2022 23:39:22 +0100
Message-ID: <4822525.e9J7NaK4W3@diego>
In-Reply-To: <CAMj1kXG=zM0EFFPn8MBWFurk=oSRPqwdd6CP1dudQC+JXV36Og@mail.gmail.com>
References: <20221130225614.1594256-1-heiko@sntech.de> <20221201193455.2hr6mwm6sa6vnd3w@kamzik> <CAMj1kXG=zM0EFFPn8MBWFurk=oSRPqwdd6CP1dudQC+JXV36Og@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

Am Donnerstag, 1. Dezember 2022, 21:57:00 CET schrieb Ard Biesheuvel:
> On Thu, 1 Dec 2022 at 20:35, Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Wed, Nov 30, 2022 at 11:56:12PM +0100, Heiko Stuebner wrote:
> > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > >
> > > We may want to runtime-optimize some core functions (str*, mem*),
> > > but not have this leak into libstub and cause build issues.
> > > Instead libstub, for the short while it's running, should just use
> > > the generic implementation.
> > >
> > > So, to be able to determine whether functions, that are used both in
> > > libstub and the main kernel, are getting compiled as part of libstub or
> > > not, add a compile-flag we can check via #ifdef.
> > >
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> I think it would be better to update arch/riscv/kernel/image-vars.h so
> that only these generic implementations are exposed to the stub in the
> first place.

The relevant code is in patch13 + patch14.

To provide more context, the actual str* function we want to run is
determined at runtime. This is due to a all the possible extensions
(present and future) a riscv core can or cannot support, which in turn
blooms into a plethora of possible implementations for them.

Of course we want to have a unified kernel image, so we check on boot
for available extensions and patch the call to the actual best function

The introduction in the mentioned patches is still simple with a
generic + bitmanipulation variant, but that is more to keep the changes
somewhat manageable and there are already more variants on the horizon.

So the actual strlen and friends is just an inline function with a call to
the actual function, which gets patched via alternatives.

So this looks then like:

--------- 8< ---------
static inline int strcmp(const char *cs, const char *ct)
{
#if defined(RISCV_EFISTUB) || defined(RISCV_PURGATORY)
        return __strcmp_generic(cs, ct);
#else
        register const char *a0 asm("a0") = cs;
        register const char *a1 asm("a1") = ct;
        register int a0_out asm("a0");

        asm volatile(
                ALTERNATIVE(
                        "call __strcmp_generic\n\t",
                        "call __strcmp_zbb\n\t",
                        0, CPUFEATURE_ZBB, CONFIG_RISCV_ISA_ZBB)
                : "=r"(a0_out)
                : "r"(a0), "r"(a1)
                : "ra", "t0", "t1", "t2", "t3", "t4", "t5");

        return a0_out;
#endif
}
--------- 8< ---------

When that gets pulled into libstub without that separation, libstub ends up
with references to __strcmp_generic and __strcmp_zbb.

Of course the zbb variant would never get used, but still would also need
to be present in libstub and image-vars.h just to make the build happy.

And for every additional variant this would also mean adding more to
unused code to libstub and image-vars.h, hence I came up with the flag
to mark when code gets to be part of libstub.


Heiko



> 
> > > ---
> > >  drivers/firmware/efi/libstub/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > > index ef5045a53ce0..777d1ab059e3 100644
> > > --- a/drivers/firmware/efi/libstub/Makefile
> > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > @@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)                := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > >                                  -fno-builtin -fpic \
> > >                                  $(call cc-option,-mno-single-pic-base)
> > >  cflags-$(CONFIG_RISCV)               := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > -                                -fpic
> > > +                                -fpic -DRISCV_EFISTUB
> > >  cflags-$(CONFIG_LOONGARCH)   := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > >                                  -fpie
> > >
> > > --
> > > 2.35.1
> > >
> >
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 




