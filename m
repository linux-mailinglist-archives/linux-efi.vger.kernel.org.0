Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB09727736
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jun 2023 08:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjFHGWW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jun 2023 02:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbjFHGWV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Jun 2023 02:22:21 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDE8E62
        for <linux-efi@vger.kernel.org>; Wed,  7 Jun 2023 23:22:18 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b1a86cdec6so1536221fa.3
        for <linux-efi@vger.kernel.org>; Wed, 07 Jun 2023 23:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686205336; x=1688797336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G0VwUCmEnGX86ZCMjrjzf2n2n4i6He7mE7SapcE39jQ=;
        b=zNzdPClVFDBPvA/Sd0tnWU4q+9TDxtptLUXsJI1uzuIKW7CepO/B7U20Akb2sVNjUf
         iChrVgfRdbCukBM3ZRmwq4tdN7GbqTVNPm4Xox66Jduri+joXchA/FrGDmJBY9C72PoA
         9JoGjTa2qwQ8C/TagifFEu2pfvGsBppwIR4LCSL+HFIa45MERVcco2p7fbwRnAa7TA2u
         lx0OfDfvg2T2IMAMc0UEWdjcz1rk4DUFcQykgrPDKjlQyM0DlDvxRlbdJM7eblnLZyLs
         AKluKMuIfFTK1Co091kHLyCIp3XxSv6ZKpTdiRftP7uL9CGY9b+Y4s7r1XHzLTn+P78i
         OfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686205336; x=1688797336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0VwUCmEnGX86ZCMjrjzf2n2n4i6He7mE7SapcE39jQ=;
        b=jnO1L4UF7UkgJeKLWTBmzXQHm4cD//0v9GTLdSHL3Zx+ouIJHEvaej7VFctW/rOWkb
         hLOzAJGTVoIAhk7XLGApSTwzmuiPrg2tIDXzoEL8nTbSLtePxysxFc+rPEGHSdNM6uYg
         Gof8S3QFSMtSVS41k/NoEP9vdoJtRE3gsALvzRNEeOUY2aXsKmUC/sY8XMurdYx9cH/C
         4UrdLYTgB78F5uF9dtV+u+IN9AWnw7h7SynbJDLoqluUvXy/1uU8uCbF2AAgPtjEGWue
         uFPHEJTFnMw7xCeDtS9VynooBFC4FhaIIhdP/lHBueF4G7LasvOKYHKTHrZc76J1xFcg
         CCiw==
X-Gm-Message-State: AC+VfDzFAmK4PS1mnBm88kBKwOIGpQ0H8KTMfBkg2Gm1W+7sutIJ9GNv
        6aviqbFCTk8R6NiJoBcolU3SUxooxEMVTzn7cEdN9Q==
X-Google-Smtp-Source: ACHHUZ7NSvEUlT8UhkX/QkQM8okQgMSoDdPNJPAgRN0eGgLLO3YmB8/MiPHPVGgliaXCkm+PDURvo1SR5U1XDuifDtY=
X-Received: by 2002:a2e:9d5a:0:b0:2af:32a7:4eef with SMTP id
 y26-20020a2e9d5a000000b002af32a74eefmr2576295ljj.35.1686205336661; Wed, 07
 Jun 2023 23:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <20230526010748.1222-4-masahisa.kojima@linaro.org> <0d3e0370-eb76-010f-3d30-9acc9b59645c@siemens.com>
 <CAFA6WYPnWJNPvhT2JDkO-qXRUaJoxBGZEvSfhxcRynV7=VSdQA@mail.gmail.com>
 <CAMj1kXFM45PCTU--+CCed6Cq_N5XqDG6tTu6fnQTSCpW2BWA5A@mail.gmail.com>
 <4ff09002-e871-38b9-43ec-227a64bac731@siemens.com> <CAC_iWjJJ5E9Q1or5yTiDynzv_WAYH-g+N24aRdu9rvcsbWqnrg@mail.gmail.com>
 <CAFA6WYNFYB1LiOFB_iwTsdD5PmnDdSbtDSH2J4FVFPx3uik8rQ@mail.gmail.com>
 <CAC_iWj+E7-XK6dCeSn4205K0O3EZCLxCaC+adu-14ST6sdudfA@mail.gmail.com>
 <76da826f-b608-6add-5401-6de818b180e3@siemens.com> <CAFA6WYPCDRjFzsUMU=SNzEt88nT7Fcm1eOFL8z4HiQO+=2JeVA@mail.gmail.com>
 <cc6bd203-83ea-c247-0986-7fec6f327ee8@siemens.com> <CAC_iWjKZNHJxq4VMFnV7oQngwBBCQveh=s34u1LZ59YUqViPbw@mail.gmail.com>
 <CAC_iWjJMv68yLC606SBhMmBYkR4wVC8SvUcPvNM=RX_qL=9Bvw@mail.gmail.com>
 <b9b8c1d3-fc8e-df94-d12b-a9e3debf3418@siemens.com> <CAC_iWj+cP4RfDNu_n-ZOp7A62W34drLpPszN_hrkqF_aPTLtMg@mail.gmail.com>
 <871ece13-7d6e-44d4-3bda-317658202f6f@siemens.com>
