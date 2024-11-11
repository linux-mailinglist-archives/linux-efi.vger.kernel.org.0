Return-Path: <linux-efi+bounces-2131-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC699C40D9
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2024 15:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D041C21932
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2024 14:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970491A072A;
	Mon, 11 Nov 2024 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OL75VVmV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1082419F47E
	for <linux-efi@vger.kernel.org>; Mon, 11 Nov 2024 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335194; cv=none; b=G1X36N0yfUDGG8BrbUWMv/PL/S8YWxjtkUNwiiVh8gvYElnR8ppzDBBPFEPggcxzwY6PW20QbaA0IIC7GI7r+DjXfSlOd3R6jtgNJVnQxpt6VDvyER+NT3t485jCUxL89wYLQYFjjczvWIcpJHLlIMWLnGl4x2tucdisldZOitI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335194; c=relaxed/simple;
	bh=mJFJ5q+aE2Q+BX8Es/7SMn3hVHkbX9M2RJsTsK9c/8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coJ+kG3MKE9wt2BGJMPlzVN78YnhbpGpZfcvrvv9dCcvTMIUMR3aactcHyG+6o/nc3FXvlKw39sJ5QvxM7Nqf+ODmQDcq/xbSZU2MtedcCzf+nJGZP3M0HXbKB8qs7C+6HQYm5XvkmuavESppcnDAM+WCazqX6R1RMGlCHPMlh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OL75VVmV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2ed59a35eso3717429a91.0
        for <linux-efi@vger.kernel.org>; Mon, 11 Nov 2024 06:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731335189; x=1731939989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgBryo6D6AeOGrl6Q4Qjz8yhigKvuJYkArqCERg4vPs=;
        b=OL75VVmVgrg9aLNhUL1Yj7VqHNCZXm2BE6E6I8XfVv5GHHKB5pXj7/ySbCr/+hEWtn
         /+dih1nzF1rTOLLX7/pMA9oTdCd6w6IB4xXwfujxFWvtE3fJRvqpeiz/jd/4fxwlpOZM
         tAfE567Vn1aN4cRAjFWKEoq9IJkdG2l/cHroaHQu93h1C3jLWWkkgseHLxtiE9fyjPfN
         xwrFtKIeQ+aGs4C6uiN1Zg3t2HrrkJJzviqOk93iS4Q0sR5uRA6OgTSkA81N19rCc8eH
         vSo1KSKEm22xXZBQPw4vimNcBlkadJ9vyN6MlS6FpiZjQ4YVC5YpA7+14d/GKyT7qoG2
         Cn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335189; x=1731939989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgBryo6D6AeOGrl6Q4Qjz8yhigKvuJYkArqCERg4vPs=;
        b=wTMQS697z1C9v1L+uSOFbyk+22VdnsSWf6xqXtySNx5ddvKYug/WdCHtgy9jUgtOpi
         uitEdq1HfC5wdy5NPWBZbgOB/MmM2FVmcX0KlDmTCbAc09GeMxPLczZ0hKh0M0zp508C
         r5s3PbVsreBLPGdeyfRrBrz/HE33gt6wf15myQiK135VLA6qIqIr1Z+f0g5TEzSF1L9+
         24uPEwWLlVFrgYaFgI4y7V5Bfhmzz50mq5kmY01lcsV6/Hk9sxExHJILwsmz3qHQNlOj
         qcLnOkpUIKAB83V1XvJZvnY49UIgAZgUHldB07cYzNLPAKCpzEaUipraAiuOK4XGtr37
         jRlw==
X-Forwarded-Encrypted: i=1; AJvYcCV9SFcAkJOBeW/if2p3a/0aV/lc4wqeX17lXpXGFY9PGbZkGyUlj53TUotC+FAFHPHkUsvrRuqvhas=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRA5x1E17iL+AkMf4A+wVpWf066WRqMt+FJtQMYRAwwlunYKDC
	mi++XG85RD/9EeTCUW2v/7Uu/dioso4G3xHxY3WteeR7ZRVt79L1YK7Zh4OG9wWixHIe7af5Ksl
	J4Jxex10im2yaXFdnV+SlL+peCduCSwooZCWQzg==
