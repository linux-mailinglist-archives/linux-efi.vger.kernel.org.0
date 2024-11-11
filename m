Return-Path: <linux-efi+bounces-2128-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3523F9C3997
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2024 09:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D310DB216E3
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2024 08:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CA915CD55;
	Mon, 11 Nov 2024 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBBVU+GK"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088515A842
	for <linux-efi@vger.kernel.org>; Mon, 11 Nov 2024 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313265; cv=none; b=qgQPOHRZNzGy+0ashTtmP8dQwaA5hUEBh7woXC+S+auu4wdUdjFnAtB69BbBYRyHm4uOTGXmryjGRSkZAyz1f8xAjQd3+vDLWZ3JOdGt1ky6Ae3WbUheenypgJE4xCPgaXU86elqn53NM2TiVihgPD5VNbt8y2+SXydxsE10d9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313265; c=relaxed/simple;
	bh=qg0QjFI1zdVvmMtIBHoub3Tgi2sonevocVqmmOJtMh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TO62lE9vaFUSUJABdvfKxw9/lJpWhdVxqmuqHC6YTOKBvlhF8QGPT1qfVTbbcHriUCWZOhDOx+APQRN/GljwUHTW+qjdkyxZDZ2JKJU7Pp0c4bNYOSNtvmrYcrP/FYXvuEIjIrPdPItszVbnRMZCeFJgvAfnBxPS4gclTgQxRr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBBVU+GK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731313262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=731nUNUH56RkNe1YrJYqN6ub2oea0yPftrA68rs2+yI=;
	b=cBBVU+GKMu1cuX4EQV9/DjTVmJ5qxxcX1R9u2fS1EOCx6NJ1jks1SW/lR1kt8aZSAG/o+Y
	nj0SIEmtUV3kTU3LqMVHen33PjEMiRIcH4JROu+KUY+m+TjFIrKknE9q9qfxZ6RMCdJMzF
	FCGGE6yY4yoyYhH7o0Dr8WWJqQYflSU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-woJ5ydj1OYqDlotf5uUjrQ-1; Mon, 11 Nov 2024 03:20:58 -0500
X-MC-Unique: woJ5ydj1OYqDlotf5uUjrQ-1
X-Mimecast-MFC-AGG-ID: woJ5ydj1OYqDlotf5uUjrQ
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-717fac47d50so1499835a34.2
        for <linux-efi@vger.kernel.org>; Mon, 11 Nov 2024 00:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731313258; x=1731918058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=731nUNUH56RkNe1YrJYqN6ub2oea0yPftrA68rs2+yI=;
        b=Dk9yEnUlV71AIqRAwhqBsBjcDZjH0AC8wla8RvxpOkvI+nvP2TE8ORTAs6dDMb2vYw
         W9B3PRQ8Xnq6Nv3LfZTHO6nIXta2732MTw7GWBlLbXC0Bm+WogQ3qdg1UTQ0tMtl9Umj
         rmwJ1jOHXeqXUooIx9gGl4jWgDo+qW4RJImNfwtac2vHGL9EQG5QjSygbACwuGfIa0qV
         lMmjz/mjjfxcByCp8F6zlRuRTn7utSSdwDRcCPJBsSiAgRr3oBvUKvKJC8QJnZunKOE8
         z80a+Bp+C58a6BKRmKfvaM1/N98DfQzlIHDQYveZqx2xFLjnyut6sJ/NG1JHt2mAH91q
         mJKA==
X-Forwarded-Encrypted: i=1; AJvYcCUKgkvRLbEtVRJM/EwXkUV3tZ8Jv1usu4Y5iYU8OlNFVrIlwZxPcbNoM/yywUtvuxQeb3hfMY/HZQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIAgINv87DWqRIh7ALW9Yi4CN3/fmqO4GmvpctnAjCtwme9k7
	wQA/VoTjBf3DGsFPcwrbsjtN+mRf3FQAAt+qPNwNI6RifRxft+xSAbtD3n2lxet1LU2lzoxBfw4
	Dl2HqRAG+xbdW8KmRLfYrS1TYOIxfYXk5BDhmN6f+mwjg0d9pLTatHbnI65rWVYBg2A28DWcf+g
	ZfmJmnPQ/sajYCs1XSZCu7WGhn0R3ZH9UP
