Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F60558428D
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 17:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiG1PGQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 11:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiG1PGP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 11:06:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37464AE75;
        Thu, 28 Jul 2022 08:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE40AB82491;
        Thu, 28 Jul 2022 15:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E41C43141;
        Thu, 28 Jul 2022 15:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659020771;
        bh=NM84GNzQ51TWu6N75z7AX4sq36naZosL0siQUhNUFBQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SmVf177Y7g4o3fC3EZeRmI6afB70te8Box9vOzakNHqGCbxMa8278+LisvG7Ep2r+
         gQQiueN8gA7JQq+j/vOdh+elKs24LHuD5WX4/zq2MDb3fN7e3TmXE6PcRUv7kCakKr
         RCtf2L7+HNRg+g1w4NTWwPPngaQZLIQjcNJT8j9f0JwLnliGxSYdkQqHBUx+yrBeDW
         m8pwQtmYANkg0P+qil/emW0hqqgdy5jSsSp+130n2AqywFtZYHfvn/r5WbN+3xDEQC
         MoJ4qCq1WL+z1L2c7OuoUur0hIykP56dspQNKSPezSUyGXhiOP7FtpF3qkGQGurJ3r
         tO3Hq01I/7Bvw==
Received: by mail-oo1-f44.google.com with SMTP id u7-20020a4a8c07000000b00435ac1584a6so335212ooj.1;
        Thu, 28 Jul 2022 08:06:11 -0700 (PDT)
X-Gm-Message-State: AJIora8hQ6WXO6HnRAlKjt+cbGDiQ656MY4+r2wFywMYZwB2NlQCv42E
        wJDjSsg+HoFoLmENc0sPppzogUsGZ98+xIJg7Qk=
X-Google-Smtp-Source: AGRyM1ubtbHii63XRa1+hTJtbnkIC8mOfe7viYVXCQ4Gn4sZTlgwyypYYYcpnqmPTAoHcfwmZSnScLQVgBIIathxDwo=
X-Received: by 2002:a4a:cb10:0:b0:435:9075:a86b with SMTP id
 r16-20020a4acb10000000b004359075a86bmr9416019ooq.98.1659020770744; Thu, 28
 Jul 2022 08:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220723224949.1089973-5-luzmaximilian@gmail.com>
 <20220726143005.wt4be7yo7sbd3xut@bogus> <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com>
 <20220726154138.74avqs6iqlzqpzjk@bogus> <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com>
 <7284953b-52bb-37ac-fbe1-1fa845c44ff9@linaro.org> <3d752603-365d-3a33-e13e-ca241cee9a11@gmail.com>
 <20220727132437.pjob3z2nyxsuxgam@bogus> <CAC_iWj+Pn+h8k=fuDHzYwqD0g4m6jGRt8sCzcz+5+rYqvz9q4w@mail.gmail.com>
 <fd922f0f-99fd-55a3-a0b5-b62ad2dbfb45@gmail.com> <20220728113347.ver6argevzmlsc2c@bogus>
In-Reply-To: <20220728113347.ver6argevzmlsc2c@bogus>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 28 Jul 2022 08:05:58 -0700
X-Gmail-Original-Message-ID: <CAMj1kXHYb-zrKOS_titU79c487ab9WPyKwJBXuj7pdqum=ygaA@mail.gmail.com>
Message-ID: <CAMj1kXHYb-zrKOS_titU79c487ab9WPyKwJBXuj7pdqum=ygaA@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 28 Jul 2022 at 04:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
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

Supporting these devices in Linux in ACPI mode would involve
reimplementing the PEP subsystem, and reimplementing PEP drivers for
all these QCOM peripherals to manage the probing and the power states.
I don't think this is realistic at all, and a huge waste of
engineering effort otherwise.

It is also orthogonal to the discussion, as far as I understand: ACPI
is not telling the system whether or not these TZ services should be
used instead of EFI runtime calls.

So I think this is a reasonable way to expose these EFI services,
although I am not thrilled about the fact that it is needed.
Surprisingly, Microsoft also supports this model both on x86 and arm64
for platforms that keep their variables on eMMC (or any other kind of
storage that sits behind a controller that cannot be shared between
the OS and the firmware). So if we agree that we will support these
systems as best we can, supporting EFI variables at runtime is
something that we should support as well. (Note that I am not
convinced about the latter point myself: on many systems, the EFI
variable store is used precisely once, when GRUB gets installed and
its path added to the boot order, so if we could find a way to
streamline that without EFI runtime services, the story around why EFI
runtime services are important becomes quite weak)

As for the use of efivars_register(): I think this is reasonable, and
the way these patches use it is exactly why it exists in the first
place. Do not that a substantial overhaul of efivars is queued up in
efi/next, although I suspect those changes do not conflict with this
series.