X-Google-Smtp-Source: AGHT+IH+F79egA8Bxj7oFCQ2mGPYIF3HWzTVjCkTkXEAfMCFeecfPwV4tiWWvWBHaHZBbmkNXNSTWThUB/WyVptmKXE=
X-Received: by 2002:a17:90b:4b91:b0:2e2:b46f:d92c with SMTP id
 98e67ed59e1d1-2e9b172023bmr16285328a91.14.1731335189253; Mon, 11 Nov 2024
 06:26:29 -0800 (PST)
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
 <CAC_iWjL4mp-sTsp5a+yFkUauXuMvZ1yoTAk_60nm-CCKUgwayw@mail.gmail.com> <CALE0LRsYXXaao2uCUMFkd8Y6f5Mxgoc-Qpft_y8wWW3ZiekbbA@mail.gmail.com>
In-Reply-To: <CALE0LRsYXXaao2uCUMFkd8Y6f5Mxgoc-Qpft_y8wWW3ZiekbbA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 16:25:53 +0200
Message-ID: <CAC_iWjL+J9tNxEdh0AoYD19h013N4nk=KmaT=RACo4-oVwuRCA@mail.gmail.com>
Subject: Re: optee-based efi runtime variable service on TI j784s4 platforms
To: Enric Balletbo i Serra <eballetb@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Manorit Chawdhry <m-chawdhry@ti.com>, 
	Udit Kumar <u-kumar1@ti.com>, "Menon, Nishanth" <nm@ti.com>, 
	Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Nov 2024 at 16:13, Enric Balletbo i Serra
<eballetb@redhat.com> wrote:
>
> Hi,
>
> Thanks a lot for your support.

You're welcome. FWIW I did test this in the past with an AM62x SoC.

>
> On Mon, Nov 11, 2024 at 12:01=E2=80=AFPM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Mon, 11 Nov 2024 at 10:21, Enric Balletbo i Serra
> > <eballetb@redhat.com> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Sat, Nov 9, 2024 at 1:31=E2=80=AFAM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Fri, 8 Nov 2024 at 23:11, Enric Balletbo i Serra <eballetb@redha=
t.com> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > Thanks for your quick answer.
> > > > >
> > > > > On Fri, Nov 8, 2024 at 4:48=E2=80=AFPM Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Enric,
> > > > > >
> > > > > > On Fri, 8 Nov 2024 at 12:26, Enric Balletbo i Serra <eballetb@r=
edhat.com> wrote:
> > > > > > >
> > > > > > > Hi all,
> > > > > > >
> > > > > > > I'm looking for any advice/clue to help me to progress on ena=
bling
> > > > > > > TEE-base EFI Runtime Variable Service on TI a j784s4 platform=
s.
> > > > > > >
> > > > > > > I basically followed the steps described in u-boot documentat=
ion [1],
> > > > > > > I enabled some debugging messages but I think I'm at the poin=
t that
> > > > > > > the problem might be in the StandaloneMM application, and I'm=
 not sure