X-Received: by 2002:a05:6808:159b:b0:3e7:5b5f:b287 with SMTP id 5614622812f47-3e794627395mr2705881b6e.2.1731313257981;
        Mon, 11 Nov 2024 00:20:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnEFp6/9FBZIbouIExDE3KA6MzIaSOVyXssNYKMt6oqF3c+m/uBwhrK59Jz1TWkrqwgPbdS/q5TsC6YgHvtmU=
X-Received: by 2002:a05:6808:159b:b0:3e7:5b5f:b287 with SMTP id
 5614622812f47-3e794627395mr2705872b6e.2.1731313257637; Mon, 11 Nov 2024
 00:20:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALE0LRvJ-n77oU=O9__NdSLw2v33zMK+WYkn2LcwWMwHCbohQw@mail.gmail.com>
 <CAC_iWjJEXU+dodjvWQYM9ohPa3P2p0bFG=exGoi-iYFrLLbCTA@mail.gmail.com>
 <CALE0LRtUz8hd4pdR9sX2Sb6tOn=K4wkRnGG9B7f72qU8JFQSYQ@mail.gmail.com> <CAC_iWjJLSSTO0Ca7rgOWAHfWzbkBkKHkQedRUbcwsoU0dtrsGA@mail.gmail.com>
In-Reply-To: <CAC_iWjJLSSTO0Ca7rgOWAHfWzbkBkKHkQedRUbcwsoU0dtrsGA@mail.gmail.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Mon, 11 Nov 2024 09:20:46 +0100
Message-ID: <CALE0LRvN3tYgWig1XnCiAZvdzE8x=cdLanGxbUvpPr5nfexSPQ@mail.gmail.com>
Subject: Re: optee-based efi runtime variable service on TI j784s4 platforms
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Manorit Chawdhry <m-chawdhry@ti.com>, 
	Udit Kumar <u-kumar1@ti.com>, "Menon, Nishanth" <nm@ti.com>, 
	Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilias,

On Sat, Nov 9, 2024 at 1:31=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, 8 Nov 2024 at 23:11, Enric Balletbo i Serra <eballetb@redhat.com>=
 wrote:
