Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5576D7281D6
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jun 2023 15:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjFHNwf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jun 2023 09:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbjFHNwZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Jun 2023 09:52:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383282D40;
        Thu,  8 Jun 2023 06:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5442619E8;
        Thu,  8 Jun 2023 13:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7E0C433A4;
        Thu,  8 Jun 2023 13:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686232338;
        bh=wo8BfKSv4ZF9OUH4lvnbw6UhtyIUvEzAU6+t+ORVXUo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jfcxUk+sksOSizS2Ki9UtcxQP4drVjFYC8OHcGXzanAdq2aHC+Kw2Cl0h3glM6cKh
         j+i8ihmD2UD6FmUYOgNXi+IpbC+6gKnPRubD3fPGaMrxCN9k4AQ3ZpcKZxumjcBfGp
         qr7kXSJ1j3k23mq9xuzpu+rtYE+YB/79XgKgY+xvvoEyn5sHCQeQcM0RZHhepBW+Pe
         QBScXJiTEEVd0OSOzwwAqwowl9K7oynFKmCRtRlmQq5P9F7XbqX6ITtSxT9ry2SNA8
         NSOUZXEmyl5hmsZ9PvQBcJXKz69fG9jmRzEBz4NYEGUqq2R11O2b7jWw8W3NUd9vEM
         PDcGQicsRwXkw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b1fe3a1a73so5888211fa.1;
        Thu, 08 Jun 2023 06:52:18 -0700 (PDT)
X-Gm-Message-State: AC+VfDwWX7m+ePrMV1C3LPEErs4tLAaBrgDly7UejK4DxhJ3Y4CYIqq4
        q7F3TgSxnwjupCnVwlEDkmLfxKwKG5BG9aGGoJ4=
X-Google-Smtp-Source: ACHHUZ7CC5lw560e3LKWiYkj8naWsH7vTihet7kqk6tpy2TZlGcC5XBR6FmeaLnqcXRf78cAyJusdftj6/+RxJrQmas=
X-Received: by 2002:a2e:3c04:0:b0:2aa:41a1:cd70 with SMTP id
 j4-20020a2e3c04000000b002aa41a1cd70mr3575729lja.3.1686232336064; Thu, 08 Jun
 2023 06:52:16 -0700 (PDT)
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
 <871ece13-7d6e-44d4-3bda-317658202f6f@siemens.com> <CAC_iWjKgCJWgKU8tC3Nfn-0CgwGhw89B3JpTgsjkjDDOcWZEdw@mail.gmail.com>
In-Reply-To: <CAC_iWjKgCJWgKU8tC3Nfn-0CgwGhw89B3JpTgsjkjDDOcWZEdw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 8 Jun 2023 15:52:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGbXdbDr6DbyuziSFuxMgAimjNnkhqy8C-S5AbxdnixuQ@mail.gmail.com>
Message-ID: <CAMj1kXGbXdbDr6DbyuziSFuxMgAimjNnkhqy8C-S5AbxdnixuQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 8 Jun 2023 at 08:22, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Jan
>
>
> On Wed, 7 Jun 2023 at 22:46, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 07.06.23 20:17, Ilias Apalodimas wrote:
> > > On Wed, 7 Jun 2023 at 20:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > >>
> > >> On 07.06.23 18:59, Ilias Apalodimas wrote:
> > >>> On Wed, 7 Jun 2023 at 19:09, Ilias Apalodimas
> > >>> <ilias.apalodimas@linaro.org> wrote:
> > >>>>
> > >>>> Hi Jan,
> > >>>>
> > >>>> [...]
> > >>>>>>>> No I don't, this will work reliably without the need to remount the efivarfs.
> > >>>>>>>> As you point out you will still have this dependency if you end up
> > >>>>>>>> building them as modules and you manage to mount the efivarfs before
> > >>>>>>>> those get inserted.  Does anyone see a reasonable workaround?
> > >>>>>>>> Deceiving the kernel and making the bootloader set the RT property bit
> > >>>>>>>> to force the filesystem being mounted as rw is a nasty hack that we
> > >>>>>>>> should avoid.  Maybe adding a kernel command line parameter that says
> > >>>>>>>> "Ignore the RTPROP I know what I am doing"?  I don't particularly love
> > >>>>>>>> this either, but it's not unreasonable.
> > >>>>>>>
> > >>>>>>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
> > >>>>>>> basically this issue mapped on reboot/shutdown, I would really love to
> > >>>>>>> see the unhandy tee-supplicant daemon to be overcome.
> > >>>>>>
> > >>>>>> I have seen this error before and it has been on my todo list. So I
> > >>>>>> have tried to fix it here [1]. Feel free to test it and let me know if
> > >>>>>> you see any further issues.
> > >>>>>>
> > >>>>>> [1] https://lkml.org/lkml/2023/6/7/927
> > >>>>>>
> > >>>>>
> > >>>>> Ah, nice, will test ASAP!
> > >>>>>
> > >>>>> Meanwhile more food: I managed to build a firmware that was missing
> > >>>>> STMM. But the driver loaded, and I got this:
> > >>>>
> > >>>> Thanks for the testing. I'll try to reproduce it locally and get back to you
> > >>>
> > >>> Can you provide a bit more info on how that was triggered btw? I would
> > >>> be helpful to know
> > >>>
> > >>> - OP-TEE version
> > >>
> > >> Today's master, 145953d55.
> > >>
> > >>> - was it compiled as a module or built-in?
> > >>
> > >> Sorry, not sure anymore, switching back and forth right now. I think it
> > >> was built-in.
> > >>
> > >>> - was the supplicant running?
> > >>
> > >> Yes.
> > >>
> > >
> > > Ok thanks, that helps.  I guess this also means U-Boot was compiled to
> > > store the variables in a file in the ESP instead of the RPMB right?
> > > Otherwise, I can't see how the device booted in the first place.
> >
> > U-Boot was not configured to perform secure booting in this case. It had
> > RPMB support enabled, just didn't have to use it.
>
> In your initial mail you said you managed to build a firmware without
> StMM.  If U-boot isn't reconfigured accordingly -- iow skip the EFI
> variable storage in an RPMB, the EFI subsystem will fail to start.
>
> In any case, I don't think the ooops you are seeing is not connected
> to this patchset.  Looking at the kernel EFI stub we only set the
> SetVariableRT if the RTPROP table is set accordingly by the firmware.
> U-Boot never sets the EFI_RT_SUPPORTED_SET_VARIABLE property since it
> can't support it.  What you are doing is remount the efivarfs as rw
> and then trying to set a variable, but the callback for it is  NULL.
> I think you'll be able to replicate the same behavior on the kernel
> without even inserting the new module.
>

I have dropped this series from efi/next for now, given that it
obviously has problems in its current state.

The risk of merging this now and fixing it later is that it may cause
regressions for early adopters that rely on the behavior we are
introducing here. Better to get this in shape first.
