Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3638558385C
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 08:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiG1GEW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 02:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiG1GEV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 02:04:21 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8295C955
        for <linux-efi@vger.kernel.org>; Wed, 27 Jul 2022 23:04:20 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31f661b3f89so8450807b3.11
        for <linux-efi@vger.kernel.org>; Wed, 27 Jul 2022 23:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CA4wATDSYUWB9Gpjzl6nBaY/UX8ZMyWfJ9JqsbS9J10=;
        b=ZqZo9AKJEwlaUWQDb0iOO1tLCjpPom4IAWxcinWucbh9rSYXGka3QSSV/Z5Ce/Vtxd
         G1TBGbz4Uq9bTL/e0Hf4maFiVDLquc6ak5ku7fvn2gXLCdKIrC+C/ZTmDsdXuMWaACa/
         h1z2tZU7fQcrxPlJK45IFfQ28LuocH021UpxVapmlB0Zl9aADmjaV0uLNL5xoXDQj540
         7QwMs6JmAlfImuFEbkbaEKVn0yJIr3WaG85YkWbbmNPNrB44AB6OC61n5Ju0OpFxqioz
         TXBNHzP8wT2hIEXD8qy2cGYctY5p7Q+5BY4mEp/yffq1u0YiPQWQB4HvxIEnwpLXefU7
         OWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CA4wATDSYUWB9Gpjzl6nBaY/UX8ZMyWfJ9JqsbS9J10=;
        b=ItjcgyhoUVmLInw+85p7/mFkspKkncoTkkG4MI+76DQuZGGHVKY8AnM11X25Y2HMZN
         GvDXoavSNXQisLUHP8zDgVbxsLmxB89ZaVhgnwF89MwF3ECZKMxGzewkZmGayIJX9wr4
         8nMK/S7CuFwRhzKi32fUp+z9pV3nTCs0lko4kyspCVnYtTmWQoxF/xxz02bGmf+aIE2q
         EhEoRmx+9NEOqDERGa8I1SpHOaXft3KV4EBz8c6YLpyTlwX01/boxHRzHE188isBvrhL
         DLlG2COlhZRqn8W7+jWgu9g1T6rBaCDN+nVZSSEPcg/jLyIl1XBiGu1l5NQQDzOeE+F0
         3HWg==
X-Gm-Message-State: AJIora/IVNFQeApxi35zO5RQE4LI3bpcJ1vcFGl926IbWOHkVLhor2dw
        S+RdHyChZfdmyLJUuI7lmyWX/ALcINoDlCB1xLT+/g==
X-Google-Smtp-Source: AGRyM1udlf3/HhTv0KnlYVLgoG36EzZB0C9m8/ZLmxBcNlB5imRW/rCGDa9yRafy4GMMrBICMoGoRw64/lyMtA4d3Bo=
X-Received: by 2002:a81:d542:0:b0:31e:c878:7565 with SMTP id
 l2-20020a81d542000000b0031ec8787565mr21125377ywj.382.1658988259228; Wed, 27
 Jul 2022 23:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-5-luzmaximilian@gmail.com> <20220726143005.wt4be7yo7sbd3xut@bogus>
 <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com> <20220726154138.74avqs6iqlzqpzjk@bogus>
 <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com> <7284953b-52bb-37ac-fbe1-1fa845c44ff9@linaro.org>
 <3d752603-365d-3a33-e13e-ca241cee9a11@gmail.com> <20220727132437.pjob3z2nyxsuxgam@bogus>
In-Reply-To: <20220727132437.pjob3z2nyxsuxgam@bogus>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 28 Jul 2022 09:03:42 +0300
Message-ID: <CAC_iWj+Pn+h8k=fuDHzYwqD0g4m6jGRt8sCzcz+5+rYqvz9q4w@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi all,

On Wed, 27 Jul 2022 at 16:24, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jul 27, 2022 at 03:03:49PM +0200, Maximilian Luz wrote:
> >
> > Is there really a good way around it?
>
> Yes rely on the firmware preferably auto discover, if that is not an option,
> how about query. It seem to be working in your case.

That's a good point.  We have a similar situation with some Arm
devices and U-Boot.  Let me try to explain a bit.

There's code plugged in in OP-TEE and U-Boot atm which allows you to
store EFI variables on an RPMB.  This is a nice alternative if your
device doesn't have any other secure storage,  however it presents
some challenges after ExitBootServices, similar to the ones you have
here.

The eMMC controller usually lives in the non-secure world.  OP-TEE
can't access that, so it relies on a userspace supplicant to perform
the RPMB accesses.  That supplicant is present in U-Boot and
Get/SetVariable works fine before ExitBootServices.  Once Linux boots,
 the 'U-Boot supplicant' goes away and we launch the linux equivalent
one from userspace.  Since variable accessing is a runtime service and
it still has to go through the firmware we can't use those anymore
since U-Boot doesn't preserve the supplicant, the eMMC driver and the
OP-TEE portions needed in the runtime section(and even if it did we
would now have 2 drivers racing to access the same hardware).  Instead
U-Boot copies the variables in runtime memory and
GetVariable/GetNextVariable still works, but SetVariable returns
EFI_UNSUPPORTED.

I've spent enough time looking at available solutions and although
this indeed breaks the EFI spec, something along the lines of
replacing the runtime services with ones that give you direct access
to the secure world, completely bypassing the firmware is imho our
least bad option.

I have an ancient branch somewhere that I can polish up and send an
RFC [1],  but the way I enabled that was to install an empty config
table from the firmware.  That empty table is basically an indication
to the kernel saying "Hey I can't store variables, can you do that for
me".

Is there any chance we can do something similar on that device (or
find a reasonable way of inferring that we need to replace some
services).  That way we could at least have a common entry point to
the kernel and leave out the DT changes.

[1] https://git.linaro.org/people/ilias.apalodimas/net-next.git/log/?h=setvar_rt_optee_3

Thanks
/Ilias

>
> > As far as I can see the alternative (especially for the apps that
> > need to be loaded manually) is hard-coding everything in the driver.
> > Which IMHO just spreads device specific information everywhere.
> >
>
> It may not be too bad compared to putting loads of firmware details
> in the DT. What happens if you get a firmware upgrade with changed
> number of firmware entities or even if the names are changed.
>
> Are these name user ABI in a way that they won't be changed ? Generally
> these entities tend to use UUID and the name you have might get changed.
>
> I would ideally prefer even the name to be supplied from the userspace.
> In this particular case, make this a driver and have the name as the
> parameter. If the secure side services are used by some non-secure
> applications, then you will need to have a user-interface which means
> you can get the named from the userspace. No need to change the driver
> in either case. Please let me know if I am missing anything to consider
> here.
>
> > Also: Let's use the TPM app as example. If that would be a SPI or I2C
> > device, you'd model it in the DT. Just because it's a hardware device
> > that's accessible via SCM/firmware you now don't?
> >
>
> Not sure if I understand the comparison here. But if there is some device
> that is access restricted but needs to be accessed and has mechanism to
> access, then you would model it as device in DT.
>
> But the one $subject is addressing looks pure software and doesn't make
> sense to model in DT IMO.
>
> > If I were absolutely certain that there is a reliable mechanism to
> > detect these apps, I'd agree with having a driver to instantiate those
> > devices. But I am not.
> >
>
> You did say you use some query API to check this. I haven't seen the driver,
> so relying on what you said earlier.
>
> --
> Regards,
> Sudeep
