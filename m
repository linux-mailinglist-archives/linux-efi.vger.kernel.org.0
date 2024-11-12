Return-Path: <linux-efi+bounces-2135-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787F89C5065
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 09:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077011F228C6
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 08:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AD420A5EB;
	Tue, 12 Nov 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBoi1U0+"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D0683A14
	for <linux-efi@vger.kernel.org>; Tue, 12 Nov 2024 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399468; cv=none; b=XnXoJaeEcTB/lSqukj1XtZzjSsa0i1Re8hclGgqAs8/op/coTfl2JQZfrQiSebiCTMo4WtyTcsxEoaKoY5v3vOv5ZRWl4Bb6EOHa4/LKEnNiQPToLETYY7yr3a6y5/T0NjqkaPCzcEQ5a1oB1QTvZRQTmP/8NGn9i+TOjpjV6bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399468; c=relaxed/simple;
	bh=FVCbZWaX6wPm7kHLfES9qGQGtmQxkogeEHRo1y/pfu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkZdPGBHAkf/irQzGX64lSFgzs08uzUF183quBWRQn4lSDWMvD8D/dOYYx5STpqwnAdeFOcM/DEReTsVVK37eS8UnZDuapAj5i4KNOGk2eFWTYa3/6BjYUSOXEczI2gsGZF6ulJVI5lofU4qF9XoAyn1htbhoPoX1j30rtsrbuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBoi1U0+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731399465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YwZmSOWx8HyqjpAWmNpo58KhEXMOSR51zwVARxdGbw=;
	b=VBoi1U0+UN57niUDa39qkFmmWPyQJB4FlXsDnduMPdYsh+WdbrNmLL1q8nz8jIX0/1nFZq
	1X/2KeaTjRbNQy9LzhIPDkq3xVKxVWgWSVELY3uGOevTex/oFPwoiDOpy82NqGpDyyV8vB
	1yUWrLY9DBylu5QAISMTBFwVvGykypo=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-dgujHghLNHmagCF-1KlkiQ-1; Tue, 12 Nov 2024 03:17:44 -0500
X-MC-Unique: dgujHghLNHmagCF-1KlkiQ-1
X-Mimecast-MFC-AGG-ID: dgujHghLNHmagCF-1KlkiQ
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3e6069ec8fbso57236b6e.0
        for <linux-efi@vger.kernel.org>; Tue, 12 Nov 2024 00:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731399463; x=1732004263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YwZmSOWx8HyqjpAWmNpo58KhEXMOSR51zwVARxdGbw=;
        b=h/d3ZURPfKiJ3S1b4LbJy6o8hZfhxwan08OUUog8TvDQt9rh7uTnbCnJ4nI0B2lmT7
         DLkKJCjpA9DaiVOLomLI/itfzb06yXajlewEuBKz404rojuQCzu/FdU8jEWRRLoPVphK
         pUTvPKIbZZQdWckg3tv2eEom2GyDaanHgYUiBpI+UNtg/obpPf688+g0TJiN0W5RgDLn
         Ky0BezkZsDSw5do+G6GXrru7B22DcsdzmPlxtXKqFKgArF6cfQ2nbQ5rLqrEPvukrunw
         cDOpKEz6ZWis3pglwT/4eDjNrqBOef1d3dVtmyzwi+Ppbn7Hn4aqFo2D7e8wk/Wc0vZC
         dUXg==
X-Forwarded-Encrypted: i=1; AJvYcCU49RjSoDRNszKNLTZoGgzz9zrGMDXZK1M0rkrk3lACU1V7G6+4HULdwiEFSIKDjI5Gvt1WOeASDZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydzCqKwmqgSRDVUHOqzFCcw6CnkRMrvyQEc17N+chVs/Ph5fxA
	BuASe4341o+H1YhkFJtKnVlEoVL/iyOFuHfLkgm2cl07zchjqbjyQf89Ss2N8voTtnnXQTROmau
	TmarFd9Bj3ooolBKiy808wZw0v+/PkhKmkFZ9IhQuCL0mhY0c0gsSeWIuTFMFM9MVl+e5AqqZSd
	aTTlkxxZ15PbOPCXNGXL+LBsvIa3xG1+P/
