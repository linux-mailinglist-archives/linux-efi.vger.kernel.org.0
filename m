Return-Path: <linux-efi+bounces-2139-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0949C5829
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 13:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE3328411C
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 12:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322141DA5E;
	Tue, 12 Nov 2024 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtiBx4tr"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFB757CBE
	for <linux-efi@vger.kernel.org>; Tue, 12 Nov 2024 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415522; cv=none; b=U1GAb+ITb0n51dj2ye24nG6HHSb+nEtjGCMX7O5qKYmgmpUJcYPVlVYt+xG5Ul+sZQ+XH/b1mNxdfhahr3LowH9plz+6XIhXpgyAxuzqAZKXOeP/iYBz9c+emnwDt77GMpvadAZWjkWmsUNOzQHCsU8uWfZH+2pwTkESAcJSiys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415522; c=relaxed/simple;
	bh=mUvjXq2CygbM643LPS2/tdYvoFBU8B0fj9i7nigg96k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sY6x9fR1oeIf5WH3gaoKP2oMyFpiSmmLmokDf81Xv8XmcEdqO19zpvocb8tfZsg0D7qWCEAE7k3zr1fQjVYg5y1R/s1vo/4gxPKAsie8U4qVktxaB0QhDFUKN/5La4eClDG9Mjn0QallLXFw0rbSzfg3MsJ0UtUlH6obDo4gQwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtiBx4tr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731415518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSGSQt1jjnTnLrSSXY0rzoJVJ2uy2j03XFk0utdBgD0=;
	b=HtiBx4tryVhiaXKu1SfAWVTzUrgBY3QbgkXWT8ooGMLYzdK2E1dxb4ux7rUot0WKT2U+In
	OhlaZcuqY9UvQPjlCtSajPLNFHkzCe6j//MROKMML0wDMJGpzoCeCm/bmikApuSDlfALrO
	mDloYR+U3YXse6ikanJGBKX1nCZZwAA=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-FNZk5SMqOqy6kBBbbUpjHg-1; Tue, 12 Nov 2024 07:45:16 -0500
X-MC-Unique: FNZk5SMqOqy6kBBbbUpjHg-1
X-Mimecast-MFC-AGG-ID: FNZk5SMqOqy6kBBbbUpjHg
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3e6069ec8fbso91769b6e.0
        for <linux-efi@vger.kernel.org>; Tue, 12 Nov 2024 04:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731415516; x=1732020316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSGSQt1jjnTnLrSSXY0rzoJVJ2uy2j03XFk0utdBgD0=;
        b=VO/L+93OR/5HR3ifi2UWZxcisCeSfem93uaMaNx8z8l7dOx0QKZjQNOnlGl+hzjgwG
         j+b9zQtjHNBZw5Ttw+yNUmTyWxZsJszyORVgw9xesUZbd4V8kPv5QctgA17clm3Klc5G
         qss8zieNfSGqFFG5LdUrZIXvQFPYpKWoKv23t4Jy/o+lcxrm5ieS7bHXJQpL3zSBYCby
         3FNxkUQXeY6a3jtoSUmGhFapb+ZxgXdfN31EybSimXlMJWYa5C8TIua3bdcZVeK9uoZu
         +UFELDXGdeZW0UKMsaBT6aO99OqKtklQ5YN4G3VNHRRaWQ14WhzDC7UT4ZKz66NEOMfS
         g0aA==
X-Forwarded-Encrypted: i=1; AJvYcCXBoExVuRjya9tfMbE8vj4yYzGQxjK1Dv4ZA5irYq0Pz0NnjKBUcxeoNw2/8ioLDpNPlB/x4hOPjZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy77jor3DHbv4So20ZnmXEPcAu+dqqieYJHKprAQlJvmZKSQYHn
	FtDFzEQd6JxoDQzzmnK5TmO+1qyGXCir9ootmCXm6qFjUeTbYgySpNa43OuBb2owhWR1JpGHdKO
	taTi8MAWOECoI7aYS+Zkukjyh5hqaaTp/B3PdFiFqdk02Qhv0WiF8hgEuIZ2V5uB36OLmYweblJ
	YHnBR0C1m1vopJbxt0zw5YPkoJnZVlHYQP
