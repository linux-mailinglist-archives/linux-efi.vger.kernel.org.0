Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A7F536C05
	for <lists+linux-efi@lfdr.de>; Sat, 28 May 2022 11:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiE1Jjh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 May 2022 05:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiE1Jjg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 May 2022 05:39:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41D17A80;
        Sat, 28 May 2022 02:39:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF4B6B816F4;
        Sat, 28 May 2022 09:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44A0C34100;
        Sat, 28 May 2022 09:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653730772;
        bh=+jA1Bp8CM4ALpWYkpR1+uBpuu0hpBW+rO9hvYyLjKl0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R5eNYLn1ow1UI70uVvuT4iPgQcBxFl80oB08uCUMIJ9KOXreHpAxmDLZ6VY7GT3We
         ARlfgaYb+MX0G+/RWiYp9vQpBMBC5W1VkFtDShi8dVCyQShQWqGAYWGk/6TORQouY0
         u8rvHXPAgNyMfP/d68ngBv4QTQ1ZCWc71JAxlHuf/GBAppno033kBVOqWdqTYIdTEh
         hJjevcPqPw6Ob/wC4AjfLfgTioVz2UGfIprhchOkHYKue8tRMaJjg4pMM9kwu9KGAa
         0X3mzg67Vvg11O3/8HS4tQx0BRVqjZAL/Mg1GBcYD0nxcRxfVVRVY2m7zRF0I/Imss
         PP5f90UNJkWQg==
Received: by mail-oi1-f177.google.com with SMTP id r68so8405023oie.12;
        Sat, 28 May 2022 02:39:32 -0700 (PDT)
X-Gm-Message-State: AOAM532cEVFodTrzV0rwFv9GzRUTKAQROMOCtRQXfcRkkpZN4XWD/Ih1
        SaxU8eolWncXFEkTUsXpww4fk5rbK2PPmdPvAMY=
X-Google-Smtp-Source: ABdhPJzvrE4SMNE48ZhDXunAUOmUjnaHS3ik+lHHctxdvkid9O+w6XgXzWtWXjh9d3Ly4N8zafm37B4N9P26GH1r2nI=
X-Received: by 2002:a05:6808:e8d:b0:322:bac0:2943 with SMTP id
 k13-20020a0568080e8d00b00322bac02943mr6081516oil.126.1653730771880; Sat, 28
 May 2022 02:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <ea51a17e00a10f3ab25d94b9a5885eb9142aa12b.1653377840.git.geert@linux-m68k.org>
 <CAMj1kXEUiuSLLcuQ-H7A4djyJF_rdr9bD4JrCP_p98Qg3K=Fow@mail.gmail.com>
In-Reply-To: <CAMj1kXEUiuSLLcuQ-H7A4djyJF_rdr9bD4JrCP_p98Qg3K=Fow@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 28 May 2022 11:39:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF8XUGrLQq+A04_nNEBQzq=8AsyXGQ-ZJoVqxFUeAoH0A@mail.gmail.com>
Message-ID: <CAMj1kXF8XUGrLQq+A04_nNEBQzq=8AsyXGQ-ZJoVqxFUeAoH0A@mail.gmail.com>
Subject: Re: [PATCH v2] efi: EFI_DISABLE_RUNTIME should depend on EFI
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 28 May 2022 at 11:24, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 24 May 2022 at 09:37, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > The EFI_DISABLE_RUNTIME config option controls the use of Extensible
> > Firmware Interface (EFI) runtime services, which matters only if EFI
> > support is enabled.
> >
> > Hence add a dependency on EFI, to prevent asking the user about this
> > control knob when configuring a kernel without EFI support.
> >
> > Fixes: a031651ff2144a3d ("efi: Allow to enable EFI runtime services by default on RT")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Acked-by: Javier Martinez Canillas <javierm@redhat.com>
> > ---
> > v2:
> >   - Add Acked-by,
> >   - Fix typo s/with/without/.
> > ---
> >  drivers/firmware/efi/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Can we just move this option into the menu/endmenu scope that already
> depends on EFI?
>

We can, and there are other candidates as well. So I'll drop this
patch, and send out another one that covers some other options too.

Thanks,
Ard.


> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index 4720ba98cec312e7..ff6e7bfa8355cfc2 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -299,6 +299,7 @@ config EFI_CUSTOM_SSDT_OVERLAYS
> >
> >  config EFI_DISABLE_RUNTIME
> >         bool "Disable EFI runtime services support by default"
> > +       depends on EFI
> >         default y if PREEMPT_RT
> >         help
> >           Allow to disable the EFI runtime services support by default. This can
> > --
> > 2.25.1
> >
