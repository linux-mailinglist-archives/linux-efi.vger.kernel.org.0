Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FD2728FE7
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jun 2023 08:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbjFIGXe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Jun 2023 02:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbjFIGXb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Jun 2023 02:23:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FE93583
        for <linux-efi@vger.kernel.org>; Thu,  8 Jun 2023 23:23:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f619c2ba18so1666271e87.1
        for <linux-efi@vger.kernel.org>; Thu, 08 Jun 2023 23:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686291782; x=1688883782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ahb0lPOTs+JWWPyDMbaPFJT91yAHGxqRHu+CdUV2gP4=;
        b=Eke/dopk+z/dH0caUgvJ/beKIOT4JjX/KQ94l40rseaCcLN0bOjEVG74QTHKfFqjkW
         dJABbRaIWUyv61Yjb+54q3zhRtl8HbYgl9g9ZNTROqaonzZDeULX+LtQld1EhFLT/Gbv
         yMqjOwjU3YufETwnSSuDe7vGlHEH5haeuwHyBBnI4RKe1OE+kDCrZpvjP3PHrhxeHBtC
         1LbMLJEPETmuXa1JSfg2gnE7XLZpq307s6UHw0FfpsUVGSQiJOJ2gmNapT3U8kRp8xIt
         m58dd5l78sikdlSMvZorFmcfJ8Eywv6XbCEqUH8pYOHIB0dCxMtDWPDww21C0nyKsAqi
         HT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686291782; x=1688883782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahb0lPOTs+JWWPyDMbaPFJT91yAHGxqRHu+CdUV2gP4=;
        b=e10f7Oa+l6SHy+ctuNJKeSM3re6iDYeqoT/1JnlgrXDfFiWfwBKlbPHyZjh3GFc7bk
         UXs4X49pUD05H2xVt4/LZtfmHrcdquwAgY6UAboIaAWRAQyHKO1QFQs9QfjaSNEUr0Mi
         Bv+ZBJducCcxB/AxXqTF2QN6IVdaHKyHorV/A9a6+1n0tS4IM3FMuh6NvrQ3DCQg+JWz
         PzA60k21z5RnmUgsZVuPZVH/Zqor1jwthLNhJZKZdEbkNMg0Ci5o7gfr0YOe7Wr6qHUf
         19Jy3ZZrOtjbNJyMci8G5WNv4ePwwZVkXozy8BdWKGWakoGt2Tm/fsaiB0DD52eoEGjh
         kUrA==
X-Gm-Message-State: AC+VfDwDMlxGkXQNKA7ELq9Rb1MaKSG3mpiXWcp1P0ZGjxWwdJFS2/gD
        jKtWyr8++Em/JLaaP8/CC9SYZ6ArQrS1qw37K311jw==
X-Google-Smtp-Source: ACHHUZ5/Xgu3TuG4gH2BiHgtC5fGqWSnnE4lx/DOdjsaDRJH9VCdJ127BsqBmVezD46td6Izk71WYd8Xz/xUcgg/fj4=
X-Received: by 2002:a05:6512:3123:b0:4f3:a723:1dc6 with SMTP id
 p3-20020a056512312300b004f3a7231dc6mr203488lfd.52.1686291782326; Thu, 08 Jun
 2023 23:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <4ff09002-e871-38b9-43ec-227a64bac731@siemens.com> <CAC_iWjJJ5E9Q1or5yTiDynzv_WAYH-g+N24aRdu9rvcsbWqnrg@mail.gmail.com>
 <CAFA6WYNFYB1LiOFB_iwTsdD5PmnDdSbtDSH2J4FVFPx3uik8rQ@mail.gmail.com>
 <CAC_iWj+E7-XK6dCeSn4205K0O3EZCLxCaC+adu-14ST6sdudfA@mail.gmail.com>
 <76da826f-b608-6add-5401-6de818b180e3@siemens.com> <CAFA6WYPCDRjFzsUMU=SNzEt88nT7Fcm1eOFL8z4HiQO+=2JeVA@mail.gmail.com>
 <cc6bd203-83ea-c247-0986-7fec6f327ee8@siemens.com> <CAC_iWjKZNHJxq4VMFnV7oQngwBBCQveh=s34u1LZ59YUqViPbw@mail.gmail.com>
 <CAC_iWjJMv68yLC606SBhMmBYkR4wVC8SvUcPvNM=RX_qL=9Bvw@mail.gmail.com>
 <b9b8c1d3-fc8e-df94-d12b-a9e3debf3418@siemens.com> <CAC_iWj+cP4RfDNu_n-ZOp7A62W34drLpPszN_hrkqF_aPTLtMg@mail.gmail.com>
 <871ece13-7d6e-44d4-3bda-317658202f6f@siemens.com> <CAC_iWjKgCJWgKU8tC3Nfn-0CgwGhw89B3JpTgsjkjDDOcWZEdw@mail.gmail.com>
 <CAMj1kXGbXdbDr6DbyuziSFuxMgAimjNnkhqy8C-S5AbxdnixuQ@mail.gmail.com> <e0c71d88-ec5d-a348-0a53-ec6cea298b60@siemens.com>
In-Reply-To: <e0c71d88-ec5d-a348-0a53-ec6cea298b60@siemens.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Fri, 9 Jun 2023 09:22:26 +0300
Message-ID: <CAC_iWjJs7pw-iF-tRL6MpJ7O1PL0riJ7aD2DkpB0F9cDMaxuiw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
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

Hi Jan,

