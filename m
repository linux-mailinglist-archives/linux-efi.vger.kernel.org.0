Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D31583EF0
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 14:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbiG1Mf7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 08:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbiG1Mf6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 08:35:58 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028A14D822
        for <linux-efi@vger.kernel.org>; Thu, 28 Jul 2022 05:35:57 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31f443e276fso17893227b3.1
        for <linux-efi@vger.kernel.org>; Thu, 28 Jul 2022 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6kv977iX0DxQe8GqSszxDwkV+ebVuYMRRbZ1g3snjc=;
        b=v7uH8UZVPUY1DgE+baRwICn8k4lVtu4x39Wor3Siqsh5ebSZO6yD/Yux6yzwiRQH9Y
         t7flcF5rbKQPtcSbqdAeCfIh5F1wzgKosuS4A66Nj5mS1FxzuVEwlJAQYDZU7/KLY1DZ
         2bgWnL258OJuEzxrf4rPJ1VBLSie8koqO4vryM6xiJa+AKDMODACMzTsJHAbIjpcwgpw
         2V0FI9iCw+jkrjnWnc37TQ2neLspwkUEXgKYrEi2hIlRLqJJsI4LjdkWSZ+av1ph3O11
         9Na9kpX65gzqHrNLlBXA/KxWoMeQ9bx8QVqllwcC7REyDJf6KlnV6WTSOUlGR6qT/Zym
         /O9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6kv977iX0DxQe8GqSszxDwkV+ebVuYMRRbZ1g3snjc=;
        b=EkPDHCu9106qzfeTElFJ+G6OwAxBfrcrhSCzQu9/n8wXYvDSusszOeBmZ+v8KOTC5G
         WfANhzEn0k1L6tvz7aJikhr1ti3CtvjEEJq2f1UjhX5iuIDDDZNVfs5FCRU97vy/FnOP
         oYJUxw2+cbqobyybeIAzUjRH374fPhrs7RvTGVVZLnFhI5cOp5w6ignCPELJtmmJR9MW
         yQsMcm/JCNREaNFDnP/74R7yMaRofN5zUSJT5Wla/b9XAoG3/sSvcHBKKZ9L6oHNib5V
         U0awZVZbJ4TmKAxR7RvyMINLtTLVuzlzvXA5ZX9Vsi/Muj0tefmp0UBvceoyCfgdhR/S
         TIDg==
X-Gm-Message-State: ACgBeo2r8uDzpyHc3U3GAZplFZX/n/phRGPPNWCAQfE6M5bJ/glbiGIV
        qp2VKT681V5Wml/p7xl+sdJYkRVxR4Rern7jKT0+5g==
X-Google-Smtp-Source: AA6agR58r+D9gfe5rfd35JLF7P8cV3HvNf9eNcgRgUXYK/mn7Yvty9e/DoSp30m6KaxnofxrnwjnlxkivXa0NbBncqw=
X-Received: by 2002:a81:6a07:0:b0:323:8614:10c2 with SMTP id
 f7-20020a816a07000000b00323861410c2mr17175ywc.191.1659011756195; Thu, 28 Jul
 2022 05:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-5-luzmaximilian@gmail.com> <20220726143005.wt4be7yo7sbd3xut@bogus>
 <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com> <20220726154138.74avqs6iqlzqpzjk@bogus>
 <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com> <7284953b-52bb-37ac-fbe1-1fa845c44ff9@linaro.org>
 <3d752603-365d-3a33-e13e-ca241cee9a11@gmail.com> <20220727132437.pjob3z2nyxsuxgam@bogus>
 <CAC_iWj+Pn+h8k=fuDHzYwqD0g4m6jGRt8sCzcz+5+rYqvz9q4w@mail.gmail.com> <fd922f0f-99fd-55a3-a0b5-b62ad2dbfb45@gmail.com>
In-Reply-To: <fd922f0f-99fd-55a3-a0b5-b62ad2dbfb45@gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 28 Jul 2022 15:35:20 +0300
Message-ID: <CAC_iWjLWBJLth26ifFfHvimProHZu_w5SjQNWSH_D2Fs_JXjbA@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Maximilian

