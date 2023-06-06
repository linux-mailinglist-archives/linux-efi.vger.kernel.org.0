Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03641723AB4
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jun 2023 09:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjFFHzt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jun 2023 03:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbjFFHyF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jun 2023 03:54:05 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23E41720
        for <linux-efi@vger.kernel.org>; Tue,  6 Jun 2023 00:51:45 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7841dc9871dso3998048241.0
        for <linux-efi@vger.kernel.org>; Tue, 06 Jun 2023 00:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686037904; x=1688629904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qEb8brDaVgEf6xNJnniCPIjPebxe7oNg6yfvYJTINhE=;
        b=zN1OwuYLYtfiOXTEJ1n9kDh922zCa5AkwC7gHObCBmiHZik39QnJ+ROITrspCVlzuT
         YCJfrvXNBqRFXIHfImLkzYi2qMdfRttx2ZEF3U2DRyvMIR/P8VXcWTXHAn5WxnLbwXH4
         /eTDKXJTmtViURLDpFr+hmoH+P47MsCb/pRFZJCMC3fkl3J7QqOl58m+RTX/CGThRxZJ
         IenCUv/YXAvAZ4xMO5Mz7aaM3Hz8uSkAPvgD0bLuPJmvHeRsHdlguS0XJZm1koQM0oR0
         ZxYCGdzSm3eWZ/hYQVuOt1890nf2Kgm+TKQgs+bnZmVFtAE1BcGwnTsv84wSKMAhPS+r
         CPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686037904; x=1688629904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEb8brDaVgEf6xNJnniCPIjPebxe7oNg6yfvYJTINhE=;
        b=Ib0vH9IzNFHI9XAXULaYzHcn5ig5SNVwAqC+jeu5fAkdKTU+2h21mB82zJYfiToqKK
         SJCihUxa+YlLK3DLzVehqJ+tSFZLB4Y4wP8wQu1D7ZZdfuxXL7fgrhrzWO5BwpZUF1Bc
         HNsI4bOF+HYfSkHNLnU+O0xARWsEjI10DY+y6408lcXGaXBemK0SE1WnrCIwmrRziuQ0
         X1LuUm+bCa20MpUdLzGXYQbey0o7TcMMzlqQ63Fom2SHIisNT5RY19PIh2kIV08ycJNj
         L5aGM6X7hYvqb0ILElW/B0qNAuBmaIAgBMc1CSgUvku3n4UDXH4ihH09X7k6/RSO7luy
         0K0g==
X-Gm-Message-State: AC+VfDwAqyCuyywqWzouBTuiBWrY+6Ey8IRTsfOBq6XSjY+wFVF16EE9
        CMO5fo/trjR0rK2F1iLwL5W2XOO7+TThcyv08aElCw==
X-Google-Smtp-Source: ACHHUZ7KvWctFlyoIZEP7ZNjUZQJG5qt/dW7yUAl1wU6fao7ISI+t/dotyHHlAYIJ8EkqA7yYwNMsCjKcRb/X0+++F0=
X-Received: by 2002:a05:6102:3110:b0:436:4f07:fbe with SMTP id
 e16-20020a056102311000b004364f070fbemr775393vsh.15.1686037904296; Tue, 06 Jun
 2023 00:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <20230526010748.1222-4-masahisa.kojima@linaro.org> <0d3e0370-eb76-010f-3d30-9acc9b59645c@siemens.com>
 <CAFA6WYPnWJNPvhT2JDkO-qXRUaJoxBGZEvSfhxcRynV7=VSdQA@mail.gmail.com> <CAMj1kXFM45PCTU--+CCed6Cq_N5XqDG6tTu6fnQTSCpW2BWA5A@mail.gmail.com>