X-Received: by 2002:a05:6830:d87:b0:718:ffc:9445 with SMTP id 46e09a7af769-71a1c1f11b8mr3383129a34.2.1731399463187;
        Tue, 12 Nov 2024 00:17:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmcllwnAschn0N17G4CiO9TRoswaB0iux0nbSzDSLawn8YtqeeN9t9NGOsoUeZxNT3h/+QFeNRLDdx51BMlag=
X-Received: by 2002:a05:6830:d87:b0:718:ffc:9445 with SMTP id
 46e09a7af769-71a1c1f11b8mr3383117a34.2.1731399462715; Tue, 12 Nov 2024
 00:17:42 -0800 (PST)
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
 <CALE0LRsYXXaao2uCUMFkd8Y6f5Mxgoc-Qpft_y8wWW3ZiekbbA@mail.gmail.com> <CAC_iWjL+J9tNxEdh0AoYD19h013N4nk=KmaT=RACo4-oVwuRCA@mail.gmail.com>
In-Reply-To: <CAC_iWjL+J9tNxEdh0AoYD19h013N4nk=KmaT=RACo4-oVwuRCA@mail.gmail.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Tue, 12 Nov 2024 09:17:31 +0100
Message-ID: <CALE0LRu2oDSo6KOhO2fTDMiqX7iqjqNjNGD_67MJFS7BJWqT_w@mail.gmail.com>
Subject: Re: optee-based efi runtime variable service on TI j784s4 platforms
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Manorit Chawdhry <m-chawdhry@ti.com>, 
	Udit Kumar <u-kumar1@ti.com>, "Menon, Nishanth" <nm@ti.com>, 
	Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 11, 2024 at 3:26=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Mon, 11 Nov 2024 at 16:13, Enric Balletbo i Serra
> <eballetb@redhat.com> wrote:
> >
> > Hi,
> >
> > Thanks a lot for your support.
>
> You're welcome. FWIW I did test this in the past with an AM62x SoC.
>

Thanks for the info, maybe I can give it a try with my BeaglePlay then...

> >
> > On Mon, Nov 11, 2024 at 12:01=E2=80=AFPM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Mon, 11 Nov 2024 at 10:21, Enric Balletbo i Serra
> > > <eballetb@redhat.com> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Sat, Nov 9, 2024 at 1:31=E2=80=AFAM Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > On Fri, 8 Nov 2024 at 23:11, Enric Balletbo i Serra <eballetb@red=
hat.com> wrote:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > > > Thanks for your quick answer.
> > > > > >
> > > > > > On Fri, Nov 8, 2024 at 4:48=E2=80=AFPM Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Enric,
> > > > > > >
> > > > > > > On Fri, 8 Nov 2024 at 12:26, Enric Balletbo i Serra <eballetb=
@redhat.com> wrote:
> > > > > > > >
> > > > > > > > Hi all,
> > > > > > > >
> > > > > > > > I'm looking for any advice/clue to help me to progress on e=
nabling
> > > > > > > > TEE-base EFI Runtime Variable Service on TI a j784s4 platfo=
rms.
> > > > > > > >
> > > > > > > > I basically followed the steps described in u-boot document=
ation [1],
> > > > > > > > I enabled some debugging messages but I think I'm at the po=
int that
> > > > > > > > the problem might be in the StandaloneMM application, and I=
'm not sure
> > > > > > > > how to debug it.
> > > > > > > >
> > > > > > > > What I see is that when I run the tee-supplicant daemon, it=
 looks like
