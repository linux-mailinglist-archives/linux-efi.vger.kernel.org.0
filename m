Return-Path: <linux-efi+bounces-2138-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 287279C56FD
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 12:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2C01F2213E
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 11:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD71B1B86CF;
	Tue, 12 Nov 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsWBuhsl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9884D1BCA11
	for <linux-efi@vger.kernel.org>; Tue, 12 Nov 2024 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412249; cv=none; b=tIIF26LBZSqb3aTMTAa9UFx5JDIW3gjhCPRvRf/YfRTtBNZPYErkCBkdWfNtCKvV+fUZxr+O1VzSTt0pizKpbh3UZOCrXqiI6MgPfZBoNVr0sXNrB/SWUmKmTJcU19LjyT8xqGuyVuJwpCV1Ec2IVoRSVJUOmnVv/ZQO/TSb+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412249; c=relaxed/simple;
	bh=36Fxpv9fRfJru+IyRVULpt6nFqMMbp8mFc0QKI06YZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dB8uceiGms77ADA7gYOA+n1mI03QnajMNpveIAQS/ef3y6S9EOBwb/FzBgVe2sdlYn+FNu7UIjGyAbPGYJa1jMSjgkS0EfwcRYN0ksjG7bHfCY1JZ6cuhOTGlwjq9HgBPmhy+43AuvB50cY2LcE6C9kS77+ALA7Tv98jt1KlgPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YsWBuhsl; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2dc61bc41so4023958a91.1
        for <linux-efi@vger.kernel.org>; Tue, 12 Nov 2024 03:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731412247; x=1732017047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRZuof606OOT943vPxL8priucDpX6fZjafbCTv30/uE=;
        b=YsWBuhslYCVW3hGIxJLWDno/qZYIwVakuIfBEwTvNX+AMk9Gb93eworUi00h2CK4d8
         JEBPxEiIeuylcCdmlDcPrDWgBicXhPqMSki1AROwoC7Gg3KbLSm/kJuACvBfoVN7bjM5
         5fYLkkmBf2H4KFRVZ7uNQZuXvKhnYwMwjmatyG73Tb/xVcJCPd3NwUEGMnN35eYu39n8
         xaWI5bc5j2ohrlTl8U/U7dEiFTJMHDtesYFsKwtUe7CMe0QJ85/29Xlfb2Ht4mRU24ih
         xmiq3JwA4quq5W0EqMOBd3D9m5bjvHspwRJEE7WHEQJjd51BMLWh3Ly6nuyQLt2HFhO/
         rLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731412247; x=1732017047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRZuof606OOT943vPxL8priucDpX6fZjafbCTv30/uE=;
        b=M5UhYluk17rCBN90IEoOQaSk0v2f1qZGH62wFEOPpYy8nIWt2O5i3/+uVwSeiK/572
         pzFl2qydFV03+2XPKGZVsrPEmXY8tp63NoK0e+l4s+hmS9/wdPx/JbrLYd/IXBDLZRIg
         hsVJ7ovE2ZoiAS0XceCVLBaOXTD741nvXmZRKxy3JSMw6MxZzCp0fvLpMiMwbxTbOYVz
         /I38GwFKDiIBDgE6IPdY5jAvcbIjSQwCSAJQXtYUDjwt4OHU0yCMnW4UsCFH/nomnikk
         ppSgBT44RGTdnEdYfaGF5t4fPUvt65v0zLK3UWgtcUSCSE5S5i6OcV/11zDxu/H1no9W
         6cBA==
X-Forwarded-Encrypted: i=1; AJvYcCXLR0aQlaAw3vrwU5Q3hgBKycwMt8PVrXp6yuflMaTGWTHtCaZmb1xSnXPeDgOunNAva2G9DK/sXvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3izHqpmRodEi/ggExzyWOtzbA54ifJDTvjuKW+wMM4HPI8g3
	hbQvwPZllZ7ZiFFsQRGpPVP009M0GHGWjlD1Sjl9crDdI+ZSVHQu8FX0nraQEFtlyvOpDp6cpj3
	BNe2Ik9U7A3W5JO0km/5n2upX0ILR/D9mLHbXwA==
