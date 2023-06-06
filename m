Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EC5723844
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jun 2023 08:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjFFG6I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jun 2023 02:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjFFG6I (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jun 2023 02:58:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC501B8;
        Mon,  5 Jun 2023 23:58:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 955726238B;
        Tue,  6 Jun 2023 06:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03784C4339C;
        Tue,  6 Jun 2023 06:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686034686;
        bh=MpmJDRibyiGyOaFh28ezYkc4fANiyKweS1h9oBDPv+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YWH7B92mkI0DT3kNPq6cTxAPrC/vu5gP59t1/UOoKZbWSGiq3UW2t0zfDbeOHgSPQ
         1R0DLLIAQcZvkY5UM4D40gZ+cQLa4IksuQZ8lSREqGVMC1uruzvycChMrPU5rZ9+uQ
         9bt7KgFkjRO5cZ6F1Xg416N/FuIIi3eqb5f3GIFOyaEVkdk0d3DfKKX8CoP0yJCoA5
         LAPzraxU0palfk8x0itGlfbpHkhUXOaK6M391e7KFAvinfW/6QJsJcNQFo+Bh2tCTe
         cSjmkr0sleEXbDI1h2AzyP8Ba9O/K8UXTr84JNzw77lM9npNivIvxQXOS1A/tjcKEs
         E6RXrijYG2ONg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b1b06af50eso50583841fa.1;
        Mon, 05 Jun 2023 23:58:05 -0700 (PDT)
X-Gm-Message-State: AC+VfDyNBzvzEOiJnISJj5T4kYuCHOJ+HWCuy5J2fChfX6RcfQfqgobp
        bFBh+ZoMoNFz/YL1ytbWBJOA4iI444RZsOP597Q=
X-Google-Smtp-Source: ACHHUZ7Vc/081XIKKuET5QOyy69OLOKWXtdVxq9it5tL4Z3SIPhBbx2gIkI9YA6N1wBkjG2hrFNY+dUB5XRcl3W1jKQ=
X-Received: by 2002:a2e:9910:0:b0:2af:d2ef:49d4 with SMTP id
 v16-20020a2e9910000000b002afd2ef49d4mr884811lji.1.1686034683959; Mon, 05 Jun
 2023 23:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <20230526010748.1222-4-masahisa.kojima@linaro.org> <0d3e0370-eb76-010f-3d30-9acc9b59645c@siemens.com>
 <CAFA6WYPnWJNPvhT2JDkO-qXRUaJoxBGZEvSfhxcRynV7=VSdQA@mail.gmail.com>
In-Reply-To: <CAFA6WYPnWJNPvhT2JDkO-qXRUaJoxBGZEvSfhxcRynV7=VSdQA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 6 Jun 2023 08:57:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFM45PCTU--+CCed6Cq_N5XqDG6tTu6fnQTSCpW2BWA5A@mail.gmail.com>
Message-ID: <CAMj1kXFM45PCTU--+CCed6Cq_N5XqDG6tTu6fnQTSCpW2BWA5A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 6 Jun 2023 at 08:52, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Jan,
>
> On Tue, 6 Jun 2023 at 12:09, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 26.05.23 03:07, Masahisa Kojima wrote:
> > > When the flash is not owned by the non-secure world, accessing the EFI
> > > variables is straightforward and done via EFI Runtime Variable Services.
> > > In this case, critical variables for system integrity and security
> > > are normally stored in the dedicated secure storage and only accessible
> > > from the secure world.
> > >
> > > On the other hand, the small embedded devices don't have the special
> > > dedicated secure storage. The eMMC device with an RPMB partition is
> > > becoming more common, we can use an RPMB partition to store the
> > > EFI Variables.
> > >
> > > The eMMC device is typically owned by the non-secure world(linux in
> > > this case). There is an existing solution utilizing eMMC RPMB partition
> > > for EFI Variables, it is implemented by interacting with
> > > TEE(OP-TEE in this case), StandaloneMM(as EFI Variable Service Pseudo TA),
> > > eMMC driver and tee-supplicant. The last piece is the tee-based
> > > variable access driver to interact with TEE and StandaloneMM.
> > >
> > > So let's add the kernel functions needed.
> > >
> > > This feature is implemented as a kernel module.
> > > StMM PTA has TA_FLAG_DEVICE_ENUM_SUPP flag when registered to OP-TEE
> > > so that this tee_stmm_efi module is probed after tee-supplicant starts,
> > > since "SetVariable" EFI Runtime Variable Service requires to
> > > interact with tee-supplicant.
> > >
> > > Acked-by: Sumit Garg <sumit.garg@linaro.org>
> > > Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > > ---
> > >  drivers/firmware/efi/Kconfig                 |  15 +
> > >  drivers/firmware/efi/Makefile                |   1 +
> > >  drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
> > >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 638 +++++++++++++++++++
> > >  4 files changed, 890 insertions(+)
> > >  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
> > >  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
> > >
...
> >
> > I think we have a probe ordering issue with this driver:
> > efivarfs_fill_super() may be called before the TEE bus was probed, thus
> > with the default efivar ops still registered. And that means
> > efivar_supports_writes() will return false, and the fs declares itself
> > as readonly. I've seen systemd mounting it r/o initialling, and you need
> > to remount the fs to enable writability.
> >
> > Is there anything that could be done to re-order things reliably, probe
> > the tee bus earlier etc.?
>
> This driver has a dependency on user-space daemon: tee-supplicant to
> be running for RPMB access. So once you start that daemon the
> corresponding device will be enumerated on the TEE bus and this driver
> probe will be invoked. So I would suggest you to load this daemon very
> early in the boot process or better to make it a part of initramfs.
>

That is not the point, really.

If this dependency exists, the code should be aware of that, and made
to work correctly in spite of it. Requiring a module to be part of
initramfs is not a reasonable fix.

IIUC, this also means that the efivar ops are updated while there is
already a client. This seems less than ideal as well
