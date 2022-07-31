Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EF2585E5B
	for <lists+linux-efi@lfdr.de>; Sun, 31 Jul 2022 11:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiGaJyz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 31 Jul 2022 05:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbiGaJyu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 31 Jul 2022 05:54:50 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14C51209E
        for <linux-efi@vger.kernel.org>; Sun, 31 Jul 2022 02:54:48 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id o15so14548396yba.10
        for <linux-efi@vger.kernel.org>; Sun, 31 Jul 2022 02:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BsZfWrLyYjP0/eroAD6Tswpaa/jZnIwA/CULSdWEsRw=;
        b=Te2BLHgKyWcngv+lgmyImbh71a//Cv1duStFCayIsf0NUJPLngkUldq0f9S3qHK7Cx
         c/0zzsaMtN0H1qc9Du2fJt4BBAJHbKOC12EeBPe9qcZ4SexySj8dOm4sHreXcyfG6MAP
         YLps9hBwq0H97frk/FYEQgEw93EIKYleJUwyXyyghkNag4m0gP/KYmGiDlGo72fc8H2i
         9HXv/47I3Lo1HbyjZJ6ZNKEKeMhnYkP3KQ+2NIoTou3FNknkV32ZSU0e7T7ayzeUL4dk
         CG1xp8yBmEO3zY2hkSKezY6hmorwGhaERPgJc1L3P88xj+XzfaXeWQ5/FZce9JZG6dHe
         Q2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsZfWrLyYjP0/eroAD6Tswpaa/jZnIwA/CULSdWEsRw=;
        b=WWvGBEKVpTRTWZimvtAAyOo1Ui0NLT62i8AdZkZ1MT7eTVmkKIUHeK5MW8YrCmLvFL
         NkDrzVsWsnvD/0JqMV5qUfotgK4FMnMIsepW7XGI0tpWCmoNdErxaryAvSKDukEVvHnw
         xuu7Pgal/xLnP4WIGxzeuJbzqRRkpPxU5AwbLK+B+Fb8e7Qse+LEq+eavMhDmHjQ4VyK
         atEROCtRMeKODfc49DcR8Fly3jV+TE+zBq8T9v/lakH0Gez86Gh8vquSpTxdFB9sKG9o
         gLWFqPh5R1UhbSyfX1zXTuBZ38FwJWfOOJVHQHlqKlyq/2SGzWmJtdORgPa3jbtkVRaW
         hkFA==
X-Gm-Message-State: ACgBeo3VDa1CXwM7KxTlwdTfOcYszo4c2g7aWeMowRzBASTEi9eQC5IR
        BA/InzFGuTWBPh5F05Vlp4T9n+q2CcrCrgicdMNyPg==
X-Google-Smtp-Source: AA6agR47nDSR8GcbtgCBHh+yHO9YCzoEII6fBOCusqMmxOnIcuKViwritOpcw9qD7bVBj07lvPbygE5GF3WtPvievts=
X-Received: by 2002:a25:424f:0:b0:671:816f:6979 with SMTP id
 p76-20020a25424f000000b00671816f6979mr7555758yba.26.1659261287749; Sun, 31
 Jul 2022 02:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-5-luzmaximilian@gmail.com> <20220726143005.wt4be7yo7sbd3xut@bogus>
 <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com> <20220726154138.74avqs6iqlzqpzjk@bogus>
 <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com> <7284953b-52bb-37ac-fbe1-1fa845c44ff9@linaro.org>
 <3d752603-365d-3a33-e13e-ca241cee9a11@gmail.com> <20220727132437.pjob3z2nyxsuxgam@bogus>
 <CAC_iWj+Pn+h8k=fuDHzYwqD0g4m6jGRt8sCzcz+5+rYqvz9q4w@mail.gmail.com>
 <fd922f0f-99fd-55a3-a0b5-b62ad2dbfb45@gmail.com> <CAC_iWjLWBJLth26ifFfHvimProHZu_w5SjQNWSH_D2Fs_JXjbA@mail.gmail.com>
 <b703f678-b2c5-cdeb-ac40-9646e043d1c3@gmail.com> <CAC_iWjLrntWuJUzVuRi0ZOtG6JXNwz7SbS2mrqpuTgU5TV6rQA@mail.gmail.com>
 <d5a19e17-08eb-8bd6-ea18-5da638d13622@gmail.com>
In-Reply-To: <d5a19e17-08eb-8bd6-ea18-5da638d13622@gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Sun, 31 Jul 2022 12:54:11 +0300
Message-ID: <CAC_iWj+mEEAVzZ-_Cn9KKw6H9sUB9sz8f16neXi-wXFXWSLycg@mail.gmail.com>
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

Hi Maximilian,

On Thu, 28 Jul 2022 at 20:27, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>

[...]