X-Google-Smtp-Source: AGHT+IGkaMb/i80SMs/x4CRnfYWLkD+E9nhXz1u00nrM28hnR2oggdxJbCVO8DtM0v4ULU57vZom5G0WvzQi0gc7Mrk=
X-Received: by 2002:a17:90b:2dcc:b0:2e2:cd22:b083 with SMTP id
 98e67ed59e1d1-2e9b14d83f1mr20816157a91.0.1731412246616; Tue, 12 Nov 2024
 03:50:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALE0LRvJ-n77oU=O9__NdSLw2v33zMK+WYkn2LcwWMwHCbohQw@mail.gmail.com>
 <CAC_iWjJEXU+dodjvWQYM9ohPa3P2p0bFG=exGoi-iYFrLLbCTA@mail.gmail.com>
 <CALE0LRtUz8hd4pdR9sX2Sb6tOn=K4wkRnGG9B7f72qU8JFQSYQ@mail.gmail.com>
 <CAC_iWjJLSSTO0Ca7rgOWAHfWzbkBkKHkQedRUbcwsoU0dtrsGA@mail.gmail.com>
 <CALE0LRvN3tYgWig1XnCiAZvdzE8x=cdLanGxbUvpPr5nfexSPQ@mail.gmail.com>
 <CAC_iWjL4mp-sTsp5a+yFkUauXuMvZ1yoTAk_60nm-CCKUgwayw@mail.gmail.com>
 <CALE0LRsYXXaao2uCUMFkd8Y6f5Mxgoc-Qpft_y8wWW3ZiekbbA@mail.gmail.com>
 <CAC_iWjL+J9tNxEdh0AoYD19h013N4nk=KmaT=RACo4-oVwuRCA@mail.gmail.com>
 <CALE0LRu2oDSo6KOhO2fTDMiqX7iqjqNjNGD_67MJFS7BJWqT_w@mail.gmail.com> <CALE0LRvFT3fDdoBLXHK2e47cibD02pxXAuZ83rTqEfrzU3HnKA@mail.gmail.com>
In-Reply-To: <CALE0LRvFT3fDdoBLXHK2e47cibD02pxXAuZ83rTqEfrzU3HnKA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 12 Nov 2024 13:50:09 +0200
Message-ID: <CAC_iWj+STZib+VOZrQtZk95skWzyLqe7_HpNM60G6axNa3Lnnw@mail.gmail.com>
Subject: Re: optee-based efi runtime variable service on TI j784s4 platforms
To: Enric Balletbo i Serra <eballetb@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Manorit Chawdhry <m-chawdhry@ti.com>, 
	Udit Kumar <u-kumar1@ti.com>, "Menon, Nishanth" <nm@ti.com>, 
	Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Enric