On Fri, 9 Jun 2023 at 09:16, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 08.06.23 15:52, Ard Biesheuvel wrote:
> > On Thu, 8 Jun 2023 at 08:22, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Jan
> >>
> >>
> >> On Wed, 7 Jun 2023 at 22:46, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>
> >>> On 07.06.23 20:17, Ilias Apalodimas wrote:
> >>>> On Wed, 7 Jun 2023 at 20:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>>>
> >>>>> On 07.06.23 18:59, Ilias Apalodimas wrote:
> >>>>>> On Wed, 7 Jun 2023 at 19:09, Ilias Apalodimas
> >>>>>> <ilias.apalodimas@linaro.org> wrote:
> >>>>>>>
> >>>>>>> Hi Jan,
> >>>>>>>
> >>>>>>> [...]
> >>>>>>>>>>> No I don't, this will work reliably without the need to remount the efivarfs.
> >>>>>>>>>>> As you point out you will still have this dependency if you end up
> >>>>>>>>>>> building them as modules and you manage to mount the efivarfs before
> >>>>>>>>>>> those get inserted.  Does anyone see a reasonable workaround?
> >>>>>>>>>>> Deceiving the kernel and making the bootloader set the RT property bit
> >>>>>>>>>>> to force the filesystem being mounted as rw is a nasty hack that we
> >>>>>>>>>>> should avoid.  Maybe adding a kernel command line parameter that says
> >>>>>>>>>>> "Ignore the RTPROP I know what I am doing"?  I don't particularly love
> >>>>>>>>>>> this either, but it's not unreasonable.
> >>>>>>>>>>
> >>>>>>>>>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
> >>>>>>>>>> basically this issue mapped on reboot/shutdown, I would really love to
> >>>>>>>>>> see the unhandy tee-supplicant daemon to be overcome.
> >>>>>>>>>
> >>>>>>>>> I have seen this error before and it has been on my todo list. So I
> >>>>>>>>> have tried to fix it here [1]. Feel free to test it and let me know if
> >>>>>>>>> you see any further issues.
> >>>>>>>>>
> >>>>>>>>> [1] https://lkml.org/lkml/2023/6/7/927
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Ah, nice, will test ASAP!
> >>>>>>>>
> >>>>>>>> Meanwhile more food: I managed to build a firmware that was missing
> >>>>>>>> STMM. But the driver loaded, and I got this:
> >>>>>>>
> >>>>>>> Thanks for the testing. I'll try to reproduce it locally and get back to you
> >>>>>>
> >>>>>> Can you provide a bit more info on how that was triggered btw? I would
> >>>>>> be helpful to know
> >>>>>>
> >>>>>> - OP-TEE version
> >>>>>
> >>>>> Today's master, 145953d55.
> >>>>>
> >>>>>> - was it compiled as a module or built-in?
> >>>>>
> >>>>> Sorry, not sure anymore, switching back and forth right now. I think it
> >>>>> was built-in.
> >>>>>
> >>>>>> - was the supplicant running?
> >>>>>
> >>>>> Yes.
> >>>>>
> >>>>
> >>>> Ok thanks, that helps.  I guess this also means U-Boot was compiled to
> >>>> store the variables in a file in the ESP instead of the RPMB right?
> >>>> Otherwise, I can't see how the device booted in the first place.
> >>>
> >>> U-Boot was not configured to perform secure booting in this case. It had
> >>> RPMB support enabled, just didn't have to use it.
> >>
> >> In your initial mail you said you managed to build a firmware without
> >> StMM.  If U-boot isn't reconfigured accordingly -- iow skip the EFI
> >> variable storage in an RPMB, the EFI subsystem will fail to start.
> >>
> >> In any case, I don't think the ooops you are seeing is not connected
> >> to this patchset.  Looking at the kernel EFI stub we only set the
> >> SetVariableRT if the RTPROP table is set accordingly by the firmware.
> >> U-Boot never sets the EFI_RT_SUPPORTED_SET_VARIABLE property since it
> >> can't support it.  What you are doing is remount the efivarfs as rw
> >> and then trying to set a variable, but the callback for it is  NULL.
> >> I think you'll be able to replicate the same behavior on the kernel
> >> without even inserting the new module.
>
> Might be true. I'll try to look into that again when the other dust settled.
>
> >
> > I have dropped this series from efi/next for now, given that it
> > obviously has problems in its current state.
> >
> > The risk of merging this now and fixing it later is that it may cause
> > regressions for early adopters that rely on the behavior we are
> > introducing here. Better to get this in shape first.
>
> On the one side, I'm sorry having ruined the merge, but my gut feeling
> is as well that this really needs to be reworked to get rid of the
> unfortunate tee-supplicant daemon. So far, we have to start the daemon
> from initrd, write a systemd service to adopt that instance, and make
> ftpm modular to remove it before terminating tee-supplicant (e.g. on
> system shutdown) - Sumit's patch didn't help there.
>

No worries, the whole functionality is intrusive, so I prefer going
through some iterations until everyone is happy.  OTOH the
'supplicant' problem isn't going away soon.  We will try to move it to
the kernel but that has some difficulties as well and it's going to
take some time.  In any case, we've lived with the supplicant for
quite some time and the ftpm module has a similar set of problems.
IOW there are kernel modules that depend on it.
From a functionality point of view nothing will change if the
supplicant gets moved to kernel space.  It  will just make distros
life easier and remove the supplicant dependency.  I've attached a
patch that solves both the kernel panic and the fortunate side-effect
is that you don't have to remount the efivarfs.  If people like it, I
can send it as a fix



Thanks
/Ilias
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
