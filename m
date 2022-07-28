Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F10A583EC4
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 14:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbiG1MZC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 08:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238371AbiG1MYy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 08:24:54 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FF66C109
        for <linux-efi@vger.kernel.org>; Thu, 28 Jul 2022 05:24:52 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-32269d60830so17555577b3.2
        for <linux-efi@vger.kernel.org>; Thu, 28 Jul 2022 05:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPGazMImeq7ZTnaeZ4AGBk0ohlKyyO3QqrKwonvdhpM=;
        b=fvhONg60bsGwrIHA6bNhsT18PaJmu/2fNF1Lc/SzqBFyU6F7SX+QoTz7oJj0Eo+Bcp
         YK4p49P2pJjPF6JoiUeG6RQFeNk5awUnc8amp9wuZAJOeLBxqlIFnJtsnW8KKJnPKAlO
         HlEwteYdyw6ojA1RB10fyUenKWffwJimbpG5FHibao9UhPDS8OMTPBZrHur0hYfxxut+
         o4+K0QCpXOfJfkn0u+VaAsk+CiaddG3CfVz13pCC2alc0np/Kt2D1N1hg8DGtFvigmwA
         0tW0GV6TO88ORk1mwskI8ONAivniVnCEa9ZlXYUm2QnRLGkJZNWuxoZq4EwPUcXwoSZl
         KAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPGazMImeq7ZTnaeZ4AGBk0ohlKyyO3QqrKwonvdhpM=;
        b=YU7hDSdEHaM45Rlvwf5kT457Cv7G6BPtcrRM5aaxbRmXFxL5DZ0njo1qtDcoOHx3mK
         09qxrkDkvr2q6wYQwvqdniXjccXegzFMaHfblDi+YRfXif3rMpQ0zCDMmYMhPvJ3RuTA
         KGKbUR5DwzSAqD5K8FdxwVehW3/0hBEe1AqJSITBntzLfLFMaJfOP2daeMirU8xMsFfH
         Tw7IGCMCag6Jqnu9pJ11qSZFwrgGCveGlerP1AhL3uAVSkt/bgJMSsB+3hGDidA+05JQ
         oWwdo/OI0QRa5PnVDDBRuss67bOFAKifwsuILWknkLoVaxNf6YCHv+PB4YPxkouqWPno
         woOA==
X-Gm-Message-State: AJIora8RaFFA8Q9ZYU7ab8mUrXmci6wmnuUtaxac5HbcXtQHT77g7y65
        HmdsmYAf56Jz6PSQT3JsHjDRCGZK9HA4jPxUdIKvgQ==
X-Google-Smtp-Source: AGRyM1vI7wkmsv9IiuZ7uHDOT8/GD4OMIdM7ZmEHjlWiZkaeOZ1vzw9DdzMlOn/B2DaC5n+8y5yYKGlcs1IlnUMRpcQ=
X-Received: by 2002:a81:e03:0:b0:31f:4e64:3e9e with SMTP id
 3-20020a810e03000000b0031f4e643e9emr10513132ywo.128.1659011091852; Thu, 28
 Jul 2022 05:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220723224949.1089973-5-luzmaximilian@gmail.com>
 <20220726143005.wt4be7yo7sbd3xut@bogus> <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com>
 <20220726154138.74avqs6iqlzqpzjk@bogus> <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com>
 <7284953b-52bb-37ac-fbe1-1fa845c44ff9@linaro.org> <3d752603-365d-3a33-e13e-ca241cee9a11@gmail.com>
 <20220727132437.pjob3z2nyxsuxgam@bogus> <CAC_iWj+Pn+h8k=fuDHzYwqD0g4m6jGRt8sCzcz+5+rYqvz9q4w@mail.gmail.com>
 <fd922f0f-99fd-55a3-a0b5-b62ad2dbfb45@gmail.com> <20220728113347.ver6argevzmlsc2c@bogus>
In-Reply-To: <20220728113347.ver6argevzmlsc2c@bogus>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 28 Jul 2022 15:24:15 +0300
Message-ID: <CAC_iWjLkSkON99xXoXphY4JWDZXy_OuOye3T_vPru8aj+j=abw@mail.gmail.com>
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

On Thu, 28 Jul 2022 at 14:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Jul 28, 2022 at 12:48:19PM +0200, Maximilian Luz wrote:
>
> [...]
>
> >
> > I would very much like to avoid the need for special bootloaders. The
> > devices we're talking about are WoA devices, meaning they _should_
> > ideally boot just fine with EFI and ACPI.
> >
>
> Completely agreed.

This is not a special bootloader though.  Quite the opposite.  It's a
standard UEFI compliant bootloader, which uses the fact that EFI is
supposed to be extensible.  It installs a linux specific config table,
similar to how we install a linux specific protocol to load our initrd
and it's certainly lot more scalable than adding new stuff to the
device tree.

>
> > From an end-user perspective, it's annoying enough that we'll have to
> > stick with DTs for the time being due to the use of PEPs in ACPI.
>
> But have we explored or investigated what it takes to rewrite ACPI f/w
> to just use standard methods ? Does it require more firmware changes or
> new firmware entities or impossible at any cost ?
>
> For me that is more important than just getting this one on DT. Because
> if you take that path, we will have to keep doing that, with loads of
> unnecessary drivers if they are not shared with any other SoC with DT
> support upstream. We might also miss chance to get things added to the ACPI
> spec as we don't care which means that we never be able to use ACPI on
> similar future platforms even though they get shipped with ACPI.
>
> It will be a loop where we constantly keep converting this ACPI shipped
> platform into DT upstream. IMHO we don't want to be there.
>
> --
> Regards,
> Sudeep

Regards
/Ilias