In-Reply-To: <871ece13-7d6e-44d4-3bda-317658202f6f@siemens.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 8 Jun 2023 09:21:40 +0300
Message-ID: <CAC_iWjKgCJWgKU8tC3Nfn-0CgwGhw89B3JpTgsjkjDDOcWZEdw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Jan


On Wed, 7 Jun 2023 at 22:46, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 07.06.23 20:17, Ilias Apalodimas wrote:
> > On Wed, 7 Jun 2023 at 20:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 07.06.23 18:59, Ilias Apalodimas wrote:
> >>> On Wed, 7 Jun 2023 at 19:09, Ilias Apalodimas
> >>> <ilias.apalodimas@linaro.org> wrote:
> >>>>
> >>>> Hi Jan,
> >>>>
> >>>> [...]
> >>>>>>>> No I don't, this will work reliably without the need to remount the efivarfs.
> >>>>>>>> As you point out you will still have this dependency if you end up
> >>>>>>>> building them as modules and you manage to mount the efivarfs before
> >>>>>>>> those get inserted.  Does anyone see a reasonable workaround?
> >>>>>>>> Deceiving the kernel and making the bootloader set the RT property bit
> >>>>>>>> to force the filesystem being mounted as rw is a nasty hack that we
> >>>>>>>> should avoid.  Maybe adding a kernel command line parameter that says
> >>>>>>>> "Ignore the RTPROP I know what I am doing"?  I don't particularly love
> >>>>>>>> this either, but it's not unreasonable.
> >>>>>>>
> >>>>>>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
> >>>>>>> basically this issue mapped on reboot/shutdown, I would really love to
> >>>>>>> see the unhandy tee-supplicant daemon to be overcome.
> >>>>>>
> >>>>>> I have seen this error before and it has been on my todo list. So I
> >>>>>> have tried to fix it here [1]. Feel free to test it and let me know if
> >>>>>> you see any further issues.
> >>>>>>
> >>>>>> [1] https://lkml.org/lkml/2023/6/7/927
> >>>>>>
> >>>>>
> >>>>> Ah, nice, will test ASAP!
> >>>>>
> >>>>> Meanwhile more food: I managed to build a firmware that was missing
> >>>>> STMM. But the driver loaded, and I got this:
> >>>>
> >>>> Thanks for the testing. I'll try to reproduce it locally and get back to you
> >>>
> >>> Can you provide a bit more info on how that was triggered btw? I would
> >>> be helpful to know
> >>>
> >>> - OP-TEE version
> >>
> >> Today's master, 145953d55.
> >>
> >>> - was it compiled as a module or built-in?
> >>
> >> Sorry, not sure anymore, switching back and forth right now. I think it
> >> was built-in.
> >>
> >>> - was the supplicant running?
> >>
> >> Yes.
> >>
> >
> > Ok thanks, that helps.  I guess this also means U-Boot was compiled to
> > store the variables in a file in the ESP instead of the RPMB right?
> > Otherwise, I can't see how the device booted in the first place.
>
> U-Boot was not configured to perform secure booting in this case. It had
> RPMB support enabled, just didn't have to use it.

In your initial mail you said you managed to build a firmware without
StMM.  If U-boot isn't reconfigured accordingly -- iow skip the EFI
variable storage in an RPMB, the EFI subsystem will fail to start.

In any case, I don't think the ooops you are seeing is not connected
to this patchset.  Looking at the kernel EFI stub we only set the
SetVariableRT if the RTPROP table is set accordingly by the firmware.
U-Boot never sets the EFI_RT_SUPPORTED_SET_VARIABLE property since it
can't support it.  What you are doing is remount the efivarfs as rw
and then trying to set a variable, but the callback for it is  NULL.
I think you'll be able to replicate the same behavior on the kernel
without even inserting the new module.

Thanks
/Ilias

>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