X-Received: by 2002:a05:6808:1a13:b0:3e3:9159:2c11 with SMTP id 5614622812f47-3e7946cc9f9mr3372273b6e.7.1731415515347;
        Tue, 12 Nov 2024 04:45:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDGhAZY7+od0yenVRj3rsW57OEY4y3KAMBsMqHb5IcjUW8RiI9dGZfbcLvcCimII+b1o0fjDjflkfyjwGU0V8=
X-Received: by 2002:a05:6808:1a13:b0:3e3:9159:2c11 with SMTP id
 5614622812f47-3e7946cc9f9mr3372262b6e.7.1731415514875; Tue, 12 Nov 2024
 04:45:14 -0800 (PST)
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
 <CALE0LRu2oDSo6KOhO2fTDMiqX7iqjqNjNGD_67MJFS7BJWqT_w@mail.gmail.com>
 <CALE0LRvFT3fDdoBLXHK2e47cibD02pxXAuZ83rTqEfrzU3HnKA@mail.gmail.com> <CAC_iWj+STZib+VOZrQtZk95skWzyLqe7_HpNM60G6axNa3Lnnw@mail.gmail.com>
In-Reply-To: <CAC_iWj+STZib+VOZrQtZk95skWzyLqe7_HpNM60G6axNa3Lnnw@mail.gmail.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Tue, 12 Nov 2024 13:45:03 +0100
Message-ID: <CALE0LRsqc6L9EunhOyvyOR_KgG28zb10YBR1qN2qgZ9iJvaHEw@mail.gmail.com>
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

On Tue, Nov 12, 2024 at 12:50=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Enric
>
> On Tue, 12 Nov 2024 at 13:40, Enric Balletbo i Serra
> <eballetb@redhat.com> wrote:
> >
> > Hi again,
> >
> > On Tue, Nov 12, 2024 at 9:17=E2=80=AFAM Enric Balletbo i Serra
> > <eballetb@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Nov 11, 2024 at 3:26=E2=80=AFPM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Mon, 11 Nov 2024 at 16:13, Enric Balletbo i Serra
> > > > <eballetb@redhat.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Thanks a lot for your support.
> > > >
> > > > You're welcome. FWIW I did test this in the past with an AM62x SoC.
> > > >
> > >
> > > Thanks for the info, maybe I can give it a try with my BeaglePlay the=
n...
> > >
> > > > >
> > > > > On Mon, Nov 11, 2024 at 12:01=E2=80=AFPM Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > On Mon, 11 Nov 2024 at 10:21, Enric Balletbo i Serra
> > > > > > <eballetb@redhat.com> wrote:
> > > > > > >
> > > > > > > Hi Ilias,
> > > > > > >
> > > > > > > On Sat, Nov 9, 2024 at 1:31=E2=80=AFAM Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, 8 Nov 2024 at 23:11, Enric Balletbo i Serra <eballe=
tb@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Ilias,
> > > > > > > > >
> > > > > > > > > Thanks for your quick answer.
> > > > > > > > >
> > > > > > > > > On Fri, Nov 8, 2024 at 4:48=E2=80=AFPM Ilias Apalodimas
> > > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Enric,
> > > > > > > > > >
> > > > > > > > > > On Fri, 8 Nov 2024 at 12:26, Enric Balletbo i Serra <eb=
alletb@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi all,
> > > > > > > > > > >
> > > > > > > > > > > I'm looking for any advice/clue to help me to progres=
s on enabling
> > > > > > > > > > > TEE-base EFI Runtime Variable Service on TI a j784s4 =
platforms.
> > > > > > > > > > >
> > > > > > > > > > > I basically followed the steps described in u-boot do=
cumentation [1],
> > > > > > > > > > > I enabled some debugging messages but I think I'm at =
the point that
> > > > > > > > > > > the problem might be in the StandaloneMM application,=
 and I'm not sure