In-Reply-To: <CAMj1kXFM45PCTU--+CCed6Cq_N5XqDG6tTu6fnQTSCpW2BWA5A@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 6 Jun 2023 13:21:33 +0530
Message-ID: <CAFA6WYNjn=7tKy2nZ6JuxWMDVzW+Yyxj8F6Kob-2ebEkCjUB4A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
To:     Ard Biesheuvel <ardb@kernel.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 6 Jun 2023 at 12:28, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 6 Jun 2023 at 08:52, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Jan,
> >
> > On Tue, 6 Jun 2023 at 12:09, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > >
> > > On 26.05.23 03:07, Masahisa Kojima wrote:
> > > > When the flash is not owned by the non-secure world, accessing the EFI
> > > > variables is straightforward and done via EFI Runtime Variable Services.
> > > > In this case, critical variables for system integrity and security
> > > > are normally stored in the dedicated secure storage and only accessible
> > > > from the secure world.
> > > >
> > > > On the other hand, the small embedded devices don't have the special
> > > > dedicated secure storage. The eMMC device with an RPMB partition is
> > > > becoming more common, we can use an RPMB partition to store the
> > > > EFI Variables.
> > > >
> > > > The eMMC device is typically owned by the non-secure world(linux in
> > > > this case). There is an existing solution utilizing eMMC RPMB partition
> > > > for EFI Variables, it is implemented by interacting with
> > > > TEE(OP-TEE in this case), StandaloneMM(as EFI Variable Service Pseudo TA),
> > > > eMMC driver and tee-supplicant. The last piece is the tee-based
> > > > variable access driver to interact with TEE and StandaloneMM.
> > > >
> > > > So let's add the kernel functions needed.
> > > >
> > > > This feature is implemented as a kernel module.
> > > > StMM PTA has TA_FLAG_DEVICE_ENUM_SUPP flag when registered to OP-TEE
> > > > so that this tee_stmm_efi module is probed after tee-supplicant starts,
> > > > since "SetVariable" EFI Runtime Variable Service requires to
> > > > interact with tee-supplicant.
> > > >
> > > > Acked-by: Sumit Garg <sumit.garg@linaro.org>
> > > > Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > > > ---
> > > >  drivers/firmware/efi/Kconfig                 |  15 +
> > > >  drivers/firmware/efi/Makefile                |   1 +
> > > >  drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
> > > >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 638 +++++++++++++++++++
> > > >  4 files changed, 890 insertions(+)
> > > >  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
> > > >  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
> > > >
> ...
> > >
> > > I think we have a probe ordering issue with this driver:
> > > efivarfs_fill_super() may be called before the TEE bus was probed, thus
> > > with the default efivar ops still registered. And that means
> > > efivar_supports_writes() will return false, and the fs declares itself
> > > as readonly. I've seen systemd mounting it r/o initialling, and you need
> > > to remount the fs to enable writability.
> > >
> > > Is there anything that could be done to re-order things reliably, probe
> > > the tee bus earlier etc.?
> >
> > This driver has a dependency on user-space daemon: tee-supplicant to
> > be running for RPMB access. So once you start that daemon the
> > corresponding device will be enumerated on the TEE bus and this driver
> > probe will be invoked. So I would suggest you to load this daemon very
> > early in the boot process or better to make it a part of initramfs.
> >
>
> That is not the point, really.
>
> If this dependency exists, the code should be aware of that, and made
> to work correctly in spite of it. Requiring a module to be part of
> initramfs is not a reasonable fix.

I am not sure if I followed you here. Until we have the tee-stmm-efi
module loaded we won't get corresponding EFI operations registered.
The key here is that the underlying OP-TEE device won't be available
until tee-supplicant (see enumeration with PTA_CMD_GET_DEVICES_SUPP)
is running.

Do you have any better ideas regarding how this should be handled?

>
> IIUC, this also means that the efivar ops are updated while there is
> already a client. This seems less than ideal as well

That's true. An ideal situation would be to allow in-kernel RPMB
access APIs for OP-TEE or other kernel drivers to use. With that we
should be able to remove this tee-supplicant dependency. I hope you
are already aware about the earlier efforts to add the RPMB subsystem
to the kernel. But with these real world use-cases emerging like EFI
variables and fTPM, we should be able to convince corresponding
subsystem maintainers.

-Sumit
