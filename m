Return-Path: <linux-efi+bounces-2129-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A5C9C3C9B
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2024 12:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F251F21E59
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2024 11:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F5C14A4CC;
	Mon, 11 Nov 2024 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IllDAVpK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9651487DC
	for <linux-efi@vger.kernel.org>; Mon, 11 Nov 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322907; cv=none; b=LTy6RVQfruExNfnx1k/8ekErigJdwWBO6JinZomWW1rgHDt/YHyLT0C08V80IKUNT6xVtpScGMqk22Lk9EbueRzUIh4naSgyHIRDHMwxFfzQQ0r7muMW2N8d8Z/UP8PDZKGj6ERkxUBUV5NQ1k14GRAZFJT1WyCQtEo8+KtWySw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322907; c=relaxed/simple;
	bh=ggTJ7n17/0xP8iJ9TwR9jevz7cpzd7bElzejP72QT8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCjnjUrZ48jBNeUX4ETUXmi35PtOjcQDTq1VDeHcBRH6rof5UV4g9DisadSxj9lIvwweLmPGBkYbn6snpKt/B4dv1qAa9NLml3+R8wdzVu10/DjulXqkDNDr+otT3JeGnCVDk+sBVivxZXvMJM636qa4wWwZ+P8wUbVT3oXIud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IllDAVpK; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso3513721a91.2
        for <linux-efi@vger.kernel.org>; Mon, 11 Nov 2024 03:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731322905; x=1731927705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcEL/g7UU6A5oURZwwzACF+il7qsicK7CTj+asC7v20=;
        b=IllDAVpKG2mGJtokIiPrLYrdlOvO1mgL7ZUz0MngTm8w9tGT6B4AsmD7CARB2lBJpi
         fSO/ig6CLZNfk8AkKOQlZh66Jtwvx0KRxdTQRNYegknWqnlIyZHYDk7LBz6dUKKOlkQv
         H4F0mTnh/oRLJfS8u2PKc2ful5ht9nNtassRFNKhStQM7axh7gMitN/oagk0U0jBjbeA
         a1mTrP6gS8x7bDzWyyQQ5sKQGU7q5q0fLPVeNzrYixGzVpQotwDzVpUEpd8Qs9qKOnpd
         6NN1Y9gaOdMO9x1iLcst3jGeFOLIDbFZtnw05SnNVKG5aVKMFgU8ee1Sf9Z/XZ1AZPgl
         ju5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322905; x=1731927705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcEL/g7UU6A5oURZwwzACF+il7qsicK7CTj+asC7v20=;
        b=gLuF0aZnGkscIyp8hm7NZ4bFwyI71qA5p6y05Y5DLMdSRtapGygnriIRW2fa/JfvgC
         Nyp8GPG8fvS5WxgdNechqAA2ffiH+Mx3ytPSxC7TEAWw87ylcsq37rWr5rKzDTdshPRg
         hrJef/nMCojFAQzfz/kYO0SO7Y1UQQTrzs/zlwjkhls5o/30LLKuOKNqK0koojUwy1Tx
         BEEX62CnEGvq38/0XfdkqOrpj2j7VzaDJ6HlJ4LR2wqBNdrwsxZ7beR7BjIohFtUiTHE
         jhqISj0AhmnHuonUD/ZGfUN5c1N+T1LElqGrZiRkykopx++QC2ws+6+Gqb7w/82ie1Vd
         VMtA==
X-Forwarded-Encrypted: i=1; AJvYcCVyY3k1K2jiWwhAwZa3NXTSswKNctovcXweTWA2b1vPpMSIMAdSTalpFhwuRrUq7HggoKOwaaaS0nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycnK63cBYykr/84eTr1tkeqffFf8WDTfr7G0NMG7IeCTJ0hAj2
	LeoT8rSU3QdnwOIiiNKAnujNPfQSfFX/X7ZRRdmzQwkb2dC0myDFqOfhP/hTGMWv6dYJaeuHoFt
	EFVhilJbmnD1ftl5GNiOp+T4wyuJRNvgZKqTIWw==