> > > > > > > how to debug it.
> > > > > > >
> > > > > > > What I see is that when I run the tee-supplicant daemon, it l=
ooks like
> > > > > > > the tee_client_open_session() call loops forever and the tee_=
stmm_efi
> > > > > > > driver never ends to probe.
> > > > > > >
> > > > > > > With debug enabled I got the following messages.
> > > > > >
> > > > > > I assume reading and storing variables already works in U-Boot =
right?
> > > > > >
> > > > >
> > > > > Reading and storing variables to the RPMB partition in U-Boot wor=
ks,
> > > > > that's using the mmc rpmb command from u-boot,
> > > >
> > > > Are you talking about env variables? Perhaps you store them in the =
mmc
> > > > and not the RPMB partition?
> > > > There's some information here [0]
> > > >
> > > > > But setting
> > > > > CONFIG_EFI_MM_COMM_TEE=3Dy in u-boot I end with a similar behavio=
ur
> > > > > (although I'm not able to debug at u-boot level) What I see is th=
at
> > > > > u-boot gets stuck
> > > > > when bootefi bootmgr is invoqued. I can also reproduce the issue =
with
> > > > > bootefi hello.
> > > > >
> > > > > =3D> run bootcmd
> > > > >   Scanning for bootflows in all bootdevs
> > > > >   Seq  Method       State   Uclass    Part  Name                 =
     Filename
> > > > >   ---  -----------  ------  --------  ----  ---------------------=
---
> > > > > ----------------
> > > > >   Scanning global bootmeth 'efi_mgr':
> > > > > ( gets stuck here)
> > > > >
> > > > > or
> > > > >
> > > > > =3D> bootefi hello
> > > > > (gets stuck)
> > > > >
> > > > > To debug I disabled CONFIG_EFI_MM_COMM_TEE to not get stuck and b=
ypass
> > > > > the error and go to Linux. My understanding is that
> > > > > CONFIG_EFI_MM_COMM_TEE is only required to read/write efi variabl=
es at
> > > > > u-boot level but OPTEE is running the StandaloneMM service. Am I
> > > > > right?
> > > >
> > > > U-Boot has two ways of storing EFI variables [0] . You can either
> > > > store them in a file or the RPMB partition. The correct thing to do=
,
> > > > since you want to use the RPMB, is enable CONFIG_EFI_MM_COMM_TEE. I=
 am
> > > > not sure why the hand happens, but one thing we can improve is figu=
re
> > > > out why it hangs and print a useful message.
> > > > There are a number of reasons that might lead to a failure. Is the
> > > > RPMB key programmed on your board? Have a look at this [1] in case =
it
> > > > helps
> > > >
> > > > >
> > > > > > >
> > > > > > > # tee-supplicant
> > > > > > > D/TC:? 0 tee_ta_init_session_with_context:557 Re-open trusted=
 service
> > > > > > > 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> > > > > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > >
> > > > If I had to guess, OP-TEE doesn't store the variables in the RPMB, =
can
> > > > you compile it with a bit more debugging enabled?
> > > >
> > >
> > > Here is a log with CFG_TEE_CORE_LOG_LEVEL=3D4, CFG_TEE_CORE_DEBUG=3Dy=
 and
> > > CFG_TEE_TA_LOG_LEVEL=3D4
> > >
> > > https://paste.centos.org/view/eed83a5b
> > >
> > > At the beginning of the log I see
> > >
> > > D/TC:0 0 check_ta_store:449 TA store: "REE"
> > >
> > > Which looks wrong to me as I built optee with:
> > >   CFG_REE_FS=3Dn
> > >   CFG_RPMB_FS_DEV_ID=3D0
> > >   CFG_RPMB_FS=3Dy
> >
> > Yes it does look wrong. Our compilation flags are
> > CFG_RPMB_FS=3Dy CFG_RPMB_FS_DEV_ID=3D0 CFG_RPMB_WRITE_KEY=3Dy
> > CFG_RPMB_TESTKEY=3Dy CFG_REE_FS=3Dn CFG_CORE_ARM64_PA_BITS=3D48
> > CFG_SCTLR_ALIGNMENT_CHECK=3Dn
> >
>
> Mine are very similar
>
> make CROSS_COMPILE=3D"$CC32" CROSS_COMPILE64=3D"$CC64" \
>     PLATFORM=3Dk3-j784s4 CFG_ARM64_core=3Dy CFG_CONSOLE_UART=3D0x8 \
>     CFG_RPMB_FS_DEV_ID=3D0 CFG_REE_FS=3Dn CFG_RPMB_FS=3Dy \
>     CFG_RPMB_WRITE_KEY=3Dy CFG_RPMB_TESTKEY=3Dy \
>     CFG_STMM_PATH=3DBL32_AP_MM.fd \
>     CFG_CORE_HEAP_SIZE=3D524288 CFG_CORE_DYN_SHM=3Dy CFG_SCTLR_ALIGNMENT_=
CHECK=3Dn \
>     CFG_TEE_CORE_LOG_LEVEL=3D4 CFG_TEE_CORE_DEBUG=3Dy CFG_TEE_TA_LOG_LEVE=
L=3D4
>
> There is a difference with CFG_CORE_ARM64_PA_BITS=3D48 , my platform defi=
nes it to
>
>    core/arch/arm/plat-k3/conf.mk:$(call force,CFG_CORE_ARM64_PA_BITS,36)
>
> But I don't think this is the problem.
>
> > The testkey etc aren't required if your board has a way of reading the
> > RPMB key from a secure location -- in fact, using the testkey is not
> > secure. Is the RPMB programmed on your board? Also can you make sure
> > CFG_RPMB_FS_DEV_ID needs to be 0? How many sd interfaces your board
> > has?
>
> My board has two interfaces, an eMMC and a SD-card, 0 is indeed the
> eMMC and I'm using the testkey which I assume was programmed the first
> time I booted with all this. Unfortunately I lost the traces. But,
> optee_rpmb works. I.e:
>
>      =3D> optee_rpmb write test 1234
>      =3D> optee_rpmb read test 4
>      Read 4 bytes, value =3D 1234
>
>
> > IOW in U-Boot does 'mmc dev 0 && mmc info' print information for the
> > RPMB partition?
> >
>
>     =3D> mmc dev 0
>     switch to partitions #0, OK
>     mmc0(part 0) is current device
>     =3D> mmc info
>     Device: mmc@4f80000
>     Manufacturer ID: 13
>     OEM: 4e
>     Name: G1M15L
>     Bus Speed: 200000000
>     Mode: HS400 (200MHz)
>     Rd Block Len: 512
>     MMC version 5.1
>     High Capacity: Yes
>     Capacity: 29.6 GiB
>     Bus Width: 8-bit DDR
>     Erase Group Size: 512 KiB
>     HC WP Group Size: 8 MiB
>     User Capacity: 29.6 GiB WRREL
>     Boot Capacity: 31.5 MiB ENH
>     RPMB Capacity: 4 MiB ENH
>     Boot area 0 is not write protected
>     Boot area 1 is not write protected
>     =3D> mmc list
>     mmc@4f80000: 0 (eMMC)
>     mmc@4fb0000: 1
>
> Any interaction with efi gives me the same result (printenv -e,
> efidebug, bootefi ...)

Yes, that makes sense, because variables fail to initialize -- which
is a core part of bringing up the EFI subsystem.

Can you recompile op-tee with CFG_RPMB_RESET_FAT and try again?

Thanks
/Ilias
>
> =3D> efidebug query -bs -rt -nv
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
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> ... stuck here ... I need to reset the board
>
> Will continue to see if I can get more useful messages
>
> Thanks,
>   Enric
>
> > Thanks
> > /Ilias
> > >
> > > I'll try to add some more prints to verify if REE is used as a store
> > > system, I assume this should say something about RPMB. Am I right wit=
h
> > > this?
> >
> >
> > >
> > > > > > >
> > > > > > > And tracing the function calls gives me that:
> > > > > > >
> > > > > > >       tee_stmm_efi_probe() {
> > > > > > >              tee_client_open_context() {
> > > > > > >                optee_get_version() {
> > > > > > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800=
)
> > > > > > >                } (ret=3D0xd)
> > > > > > >                tee_ctx_match(); (ret=3D0x1)
> > > > > > >                optee_smc_open() {
> > > > > > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800=
)
> > > > > > >                  optee_open() {
> > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > >                  } (ret=3D0x0)
> > > > > > >                } (ret=3D0x0)
> > > > > > >              } (ret=3D0xffff000004e71c80)
> > > > > > >              tee_client_open_session() {
> > > > > > >                optee_open_session() {
> > > > > > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800=
)
> > > > > > >                  optee_get_msg_arg() {
> > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > >                    tee_shm_get_va(); (ret=3D0xffff00000290900=
0)
> > > > > > >                  } (ret=3D0xffff000002909000)
> > > > > > >                  tee_session_calc_client_uuid(); (ret=3D0x0)
> > > > > > >                  optee_to_msg_param(); (ret=3D0x0)
> > > > > > >                  optee_smc_do_call_with_arg() {
> > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > >                    tee_shm_get_va(); (ret=3D0xffff00000290900=
0)
> > > > > > >                    tee_shm_get_va(); (ret=3D0xffff00000290906=
0)
> > > > > > >                    optee_cq_wait_init(); (ret=3D0xffff000002e=
55910)
> > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > >      ... continues sending this forever ...
> > > > > > >      ... Hit ^C to stop recording ...
> > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > >                    optee_smccc_smc() {
> > > > > > >
> > > > > > > [1] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#=
using-op-tee-for-efi-variables
> > > > > > >
> > > > > > > Thanks in advance,
> > > > > >
> > > > > > The most common problem with this is miscompiling the tee_suppl=
icant
> > > > > > application.
> > > > > > Since we don't know if the system has an RPMB, we emulate it in=
 the
> > > > > > tee_supplicant. How did you get the supplicant and can you chec=
k if it
> > > > > > was compiled with RPMB_EMU=3D0 or 1?
> > > > > >
> > > > >
> > > > > I'm using the tee-supplicant provided by the fedora package which=
 is
> > > > > built with ` -DRPMB_EMU=3D0`, I think that's correct, right?
> > > > >
> > > >
> > > > Yes, this is correct. We fixed the Fedora package to compile the
> > > > supplicant correctly a while back.
> > > >
> > > > [0] https://www.linaro.org/blog/uefi-secureboot-in-u-boot/
> > > > [1] https://apalos.github.io/Protected%20UEFI%20variables%20with%20=
U-Boot.html#Protected%20UEFI%20variables%20with%20U-Boot
> > > >
> > > >
> > > > Regards
> > > > /Ilias
> > > > > Thanks,
> > > > >    Enric
> > > > >
> > > > > > Thanks
> > > > > > /Ilias
> > > > > >
> > > > > > >    Enric
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>

