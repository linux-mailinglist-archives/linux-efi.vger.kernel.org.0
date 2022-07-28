Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95A1584478
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 18:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiG1Q4k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 12:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiG1Q4j (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 12:56:39 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7189C5F9AF
        for <linux-efi@vger.kernel.org>; Thu, 28 Jul 2022 09:56:37 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3238de26fb1so7401917b3.8
        for <linux-efi@vger.kernel.org>; Thu, 28 Jul 2022 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oc0lYZZen+n96H3YkJlz8amsnvCsXfd6yw7H3HRAv34=;
        b=LvEPmb5gwSpnB2b/XfP2TsjWKUpKxjPvyNp/0TXuTe4dFBociwyBIFRmRBMgLufeqQ
         JbU7CU+ASwWDDo1aahIXU8O8h5SOOSRK/N7ugORv963f/VE1GEuPnMhMlQm0dNeH/unJ
         nZhQsjgzp0g4VX+AN+FU04VjYDYJp7WRZiDRl6Yk8NynNfO4fn8O01ME0GF3gijiDDkt
         k/OamyyajXQvcH/bO9zXFot9OOwaauBMAUwcR/pb/W4OfhawaBwLPrHvpv3AsRGuYRqF
         k9kdy25z5AKsLkQFzaEWhfsA7PJhpB9XiDCdiUa/axhtsSe6qASTK67wSRx9/5cXQE8v
         g74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oc0lYZZen+n96H3YkJlz8amsnvCsXfd6yw7H3HRAv34=;
        b=hoAxPYY+zAxTtMIjvowSXiVvg+qnsr5xFcMH4PDXcSlZG9JSo/NTM9GWCdGU73AmAQ
         roCy2sjvGUztV9KsgF6B6Yxv4G2u+O1HurfHoTdAb/1igaCv4fFaLIV1LOM3wQyNJY9/
         Fgc/MAOsBaDY5fSExs29J8NJhVToOZe4FmnpHbkfK+/WMrfsckDzDhDNm4e5QC5mzXUr
         QUY10W9Xg1R8KfWSFb6ytBB8ZcVfqR91/dV6qzz5JvsnJ3mhwaEoSMgeS1Ubmy7K+dum
         kI9SMVdJrS8whMIrui+WgiUq9CxmE7j5+xo6Nh64MtCASySo34FXxJZitSl15bWTq1xc
         jquw==
X-Gm-Message-State: ACgBeo0TnoogRPpMcAigrnR6VbS73mC/NcWxAoM8mWq10YV2zFDSY9pb
        8RqcWRj+ySrdGfuF+NHcfCnuU39VOxAFOMtvc2sKGQ==
X-Google-Smtp-Source: AA6agR42EGEUyzYTo3gBZ8QlvPbpFDUMcDOY9xlNbtBF0J/wWPwVHlB4+Nl+tb/UgglFFTHYed3NhawdldcN4gc+Y2E=
X-Received: by 2002:a81:6a07:0:b0:323:8614:10c2 with SMTP id
 f7-20020a816a07000000b00323861410c2mr1192910ywc.191.1659027396641; Thu, 28
 Jul 2022 09:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-5-luzmaximilian@gmail.com> <20220726143005.wt4be7yo7sbd3xut@bogus>
 <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com> <20220726154138.74avqs6iqlzqpzjk@bogus>
 <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com> <7284953b-52bb-37ac-fbe1-1fa845c44ff9@linaro.org>
 <3d752603-365d-3a33-e13e-ca241cee9a11@gmail.com> <20220727132437.pjob3z2nyxsuxgam@bogus>
 <CAC_iWj+Pn+h8k=fuDHzYwqD0g4m6jGRt8sCzcz+5+rYqvz9q4w@mail.gmail.com>
 <fd922f0f-99fd-55a3-a0b5-b62ad2dbfb45@gmail.com> <CAC_iWjLWBJLth26ifFfHvimProHZu_w5SjQNWSH_D2Fs_JXjbA@mail.gmail.com>
 <b703f678-b2c5-cdeb-ac40-9646e043d1c3@gmail.com>
In-Reply-To: <b703f678-b2c5-cdeb-ac40-9646e043d1c3@gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 28 Jul 2022 19:56:00 +0300
Message-ID: <CAC_iWjLrntWuJUzVuRi0ZOtG6JXNwz7SbS2mrqpuTgU5TV6rQA@mail.gmail.com>
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

On Thu, 28 Jul 2022 at 15:49, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>

[...]

> >>
> >>> I have an ancient branch somewhere that I can polish up and send an
> >>> RFC [1],  but the way I enabled that was to install an empty config
> >>> table from the firmware.  That empty table is basically an indication
> >>> to the kernel saying "Hey I can't store variables, can you do that for
> >>> me".
> >>>
> >>> Is there any chance we can do something similar on that device (or
> >>> find a reasonable way of inferring that we need to replace some
> >>> services).  That way we could at least have a common entry point to
> >>> the kernel and leave out the DT changes.
> >>>
> >>> [1] https://git.linaro.org/people/ilias.apalodimas/net-next.git/log/?h=setvar_rt_optee_3
> >>
> >> I would very much like to avoid the need for special bootloaders. The
> >> devices we're talking about are WoA devices, meaning they _should_
> >> ideally boot just fine with EFI and ACPI.
> >
> > I've already responded to following email, but I'll repeat it here for
> > completeness. It's not a special bootloader.  It's the opposite, it's
> > a generic UEFI compliant bootloader which takes advantage of the fact
> > EFI is extensible. We are doing something very similar in how we load
> > our initrd via the EFI_LOAD_FILE2 protocol.  Whether Qualcomm can add
> > that to their bootloaders is a different topic though.  But at some
> > point we need to draw a line than keep overloading the DT because a
> > vendor decided to go down it's own path.
>
> But still, you're asking users to install an extra thing in the boot
> chain.

Not users.  EFI firmware implementations that want to support this in
a generic way.

> That's what I mean by "special". So the situation would then be
> this: User needs a) GRUB (or something similar) for booting the kernel
> (or dual-booting, ...), b) DTBLoader for loading the device-tree because
> we don't support the ACPI Qualcomm provided, and c) your thing for EFI
> variables and potentially other firmware fix-ups. b) and c) are both
> things that "normal" users don't expect. IMHO we should try to get rid
> of those "non-standard" things, not add more.

