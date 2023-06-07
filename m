Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4034A725464
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 08:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbjFGGgq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 02:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjFGGgV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 02:36:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF9D1BCB
        for <linux-efi@vger.kernel.org>; Tue,  6 Jun 2023 23:35:59 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1b30445cfso63341821fa.1
        for <linux-efi@vger.kernel.org>; Tue, 06 Jun 2023 23:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686119758; x=1688711758;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6EFrOABaDLpt7VYlTUqL5NsJz5X4d5SpsRmR/+h4/eU=;
        b=zrmWamvQ3NIx3kxQvmqEpNBeEnJAHQDUu/bZmuRldmyopAs7kcnSeLHNBrfMgs/DUf
         LwvpEhjtVbMAC914DwVypWF0zQRTS61IThhfy5X5jdVAR2RW0hofwanKWuI4YB/WS70x
         qkcxSl/G/TwpnvHZOaZEUFwk57mkb6YyQoykP59tiGCLEh8FW67mwzCe1ObItq9Old0O
         vOp30KmxVKJWFt0vEU4bFHcomlqfau0R2V4/WkKEpRJT2gSyEZqPrwhU0q9GDHTbUAsh
         8khzqmfVHqMz8EuRkkVIrwmMYYQs3vppRPChSv7KPSGfKu9HjpOFFHwXhL03K0AavwJe
         y+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686119758; x=1688711758;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EFrOABaDLpt7VYlTUqL5NsJz5X4d5SpsRmR/+h4/eU=;
        b=ZC2SknB5o/aalZo4wYdAT7GYkmOzsiCmWAL2Pqr7sD0L2qmiMiYjLjg4/oZqpIFLQV
         c9/n4NnyK9RAYrFiKmS11b1iIhsB0hYSrkdKBCV2s/3UZ0+OW9vv6zJLq36287FkE7CD
         oGLiUs22ZpJRZ8S1vRRwXKa3tB/dy+esGZsp/J8hw5TAkTXtS8t7cFaEerG1mqnnyoU2
         MS4GPtUwj21B8o5K7sgPKdpgnZQeiEmbVctjVJHzeGDiAGDYdfk2AFnNh2nYLG5obNia
         y5CHsrhdAzOCC7S0Dh803XAgXCiUwIO4hLbgPdRHPkspSSQi9oWiyJhezMOp8+WTxnjV
         ypsw==
X-Gm-Message-State: AC+VfDxP6M8A9wUUecSKH69IPvtWwmP+3m31cL5PDemfvlnBtDBW0weF
        dgW1DrJ+m7rMmNwHw9yzKp7QQZazgjHyMfdwjO2Z9w==
X-Google-Smtp-Source: ACHHUZ50P4GwMwpVy/3E1kfflfT7/u++IWVGt8rvCPVQv9ibu4LaVmw1D0lXhPSu99Kuo+IyTcRTb+mYR4WbUz61hcE=
X-Received: by 2002:a2e:9096:0:b0:2ad:dd7e:6651 with SMTP id
 l22-20020a2e9096000000b002addd7e6651mr2194957ljg.43.1686119757684; Tue, 06
 Jun 2023 23:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <20230526010748.1222-4-masahisa.kojima@linaro.org> <0d3e0370-eb76-010f-3d30-9acc9b59645c@siemens.com>
 <CAFA6WYPnWJNPvhT2JDkO-qXRUaJoxBGZEvSfhxcRynV7=VSdQA@mail.gmail.com>
 <CAMj1kXFM45PCTU--+CCed6Cq_N5XqDG6tTu6fnQTSCpW2BWA5A@mail.gmail.com>
 <4ff09002-e871-38b9-43ec-227a64bac731@siemens.com> <CAC_iWjJJ5E9Q1or5yTiDynzv_WAYH-g+N24aRdu9rvcsbWqnrg@mail.gmail.com>
In-Reply-To: <CAC_iWjJJ5E9Q1or5yTiDynzv_WAYH-g+N24aRdu9rvcsbWqnrg@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 7 Jun 2023 09:35:21 +0300
Message-ID: <CAC_iWjLm-2GVOn4QpoLBiCYLM1+zuQHttzEvrpNo1qt9AqXaUQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 7 Jun 2023 at 09:34, Ilias Apalodimas
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
>

Forgot to attach the link... apologies for the noise.
[0] https://lore.kernel.org/all/CAC_iWjLOhUvp5ggCCkHN5MRNfB_h6FZ2Z14yrtR3aqGn0Ovxig@mail.gmail.com/

> Thanks
> /Ilias
> >
> > Jan
> >
> > --
> > Siemens AG, Technology
> > Competence Center Embedded Linux
> >
