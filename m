Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82A8587DD5
	for <lists+linux-efi@lfdr.de>; Tue,  2 Aug 2022 16:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbiHBODC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Aug 2022 10:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbiHBOCj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Aug 2022 10:02:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA3C2CCBB;
        Tue,  2 Aug 2022 07:02:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18B8861470;
        Tue,  2 Aug 2022 14:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E3FC433C1;
        Tue,  2 Aug 2022 14:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659448949;
        bh=9x8ASZ0DiQgO5GNP2Mu6gvzA5hkYQ45AJslM0qDehok=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vDblaSuPvLl+nPY4rTYEgQYQmOu7xnBbaFZQ1DS6DpW29hypZFzjTo2dZORIMQEog
         4HYtAhBYTBUHrqnwX/sK65wjMCec1VYVM9xeYqSkHAM+tuYfFWkhVugNJceDjeSxx2
         +jxKBkyJL0xsfBLV5Hh3Rj8rrrgBQcdrr7eSgKOPQfB5hcXLxPaTwdrTFGkTHJvkWZ
         3Sh6/9Kq8A1kw5sRKBt5gybbcyKhv/loE5AzXiPldDsyw5m65F7i2n8+atBot+PQT3
         Vo6MS0yKGg2sZQTVgEGetNeb/0YeM4PJnmT5Q45y1mrRD6mPcigGptJ/a67+ntU3L9
         Vv+ElTHoEuMbw==
Received: by mail-oi1-f179.google.com with SMTP id u9so16582429oiv.12;
        Tue, 02 Aug 2022 07:02:29 -0700 (PDT)
X-Gm-Message-State: AJIora9hc1sl82UhiFy6Qwj1Kfs7ZppOdS4j53UnNfxTzw1hrBoQP7d+
        9fovh1dVVbcjotOPQ6qUy7o8mq11Xve3bE6biSQ=
X-Google-Smtp-Source: AGRyM1vhdcxaJSMtWocwq78kAx7+XyhE96BKlFzWeNKFk3pe34YuksL1BZV9jZwcA2lETmfrhztmwIL9yTNqxjT8Lg0=
X-Received: by 2002:a05:6808:1489:b0:33a:861c:838e with SMTP id
 e9-20020a056808148900b0033a861c838emr8253279oiw.228.1659448948586; Tue, 02
 Aug 2022 07:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <dfd07f84-c4bd-a18c-2263-49f999f2934c@linaro.org> <f42539d0-c2a3-a2b2-c35b-b7a5904b376f@gmail.com>
In-Reply-To: <f42539d0-c2a3-a2b2-c35b-b7a5904b376f@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 2 Aug 2022 16:02:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXExyKKHK0A48vmqxqRHrT+xgDt3qB1gHvJ31gPAeE2KSA@mail.gmail.com>
Message-ID: <CAMj1kXExyKKHK0A48vmqxqRHrT+xgDt3qB1gHvJ31gPAeE2KSA@mail.gmail.com>
Subject: Re: [PATCH 0/4] firmware: Add support for Qualcomm UEFI Secure Application
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2 Aug 2022 at 15:22, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
>
>
> On 8/2/22 13:51, Srinivas Kandagatla wrote:
> > Hi Maximilian,
> >
> > On 23/07/2022 23:49, Maximilian Luz wrote:
> >> On modern Qualcomm platforms, access to EFI variables is restricted to
> >> the secure world / TrustZone, i.e. the Trusted Execution Environment
> >> (TrEE or TEE) as Qualcomm seems to call it. To access EFI variables, we
> >> therefore need to talk to the UEFI Secure Application (uefisecapp),
> >> residing in the TrEE.
> >>
> >> This series adds support for accessing EFI variables on those platforms.
> >>
> >> To do this, we first need to add some SCM call functions used to manage
> >> and talk to Secure Applications. A very small subset of this interface
> >> is added in the second patch (whereas the first one exports the required
> >> functions for that). Interface specifications are extracted from [1].
> >> While this does not (yet) support re-entrant SCM calls (including
> >> callbacks and listeners), this is enough to talk to the aforementioned
> >> uefisecapp on a couple of platforms (I've tested this on a Surface Pro X
> >> and heard reports from Lenovo Flex 5G, Lenovo Thinkpad x13s, and Lenovo
> >> Yoga C630 devices).
> >>
> >> The third patch adds a client driver for uefisecapp, installing the
> >> respective efivar operations. The application interface has been reverse
> >> engineered from the Windows QcTrEE8180.sys driver.
> >>
> >> Apart from uefisecapp, there are more Secure Applications running that
> >> we might want to support in the future. For example, on the Surface Pro
> >> X (sc8180x-based), the TPM is also managed via one.
> >>
> >> I'm not sure whether this should go to drivers/firmware or to
> >> drivers/soc/qcom. I've put this into firmware as all of this is
> >> essentially an interface to the secure firmware running in the TrustZone
> >> (and SCM stuff is handled here already), but please let me know if I
> >> should move this.
> >
> >  From what I see so far is that this is adapted from downstream qseecom driver, this approach could work for a limited usecases but not scalable, as we cannot add drivers for each Qualcomm specific TA in kernel.
> > This has to be handled in much generic way using Linux TEE framework, and let the userspace side deal with TA specific bits.
>
> I generally agree with the sentiment, however UEFI variables should IMHO be
> handled by the kernel. Moving handling of those to userspace breaks things like
> EFI-based pstore and efivarfs. The latter will in turn break some user-space
> tools (most notably efibootmgr used by e.g. GRUB and I think fwupdmgr which
> needs to set some capsule variables). Ideally, we would find a way to not break
> these, i.e. have them work out-of-the-box.
>

Only capsule-on-disk requires SetVariable() at runtime, and I doubt
whether these platforms implement any of that.

> A similar argumentation might apply to the TPM app.
>

There is a difference, though - the TPM is modeled as a device and
runtime access to it is implemented as a device driver, which is only
accessed from user space.

> > AFAIU, Qualcomm is moving away from qseecom interface to new smc-invoke interface, most of Qualcomm SoCs starting from SDM660 already have support to this.
> >
> > This interface provides a better abstracted IPC mechanism to talk to TA. Most of these TA specific interfaces are packed in closed userspace source.
> > Having said that QTEE smcinvoke driver can be modeled as a proper TEE driver with Userspace driving the TA specific bits using existing tee uapis.
> > This also brings in other features like loading, Listeners aka callbacks, secure memory allocations..etc.
> >
> > In the past, I have tried to do a prototype of this smcinvoke driver as a proper tee driver, incase you are interested patches are at https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=tracking-qcomlt-qcomtee
> > Plan is to discuss with Qualcomm and send it for upstream review.
>
> Thanks for this information! So as far as I understand it, this is currently an
> interface to user-space only, i.e. does not allow in-kernel drivers for apps?
> It would be great if this could then be extended to handle (the bare minimum
> of) in-kernel drivers (i.e. only things that the kernel itself needs, like EFI
> variables). Alternatively, I'm happy to hear suggestions on how we not break
> the aforementioned things while moving handling off to userspace.
>
> > I think its worth exploring if uefisecapp can talk smcinvoke.
> > I can ping Qualcomm engineers to see if that is doable.
>
> I think that would be great! Thanks!
>
> Regards,
> Max