But that's exactly why EFI is extensible .  You can have non standard
functionality on your firmware for cases like this which doesn't need
to land in the spec.

>
> >>   From an end-user perspective, it's annoying enough that we'll have to
> >> stick with DTs for the time being due to the use of PEPs in ACPI. I
> >> really don't want to add some special bootloader for fixups to that.
> >> Also, this would just move the problem from kernel to bootloader.
> >
> > But it *is* a bootloader problem.  The bootloader is aware of the fact
> > that it can't provide runtime services for X reasons and that's
> > exactly why we are trying to set EFI_RT_PROPERTIES_TABLE correctly
> > from the firmware.  All we are doing is install a config table to tell
> > the OS "I can't do that, can you find a way around it?".
>
> Sure, but is making the Linux installation process more device
> dependent and complicated really the best way to solve this?

Isn't it device dependent already?  That boat has sailed already since
we need to change the very definition of runtime services and replace
them with OS specific ones.  If we add it on the DT, you'll end up
with different DTs per OS and potentially per use case.  In my head
the DTs should be part of the firmware (and authenticated by the
firmware as well) instead of loading whatever we want each time.  By
using a config table we can add a u64 (random thought),  that tells
the kernel which TEE implementation will handle variable storage.  So
we can have a common extension to boot loaders, which at least uses
EFI interfaces to communicate the functionality.

I really prefer this to adding it on a DT, but I am not that picky.
Your email raises an important topic of replacing runtime services
with OS specific ones,  which is unfortunately very much needed and we
should fix that.

Thanks
/Ilias
>
> Regards,
> Max