On Tue, 12 Nov 2024 at 13:40, Enric Balletbo i Serra
<eballetb@redhat.com> wrote:
>
> Hi again,
>
> On Tue, Nov 12, 2024 at 9:17=E2=80=AFAM Enric Balletbo i Serra
> <eballetb@redhat.com> wrote:
> >
> > Hi,
> >
> > On Mon, Nov 11, 2024 at 3:26=E2=80=AFPM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Mon, 11 Nov 2024 at 16:13, Enric Balletbo i Serra
> > > <eballetb@redhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Thanks a lot for your support.
> > >
> > > You're welcome. FWIW I did test this in the past with an AM62x SoC.
> > >
> >
> > Thanks for the info, maybe I can give it a try with my BeaglePlay then.=
..
> >
> > > >
> > > > On Mon, Nov 11, 2024 at 12:01=E2=80=AFPM Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > On Mon, 11 Nov 2024 at 10:21, Enric Balletbo i Serra
> > > > > <eballetb@redhat.com> wrote:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > > > On Sat, Nov 9, 2024 at 1:31=E2=80=AFAM Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > On Fri, 8 Nov 2024 at 23:11, Enric Balletbo i Serra <eballetb=
@redhat.com> wrote:
> > > > > > > >
> > > > > > > > Hi Ilias,
> > > > > > > >
> > > > > > > > Thanks for your quick answer.
> > > > > > > >
> > > > > > > > On Fri, Nov 8, 2024 at 4:48=E2=80=AFPM Ilias Apalodimas
> > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Enric,
> > > > > > > > >
> > > > > > > > > On Fri, 8 Nov 2024 at 12:26, Enric Balletbo i Serra <ebal=
letb@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi all,
> > > > > > > > > >
> > > > > > > > > > I'm looking for any advice/clue to help me to progress =
on enabling
> > > > > > > > > > TEE-base EFI Runtime Variable Service on TI a j784s4 pl=
atforms.
> > > > > > > > > >
> > > > > > > > > > I basically followed the steps described in u-boot docu=
mentation [1],
> > > > > > > > > > I enabled some debugging messages but I think I'm at th=
e point that
> > > > > > > > > > the problem might be in the StandaloneMM application, a=
nd I'm not sure
> > > > > > > > > > how to debug it.
> > > > > > > > > >
> > > > > > > > > > What I see is that when I run the tee-supplicant daemon=
, it looks like
> > > > > > > > > > the tee_client_open_session() call loops forever and th=
e tee_stmm_efi
> > > > > > > > > > driver never ends to probe.
> > > > > > > > > >
> > > > > > > > > > With debug enabled I got the following messages.
> > > > > > > > >
> > > > > > > > > I assume reading and storing variables already works in U=
-Boot right?
> > > > > > > > >
> > > > > > > >
> > > > > > > > Reading and storing variables to the RPMB partition in U-Bo=
ot works,
> > > > > > > > that's using the mmc rpmb command from u-boot,
> > > > > > >
> > > > > > > Are you talking about env variables? Perhaps you store them i=
n the mmc
> > > > > > > and not the RPMB partition?
> > > > > > > There's some information here [0]
> > > > > > >
> > > > > > > > But setting
> > > > > > > > CONFIG_EFI_MM_COMM_TEE=3Dy in u-boot I end with a similar b=
ehaviour
> > > > > > > > (although I'm not able to debug at u-boot level) What I see=
 is that
> > > > > > > > u-boot gets stuck
> > > > > > > > when bootefi bootmgr is invoqued. I can also reproduce the =
issue with
> > > > > > > > bootefi hello.
> > > > > > > >
> > > > > > > > =3D> run bootcmd
> > > > > > > >   Scanning for bootflows in all bootdevs
> > > > > > > >   Seq  Method       State   Uclass    Part  Name           =
           Filename
> > > > > > > >   ---  -----------  ------  --------  ----  ---------------=
---------
> > > > > > > > ----------------
> > > > > > > >   Scanning global bootmeth 'efi_mgr':
> > > > > > > > ( gets stuck here)
> > > > > > > >
> > > > > > > > or
> > > > > > > >
> > > > > > > > =3D> bootefi hello
> > > > > > > > (gets stuck)
> > > > > > > >
> > > > > > > > To debug I disabled CONFIG_EFI_MM_COMM_TEE to not get stuck=
 and bypass
> > > > > > > > the error and go to Linux. My understanding is that
> > > > > > > > CONFIG_EFI_MM_COMM_TEE is only required to read/write efi v=
ariables at
> > > > > > > > u-boot level but OPTEE is running the StandaloneMM service.=
 Am I
> > > > > > > > right?
> > > > > > >
> > > > > > > U-Boot has two ways of storing EFI variables [0] . You can ei=
ther
> > > > > > > store them in a file or the RPMB partition. The correct thing=
 to do,
> > > > > > > since you want to use the RPMB, is enable CONFIG_EFI_MM_COMM_=
TEE. I am
> > > > > > > not sure why the hand happens, but one thing we can improve i=
s figure
> > > > > > > out why it hangs and print a useful message.
> > > > > > > There are a number of reasons that might lead to a failure. I=
s the
> > > > > > > RPMB key programmed on your board? Have a look at this [1] in=
 case it
> > > > > > > helps
> > > > > > >
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > # tee-supplicant
> > > > > > > > > > D/TC:? 0 tee_ta_init_session_with_context:557 Re-open t=
rusted service
> > > > > > > > > > 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> > > > > > > > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > > > > > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > >
> > > > > > > If I had to guess, OP-TEE doesn't store the variables in the =
RPMB, can
> > > > > > > you compile it with a bit more debugging enabled?
> > > > > > >
> > > > > >
> > > > > > Here is a log with CFG_TEE_CORE_LOG_LEVEL=3D4, CFG_TEE_CORE_DEB=
UG=3Dy and
> > > > > > CFG_TEE_TA_LOG_LEVEL=3D4
> > > > > >
> > > > > > https://paste.centos.org/view/eed83a5b
> > > > > >
> > > > > > At the beginning of the log I see
> > > > > >
> > > > > > D/TC:0 0 check_ta_store:449 TA store: "REE"
> > > > > >
> > > > > > Which looks wrong to me as I built optee with:
> > > > > >   CFG_REE_FS=3Dn
> > > > > >   CFG_RPMB_FS_DEV_ID=3D0
> > > > > >   CFG_RPMB_FS=3Dy
> > > > >
> > > > > Yes it does look wrong. Our compilation flags are
> > > > > CFG_RPMB_FS=3Dy CFG_RPMB_FS_DEV_ID=3D0 CFG_RPMB_WRITE_KEY=3Dy
> > > > > CFG_RPMB_TESTKEY=3Dy CFG_REE_FS=3Dn CFG_CORE_ARM64_PA_BITS=3D48
> > > > > CFG_SCTLR_ALIGNMENT_CHECK=3Dn
> > > > >
> > > >
> > > > Mine are very similar
> > > >
> > > > make CROSS_COMPILE=3D"$CC32" CROSS_COMPILE64=3D"$CC64" \
> > > >     PLATFORM=3Dk3-j784s4 CFG_ARM64_core=3Dy CFG_CONSOLE_UART=3D0x8 =
\
> > > >     CFG_RPMB_FS_DEV_ID=3D0 CFG_REE_FS=3Dn CFG_RPMB_FS=3Dy \
> > > >     CFG_RPMB_WRITE_KEY=3Dy CFG_RPMB_TESTKEY=3Dy \
> > > >     CFG_STMM_PATH=3DBL32_AP_MM.fd \
> > > >     CFG_CORE_HEAP_SIZE=3D524288 CFG_CORE_DYN_SHM=3Dy CFG_SCTLR_ALIG=
NMENT_CHECK=3Dn \
> > > >     CFG_TEE_CORE_LOG_LEVEL=3D4 CFG_TEE_CORE_DEBUG=3Dy CFG_TEE_TA_LO=
G_LEVEL=3D4
> > > >
> > > > There is a difference with CFG_CORE_ARM64_PA_BITS=3D48 , my platfor=
m defines it to
> > > >
> > > >    core/arch/arm/plat-k3/conf.mk:$(call force,CFG_CORE_ARM64_PA_BIT=
S,36)
> > > >
> > > > But I don't think this is the problem.
> > > >
> > > > > The testkey etc aren't required if your board has a way of readin=
g the
> > > > > RPMB key from a secure location -- in fact, using the testkey is =
not
> > > > > secure. Is the RPMB programmed on your board? Also can you make s=
ure
> > > > > CFG_RPMB_FS_DEV_ID needs to be 0? How many sd interfaces your boa=
rd
> > > > > has?
> > > >
> > > > My board has two interfaces, an eMMC and a SD-card, 0 is indeed the
> > > > eMMC and I'm using the testkey which I assume was programmed the fi=
rst
> > > > time I booted with all this. Unfortunately I lost the traces. But,
> > > > optee_rpmb works. I.e:
> > > >
> > > >      =3D> optee_rpmb write test 1234
> > > >      =3D> optee_rpmb read test 4
> > > >      Read 4 bytes, value =3D 1234
> > > >
> > > >
> > > > > IOW in U-Boot does 'mmc dev 0 && mmc info' print information for =
the
> > > > > RPMB partition?
> > > > >
> > > >
> > > >     =3D> mmc dev 0
> > > >     switch to partitions #0, OK
> > > >     mmc0(part 0) is current device
> > > >     =3D> mmc info
> > > >     Device: mmc@4f80000
> > > >     Manufacturer ID: 13
> > > >     OEM: 4e
> > > >     Name: G1M15L
> > > >     Bus Speed: 200000000
> > > >     Mode: HS400 (200MHz)
> > > >     Rd Block Len: 512
> > > >     MMC version 5.1
> > > >     High Capacity: Yes
> > > >     Capacity: 29.6 GiB
> > > >     Bus Width: 8-bit DDR
> > > >     Erase Group Size: 512 KiB
> > > >     HC WP Group Size: 8 MiB
> > > >     User Capacity: 29.6 GiB WRREL
> > > >     Boot Capacity: 31.5 MiB ENH
> > > >     RPMB Capacity: 4 MiB ENH
> > > >     Boot area 0 is not write protected
> > > >     Boot area 1 is not write protected
> > > >     =3D> mmc list
> > > >     mmc@4f80000: 0 (eMMC)
> > > >     mmc@4fb0000: 1
> > > >
> > > > Any interaction with efi gives me the same result (printenv -e,
> > > > efidebug, bootefi ...)
> > >
> > > Yes, that makes sense, because variables fail to initialize -- which
> > > is a core part of bringing up the EFI subsystem.
> > >
> > > Can you recompile op-tee with CFG_RPMB_RESET_FAT and try again?
> > >
> >
> > Unfortunately that didn't help, but I don't see this code being run.

That's weird, look below.

> > Who sets for the first place the uefi variables, is this u-boot
> > writing them to the rpmb? or is optee itself?

U-Boot sets the variables, but it does so via StandAloneMM.

> >
>
> I tried to compare the behaviour between optee_rpmb (works) and
> efidebug (doesn't worrk). I see that the first thing optee_rpmb
> command does is open a session against the TA application, something
> that efidebug doesn't do, shouldn't efidebug do the same to access to
> the rpmb device and read or write the efi variables?
>

That's a bit more complicated and explained to one of the blog posts I
pasted above.
We do open an OP-TEE session, but not for talking to a TA. We send the
messages to StandAloneMM, which then usese OPTEE RPMB APIs to write
the flash.

The weird thing is why OP-TEE does not format your RPMB when compiling
with that flag.
If done correctly, OP-TEE will wipe the RPMB contents the first time
it tries to access it.

Cheers
/Ilias

> =3D> optee_rpmb read test 4
> D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA
> 023f8f1a-292a-432b-8fc4-de8471358067
> D/TC:? 0 ldelf_load_ldelf:110 ldelf load address 0x40007000
> D/LD:  ldelf:142 Loading TS 023f8f1a-292a-432b-8fc4-de8471358067
> F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> F/TC:? 0 trace_syscall:147 syscall #5 (syscall_open_ta_session)
> D/TC:? 0 ldelf_syscall_open_bin:163 Lookup user TA ELF
> 023f8f1a-292a-432b-8fc4-de8471358067 (early TA)
> D/TC:? 0 ldelf_syscall_open_bin:167 res=3D0
> F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 trace_syscall:147 syscall #11 (syscall_mask_cancellation)
> F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
>
> =3D> efidebug query -bs -rt -nv
> MMC: no card present
> mmc_init: -123, time 2002
> D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> D/TC:? 0 spm_handle_scall:859 Received FFA version
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
>
>
>
> >
> > > Thanks
> > > /Ilias
> > > >
> > > > =3D> efidebug query -bs -rt -nv
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
> > > > ... stuck here ... I need to reset the board
> > > >
> > > > Will continue to see if I can get more useful messages
> > > >
> > > > Thanks,
> > > >   Enric
> > > >
> > > > > Thanks
> > > > > /Ilias
> > > > > >
> > > > > > I'll try to add some more prints to verify if REE is used as a =
store
> > > > > > system, I assume this should say something about RPMB. Am I rig=
ht with
> > > > > > this?
> > > > >
> > > > >
> > > > > >
> > > > > > > > > >
> > > > > > > > > > And tracing the function calls gives me that:
> > > > > > > > > >
> > > > > > > > > >       tee_stmm_efi_probe() {
> > > > > > > > > >              tee_client_open_context() {
> > > > > > > > > >                optee_get_version() {
> > > > > > > > > >                  tee_get_drvdata(); (ret=3D0xffff000002=
e55800)
> > > > > > > > > >                } (ret=3D0xd)
> > > > > > > > > >                tee_ctx_match(); (ret=3D0x1)
> > > > > > > > > >                optee_smc_open() {
> > > > > > > > > >                  tee_get_drvdata(); (ret=3D0xffff000002=
e55800)
> > > > > > > > > >                  optee_open() {
> > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > >                  } (ret=3D0x0)
> > > > > > > > > >                } (ret=3D0x0)
> > > > > > > > > >              } (ret=3D0xffff000004e71c80)
> > > > > > > > > >              tee_client_open_session() {
> > > > > > > > > >                optee_open_session() {
> > > > > > > > > >                  tee_get_drvdata(); (ret=3D0xffff000002=
e55800)
> > > > > > > > > >                  optee_get_msg_arg() {
> > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > >                    tee_shm_get_va(); (ret=3D0xffff00000=
2909000)
> > > > > > > > > >                  } (ret=3D0xffff000002909000)
> > > > > > > > > >                  tee_session_calc_client_uuid(); (ret=
=3D0x0)
> > > > > > > > > >                  optee_to_msg_param(); (ret=3D0x0)
> > > > > > > > > >                  optee_smc_do_call_with_arg() {
> > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > >                    tee_shm_get_va(); (ret=3D0xffff00000=
2909000)
> > > > > > > > > >                    tee_shm_get_va(); (ret=3D0xffff00000=
2909060)
> > > > > > > > > >                    optee_cq_wait_init(); (ret=3D0xffff0=
00002e55910)
> > > > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004=
)
> > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004=
)
> > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004=
)
> > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004=
)
> > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004=
)
> > > > > > > > > >      ... continues sending this forever ...
> > > > > > > > > >      ... Hit ^C to stop recording ...
> > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > >                    optee_smccc_smc() {
> > > > > > > > > >
> > > > > > > > > > [1] https://docs.u-boot.org/en/latest/develop/uefi/uefi=
.html#using-op-tee-for-efi-variables
> > > > > > > > > >
> > > > > > > > > > Thanks in advance,
> > > > > > > > >
> > > > > > > > > The most common problem with this is miscompiling the tee=
_supplicant
> > > > > > > > > application.
> > > > > > > > > Since we don't know if the system has an RPMB, we emulate=
 it in the
> > > > > > > > > tee_supplicant. How did you get the supplicant and can yo=
u check if it
> > > > > > > > > was compiled with RPMB_EMU=3D0 or 1?
> > > > > > > > >
> > > > > > > >
> > > > > > > > I'm using the tee-supplicant provided by the fedora package=
 which is
> > > > > > > > built with ` -DRPMB_EMU=3D0`, I think that's correct, right=
?
> > > > > > > >
> > > > > > >
> > > > > > > Yes, this is correct. We fixed the Fedora package to compile =
the
> > > > > > > supplicant correctly a while back.
> > > > > > >
> > > > > > > [0] https://www.linaro.org/blog/uefi-secureboot-in-u-boot/
> > > > > > > [1] https://apalos.github.io/Protected%20UEFI%20variables%20w=
ith%20U-Boot.html#Protected%20UEFI%20variables%20with%20U-Boot
> > > > > > >
> > > > > > >
> > > > > > > Regards
> > > > > > > /Ilias
> > > > > > > > Thanks,
> > > > > > > >    Enric
> > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > > /Ilias
> > > > > > > > >
> > > > > > > > > >    Enric
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
>