> >>>>>
> >>>>> [1] https://git.linaro.org/people/ilias.apalodimas/net-next.git/log/?h=setvar_rt_optee_3
> >>>>
> >>>> I would very much like to avoid the need for special bootloaders. The
> >>>> devices we're talking about are WoA devices, meaning they _should_
> >>>> ideally boot just fine with EFI and ACPI.
> >>>
> >>> I've already responded to following email, but I'll repeat it here for
> >>> completeness. It's not a special bootloader.  It's the opposite, it's
> >>> a generic UEFI compliant bootloader which takes advantage of the fact
> >>> EFI is extensible. We are doing something very similar in how we load
> >>> our initrd via the EFI_LOAD_FILE2 protocol.  Whether Qualcomm can add
> >>> that to their bootloaders is a different topic though.  But at some
> >>> point we need to draw a line than keep overloading the DT because a
> >>> vendor decided to go down it's own path.
> >>
> >> But still, you're asking users to install an extra thing in the boot
> >> chain.
> >
> > Not users.  EFI firmware implementations that want to support this in
> > a generic way.
>
> The whole point here is that we don't have control over that. I'd like
> to fix the firmware, but we're talking about WoA devices where, let's
> face it, both device and SoC vendor don't really care about Linux. Even
> if you'd convince them to implement that for future generations, you'd
> still need them to push firmware updates for older generations.
> Generations that are end-of-life. IMHO, we should still try support
> those. Or we just say "sorry, Linux doesn't support that on your WoA
> device".

Yea we agree on that.  I've mentioned on a previous mail that whether
Qualcomm wants to support this in a generic way is questionable, since
we have no control over the firmware.  My only 'objection' is that the
kernel has a generic way of discovering which runtime services are
supported, which we will completely ignore based on some DT entries.

In any case let's find something that fits OP-TEE as well, since I can
send those patches afterwards.

>
> >> That's what I mean by "special". So the situation would then be
> >> this: User needs a) GRUB (or something similar) for booting the kernel
> >> (or dual-booting, ...), b) DTBLoader for loading the device-tree because
> >> we don't support the ACPI Qualcomm provided, and c) your thing for EFI
> >> variables and potentially other firmware fix-ups. b) and c) are both
> >> things that "normal" users don't expect. IMHO we should try to get rid
> >> of those "non-standard" things, not add more.
> >
> > But that's exactly why EFI is extensible .  You can have non standard
> > functionality on your firmware for cases like this which doesn't need
> > to land in the spec.
> >
> >>
> >>>>    From an end-user perspective, it's annoying enough that we'll have to
> >>>> stick with DTs for the time being due to the use of PEPs in ACPI. I
> >>>> really don't want to add some special bootloader for fixups to that.
> >>>> Also, this would just move the problem from kernel to bootloader.
> >>>
> >>> But it *is* a bootloader problem.  The bootloader is aware of the fact
> >>> that it can't provide runtime services for X reasons and that's
> >>> exactly why we are trying to set EFI_RT_PROPERTIES_TABLE correctly
> >>> from the firmware.  All we are doing is install a config table to tell
> >>> the OS "I can't do that, can you find a way around it?".
> >>
> >> Sure, but is making the Linux installation process more device
> >> dependent and complicated really the best way to solve this?
> >
> > Isn't it device dependent already?  That boat has sailed already since
> > we need to change the very definition of runtime services and replace
> > them with OS specific ones.  If we add it on the DT, you'll end up
> > with different DTs per OS and potentially per use case.  In my head
> > the DTs should be part of the firmware (and authenticated by the
> > firmware as well) instead of loading whatever we want each time.  By
> > using a config table we can add a u64 (random thought),  that tells
> > the kernel which TEE implementation will handle variable storage.  So
> > we can have a common extension to boot loaders, which at least uses
> > EFI interfaces to communicate the functionality.
>
> The only thing that is making the installation-process for end-users
> device dependent is installing the DTB. We can handle the device
> specific stuff in the kernel, just as we already handle buggy devices.
>
> Further, you seem to assume that these devices provide a DT in the first
> place. WoA devices use ACPI, so they don't. But for the time being (as
> discussed elsewhere) we unfortunately need to stick with DTs and can't
> really use ACPI. I agree that we should avoid OS and use-case specific
> DTs, but I don't see how this would make a DT use-case or OS specific.
> Things are firmware specific, the interface doesn't change with a
> different OS, and we're only indicating the presence of that interface.
>
> My current suggestion (already sent to Sudeep earlier) is (roughly)
> this: Add one compatible for the TrEE / TrustZone interface. Then decide
> to load or instantiate what needs to be loaded in the driver for that.
> That (depending on maybe SoC / platform / vendor) includes installing
> the efivar operations. This way we don't have to fill the DT with the
> specific things running in firmware.

As far as OP-TEE is concerned, I think we can make the 'feature'
discoverable.  I'll go propose that to op-tee but if that gets
accepted, we don't need any extra nodes (other than the existing one),
to wire up efivars_register().

Thanks
/Ilias
>
> Regards,
> Max
