Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82ADB5842C8
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiG1PQm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 11:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiG1PQl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 11:16:41 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294DE4F6B2
        for <linux-efi@vger.kernel.org>; Thu, 28 Jul 2022 08:16:40 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ef5380669cso22705937b3.9
        for <linux-efi@vger.kernel.org>; Thu, 28 Jul 2022 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I/V7r/JjnXzUGcT6ui2gSCucu1LvJKddLujQ+JW0ayQ=;
        b=gtAegM1F7Ga+mua1tY0e5tEW6tISaVKUX4kBorZeA23I7ZxrtAHlX6MMeI7VPUS7Z8
         JasOmqNpNBjQV13JSpTdrN/pR7yns90gilE4ACtbhzDK/p/HW6ySpgJ7CJZsLZNu2zNL
         CILNfwTlct/Rnd7xJdyp89hoOw+7XyPFNRCmIAzftsNXvDbdfKx3lCmeiCdfpMyMZKFu
         HYqcjJNSLeh7uKHSlcifaPueU54vOp10O3VVMNmFXGnlbYw61STJ0H+f1p0nssrlj7U5
         J5cNHKjJ1RyN9kDYIkTS3HSMcSDpTeVIFGPLgotsQ/pyJ6a3VvKsvzPZ3J147/XOnS+U
         WvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/V7r/JjnXzUGcT6ui2gSCucu1LvJKddLujQ+JW0ayQ=;
        b=SpaIsHj2DLT+nADRH21xH6+R30sk1CMEsIodyqNsTlxVauJhmZIb5wGL3l7wcx+Hdu
         823gzHfRIVxwgz5b1b2hOSi9R6l93HgVZovUwpYAh089zu6t8Hg9CvHMtMrqtnFVlPOd
         8x1qgbZNgtNCvi91y1k2Sy4Jpy0vPZDPcwQcAuYoRpTGTtn5p9hOPda9TVeKTkzu0+Hv
         YTlAr9mjdpMRzCZJZs/Um2QszCBVSH/BlvtpdYDEnHv5dMzb7BfiNmqFcstE088r7U6C
         yh5sV2y7EUvhwgBnXM8MC9NAZ6a9HS2oc9GP3hNxGYR7C6ShzQEmnrMB0Dlt9V8eHC/E
         oJkg==
X-Gm-Message-State: AJIora/peTQovdt5WWdI/2kA+zjuY0wazZqAXXteneAEV5WSMkQ0P1h5
        QZuyQ+jQjeQYMaVEMZy3mxfw+NQxG0bm22NBExOy3g==
X-Google-Smtp-Source: AGRyM1vcmGJ+mmue/tBswMy79EHyowZgJFZhNzrIrwc9P7sgN6Pu3ui4GIF00O3/ldF3QTLG8lR4xHsP9ul10IGd220=
X-Received: by 2002:a81:a149:0:b0:31f:fded:b121 with SMTP id
 y70-20020a81a149000000b0031ffdedb121mr5995007ywg.122.1659021399305; Thu, 28
 Jul 2022 08:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220723224949.1089973-5-luzmaximilian@gmail.com>
 <20220726143005.wt4be7yo7sbd3xut@bogus> <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com>
 <20220726154138.74avqs6iqlzqpzjk@bogus> <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com>
 <7284953b-52bb-37ac-fbe1-1fa845c44ff9@linaro.org> <3d752603-365d-3a33-e13e-ca241cee9a11@gmail.com>
 <20220727132437.pjob3z2nyxsuxgam@bogus> <CAC_iWj+Pn+h8k=fuDHzYwqD0g4m6jGRt8sCzcz+5+rYqvz9q4w@mail.gmail.com>
 <fd922f0f-99fd-55a3-a0b5-b62ad2dbfb45@gmail.com> <20220728113347.ver6argevzmlsc2c@bogus>
 <CAMj1kXHYb-zrKOS_titU79c487ab9WPyKwJBXuj7pdqum=ygaA@mail.gmail.com>
In-Reply-To: <CAMj1kXHYb-zrKOS_titU79c487ab9WPyKwJBXuj7pdqum=ygaA@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 28 Jul 2022 18:16:03 +0300
Message-ID: <CAC_iWjJTENeF_4jvD0VGo_mbtw0ZH2xd9oX2JdvJJFK=vAxBcw@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Ard,

[...]

> > > From an end-user perspective, it's annoying enough that we'll have to
> > > stick with DTs for the time being due to the use of PEPs in ACPI.
> >
> > But have we explored or investigated what it takes to rewrite ACPI f/w
> > to just use standard methods ? Does it require more firmware changes or
> > new firmware entities or impossible at any cost ?
> >
> > For me that is more important than just getting this one on DT. Because
> > if you take that path, we will have to keep doing that, with loads of
> > unnecessary drivers if they are not shared with any other SoC with DT
> > support upstream. We might also miss chance to get things added to the ACPI
> > spec as we don't care which means that we never be able to use ACPI on
> > similar future platforms even though they get shipped with ACPI.
> >
> > It will be a loop where we constantly keep converting this ACPI shipped
> > platform into DT upstream. IMHO we don't want to be there.
> >
>
> Supporting these devices in Linux in ACPI mode would involve
> reimplementing the PEP subsystem, and reimplementing PEP drivers for
> all these QCOM peripherals to manage the probing and the power states.
> I don't think this is realistic at all, and a huge waste of
> engineering effort otherwise.
>
> It is also orthogonal to the discussion, as far as I understand: ACPI
> is not telling the system whether or not these TZ services should be
> used instead of EFI runtime calls.
>
> So I think this is a reasonable way to expose these EFI services,
> although I am not thrilled about the fact that it is needed.
> Surprisingly, Microsoft also supports this model both on x86 and arm64
> for platforms that keep their variables on eMMC (or any other kind of
> storage that sits behind a controller that cannot be shared between
> the OS and the firmware). So if we agree that we will support these
> systems as best we can, supporting EFI variables at runtime is
> something that we should support as well. (Note that I am not
> convinced about the latter point myself: on many systems, the EFI
> variable store is used precisely once, when GRUB gets installed and
> its path added to the boot order, so if we could find a way to
> streamline that without EFI runtime services, the story around why EFI
> runtime services are important becomes quite weak)

Unfortunately this is not entirely true.  Yes the majority of use
cases is what you describe, however we also need SetVariable for
capsule update on disk.

[...]