> >
> > Hi Ilias,
> >
> > Thanks for your quick answer.
> >
> > On Fri, Nov 8, 2024 at 4:48=E2=80=AFPM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Enric,
> > >
> > > On Fri, 8 Nov 2024 at 12:26, Enric Balletbo i Serra <eballetb@redhat.=
com> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > I'm looking for any advice/clue to help me to progress on enabling
> > > > TEE-base EFI Runtime Variable Service on TI a j784s4 platforms.
> > > >
> > > > I basically followed the steps described in u-boot documentation [1=
],
> > > > I enabled some debugging messages but I think I'm at the point that
> > > > the problem might be in the StandaloneMM application, and I'm not s=
ure
> > > > how to debug it.
> > > >
> > > > What I see is that when I run the tee-supplicant daemon, it looks l=
ike
> > > > the tee_client_open_session() call loops forever and the tee_stmm_e=
fi
> > > > driver never ends to probe.
> > > >
> > > > With debug enabled I got the following messages.
> > >
> > > I assume reading and storing variables already works in U-Boot right?
> > >
> >
> > Reading and storing variables to the RPMB partition in U-Boot works,
> > that's using the mmc rpmb command from u-boot,
>
> Are you talking about env variables? Perhaps you store them in the mmc
> and not the RPMB partition?
> There's some information here [0]
>
> > But setting
> > CONFIG_EFI_MM_COMM_TEE=3Dy in u-boot I end with a similar behaviour
> > (although I'm not able to debug at u-boot level) What I see is that
> > u-boot gets stuck
> > when bootefi bootmgr is invoqued. I can also reproduce the issue with
> > bootefi hello.
> >
> > =3D> run bootcmd
> >   Scanning for bootflows in all bootdevs
> >   Seq  Method       State   Uclass    Part  Name                      F=
ilename
> >   ---  -----------  ------  --------  ----  ------------------------
> > ----------------
> >   Scanning global bootmeth 'efi_mgr':
> > ( gets stuck here)
> >
> > or
> >
> > =3D> bootefi hello
> > (gets stuck)
> >
> > To debug I disabled CONFIG_EFI_MM_COMM_TEE to not get stuck and bypass
> > the error and go to Linux. My understanding is that
> > CONFIG_EFI_MM_COMM_TEE is only required to read/write efi variables at
> > u-boot level but OPTEE is running the StandaloneMM service. Am I
> > right?
>
> U-Boot has two ways of storing EFI variables [0] . You can either
> store them in a file or the RPMB partition. The correct thing to do,
> since you want to use the RPMB, is enable CONFIG_EFI_MM_COMM_TEE. I am
> not sure why the hand happens, but one thing we can improve is figure
> out why it hangs and print a useful message.
> There are a number of reasons that might lead to a failure. Is the
> RPMB key programmed on your board? Have a look at this [1] in case it
> helps
>
> >
> > > >
> > > > # tee-supplicant
> > > > D/TC:? 0 tee_ta_init_session_with_context:557 Re-open trusted servi=
ce
> > > > 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
>
> If I had to guess, OP-TEE doesn't store the variables in the RPMB, can
> you compile it with a bit more debugging enabled?
>

Here is a log with CFG_TEE_CORE_LOG_LEVEL=3D4, CFG_TEE_CORE_DEBUG=3Dy and
CFG_TEE_TA_LOG_LEVEL=3D4

https://paste.centos.org/view/eed83a5b

At the beginning of the log I see

D/TC:0 0 check_ta_store:449 TA store: "REE"

Which looks wrong to me as I built optee with:
  CFG_REE_FS=3Dn
  CFG_RPMB_FS_DEV_ID=3D0
  CFG_RPMB_FS=3Dy

I'll try to add some more prints to verify if REE is used as a store
system, I assume this should say something about RPMB. Am I right with
this?

> > > >
> > > > And tracing the function calls gives me that:
> > > >
> > > >       tee_stmm_efi_probe() {
> > > >              tee_client_open_context() {
> > > >                optee_get_version() {
> > > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > >                } (ret=3D0xd)
> > > >                tee_ctx_match(); (ret=3D0x1)
> > > >                optee_smc_open() {
> > > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > >                  optee_open() {
> > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > >                  } (ret=3D0x0)
> > > >                } (ret=3D0x0)
> > > >              } (ret=3D0xffff000004e71c80)
> > > >              tee_client_open_session() {
> > > >                optee_open_session() {
> > > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > >                  optee_get_msg_arg() {
> > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > >                    tee_shm_get_va(); (ret=3D0xffff000002909000)
> > > >                  } (ret=3D0xffff000002909000)
> > > >                  tee_session_calc_client_uuid(); (ret=3D0x0)
> > > >                  optee_to_msg_param(); (ret=3D0x0)
> > > >                  optee_smc_do_call_with_arg() {
> > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > >                    tee_shm_get_va(); (ret=3D0xffff000002909000)
> > > >                    tee_shm_get_va(); (ret=3D0xffff000002909060)
> > > >                    optee_cq_wait_init(); (ret=3D0xffff000002e55910)
> > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > >      ... continues sending this forever ...
> > > >      ... Hit ^C to stop recording ...
> > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > >                    optee_smccc_smc() {
> > > >
> > > > [1] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#using-=
op-tee-for-efi-variables
> > > >
> > > > Thanks in advance,
> > >
> > > The most common problem with this is miscompiling the tee_supplicant
> > > application.
> > > Since we don't know if the system has an RPMB, we emulate it in the
> > > tee_supplicant. How did you get the supplicant and can you check if i=
t
> > > was compiled with RPMB_EMU=3D0 or 1?
> > >
> >
> > I'm using the tee-supplicant provided by the fedora package which is
> > built with ` -DRPMB_EMU=3D0`, I think that's correct, right?
> >
>
> Yes, this is correct. We fixed the Fedora package to compile the
> supplicant correctly a while back.
>
> [0] https://www.linaro.org/blog/uefi-secureboot-in-u-boot/
> [1] https://apalos.github.io/Protected%20UEFI%20variables%20with%20U-Boot=
.html#Protected%20UEFI%20variables%20with%20U-Boot
>
>
> Regards
> /Ilias
> > Thanks,
> >    Enric
> >
> > > Thanks
> > > /Ilias
> > >
> > > >    Enric
> > > >
> > >
> >
>