> > > > > > > > > > > how to debug it.
> > > > > > > > > > >
> > > > > > > > > > > What I see is that when I run the tee-supplicant daem=
on, it looks like
> > > > > > > > > > > the tee_client_open_session() call loops forever and =
the tee_stmm_efi
> > > > > > > > > > > driver never ends to probe.
> > > > > > > > > > >
> > > > > > > > > > > With debug enabled I got the following messages.
> > > > > > > > > >
> > > > > > > > > > I assume reading and storing variables already works in=
 U-Boot right?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Reading and storing variables to the RPMB partition in U-=
Boot works,
> > > > > > > > > that's using the mmc rpmb command from u-boot,
> > > > > > > >
> > > > > > > > Are you talking about env variables? Perhaps you store them=
 in the mmc
> > > > > > > > and not the RPMB partition?
> > > > > > > > There's some information here [0]
> > > > > > > >
> > > > > > > > > But setting
> > > > > > > > > CONFIG_EFI_MM_COMM_TEE=3Dy in u-boot I end with a similar=
 behaviour
> > > > > > > > > (although I'm not able to debug at u-boot level) What I s=
ee is that
> > > > > > > > > u-boot gets stuck
> > > > > > > > > when bootefi bootmgr is invoqued. I can also reproduce th=
e issue with
> > > > > > > > > bootefi hello.
> > > > > > > > >
> > > > > > > > > =3D> run bootcmd
> > > > > > > > >   Scanning for bootflows in all bootdevs
> > > > > > > > >   Seq  Method       State   Uclass    Part  Name         =
             Filename
> > > > > > > > >   ---  -----------  ------  --------  ----  -------------=
-----------
> > > > > > > > > ----------------
> > > > > > > > >   Scanning global bootmeth 'efi_mgr':
> > > > > > > > > ( gets stuck here)
> > > > > > > > >
> > > > > > > > > or
> > > > > > > > >
> > > > > > > > > =3D> bootefi hello
> > > > > > > > > (gets stuck)
> > > > > > > > >
> > > > > > > > > To debug I disabled CONFIG_EFI_MM_COMM_TEE to not get stu=
ck and bypass
> > > > > > > > > the error and go to Linux. My understanding is that
> > > > > > > > > CONFIG_EFI_MM_COMM_TEE is only required to read/write efi=
 variables at
> > > > > > > > > u-boot level but OPTEE is running the StandaloneMM servic=
e. Am I
> > > > > > > > > right?
> > > > > > > >
> > > > > > > > U-Boot has two ways of storing EFI variables [0] . You can =
either
> > > > > > > > store them in a file or the RPMB partition. The correct thi=
ng to do,
> > > > > > > > since you want to use the RPMB, is enable CONFIG_EFI_MM_COM=
M_TEE. I am
> > > > > > > > not sure why the hand happens, but one thing we can improve=
 is figure
> > > > > > > > out why it hangs and print a useful message.
> > > > > > > > There are a number of reasons that might lead to a failure.=
 Is the
> > > > > > > > RPMB key programmed on your board? Have a look at this [1] =
in case it
> > > > > > > > helps
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > # tee-supplicant
> > > > > > > > > > > D/TC:? 0 tee_ta_init_session_with_context:557 Re-open=
 trusted service
> > > > > > > > > > > 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> > > > > > > > > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct req=
uest
> > > > > > > >
> > > > > > > > If I had to guess, OP-TEE doesn't store the variables in th=
e RPMB, can
> > > > > > > > you compile it with a bit more debugging enabled?
> > > > > > > >
> > > > > > >
> > > > > > > Here is a log with CFG_TEE_CORE_LOG_LEVEL=3D4, CFG_TEE_CORE_D=
EBUG=3Dy and
> > > > > > > CFG_TEE_TA_LOG_LEVEL=3D4
> > > > > > >
> > > > > > > https://paste.centos.org/view/eed83a5b
> > > > > > >
> > > > > > > At the beginning of the log I see
> > > > > > >
> > > > > > > D/TC:0 0 check_ta_store:449 TA store: "REE"
> > > > > > >
> > > > > > > Which looks wrong to me as I built optee with:
> > > > > > >   CFG_REE_FS=3Dn
> > > > > > >   CFG_RPMB_FS_DEV_ID=3D0
> > > > > > >   CFG_RPMB_FS=3Dy
> > > > > >
> > > > > > Yes it does look wrong. Our compilation flags are
> > > > > > CFG_RPMB_FS=3Dy CFG_RPMB_FS_DEV_ID=3D0 CFG_RPMB_WRITE_KEY=3Dy
> > > > > > CFG_RPMB_TESTKEY=3Dy CFG_REE_FS=3Dn CFG_CORE_ARM64_PA_BITS=3D48
> > > > > > CFG_SCTLR_ALIGNMENT_CHECK=3Dn
> > > > > >
> > > > >
> > > > > Mine are very similar
> > > > >
> > > > > make CROSS_COMPILE=3D"$CC32" CROSS_COMPILE64=3D"$CC64" \
> > > > >     PLATFORM=3Dk3-j784s4 CFG_ARM64_core=3Dy CFG_CONSOLE_UART=3D0x=
8 \
> > > > >     CFG_RPMB_FS_DEV_ID=3D0 CFG_REE_FS=3Dn CFG_RPMB_FS=3Dy \
> > > > >     CFG_RPMB_WRITE_KEY=3Dy CFG_RPMB_TESTKEY=3Dy \
> > > > >     CFG_STMM_PATH=3DBL32_AP_MM.fd \
> > > > >     CFG_CORE_HEAP_SIZE=3D524288 CFG_CORE_DYN_SHM=3Dy CFG_SCTLR_AL=
IGNMENT_CHECK=3Dn \
> > > > >     CFG_TEE_CORE_LOG_LEVEL=3D4 CFG_TEE_CORE_DEBUG=3Dy CFG_TEE_TA_=
LOG_LEVEL=3D4
> > > > >
> > > > > There is a difference with CFG_CORE_ARM64_PA_BITS=3D48 , my platf=
orm defines it to
> > > > >
> > > > >    core/arch/arm/plat-k3/conf.mk:$(call force,CFG_CORE_ARM64_PA_B=
ITS,36)
> > > > >
> > > > > But I don't think this is the problem.
> > > > >
> > > > > > The testkey etc aren't required if your board has a way of read=
ing the
> > > > > > RPMB key from a secure location -- in fact, using the testkey i=
s not
> > > > > > secure. Is the RPMB programmed on your board? Also can you make=
 sure
> > > > > > CFG_RPMB_FS_DEV_ID needs to be 0? How many sd interfaces your b=
oard
> > > > > > has?
> > > > >
> > > > > My board has two interfaces, an eMMC and a SD-card, 0 is indeed t=
he
> > > > > eMMC and I'm using the testkey which I assume was programmed the =
first
> > > > > time I booted with all this. Unfortunately I lost the traces. But=
,
> > > > > optee_rpmb works. I.e:
> > > > >
> > > > >      =3D> optee_rpmb write test 1234
> > > > >      =3D> optee_rpmb read test 4
> > > > >      Read 4 bytes, value =3D 1234
> > > > >
> > > > >
> > > > > > IOW in U-Boot does 'mmc dev 0 && mmc info' print information fo=
r the
> > > > > > RPMB partition?
> > > > > >
> > > > >
> > > > >     =3D> mmc dev 0
> > > > >     switch to partitions #0, OK
> > > > >     mmc0(part 0) is current device
> > > > >     =3D> mmc info
> > > > >     Device: mmc@4f80000
> > > > >     Manufacturer ID: 13
> > > > >     OEM: 4e
> > > > >     Name: G1M15L
> > > > >     Bus Speed: 200000000
> > > > >     Mode: HS400 (200MHz)
> > > > >     Rd Block Len: 512
> > > > >     MMC version 5.1
> > > > >     High Capacity: Yes
> > > > >     Capacity: 29.6 GiB
> > > > >     Bus Width: 8-bit DDR
> > > > >     Erase Group Size: 512 KiB
> > > > >     HC WP Group Size: 8 MiB
> > > > >     User Capacity: 29.6 GiB WRREL
> > > > >     Boot Capacity: 31.5 MiB ENH
> > > > >     RPMB Capacity: 4 MiB ENH
> > > > >     Boot area 0 is not write protected
> > > > >     Boot area 1 is not write protected
> > > > >     =3D> mmc list
> > > > >     mmc@4f80000: 0 (eMMC)
> > > > >     mmc@4fb0000: 1
> > > > >
> > > > > Any interaction with efi gives me the same result (printenv -e,
> > > > > efidebug, bootefi ...)
> > > >
> > > > Yes, that makes sense, because variables fail to initialize -- whic=
h
> > > > is a core part of bringing up the EFI subsystem.
> > > >
> > > > Can you recompile op-tee with CFG_RPMB_RESET_FAT and try again?
> > > >
> > >
> > > Unfortunately that didn't help, but I don't see this code being run.
>
> That's weird, look below.
>
> > > Who sets for the first place the uefi variables, is this u-boot
> > > writing them to the rpmb? or is optee itself?
>
> U-Boot sets the variables, but it does so via StandAloneMM.
>
> > >
> >
> > I tried to compare the behaviour between optee_rpmb (works) and
> > efidebug (doesn't worrk). I see that the first thing optee_rpmb
> > command does is open a session against the TA application, something
> > that efidebug doesn't do, shouldn't efidebug do the same to access to
> > the rpmb device and read or write the efi variables?
> >
>
> That's a bit more complicated and explained to one of the blog posts I
> pasted above.
> We do open an OP-TEE session, but not for talking to a TA. We send the
> messages to StandAloneMM, which then usese OPTEE RPMB APIs to write
> the flash.
>
> The weird thing is why OP-TEE does not format your RPMB when compiling
> with that flag.
> If done correctly, OP-TEE will wipe the RPMB contents the first time
> it tries to access it.
>

It does if I call optee_rpmb command

E/TC:? 0 rpmb_fs_setup:2143 **** Clearing Storage ****

But I don't see any attempt to write efi variables to the rpmb
partition if I use the normal boot workflow or calling any efi command
from the prompt.

I think I need to read a bit more about all the pieces because I might
miss something.

=3D> optee_rpmb read test 4
D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA
023f8f1a-292a-432b-8fc4-de8471358067
D/TC:? 0 ldelf_load_ldelf:110 ldelf load address 0x40007000
D/LD:  ldelf:142 Loading TS 023f8f1a-292a-432b-8fc4-de8471358067
F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
F/TC:? 0 trace_syscall:147 syscall #5 (syscall_open_ta_session)
D/TC:? 0 ldelf_syscall_open_bin:135 > ldelf_syscall_open_bin
D/TC:? 0 ldelf_syscall_open_bin:164 Lookup user TA ELF
023f8f1a-292a-432b-8fc4-de8471358067 (early TA)
D/TC:? 0 ldelf_syscall_open_bin:168 res=3D0
F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 trace_syscall:147 syscall #11 (syscall_mask_cancellation)
F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 492 bytes
F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 532 bytes
F/TC:? 0 read_compressed:178 924 bytes
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 read_compressed:178 248 bytes
F/TC:? 0 read_compressed:178 760 bytes
F/TC:? 0 trace_syscall:147 syscall #6 (syscall_close_ta_session)
F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
D/LD:  ldelf:176 ELF (023f8f1a-292a-432b-8fc4-de8471358067) at 0x40048000
F/TC:? 0 trace_syscall:147 syscall #33 (syscall_cryp_random_number_generate=
)
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 trace_syscall:147 syscall #4 (syscall_get_property_name_to_index)
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 trace_syscall:147 syscall #41 (syscall_storage_obj_open)
D/TC:? 0 rpmb_fs_open_internal:2356 >>> rpmb_fs_open_internal
D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
D/TC:? 0 tee_rpmb_init:1253 >>> core/tee/tee_rpmb_fs.c:1253
D/TC:? 0 legacy_rpmb_init:1142 Trying legacy RPMB init
D/TC:? 0 rpmb_set_dev_info:1111 RPMB: Syncing device information
D/TC:? 0 rpmb_set_dev_info:1113 RPMB: RPMB size is 32*128 KB
D/TC:? 0 rpmb_set_dev_info:1114 RPMB: Reliable Write Sector Count is 1
D/TC:? 0 rpmb_set_dev_info:1116 RPMB: CID
D/TC:? 0 rpmb_set_dev_info:1117 000000009e93ab30  13 01 4e 47 31 4d 31
35  4c 10 27 91 28 07 a9 00
D/TC:? 0 legacy_rpmb_init:1162 RPMB INIT: Deriving key
D/TC:? 0 tee_rpmb_key_gen:308 RPMB: Using test key
D/TC:? 0 legacy_rpmb_init:1176 RPMB INIT: Verifying Key
F/TC:? 0 plat_prng_add_jitter_entropy:68 0x61
D/TC:? 0 legacy_rpmb_init:1180 Found working RPMB device
D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 0
D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
E/TC:? 0 rpmb_fs_setup:2143 **** Clearing Storage ****
D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 2
F/TC:? 0 plat_prng_add_jitter_entropy:68 0xD3
D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 0
D/TC:? 0 tee_rpmb_read:1362 Read 8 blocks at index 2
F/TC:? 0 dump_fat:1951 flags 0x2, size 0, address 0, filename ''
D/TC:? 0 read_fat:2221 fat_address 0
D/TC:? 0 tee_rpmb_read:1362 Read 8 blocks at index 2
F/TC:? 0 plat_prng_add_jitter_entropy:68 0x18
E/TA:  read_persist_value:338 Can't open named object value, res =3D 0xffff=
0008
D/TC:? 0 tee_ta_invoke_command:798 Error: ffff0008 of 4
D/TC:? 0 tee_ta_close_session:460 csess 0x9e925a50 id 1
D/TC:? 0 tee_ta_close_session:479 Destroy session
D/TC:? 0 destroy_context:318 Destroy TA ctx (0x9e9259f0)
Failed to read persistent value







> Cheers
> /Ilias
>
> > =3D> optee_rpmb read test 4
> > D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA
> > 023f8f1a-292a-432b-8fc4-de8471358067
> > D/TC:? 0 ldelf_load_ldelf:110 ldelf load address 0x40007000
> > D/LD:  ldelf:142 Loading TS 023f8f1a-292a-432b-8fc4-de8471358067
> > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > F/TC:? 0 trace_syscall:147 syscall #5 (syscall_open_ta_session)
> > D/TC:? 0 ldelf_syscall_open_bin:163 Lookup user TA ELF
> > 023f8f1a-292a-432b-8fc4-de8471358067 (early TA)
> > D/TC:? 0 ldelf_syscall_open_bin:167 res=3D0
> > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> > F/TC:? 0 read_compressed:178 1024 bytes
> > F/TC:? 0 read_compressed:178 1024 bytes
> > F/TC:? 0 read_compressed:178 1024 bytes
> > F/TC:? 0 read_compressed:178 1024 bytes
> > F/TC:? 0 trace_syscall:147 syscall #11 (syscall_mask_cancellation)
> > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> >
> > =3D> efidebug query -bs -rt -nv
> > MMC: no card present
> > mmc_init: -123, time 2002
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
> >
> >
> >
> > >
> > > > Thanks
> > > > /Ilias
> > > > >
> > > > > =3D> efidebug query -bs -rt -nv
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
> > > > > ... stuck here ... I need to reset the board
> > > > >
> > > > > Will continue to see if I can get more useful messages
> > > > >
> > > > > Thanks,
> > > > >   Enric
> > > > >
> > > > > > Thanks
> > > > > > /Ilias
> > > > > > >
> > > > > > > I'll try to add some more prints to verify if REE is used as =
a store
> > > > > > > system, I assume this should say something about RPMB. Am I r=
ight with
> > > > > > > this?
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > And tracing the function calls gives me that:
> > > > > > > > > > >
> > > > > > > > > > >       tee_stmm_efi_probe() {
> > > > > > > > > > >              tee_client_open_context() {
> > > > > > > > > > >                optee_get_version() {
> > > > > > > > > > >                  tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > > >                } (ret=3D0xd)
> > > > > > > > > > >                tee_ctx_match(); (ret=3D0x1)
> > > > > > > > > > >                optee_smc_open() {
> > > > > > > > > > >                  tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > > >                  optee_open() {
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff00=
0002e55800)
> > > > > > > > > > >                  } (ret=3D0x0)
> > > > > > > > > > >                } (ret=3D0x0)
> > > > > > > > > > >              } (ret=3D0xffff000004e71c80)
> > > > > > > > > > >              tee_client_open_session() {
> > > > > > > > > > >                optee_open_session() {
> > > > > > > > > > >                  tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > > >                  optee_get_msg_arg() {
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff00=
0002e55800)
> > > > > > > > > > >                    tee_shm_get_va(); (ret=3D0xffff000=
002909000)
> > > > > > > > > > >                  } (ret=3D0xffff000002909000)
> > > > > > > > > > >                  tee_session_calc_client_uuid(); (ret=
=3D0x0)
> > > > > > > > > > >                  optee_to_msg_param(); (ret=3D0x0)
> > > > > > > > > > >                  optee_smc_do_call_with_arg() {
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff00=
0002e55800)
> > > > > > > > > > >                    tee_shm_get_va(); (ret=3D0xffff000=
002909000)
> > > > > > > > > > >                    tee_shm_get_va(); (ret=3D0xffff000=
002909060)
> > > > > > > > > > >                    optee_cq_wait_init(); (ret=3D0xfff=
f000002e55910)
> > > > > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff00=
04)
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff00=
0002e55800)
> > > > > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff00=
04)
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff00=
0002e55800)
> > > > > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff00=
04)
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff00=
0002e55800)
> > > > > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff00=
04)
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff00=
0002e55800)
> > > > > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff00=
04)
> > > > > > > > > > >      ... continues sending this forever ...
> > > > > > > > > > >      ... Hit ^C to stop recording ...
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff00=
0002e55800)
> > > > > > > > > > >                    optee_smccc_smc() {
> > > > > > > > > > >
> > > > > > > > > > > [1] https://docs.u-boot.org/en/latest/develop/uefi/ue=
fi.html#using-op-tee-for-efi-variables
> > > > > > > > > > >
> > > > > > > > > > > Thanks in advance,
> > > > > > > > > >
> > > > > > > > > > The most common problem with this is miscompiling the t=
ee_supplicant
> > > > > > > > > > application.
> > > > > > > > > > Since we don't know if the system has an RPMB, we emula=
te it in the
> > > > > > > > > > tee_supplicant. How did you get the supplicant and can =
you check if it
> > > > > > > > > > was compiled with RPMB_EMU=3D0 or 1?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I'm using the tee-supplicant provided by the fedora packa=
ge which is
> > > > > > > > > built with ` -DRPMB_EMU=3D0`, I think that's correct, rig=
ht?
> > > > > > > > >
> > > > > > > >
> > > > > > > > Yes, this is correct. We fixed the Fedora package to compil=
e the
> > > > > > > > supplicant correctly a while back.
> > > > > > > >
> > > > > > > > [0] https://www.linaro.org/blog/uefi-secureboot-in-u-boot/
> > > > > > > > [1] https://apalos.github.io/Protected%20UEFI%20variables%2=
0with%20U-Boot.html#Protected%20UEFI%20variables%20with%20U-Boot
> > > > > > > >
> > > > > > > >
> > > > > > > > Regards
> > > > > > > > /Ilias
> > > > > > > > > Thanks,
> > > > > > > > >    Enric
> > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > > /Ilias
> > > > > > > > > >
> > > > > > > > > > >    Enric
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> >
>