X-Google-Smtp-Source: AGHT+IFyYA9Cvs63Fdp2H3AkCI6uaGHNNzXquZF1X9Q8r2XE4XoIOEjQkozWfVHHkSoY/Fhxx4kebpwP792jnJ0kkgQ=
X-Received: by 2002:a17:90b:3d91:b0:2e2:a029:3b4b with SMTP id
 98e67ed59e1d1-2e9b177632bmr16563493a91.28.1731322904951; Mon, 11 Nov 2024
 03:01:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALE0LRvJ-n77oU=O9__NdSLw2v33zMK+WYkn2LcwWMwHCbohQw@mail.gmail.com>
 <CAC_iWjJEXU+dodjvWQYM9ohPa3P2p0bFG=exGoi-iYFrLLbCTA@mail.gmail.com>
 <CALE0LRtUz8hd4pdR9sX2Sb6tOn=K4wkRnGG9B7f72qU8JFQSYQ@mail.gmail.com>
 <CAC_iWjJLSSTO0Ca7rgOWAHfWzbkBkKHkQedRUbcwsoU0dtrsGA@mail.gmail.com> <CALE0LRvN3tYgWig1XnCiAZvdzE8x=cdLanGxbUvpPr5nfexSPQ@mail.gmail.com>
In-Reply-To: <CALE0LRvN3tYgWig1XnCiAZvdzE8x=cdLanGxbUvpPr5nfexSPQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 13:01:08 +0200
Message-ID: <CAC_iWjL4mp-sTsp5a+yFkUauXuMvZ1yoTAk_60nm-CCKUgwayw@mail.gmail.com>
Subject: Re: optee-based efi runtime variable service on TI j784s4 platforms
To: Enric Balletbo i Serra <eballetb@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Manorit Chawdhry <m-chawdhry@ti.com>, 
	Udit Kumar <u-kumar1@ti.com>, "Menon, Nishanth" <nm@ti.com>, 
	Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Nov 2024 at 10:21, Enric Balletbo i Serra
<eballetb@redhat.com> wrote:
>
> Hi Ilias,
>
> On Sat, Nov 9, 2024 at 1:31=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Fri, 8 Nov 2024 at 23:11, Enric Balletbo i Serra <eballetb@redhat.co=
m> wrote:
> > >
> > > Hi Ilias,
> > >
> > > Thanks for your quick answer.
> > >
> > > On Fri, Nov 8, 2024 at 4:48=E2=80=AFPM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Enric,
> > > >
> > > > On Fri, 8 Nov 2024 at 12:26, Enric Balletbo i Serra <eballetb@redha=
t.com> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > I'm looking for any advice/clue to help me to progress on enablin=
g
> > > > > TEE-base EFI Runtime Variable Service on TI a j784s4 platforms.
> > > > >
> > > > > I basically followed the steps described in u-boot documentation =
[1],
> > > > > I enabled some debugging messages but I think I'm at the point th=
at
> > > > > the problem might be in the StandaloneMM application, and I'm not=
 sure
> > > > > how to debug it.
> > > > >
> > > > > What I see is that when I run the tee-supplicant daemon, it looks=
 like