> > > > > > > > the tee_client_open_session() call loops forever and the te=
e_stmm_efi
> > > > > > > > driver never ends to probe.
> > > > > > > >
> > > > > > > > With debug enabled I got the following messages.
> > > > > > >
> > > > > > > I assume reading and storing variables already works in U-Boo=
t right?
> > > > > > >
> > > > > >
> > > > > > Reading and storing variables to the RPMB partition in U-Boot w=
orks,
> > > > > > that's using the mmc rpmb command from u-boot,
> > > > >
> > > > > Are you talking about env variables? Perhaps you store them in th=
e mmc
> > > > > and not the RPMB partition?
> > > > > There's some information here [0]
> > > > >
> > > > > > But setting
> > > > > > CONFIG_EFI_MM_COMM_TEE=3Dy in u-boot I end with a similar behav=
iour
> > > > > > (although I'm not able to debug at u-boot level) What I see is =
that
> > > > > > u-boot gets stuck
> > > > > > when bootefi bootmgr is invoqued. I can also reproduce the issu=
e with
> > > > > > bootefi hello.
> > > > > >
> > > > > > =3D> run bootcmd
> > > > > >   Scanning for bootflows in all bootdevs
> > > > > >   Seq  Method       State   Uclass    Part  Name               =
       Filename
> > > > > >   ---  -----------  ------  --------  ----  -------------------=
-----
> > > > > > ----------------
> > > > > >   Scanning global bootmeth 'efi_mgr':
> > > > > > ( gets stuck here)
> > > > > >
> > > > > > or
> > > > > >
> > > > > > =3D> bootefi hello
> > > > > > (gets stuck)
> > > > > >
> > > > > > To debug I disabled CONFIG_EFI_MM_COMM_TEE to not get stuck and=
 bypass
> > > > > > the error and go to Linux. My understanding is that
> > > > > > CONFIG_EFI_MM_COMM_TEE is only required to read/write efi varia=
bles at
> > > > > > u-boot level but OPTEE is running the StandaloneMM service. Am =
I
> > > > > > right?
> > > > >
> > > > > U-Boot has two ways of storing EFI variables [0] . You can either
> > > > > store them in a file or the RPMB partition. The correct thing to =
do,
> > > > > since you want to use the RPMB, is enable CONFIG_EFI_MM_COMM_TEE.=
 I am
> > > > > not sure why the hand happens, but one thing we can improve is fi=
gure
> > > > > out why it hangs and print a useful message.
> > > > > There are a number of reasons that might lead to a failure. Is th=
e
> > > > > RPMB key programmed on your board? Have a look at this [1] in cas=
e it
> > > > > helps
> > > > >
> > > > > >
> > > > > > > >
> > > > > > > > # tee-supplicant
> > > > > > > > D/TC:? 0 tee_ta_init_session_with_context:557 Re-open trust=
ed service
> > > > > > > > 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> > > > > > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > > > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > >
> > > > > If I had to guess, OP-TEE doesn't store the variables in the RPMB=
, can
> > > > > you compile it with a bit more debugging enabled?
> > > > >
> > > >
> > > > Here is a log with CFG_TEE_CORE_LOG_LEVEL=3D4, CFG_TEE_CORE_DEBUG=
=3Dy and
> > > > CFG_TEE_TA_LOG_LEVEL=3D4
> > > >
> > > > https://paste.centos.org/view/eed83a5b
> > > >
> > > > At the beginning of the log I see
> > > >
> > > > D/TC:0 0 check_ta_store:449 TA store: "REE"
> > > >
> > > > Which looks wrong to me as I built optee with:
> > > >   CFG_REE_FS=3Dn
> > > >   CFG_RPMB_FS_DEV_ID=3D0
> > > >   CFG_RPMB_FS=3Dy
> > >
> > > Yes it does look wrong. Our compilation flags are
> > > CFG_RPMB_FS=3Dy CFG_RPMB_FS_DEV_ID=3D0 CFG_RPMB_WRITE_KEY=3Dy
> > > CFG_RPMB_TESTKEY=3Dy CFG_REE_FS=3Dn CFG_CORE_ARM64_PA_BITS=3D48
> > > CFG_SCTLR_ALIGNMENT_CHECK=3Dn
> > >
> >
> > Mine are very similar
> >
> > make CROSS_COMPILE=3D"$CC32" CROSS_COMPILE64=3D"$CC64" \
> >     PLATFORM=3Dk3-j784s4 CFG_ARM64_core=3Dy CFG_CONSOLE_UART=3D0x8 \
> >     CFG_RPMB_FS_DEV_ID=3D0 CFG_REE_FS=3Dn CFG_RPMB_FS=3Dy \
> >     CFG_RPMB_WRITE_KEY=3Dy CFG_RPMB_TESTKEY=3Dy \
> >     CFG_STMM_PATH=3DBL32_AP_MM.fd \
> >     CFG_CORE_HEAP_SIZE=3D524288 CFG_CORE_DYN_SHM=3Dy CFG_SCTLR_ALIGNMEN=
T_CHECK=3Dn \
> >     CFG_TEE_CORE_LOG_LEVEL=3D4 CFG_TEE_CORE_DEBUG=3Dy CFG_TEE_TA_LOG_LE=
VEL=3D4
> >
> > There is a difference with CFG_CORE_ARM64_PA_BITS=3D48 , my platform de=
fines it to
> >
> >    core/arch/arm/plat-k3/conf.mk:$(call force,CFG_CORE_ARM64_PA_BITS,36=
)
> >
> > But I don't think this is the problem.
> >
> > > The testkey etc aren't required if your board has a way of reading th=
e
> > > RPMB key from a secure location -- in fact, using the testkey is not
> > > secure. Is the RPMB programmed on your board? Also can you make sure
> > > CFG_RPMB_FS_DEV_ID needs to be 0? How many sd interfaces your board
> > > has?
> >
> > My board has two interfaces, an eMMC and a SD-card, 0 is indeed the
> > eMMC and I'm using the testkey which I assume was programmed the first
> > time I booted with all this. Unfortunately I lost the traces. But,
> > optee_rpmb works. I.e:
> >
> >      =3D> optee_rpmb write test 1234
> >      =3D> optee_rpmb read test 4
> >      Read 4 bytes, value =3D 1234
> >
> >
> > > IOW in U-Boot does 'mmc dev 0 && mmc info' print information for the
> > > RPMB partition?
> > >
> >
> >     =3D> mmc dev 0
> >     switch to partitions #0, OK
> >     mmc0(part 0) is current device
> >     =3D> mmc info
> >     Device: mmc@4f80000
> >     Manufacturer ID: 13
> >     OEM: 4e
> >     Name: G1M15L
> >     Bus Speed: 200000000
> >     Mode: HS400 (200MHz)
> >     Rd Block Len: 512
> >     MMC version 5.1
> >     High Capacity: Yes
> >     Capacity: 29.6 GiB
> >     Bus Width: 8-bit DDR
> >     Erase Group Size: 512 KiB
> >     HC WP Group Size: 8 MiB
> >     User Capacity: 29.6 GiB WRREL
> >     Boot Capacity: 31.5 MiB ENH
> >     RPMB Capacity: 4 MiB ENH
> >     Boot area 0 is not write protected
> >     Boot area 1 is not write protected
> >     =3D> mmc list
> >     mmc@4f80000: 0 (eMMC)
> >     mmc@4fb0000: 1
> >
> > Any interaction with efi gives me the same result (printenv -e,
> > efidebug, bootefi ...)
>
> Yes, that makes sense, because variables fail to initialize -- which
> is a core part of bringing up the EFI subsystem.
>
> Can you recompile op-tee with CFG_RPMB_RESET_FAT and try again?
>

Unfortunately that didn't help, but I don't see this code being run.
Who sets for the first place the uefi variables, is this u-boot
writing them to the rpmb? or is optee itself?


> Thanks
> /Ilias
> >
> > =3D> efidebug query -bs -rt -nv
> > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > ... stuck here ... I need to reset the board
> >
> > Will continue to see if I can get more useful messages
> >
> > Thanks,
> >   Enric
> >
> > > Thanks
> > > /Ilias
> > > >
> > > > I'll try to add some more prints to verify if REE is used as a stor=
e
> > > > system, I assume this should say something about RPMB. Am I right w=
ith
> > > > this?
> > >
> > >
> > > >
> > > > > > > >
> > > > > > > > And tracing the function calls gives me that:
> > > > > > > >
> > > > > > > >       tee_stmm_efi_probe() {
> > > > > > > >              tee_client_open_context() {
> > > > > > > >                optee_get_version() {
> > > > > > > >                  tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > > >                } (ret=3D0xd)
> > > > > > > >                tee_ctx_match(); (ret=3D0x1)
> > > > > > > >                optee_smc_open() {
> > > > > > > >                  tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > > >                  optee_open() {
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e5=
5800)
> > > > > > > >                  } (ret=3D0x0)
> > > > > > > >                } (ret=3D0x0)
> > > > > > > >              } (ret=3D0xffff000004e71c80)
> > > > > > > >              tee_client_open_session() {
> > > > > > > >                optee_open_session() {
> > > > > > > >                  tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > > >                  optee_get_msg_arg() {
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e5=
5800)
> > > > > > > >                    tee_shm_get_va(); (ret=3D0xffff000002909=
000)
> > > > > > > >                  } (ret=3D0xffff000002909000)
> > > > > > > >                  tee_session_calc_client_uuid(); (ret=3D0x0=
)
> > > > > > > >                  optee_to_msg_param(); (ret=3D0x0)
> > > > > > > >                  optee_smc_do_call_with_arg() {
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e5=
5800)
> > > > > > > >                    tee_shm_get_va(); (ret=3D0xffff000002909=
000)
> > > > > > > >                    tee_shm_get_va(); (ret=3D0xffff000002909=
060)
> > > > > > > >                    optee_cq_wait_init(); (ret=3D0xffff00000=
2e55910)
> > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e5=
5800)
> > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e5=
5800)
> > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e5=
5800)
> > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e5=
5800)
> > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > > >      ... continues sending this forever ...
> > > > > > > >      ... Hit ^C to stop recording ...
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e5=
5800)
> > > > > > > >                    optee_smccc_smc() {
> > > > > > > >
> > > > > > > > [1] https://docs.u-boot.org/en/latest/develop/uefi/uefi.htm=
l#using-op-tee-for-efi-variables
> > > > > > > >
> > > > > > > > Thanks in advance,
> > > > > > >
> > > > > > > The most common problem with this is miscompiling the tee_sup=
plicant
> > > > > > > application.
> > > > > > > Since we don't know if the system has an RPMB, we emulate it =
in the
> > > > > > > tee_supplicant. How did you get the supplicant and can you ch=
eck if it
> > > > > > > was compiled with RPMB_EMU=3D0 or 1?
> > > > > > >
> > > > > >
> > > > > > I'm using the tee-supplicant provided by the fedora package whi=
ch is
> > > > > > built with ` -DRPMB_EMU=3D0`, I think that's correct, right?
> > > > > >
> > > > >
> > > > > Yes, this is correct. We fixed the Fedora package to compile the
> > > > > supplicant correctly a while back.
> > > > >
> > > > > [0] https://www.linaro.org/blog/uefi-secureboot-in-u-boot/
> > > > > [1] https://apalos.github.io/Protected%20UEFI%20variables%20with%=
20U-Boot.html#Protected%20UEFI%20variables%20with%20U-Boot
> > > > >
> > > > >
> > > > > Regards
> > > > > /Ilias
> > > > > > Thanks,
> > > > > >    Enric
> > > > > >
> > > > > > > Thanks
> > > > > > > /Ilias
> > > > > > >
> > > > > > > >    Enric
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>


