Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947337255B1
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 09:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbjFGH3V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 03:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbjFGH2V (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 03:28:21 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB3730DD
        for <linux-efi@vger.kernel.org>; Wed,  7 Jun 2023 00:25:31 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-43b3b30bd55so849546137.3
        for <linux-efi@vger.kernel.org>; Wed, 07 Jun 2023 00:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686122730; x=1688714730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbZsMTtgivDoJEuH3IaNChHHrvk2Q0PtcwAfQDF1PA8=;
        b=P+xL9+U37Z+N4Mg9/jK1h93OPPuF7gNd5e682jUXmulyGnYN7E2Lt1E0pV3vImjW6i
         E+JGjPeeSkHP8lHcNLCr8FpcXhdFn63NHO3RRD9Uw58Rm8TX3nWeC0ypMRI7EQkHmcKg
         kskP06M+dRD2l41gqVSq+ToUSy/qs/4jcme5Kw6bZbXm4ViBSiUP7+mcI667Q7ddZ3GF
         h8Www7jgcJBNIIFrnpj8wOAzwHTqfKbAT+KMDzQjHnmfEzFOHVwF/QwwEjPzhHBoskeW
         sshaKLWse0H+qPYbgIuRvS35+lpdvSzaAvxWmeStc+QJFjSiUQE8AViznEohsbl1zNBc
         Tlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686122730; x=1688714730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbZsMTtgivDoJEuH3IaNChHHrvk2Q0PtcwAfQDF1PA8=;
        b=GPF3umicpD+7g33g/IUZ5corJvYmERawm++4Im+rUgSGT8Li1FhC6t1OuFlhDz0MGn
         2KTrnuBSwQGIA8JbiP4a5xPJVeCNY1EOck5VpAp/208+/2exHEWqPwYU9QNLBNB9BiZe
         I5J+Utv9sErNa1sxoeSYjr83ygAS0TiyUh3plG4Lr2AYGr/CkE4mDXOLpibutk1fmEdF
         iAGQWaL78gXX8MHQHzMiXwUCDhV4v9MxSBQpLcfPNC1vSDFGN2q6I803DgLCov12Ehvb
         /sCq0U8Xz+hkd3QPloCGtexY7FIkQSKHGCe35DXrOMCNGWrcvedUSPIT93o+W05MI3eT
         kpqg==
X-Gm-Message-State: AC+VfDzXj74w75bhyvIiFlzIkKr4dMJT1T/pzupLQqYveIBxAutLuxQD
        6l6kdpUeW1LM6qo16vLqyv2IiNjcPAtCFmEtiDo0Vg==
X-Google-Smtp-Source: ACHHUZ7lv+GHV6l5ITHPctjVPOJkZIdheJ4gOyp3YHUlRvjuZo0mxUxrjHyb3hadANufXU4xhlBUxp357jZhrj1AJB0=
X-Received: by 2002:a67:bd09:0:b0:426:b2d8:17e9 with SMTP id
 y9-20020a67bd09000000b00426b2d817e9mr634816vsq.20.1686122730438; Wed, 07 Jun
 2023 00:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <20230526010748.1222-4-masahisa.kojima@linaro.org> <0d3e0370-eb76-010f-3d30-9acc9b59645c@siemens.com>
 <CAFA6WYPnWJNPvhT2JDkO-qXRUaJoxBGZEvSfhxcRynV7=VSdQA@mail.gmail.com>
 <CAMj1kXFM45PCTU--+CCed6Cq_N5XqDG6tTu6fnQTSCpW2BWA5A@mail.gmail.com>
 <4ff09002-e871-38b9-43ec-227a64bac731@siemens.com> <CAC_iWjJJ5E9Q1or5yTiDynzv_WAYH-g+N24aRdu9rvcsbWqnrg@mail.gmail.com>
In-Reply-To: <CAC_iWjJJ5E9Q1or5yTiDynzv_WAYH-g+N24aRdu9rvcsbWqnrg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 7 Jun 2023 12:55:19 +0530
Message-ID: <CAFA6WYNFYB1LiOFB_iwTsdD5PmnDdSbtDSH2J4FVFPx3uik8rQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Wed, 7 Jun 2023 at 12:05, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Jan,
>
> [...]
>
> > >>>>
> > > ...
> > >>>
> > >>> I think we have a probe ordering issue with this driver:
> > >>> efivarfs_fill_super() may be called before the TEE bus was probed, thus
> > >>> with the default efivar ops still registered. And that means
> > >>> efivar_supports_writes() will return false, and the fs declares itself
> > >>> as readonly. I've seen systemd mounting it r/o initialling, and you need
> > >>> to remount the fs to enable writability.
> > >>>
> > >>> Is there anything that could be done to re-order things reliably, probe
> > >>> the tee bus earlier etc.?
> > >>
> > >> This driver has a dependency on user-space daemon: tee-supplicant to
> > >> be running for RPMB access. So once you start that daemon the
> > >> corresponding device will be enumerated on the TEE bus and this driver
> > >> probe will be invoked. So I would suggest you to load this daemon very
> > >> early in the boot process or better to make it a part of initramfs.
> > >>
> > >
> > > That is not the point, really.
> > >
> > > If this dependency exists, the code should be aware of that, and made
> > > to work correctly in spite of it. Requiring a module to be part of
> > > initramfs is not a reasonable fix.
> >
> > In fact, I've tested a non-modularized build as well, just to exclude
> > that issue. The daemon dependency is more likely the problem here.
> >
> > >
> > > IIUC, this also means that the efivar ops are updated while there is
> > > already a client. This seems less than ideal as well
>
> As Sumit pointed out, the 'device' won't be available from OP-TEE
> until the supplicant is up and running and as a result, the module
> _probe() function won't run.  Unfortunately, this isn't something we
> can avoid since the supplicant is responsible for the RPMB writes.
> The only thing I can think of is moving parts of the supplicant to the
> kernel and wiring up the RPC calls for reading/writing data to the
> eMMC subsystem.  There was another discussion here [0] requesting the
> same thing for different reasons. But unless I am missing something
> this won't solve the problem completely either.  You still have a
> timing dependency of "when did the RT callbacks change" -- "when was
> my efivarfs mounted".

With the RPMB writes wired through the kernel [1], the only dependency
left is when do you load the tee-stmm-efi driver to have real EFI
runtime variables support. IMO, tee-stmm-efi driver should be built-in
to support systems without initramfs. The distro installers may choose
to bundle it in initramfs. Do you still see a timing dependency with
this approach?

[1] Of Course here we need the eMMC and TEE/OPTEE drivers to be built-in too.

-Sumit

>
> Thanks
> /Ilias
> >
> > Jan
> >
> > --
> > Siemens AG, Technology
> > Competence Center Embedded Linux
> >
