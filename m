Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E86640AF2
	for <lists+linux-efi@lfdr.de>; Fri,  2 Dec 2022 17:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiLBQhh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Dec 2022 11:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiLBQhf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Dec 2022 11:37:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80345BC596
        for <linux-efi@vger.kernel.org>; Fri,  2 Dec 2022 08:37:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AB3262351
        for <linux-efi@vger.kernel.org>; Fri,  2 Dec 2022 16:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1B7C4314D
        for <linux-efi@vger.kernel.org>; Fri,  2 Dec 2022 16:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669999049;
        bh=EvJJMDT2Lq9pPqMsw0zk5dy2vuzQb62lx5KfT70us/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZZolye9g9cXNPBfD/6CR7XzvyGpcNzWhbXQTX9PJizhF5AxoqHjtioLxMsY54gcCv
         D3Fuw2v0UGgWU83YkfOHZapX5zUjPkx5t7YA6jlP86kBkU07BzflPCgi+BP+oaGOAn
         aJd9CVsRQwxq52T9rJCQiuEtYk6fZsM99T/wLQseCrNoYy6Se7VkCTYLWT5/ilFEF2
         0PWE8eXKsht3/oaEP/P0sxt6g3RrXP0iPLy/i1ivzQmECuUF5emXZ+swPvsRW9oHub
         tneS4nxN/zoLHs9kjln/u0sk6UE87e6V8B+Fev8NdxFbEXigjInVy7TlMeFWsscfXU
         JOZe2YLKAH3Vw==
Received: by mail-lj1-f182.google.com with SMTP id b9so6000124ljr.5
        for <linux-efi@vger.kernel.org>; Fri, 02 Dec 2022 08:37:29 -0800 (PST)
X-Gm-Message-State: ANoB5pkWI0bs2jPkmdthrdPVWVQ3rA3GVlX3Hwv8BxIE9bE0q5Cc8zz+
        f0PMJ5rl7bTa3yGrqtMjUpXGtAlHPZvVX9qp1PY=
X-Google-Smtp-Source: AA0mqf4cP5vb+93NiI7bo/ZZvh3IXG/Angm4270zBWJmIi4Rjhoz7ku+a9UJTL6u9/quHp9vK7vWlRhjTjhEhM8Np5E=
X-Received: by 2002:a05:651c:1603:b0:26d:d603:8df2 with SMTP id
 f3-20020a05651c160300b0026dd6038df2mr21120504ljq.189.1669999047497; Fri, 02
 Dec 2022 08:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20221130225614.1594256-1-heiko@sntech.de> <20221201193455.2hr6mwm6sa6vnd3w@kamzik>
 <CAMj1kXG=zM0EFFPn8MBWFurk=oSRPqwdd6CP1dudQC+JXV36Og@mail.gmail.com> <4822525.e9J7NaK4W3@diego>
In-Reply-To: <4822525.e9J7NaK4W3@diego>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 2 Dec 2022 17:37:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGBSLf4ppjA5_F4Ork+ZJ45Sk0w6SnPc3eDcWbTMkj3SQ@mail.gmail.com>
Message-ID: <CAMj1kXGBSLf4ppjA5_F4Ork+ZJ45Sk0w6SnPc3eDcWbTMkj3SQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] efi/riscv: libstub: mark when compiling libstub
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        emil.renner.berthing@canonical.com, linux-efi@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 1 Dec 2022 at 23:39, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Ard,
>
> Am Donnerstag, 1. Dezember 2022, 21:57:00 CET schrieb Ard Biesheuvel:
> > On Thu, 1 Dec 2022 at 20:35, Andrew Jones <ajones@ventanamicro.com> wro=
te:
> > >
> > > On Wed, Nov 30, 2022 at 11:56:12PM +0100, Heiko Stuebner wrote:
> > > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > > >
> > > > We may want to runtime-optimize some core functions (str*, mem*),
> > > > but not have this leak into libstub and cause build issues.
> > > > Instead libstub, for the short while it's running, should just use
> > > > the generic implementation.
> > > >
> > > > So, to be able to determine whether functions, that are used both i=
n
> > > > libstub and the main kernel, are getting compiled as part of libstu=
b or
> > > > not, add a compile-flag we can check via #ifdef.
> > > >
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> >
> > I think it would be better to update arch/riscv/kernel/image-vars.h so
> > that only these generic implementations are exposed to the stub in the
> > first place.
>

Actually, all references to string and memory functions are going away
from the stub. This is already in -next.

EFI now has zboot support, which means you can create a EFI bootable
kernel image that carries the actual kernel in compressed form rather
than as a hybrid EFI/bare metal image.