> > > > > the tee_client_open_session() call loops forever and the tee_stmm=
_efi
> > > > > driver never ends to probe.
> > > > >
> > > > > With debug enabled I got the following messages.
> > > >
> > > > I assume reading and storing variables already works in U-Boot righ=
t?
> > > >
> > >
> > > Reading and storing variables to the RPMB partition in U-Boot works,
> > > that's using the mmc rpmb command from u-boot,
> >
> > Are you talking about env variables? Perhaps you store them in the mmc
> > and not the RPMB partition?
> > There's some information here [0]
> >
> > > But setting
> > > CONFIG_EFI_MM_COMM_TEE=3Dy in u-boot I end with a similar behaviour
> > > (although I'm not able to debug at u-boot level) What I see is that
> > > u-boot gets stuck
> > > when bootefi bootmgr is invoqued. I can also reproduce the issue with
> > > bootefi hello.
> > >
> > > =3D> run bootcmd
> > >   Scanning for bootflows in all bootdevs
> > >   Seq  Method       State   Uclass    Part  Name                     =
 Filename
> > >   ---  -----------  ------  --------  ----  ------------------------
> > > ----------------
> > >   Scanning global bootmeth 'efi_mgr':
> > > ( gets stuck here)
> > >
> > > or
> > >
> > > =3D> bootefi hello
> > > (gets stuck)
> > >
> > > To debug I disabled CONFIG_EFI_MM_COMM_TEE to not get stuck and bypas=
s
> > > the error and go to Linux. My understanding is that
> > > CONFIG_EFI_MM_COMM_TEE is only required to read/write efi variables a=
t
> > > u-boot level but OPTEE is running the StandaloneMM service. Am I
> > > right?
> >
> > U-Boot has two ways of storing EFI variables [0] . You can either
> > store them in a file or the RPMB partition. The correct thing to do,
> > since you want to use the RPMB, is enable CONFIG_EFI_MM_COMM_TEE. I am
> > not sure why the hand happens, but one thing we can improve is figure
> > out why it hangs and print a useful message.
> > There are a number of reasons that might lead to a failure. Is the
> > RPMB key programmed on your board? Have a look at this [1] in case it
> > helps
> >
> > >
> > > > >
> > > > > # tee-supplicant
> > > > > D/TC:? 0 tee_ta_init_session_with_context:557 Re-open trusted ser=
vice
> > > > > 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> > > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> >
> > If I had to guess, OP-TEE doesn't store the variables in the RPMB, can
> > you compile it with a bit more debugging enabled?
> >
>
> Here is a log with CFG_TEE_CORE_LOG_LEVEL=3D4, CFG_TEE_CORE_DEBUG=3Dy and
> CFG_TEE_TA_LOG_LEVEL=3D4
>
> https://paste.centos.org/view/eed83a5b
>
> At the beginning of the log I see
>
> D/TC:0 0 check_ta_store:449 TA store: "REE"
>
> Which looks wrong to me as I built optee with:
>   CFG_REE_FS=3Dn
>   CFG_RPMB_FS_DEV_ID=3D0
>   CFG_RPMB_FS=3Dy

Yes it does look wrong. Our compilation flags are
CFG_RPMB_FS=3Dy CFG_RPMB_FS_DEV_ID=3D0 CFG_RPMB_WRITE_KEY=3Dy
CFG_RPMB_TESTKEY=3Dy CFG_REE_FS=3Dn CFG_CORE_ARM64_PA_BITS=3D48
CFG_SCTLR_ALIGNMENT_CHECK=3Dn

The testkey etc aren't required if your board has a way of reading the
RPMB key from a secure location -- in fact, using the testkey is not
secure. Is the RPMB programmed on your board? Also can you make sure
CFG_RPMB_FS_DEV_ID needs to be 0? How many sd interfaces your board
has?
IOW in U-Boot does 'mmc dev 0 && mmc info' print information for the
RPMB partition?

Thanks
/Ilias
>
> I'll try to add some more prints to verify if REE is used as a store
> system, I assume this should say something about RPMB. Am I right with
> this?


>
> > > > >
> > > > > And tracing the function calls gives me that:
> > > > >
> > > > >       tee_stmm_efi_probe() {
> > > > >              tee_client_open_context() {
> > > > >                optee_get_version() {
> > > > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > > >                } (ret=3D0xd)
> > > > >                tee_ctx_match(); (ret=3D0x1)
> > > > >                optee_smc_open() {
> > > > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > > >                  optee_open() {
> > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > > >                  } (ret=3D0x0)
> > > > >                } (ret=3D0x0)
> > > > >              } (ret=3D0xffff000004e71c80)
> > > > >              tee_client_open_session() {
> > > > >                optee_open_session() {
> > > > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > > >                  optee_get_msg_arg() {
> > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > > >                    tee_shm_get_va(); (ret=3D0xffff000002909000)
> > > > >                  } (ret=3D0xffff000002909000)
> > > > >                  tee_session_calc_client_uuid(); (ret=3D0x0)
> > > > >                  optee_to_msg_param(); (ret=3D0x0)
> > > > >                  optee_smc_do_call_with_arg() {
> > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > > >                    tee_shm_get_va(); (ret=3D0xffff000002909000)
> > > > >                    tee_shm_get_va(); (ret=3D0xffff000002909060)
> > > > >                    optee_cq_wait_init(); (ret=3D0xffff000002e5591=
0)
> > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > >      ... continues sending this forever ...
> > > > >      ... Hit ^C to stop recording ...
> > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > > >                    optee_smccc_smc() {
> > > > >
> > > > > [1] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#usin=
g-op-tee-for-efi-variables
> > > > >
> > > > > Thanks in advance,
> > > >
> > > > The most common problem with this is miscompiling the tee_supplican=
t
> > > > application.
> > > > Since we don't know if the system has an RPMB, we emulate it in the
> > > > tee_supplicant. How did you get the supplicant and can you check if=
 it
> > > > was compiled with RPMB_EMU=3D0 or 1?
> > > >
> > >
> > > I'm using the tee-supplicant provided by the fedora package which is
> > > built with ` -DRPMB_EMU=3D0`, I think that's correct, right?
> > >
> >
> > Yes, this is correct. We fixed the Fedora package to compile the
> > supplicant correctly a while back.
> >
> > [0] https://www.linaro.org/blog/uefi-secureboot-in-u-boot/
> > [1] https://apalos.github.io/Protected%20UEFI%20variables%20with%20U-Bo=
ot.html#Protected%20UEFI%20variables%20with%20U-Boot
> >
> >
> > Regards
> > /Ilias
> > > Thanks,
> > >    Enric
> > >
> > > > Thanks
> > > > /Ilias
> > > >
> > > > >    Enric
> > > > >
> > > >
> > >
> >
>

