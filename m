Return-Path: <linux-efi+bounces-2127-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8BB9C28D8
	for <lists+linux-efi@lfdr.de>; Sat,  9 Nov 2024 01:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B3A8B20D30
	for <lists+linux-efi@lfdr.de>; Sat,  9 Nov 2024 00:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2008F49;
	Sat,  9 Nov 2024 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Og6J93pz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07943442C
	for <linux-efi@vger.kernel.org>; Sat,  9 Nov 2024 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112312; cv=none; b=MINX3/4gHM9SlTwXCjH8S5F7r6NO7JAwo1zFvpOhWt4I9agFYc3q48APe9EhTntbmysvERLwyK1TC0AXlPT+oCSa87vZfNgfO9NK8SM1LECCfMRwpCktjodCg+Xzyu4jLm3GnGrm8DZsEgXDkaZx1+UK8b2oicIBeRcG2sTJAkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112312; c=relaxed/simple;
	bh=hVVjQGaMk42kxACl9iiDgyEjZfh4FOjrVSHr0dR5jRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHxydC9IM7h0+bcplrWoZZhRZIxVlv/kK8g3Sp+WcdIQ05fJWX3FUCUrriYm00EklDd1S6UrnL/yzp4VpzPzBy7XnYeZyjWZFyr9yVnjaLbeRZ0d6GlybAkRuTuO+6PSZUIhK46xnKJDc6kKJCtk2LbpxPZduBhlcF5XcndnnzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Og6J93pz; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7f3e30a43f1so2031532a12.1
        for <linux-efi@vger.kernel.org>; Fri, 08 Nov 2024 16:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731112310; x=1731717110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1E26MnGizRapo2n2N6bqp5svQaI3HCt3C2eCsi3AIQ=;
        b=Og6J93pzPlqZJShO2f6KacJOJMotfRsTO6axcQkSG2G1sUNLXC6jrZxZ05/RB1t640
         p5biNzzfzK6/ZDMvqHfp1MXOsarIQEparqbyT7O+lUDvoKnh6IM1d5jW7YNLAiLqj53r
         VHI/DiNzSFi99iRY03XNm6mDfgDgRamOXmT16vV+Dh4zA8Hxyd48f1czwM++CYc2AEO9
         HifXE4WyHIbaC3fwrL//dTQ7XCbzCaSkxM2HSWcRwiKJx7mQNVwjsIAPVCREmfmtmBJF
         tnDW4k5DiY4T88T+0PkaRX+Q4aZqv9w3raH56gq8MJbdKfTwdSkwH9Ouv0pXsp50p4JF
         Wk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112310; x=1731717110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1E26MnGizRapo2n2N6bqp5svQaI3HCt3C2eCsi3AIQ=;
        b=HehDudfSb5/LZni+JWhVpkGUouSHdTonnFjHJkiys5Yj1L00LxXIVeHs0juTiz0N8V
         3qjRRRUKp4VkUxBj4teZYxzPWor3iYw6FjPutn+jfzzht6lxQY9hZkx3Mlq2VNSYShSP
         KbNZ2gvHJFdneY1hZZiPuIRaoYExtqaX9SOc5DGh67ypkJU2xuK4a8925LB6se6pT+HJ
         xw9I5OsjeF4Gsxnq7FwasBxQAobX7hPwUS9ADQpVLYfGBs9u2Z8ZIPPQKDlfSed0kGO+
         UMAzDW6kSkFOvlI0kR9/BoMS336nsS7pQaaaU0a+ngEMwbf00/Yq6k01v0ICRFc2J1sK
         TStQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJUur1BbyoQAL+n5AdWV9FgxHpxFTVcEKVTiR16gdjxYM29ciIRRRTlV44fvU3nDtNpENPqquR/pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHW73YybEvobKC6EFEKZUxYM4cvcZ/PTDUez4kW09CRwblz0aj
	tz+HZOWo9/pbZhsKFqac+S4mnsjDyQ8orQY+QFr4MG9/kR6NNGT80KHDYqk0eDnLoEg0uZN9SD1
	ITTyjaqzjOSE8n0BIYFCnoV5+mccr5dtJ6/KeHg==
X-Google-Smtp-Source: AGHT+IHCHLh39cxBw5ufNm7dZo+CDQzWBDFzWuOIxiVp3gnbTUBNURR8pxRRy/13hfp6Af72Rhtnz9aRlZ+COJrcvI4=
X-Received: by 2002:a17:902:e747:b0:20c:e262:2560 with SMTP id
 d9443c01a7336-21183e4c8a3mr62876625ad.50.1731112310250; Fri, 08 Nov 2024
 16:31:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALE0LRvJ-n77oU=O9__NdSLw2v33zMK+WYkn2LcwWMwHCbohQw@mail.gmail.com>
 <CAC_iWjJEXU+dodjvWQYM9ohPa3P2p0bFG=exGoi-iYFrLLbCTA@mail.gmail.com> <CALE0LRtUz8hd4pdR9sX2Sb6tOn=K4wkRnGG9B7f72qU8JFQSYQ@mail.gmail.com>
In-Reply-To: <CALE0LRtUz8hd4pdR9sX2Sb6tOn=K4wkRnGG9B7f72qU8JFQSYQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 9 Nov 2024 00:31:14 +0000
Message-ID: <CAC_iWjJLSSTO0Ca7rgOWAHfWzbkBkKHkQedRUbcwsoU0dtrsGA@mail.gmail.com>
Subject: Re: optee-based efi runtime variable service on TI j784s4 platforms
To: Enric Balletbo i Serra <eballetb@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Manorit Chawdhry <m-chawdhry@ti.com>, 
	Udit Kumar <u-kumar1@ti.com>, "Menon, Nishanth" <nm@ti.com>, 
	Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Nov 2024 at 23:11, Enric Balletbo i Serra <eballetb@redhat.com> w=
