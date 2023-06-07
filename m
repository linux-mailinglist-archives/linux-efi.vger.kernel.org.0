Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5471725782
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 10:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbjFGI0U (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 04:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238313AbjFGI0T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 04:26:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06330138
        for <linux-efi@vger.kernel.org>; Wed,  7 Jun 2023 01:26:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so791671e87.2
        for <linux-efi@vger.kernel.org>; Wed, 07 Jun 2023 01:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686126376; x=1688718376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=meqyLpIa2eoOfIkaFe10EGZNXQ4rVkSgK0+HDZ26xns=;
        b=ZF9p5u4hM9PFz+rRCKYlZoTUlbcYIxDgpTVxuZuiVVFOg/LdolKhBWBUAUQKQRa46+
         3DYQkg0hk5CEIO3iWRBEJF4S7DRTfWuXV/UW32si/8CbDvnNN5pQgt/of+kV67Y3jaPP
         rt4eHEz6FN/vj8pIB6s0uXTdAV6eeaIBamyD1Z5PmuVIkcC0r2W8LHJBo5VktSGZM3Am
         3kc67vWS9Ghitg9knI+ULF6FuPOzg1dsiQHth+lH2XdKZSn/a/APkBgq00uutbLXV5Ht
         t1B5ezcUGlevGxUyo6SMZ1jKBThmmMhZn3adfo363b35EgjK9jxhaZlij6GXxsLBwpja
         fhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686126376; x=1688718376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=meqyLpIa2eoOfIkaFe10EGZNXQ4rVkSgK0+HDZ26xns=;
        b=frL7DaJNt/pWOb8THeeH1pO/Hsu1v/CnyapUKuOGsnkR5ny9gwfvumiIXBXRTz8nr8
         wB+bA+8Sa1Tw3P52NRenyrFjxN7tvV6sWWtNA3TEwvLL04+PkKAj438kO/nXeSXfpHdw
         g5YSUDzPuoLZByYi+hAsv1BoV/sU48ZJxJV4NbE6nMg2tRcukedrTf2nwlnDiMpWnEpV
         OfufgcZBP9op35m1L1oXO3I7AYDZ0Dsz/8yt74+FHp4uDt6M/bKm8sUH8fMXpXmw0kAK
         rMrZW00tpGb36n++X/gBgRChBZQDG3VOheiiwpCcoEmQ0Nol+VYhn8sMRP7uGFPbAT5s
         qLbw==
X-Gm-Message-State: AC+VfDwgsIwwsqKbBnOTU8AQ824NWHN+jAKX9/W0rYv1aYXrVIFnHh34
        cqggW1S6bO2P8dWEoLyrtOc+o8maFIIgJBE1MDDESQ==
X-Google-Smtp-Source: ACHHUZ6rY7hwhROngrX3S6mKYk8pyY2vNRuLKLBfVKmc4MLTyNTLbfrhXuBN2UniToyQLzyYEgTqSFvqaZji+YzCtio=
X-Received: by 2002:a2e:8517:0:b0:2a7:75aa:40c with SMTP id
 j23-20020a2e8517000000b002a775aa040cmr2037906lji.10.1686126376194; Wed, 07
 Jun 2023 01:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <20230526010748.1222-4-masahisa.kojima@linaro.org> <0d3e0370-eb76-010f-3d30-9acc9b59645c@siemens.com>
 <CAFA6WYPnWJNPvhT2JDkO-qXRUaJoxBGZEvSfhxcRynV7=VSdQA@mail.gmail.com>
 <CAMj1kXFM45PCTU--+CCed6Cq_N5XqDG6tTu6fnQTSCpW2BWA5A@mail.gmail.com>
 <4ff09002-e871-38b9-43ec-227a64bac731@siemens.com> <CAC_iWjJJ5E9Q1or5yTiDynzv_WAYH-g+N24aRdu9rvcsbWqnrg@mail.gmail.com>
 <CAFA6WYNFYB1LiOFB_iwTsdD5PmnDdSbtDSH2J4FVFPx3uik8rQ@mail.gmail.com>
In-Reply-To: <CAFA6WYNFYB1LiOFB_iwTsdD5PmnDdSbtDSH2J4FVFPx3uik8rQ@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 7 Jun 2023 11:25:40 +0300
Message-ID: <CAC_iWj+E7-XK6dCeSn4205K0O3EZCLxCaC+adu-14ST6sdudfA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Sumit,

On Wed, 7 Jun 2023 at 10:25, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Ilias,
>
> On Wed, 7 Jun 2023 at 12:05, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Jan,
> >
> > [...]
> >
> > > >>>>
> > > > ...
> > > >>>
> > > >>> I think we have a probe ordering issue with this driver:
> > > >>> efivarfs_fill_super() may be called before the TEE bus was probed, thus
> > > >>> with the default efivar ops still registered. And that means
> > > >>> efivar_supports_writes() will return false, and the fs declares itself
> > > >>> as readonly. I've seen systemd mounting it r/o initialling, and you need
> > > >>> to remount the fs to enable writability.
> > > >>>
> > > >>> Is there anything that could be done to re-order things reliably, probe
> > > >>> the tee bus earlier etc.?
> > > >>
> > > >> This driver has a dependency on user-space daemon: tee-supplicant to
> > > >> be running for RPMB access. So once you start that daemon the
> > > >> corresponding device will be enumerated on the TEE bus and this driver
> > > >> probe will be invoked. So I would suggest you to load this daemon very
> > > >> early in the boot process or better to make it a part of initramfs.
> > > >>
> > > >
> > > > That is not the point, really.
> > > >
> > > > If this dependency exists, the code should be aware of that, and made
> > > > to work correctly in spite of it. Requiring a module to be part of
> > > > initramfs is not a reasonable fix.
> > >
> > > In fact, I've tested a non-modularized build as well, just to exclude
> > > that issue. The daemon dependency is more likely the problem here.
> > >
> > > >
> > > > IIUC, this also means that the efivar ops are updated while there is
> > > > already a client. This seems less than ideal as well
> >
> > As Sumit pointed out, the 'device' won't be available from OP-TEE
> > until the supplicant is up and running and as a result, the module
> > _probe() function won't run.  Unfortunately, this isn't something we
> > can avoid since the supplicant is responsible for the RPMB writes.
> > The only thing I can think of is moving parts of the supplicant to the
> > kernel and wiring up the RPC calls for reading/writing data to the
> > eMMC subsystem.  There was another discussion here [0] requesting the
> > same thing for different reasons. But unless I am missing something
> > this won't solve the problem completely either.  You still have a
> > timing dependency of "when did the RT callbacks change" -- "when was
> > my efivarfs mounted".
>
> With the RPMB writes wired through the kernel [1], the only dependency
> left is when do you load the tee-stmm-efi driver to have real EFI
> runtime variables support. IMO, tee-stmm-efi driver should be built-in
> to support systems without initramfs. The distro installers may choose
> to bundle it in initramfs. Do you still see a timing dependency with
> this approach?

No I don't, this will work reliably without the need to remount the efivarfs.
As you point out you will still have this dependency if you end up
building them as modules and you manage to mount the efivarfs before
those get inserted.  Does anyone see a reasonable workaround?
Deceiving the kernel and making the bootloader set the RT property bit
to force the filesystem being mounted as rw is a nasty hack that we
should avoid.  Maybe adding a kernel command line parameter that says
"Ignore the RTPROP I know what I am doing"?  I don't particularly love
this either, but it's not unreasonable.

Thanks
/Ilias
>
> [1] Of Course here we need the eMMC and TEE/OPTEE drivers to be built-in too.
>
> -Sumit
>
> >
> > Thanks
> > /Ilias
> > >
> > > Jan
> > >
> > > --
> > > Siemens AG, Technology
> > > Competence Center Embedded Linux
> > >