On Thu, 28 Jul 2022 at 13:48, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> On 7/28/22 08:03, Ilias Apalodimas wrote:
> > Hi all,
> >
> > On Wed, 27 Jul 2022 at 16:24, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>
> >> On Wed, Jul 27, 2022 at 03:03:49PM +0200, Maximilian Luz wrote:
> >>>
> >>> Is there really a good way around it?
> >>
> >> Yes rely on the firmware preferably auto discover, if that is not an option,
> >> how about query. It seem to be working in your case.
> >
> > That's a good point.  We have a similar situation with some Arm
> > devices and U-Boot.  Let me try to explain a bit.
> >
> > There's code plugged in in OP-TEE and U-Boot atm which allows you to
> > store EFI variables on an RPMB.  This is a nice alternative if your
> > device doesn't have any other secure storage,  however it presents
> > some challenges after ExitBootServices, similar to the ones you have
> > here.
> >
> > The eMMC controller usually lives in the non-secure world.  OP-TEE
> > can't access that, so it relies on a userspace supplicant to perform
> > the RPMB accesses.  That supplicant is present in U-Boot and
> > Get/SetVariable works fine before ExitBootServices.  Once Linux boots,
> >   the 'U-Boot supplicant' goes away and we launch the linux equivalent
> > one from userspace.  Since variable accessing is a runtime service and
> > it still has to go through the firmware we can't use those anymore
> > since U-Boot doesn't preserve the supplicant, the eMMC driver and the
> > OP-TEE portions needed in the runtime section(and even if it did we
> > would now have 2 drivers racing to access the same hardware).  Instead
> > U-Boot copies the variables in runtime memory and
> > GetVariable/GetNextVariable still works, but SetVariable returns
> > EFI_UNSUPPORTED.
> >
> > I've spent enough time looking at available solutions and although
> > this indeed breaks the EFI spec, something along the lines of
> > replacing the runtime services with ones that give you direct access
> > to the secure world, completely bypassing the firmware is imho our
> > least bad option.
>
> This sounds very similar to what Qualcomm may be doing on some devices.
> The TrEE interface allows for callbacks and there are indications that
> one such callback-service is for RPMB. I believe that at least on some
> platforms, Qualcomm also stores UEFI variables in RPMB and uses the same
> uefisecapp interface in combination with RPMB listeners installed by the
> kernel to access them.
>
> > I have an ancient branch somewhere that I can polish up and send an
> > RFC [1],  but the way I enabled that was to install an empty config
> > table from the firmware.  That empty table is basically an indication
> > to the kernel saying "Hey I can't store variables, can you do that for
> > me".
> >
> > Is there any chance we can do something similar on that device (or
> > find a reasonable way of inferring that we need to replace some
> > services).  That way we could at least have a common entry point to
> > the kernel and leave out the DT changes.
> >
> > [1] https://git.linaro.org/people/ilias.apalodimas/net-next.git/log/?h=setvar_rt_optee_3
>
> I would very much like to avoid the need for special bootloaders. The
> devices we're talking about are WoA devices, meaning they _should_
> ideally boot just fine with EFI and ACPI.

I've already responded to following email, but I'll repeat it here for
completeness. It's not a special bootloader.  It's the opposite, it's
a generic UEFI compliant bootloader which takes advantage of the fact
EFI is extensible. We are doing something very similar in how we load
our initrd via the EFI_LOAD_FILE2 protocol.  Whether Qualcomm can add
that to their bootloaders is a different topic though.  But at some
point we need to draw a line than keep overloading the DT because a
vendor decided to go down it's own path.

>
>  From an end-user perspective, it's annoying enough that we'll have to
> stick with DTs for the time being due to the use of PEPs in ACPI. I
> really don't want to add some special bootloader for fixups to that.
> Also, this would just move the problem from kernel to bootloader.

But it *is* a bootloader problem.  The bootloader is aware of the fact
that it can't provide runtime services for X reasons and that's
exactly why we are trying to set EFI_RT_PROPERTIES_TABLE correctly
from the firmware.  All we are doing is install a config table to tell
the OS "I can't do that, can you find a way around it?".

Regards
/Ilias

>
> If you have any suggestions for another way of detecting this, please
> feel free to share. I, unfortunately, don't.
>
> Regards,
> Max