rote:
>
> Hi Ilias,
>
> Thanks for your quick answer.
>
> On Fri, Nov 8, 2024 at 4:48=E2=80=AFPM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Enric,
> >
> > On Fri, 8 Nov 2024 at 12:26, Enric Balletbo i Serra <eballetb@redhat.co=
m> wrote:
> > >
> > > Hi all,
> > >
> > > I'm looking for any advice/clue to help me to progress on enabling
> > > TEE-base EFI Runtime Variable Service on TI a j784s4 platforms.
> > >
> > > I basically followed the steps described in u-boot documentation [1],
> > > I enabled some debugging messages but I think I'm at the point that
> > > the problem might be in the StandaloneMM application, and I'm not sur=
e
> > > how to debug it.
> > >
> > > What I see is that when I run the tee-supplicant daemon, it looks lik=
e
> > > the tee_client_open_session() call loops forever and the tee_stmm_efi
> > > driver never ends to probe.
> > >
> > > With debug enabled I got the following messages.
> >
> > I assume reading and storing variables already works in U-Boot right?
> >
>
> Reading and storing variables to the RPMB partition in U-Boot works,
> that's using the mmc rpmb command from u-boot,

Are you talking about env variables? Perhaps you store them in the mmc
and not the RPMB partition?
There's some information here [0]

> But setting
> CONFIG_EFI_MM_COMM_TEE=3Dy in u-boot I end with a similar behaviour
> (although I'm not able to debug at u-boot level) What I see is that
> u-boot gets stuck
> when bootefi bootmgr is invoqued. I can also reproduce the issue with
> bootefi hello.
>
> =3D> run bootcmd
>   Scanning for bootflows in all bootdevs
>   Seq  Method       State   Uclass    Part  Name                      Fil=
ename
>   ---  -----------  ------  --------  ----  ------------------------
> ----------------
>   Scanning global bootmeth 'efi_mgr':
> ( gets stuck here)
>
> or
>
> =3D> bootefi hello
> (gets stuck)
>
> To debug I disabled CONFIG_EFI_MM_COMM_TEE to not get stuck and bypass
> the error and go to Linux. My understanding is that
> CONFIG_EFI_MM_COMM_TEE is only required to read/write efi variables at
> u-boot level but OPTEE is running the StandaloneMM service. Am I
> right?

U-Boot has two ways of storing EFI variables [0] . You can either
store them in a file or the RPMB partition. The correct thing to do,
since you want to use the RPMB, is enable CONFIG_EFI_MM_COMM_TEE. I am
not sure why the hand happens, but one thing we can improve is figure
out why it hangs and print a useful message.
There are a number of reasons that might lead to a failure. Is the
RPMB key programmed on your board? Have a look at this [1] in case it
helps

>
> > >
> > > # tee-supplicant
> > > D/TC:? 0 tee_ta_init_session_with_context:557 Re-open trusted service
> > > 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request

If I had to guess, OP-TEE doesn't store the variables in the RPMB, can
you compile it with a bit more debugging enabled?

> > >
> > > And tracing the function calls gives me that:
> > >
> > >       tee_stmm_efi_probe() {
> > >              tee_client_open_context() {
> > >                optee_get_version() {
> > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                } (ret=3D0xd)
> > >                tee_ctx_match(); (ret=3D0x1)
> > >                optee_smc_open() {
> > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                  optee_open() {
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                  } (ret=3D0x0)
> > >                } (ret=3D0x0)
> > >              } (ret=3D0xffff000004e71c80)
> > >              tee_client_open_session() {
> > >                optee_open_session() {
> > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                  optee_get_msg_arg() {
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                    tee_shm_get_va(); (ret=3D0xffff000002909000)
> > >                  } (ret=3D0xffff000002909000)
> > >                  tee_session_calc_client_uuid(); (ret=3D0x0)
> > >                  optee_to_msg_param(); (ret=3D0x0)
> > >                  optee_smc_do_call_with_arg() {
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                    tee_shm_get_va(); (ret=3D0xffff000002909000)
> > >                    tee_shm_get_va(); (ret=3D0xffff000002909060)
> > >                    optee_cq_wait_init(); (ret=3D0xffff000002e55910)
> > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > >      ... continues sending this forever ...
> > >      ... Hit ^C to stop recording ...
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                    optee_smccc_smc() {
> > >
> > > [1] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#using-op=
-tee-for-efi-variables
> > >
> > > Thanks in advance,
> >
> > The most common problem with this is miscompiling the tee_supplicant
> > application.
> > Since we don't know if the system has an RPMB, we emulate it in the
> > tee_supplicant. How did you get the supplicant and can you check if it
> > was compiled with RPMB_EMU=3D0 or 1?
> >
>
> I'm using the tee-supplicant provided by the fedora package which is
> built with ` -DRPMB_EMU=3D0`, I think that's correct, right?
>

Yes, this is correct. We fixed the Fedora package to compile the
supplicant correctly a while back.

[0] https://www.linaro.org/blog/uefi-secureboot-in-u-boot/
[1] https://apalos.github.io/Protected%20UEFI%20variables%20with%20U-Boot.h=
tml#Protected%20UEFI%20variables%20with%20U-Boot


Regards
/Ilias
> Thanks,
>    Enric
>
> > Thanks
> > /Ilias
> >
> > >    Enric
> > >
> >
>

