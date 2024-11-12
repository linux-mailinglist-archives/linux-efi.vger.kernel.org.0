Return-Path: <linux-efi+bounces-2144-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620779C620C
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 21:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F03B281BE
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 17:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5392139BC;
	Tue, 12 Nov 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+k0hYBs"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F36213148
	for <linux-efi@vger.kernel.org>; Tue, 12 Nov 2024 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433659; cv=none; b=Md5FJw7iKUqvr64NzehLl9c2swqTHLFyXWAjdAfw3xXhtd0ue3EP0zFGUzRiQ9AbPTzp683w3l1D/py+5PrkcJWR4CuIdTKU7ONKDVjgABFcfh26wIdILwr/wz2ngCbeCRQB+BvrePzIUrBTFQactJN/Zz1Sh3ws+ry1DVZ1chg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433659; c=relaxed/simple;
	bh=9CIbmtkBnwDOa194fJrdfbPlEwol1OUacHCHUplIoxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LU8GAD2T9363erDTU7Vgg+bJBL2t+jhE5Yg9zZOr8FZYB776L4D2cn3D8+gcxAlFDeQ2dDHjdoM3H1zwYcV/s1i9lL7fgCscoVNt5eabN4CVSm/Ejgi71rk/ka1EAZ2tseoeVfsqqN3tGIIDJDz3x4WoHcgUeFtBtVmNxVk/L6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+k0hYBs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731433656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fi02c7cMfZo/ph0LI2Ys+XfiBl+lurtCayq4ptv4hRM=;
	b=R+k0hYBsL+mOIYheRo3RK+lkj6klkPjEW1QQAolafn7o6cV+AYBwVYCZp8U9jaf414WgND
	50a+e5/WUCoqXa74N+KaDbYWoRzbVZ+A46LMUI+2wjN2QM+expEtczWT/JJ/AYvjN6A7a2
	JRBgN2+yVzaHcmTB8ENxAUbR9th+b5A=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-ctzlut7NO7-vUyFwbHeHXA-1; Tue, 12 Nov 2024 12:47:35 -0500
X-MC-Unique: ctzlut7NO7-vUyFwbHeHXA-1
X-Mimecast-MFC-AGG-ID: ctzlut7NO7-vUyFwbHeHXA
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-71813ca0342so657602a34.2
        for <linux-efi@vger.kernel.org>; Tue, 12 Nov 2024 09:47:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731433654; x=1732038454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fi02c7cMfZo/ph0LI2Ys+XfiBl+lurtCayq4ptv4hRM=;
        b=pt3Mk+rvGjPhBH9xaNR/5CwNu2On5i4z91UDCzwEDUjKl2TTV8HhHpIYyZJQ/hBv9z
         VlfruGmpf/5EOoKiEMxnNn0hN5yw7gBoN+4LzHkSMIUIhtdcxV8naycv+jjVyEUd4y9V
         Rj9EdqmiLjithvHvZFvHfg/sdjaTtBhchIo5IkwmTIBkdat+3ia+oI/Ygx8aEQ226u5y
         +uog3tkVHRAU996XaukkvdszqX1YK+tf5qkEpu+F6SE8iBWeuvWiU7lEXXkArsLfFtS7
         1KIKtGboy12JhwPrY9xwFTEkQxfCqO0GiYw4ivhv01H3E2Z6F2PQ/gJA5L3nBwnZ5PMy
         nwig==
X-Forwarded-Encrypted: i=1; AJvYcCUdpvNY7yQIGWuGuwmsWWYslp+Vd+xQ2bV7Mt7sNVIrHTNRyXR6wQ++Ujdl6j076Ttu+9QXQwDJgao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAgBtiPUVRn0Nxzt03kftVi2qTPQ38A06YLOW2NSY++o/74tvp
	SFQOqY8HtAKeVe8g+A2EuRKtj2qZ3xYcEuOEnumusPBEBmUsBXYoNOKZyoQektl+7qkekNeYiOK
	mGq95giXWHUeQf2j9vlkB1R/iEoT1vBq7B+1ic5GrjoUSwBS8rEb9TZBqObR9axES0dqtfks16L
	PDCo/ywwz2Au+xJFmVWtDuVXURJOZcV1T6
X-Received: by 2002:a05:6820:b45:b0:5ed:ee42:1b00 with SMTP id 006d021491bc7-5ee57c31ea2mr1851661eaf.1.1731433654184;
        Tue, 12 Nov 2024 09:47:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOoURhaOmkiA2ZoXle+9Es26RUW6+mhFgNzO5A514CCL/A75yNHbSskZSQaDdbB/O9MFL8JRdqJtpVQ9INtx8=
X-Received: by 2002:a05:6820:b45:b0:5ed:ee42:1b00 with SMTP id
 006d021491bc7-5ee57c31ea2mr1851654eaf.1.1731433653700; Tue, 12 Nov 2024
 09:47:33 -0800 (PST)
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
 <CALE0LRvFT3fDdoBLXHK2e47cibD02pxXAuZ83rTqEfrzU3HnKA@mail.gmail.com>
 <CAC_iWj+STZib+VOZrQtZk95skWzyLqe7_HpNM60G6axNa3Lnnw@mail.gmail.com>
 <CALE0LRsqc6L9EunhOyvyOR_KgG28zb10YBR1qN2qgZ9iJvaHEw@mail.gmail.com>
 <CAC_iWjKLqDFb1wSUQ1uMqOfbeRtzGNX9gyTHtQy5-71WvBiiLA@mail.gmail.com>
 <CALE0LRt7cwwwQ0Rh+0qJsUzTsNULEQSYgAoviQp5F5SXeJk8LQ@mail.gmail.com>
 <CAC_iWjKkdS71Fh3LZ0CJR-vnC+PwGKGndxjU3WjjUPnZ84DYWg@mail.gmail.com> <CALE0LRt2ct8onNyPvTNzy3Ps1kqduqx-OMmnQse-SXsk5M451Q@mail.gmail.com>
In-Reply-To: <CALE0LRt2ct8onNyPvTNzy3Ps1kqduqx-OMmnQse-SXsk5M451Q@mail.gmail.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Tue, 12 Nov 2024 18:47:22 +0100
Message-ID: <CALE0LRsA==Art8xqRQfPQq0HP6ebtYTuQ677t-BV7fDZB3grWg@mail.gmail.com>
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


On Tue, Nov 12, 2024 at 5:03=E2=80=AFPM Enric Balletbo i Serra
<eballetb@redhat.com> wrote:
>
> On Tue, Nov 12, 2024 at 4:07=E2=80=AFPM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Tue, 12 Nov 2024 at 16:39, Enric Balletbo i Serra
> > <eballetb@redhat.com> wrote:
> > >
> > > On Tue, Nov 12, 2024 at 2:23=E2=80=AFPM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > [...]
> > > >
> > > > > > > > >
> > > > > > > >
> > > > > > > > Unfortunately that didn't help, but I don't see this code b=
eing run.
> > > > > >
> > > > > > That's weird, look below.
> > > > > >
> > > > > > > > Who sets for the first place the uefi variables, is this u-=
boot
> > > > > > > > writing them to the rpmb? or is optee itself?
> > > > > >
> > > > > > U-Boot sets the variables, but it does so via StandAloneMM.
> > > > > >
> > > > > > > >
> > > > > > >
> > > > > > > I tried to compare the behaviour between optee_rpmb (works) a=
nd
> > > > > > > efidebug (doesn't worrk). I see that the first thing optee_rp=
mb
> > > > > > > command does is open a session against the TA application, so=
mething
> > > > > > > that efidebug doesn't do, shouldn't efidebug do the same to a=
ccess to
> > > > > > > the rpmb device and read or write the efi variables?
> > > > > > >
> > > > > >
> > > > > > That's a bit more complicated and explained to one of the blog =
posts I
> > > > > > pasted above.
> > > > > > We do open an OP-TEE session, but not for talking to a TA. We s=
end the
> > > > > > messages to StandAloneMM, which then usese OPTEE RPMB APIs to w=
rite
> > > > > > the flash.
> > > > > >
> > > > > > The weird thing is why OP-TEE does not format your RPMB when co=
mpiling
> > > > > > with that flag.
> > > > > > If done correctly, OP-TEE will wipe the RPMB contents the first=
 time
> > > > > > it tries to access it.
> > > > > >
> > > > >
> > > > > It does if I call optee_rpmb command
> > > > >
> > > > > E/TC:? 0 rpmb_fs_setup:2143 **** Clearing Storage ****
> > > > >
> > > > > But I don't see any attempt to write efi variables to the rpmb
> > > > > partition if I use the normal boot workflow or calling any efi co=
mmand
> > > > > from the prompt.
> > > > >
> > > > > I think I need to read a bit more about all the pieces because I =
might
> > > > > miss something.
> > > >
> > > > You don't need the command above to store variables. You need this =
in
> > > > case you need to use the RPMB from the command line.
> > > > Do a 'printenv -e && setenv -e -bs -rt -nv test test1 && printenv -=
e'.
> > > > Does that work ?
> > > >
> > >
> > > No, `printenv -e` gets stuck. This is the log with some debug message=
s I added.
> > >
> > > =3D> printenv -e
> > > > lib/efi_loader/efi_setup.c:227 Initialize once only
> > >   > lib/efi_loader/efi_setup.c:234 Set up console modes
> > >   > lib/efi_loader/efi_setup.c:242 Proble block devices to find the E=
SP
> > > MMC: no card present
> > > mmc_init: -123, time 2002
> > >   > lib/efi_loader/efi_setup.c:249 Initialize variable services
> > >      > lib/efi_loader/efi_var_mem.c:223 efi_allocate_pages
> > >      > lib/efi_loader/efi_var_mem.c:236 efi_create_event
> > >   < lib/efi_loader/efi_var_mem.c:244 - ret=3D0
> > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> >
> > Please try again with the FAT reset config flag in OP-TEE and without
> > doing any reads and writes from the U-Boot console
> >
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
> > > ... stuck here ... traces indicates never outs from the efi_setup, so
> > > looks like hungs
> > >
> > > Let me try with BeaglePlay and read a bit more, as I feel I'm a bit
> > > lost right now.
> >
> > Sure, let me know if you need anything else.
> >
>
> Same behaviour on BeaglePlay, so either it's currently broken or I'm
> making the same mistake in my process on both boards.
>
> Ilias, by chance, do you have in which versions did you test?
>

So it looks like it is a problem with edk2 and/or edk2-platform, since
reverting those repositories back to September, things started to look
a lot better and I'm able to see en UEFI variables programmed.

FWIW I just found this project [1] from you, thank you for it. Turns
out that it is easy to reproduce the issue I'm facing even with qemu.
I'll try to bisect what's the problem and report properly.

Thank you very much for your guidance and support.

Cheers,
  Enric

[1] https://git.linaro.org/people/ilias.apalodimas/efi_optee_variables.git/


> Thanks,
>   Enric
> > /Ilias
> > >
> > > > >
> > > > > =3D> optee_rpmb read test 4
> > > > > D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA
> > > > > 023f8f1a-292a-432b-8fc4-de8471358067
> > > > > D/TC:? 0 ldelf_load_ldelf:110 ldelf load address 0x40007000
> > > > > D/LD:  ldelf:142 Loading TS 023f8f1a-292a-432b-8fc4-de8471358067
> > > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > > F/TC:? 0 trace_syscall:147 syscall #5 (syscall_open_ta_session)
> > > > > D/TC:? 0 ldelf_syscall_open_bin:135 > ldelf_syscall_open_bin
> > > > > D/TC:? 0 ldelf_syscall_open_bin:164 Lookup user TA ELF
> > > > > 023f8f1a-292a-432b-8fc4-de8471358067 (early TA)
> > > > > D/TC:? 0 ldelf_syscall_open_bin:168 res=3D0
> > > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 trace_syscall:147 syscall #11 (syscall_mask_cancellation=
)
> > > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 492 bytes
> > > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_right=
s)
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > F/TC:? 0 read_compressed:178 532 bytes
> > > > > F/TC:? 0 read_compressed:178 924 bytes
> > > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_right=
s)
> > > > > F/TC:? 0 read_compressed:178 248 bytes
> > > > > F/TC:? 0 read_compressed:178 760 bytes
> > > > > F/TC:? 0 trace_syscall:147 syscall #6 (syscall_close_ta_session)
> > > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > > D/LD:  ldelf:176 ELF (023f8f1a-292a-432b-8fc4-de8471358067) at 0x=
40048000
> > > > > F/TC:? 0 trace_syscall:147 syscall #33 (syscall_cryp_random_numbe=
r_generate)
> > > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_right=
s)
> > > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_right=
s)
> > > > > F/TC:? 0 trace_syscall:147 syscall #4 (syscall_get_property_name_=
to_index)
> > > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_right=
s)
> > > > > F/TC:? 0 trace_syscall:147 syscall #41 (syscall_storage_obj_open)
> > > > > D/TC:? 0 rpmb_fs_open_internal:2356 >>> rpmb_fs_open_internal
> > > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > > D/TC:? 0 tee_rpmb_init:1253 >>> core/tee/tee_rpmb_fs.c:1253
> > > > > D/TC:? 0 legacy_rpmb_init:1142 Trying legacy RPMB init
> > > > > D/TC:? 0 rpmb_set_dev_info:1111 RPMB: Syncing device information
> > > > > D/TC:? 0 rpmb_set_dev_info:1113 RPMB: RPMB size is 32*128 KB
> > > > > D/TC:? 0 rpmb_set_dev_info:1114 RPMB: Reliable Write Sector Count=
 is 1
> > > > > D/TC:? 0 rpmb_set_dev_info:1116 RPMB: CID
> > > > > D/TC:? 0 rpmb_set_dev_info:1117 000000009e93ab30  13 01 4e 47 31 =
4d 31
> > > > > 35  4c 10 27 91 28 07 a9 00
> > > > > D/TC:? 0 legacy_rpmb_init:1162 RPMB INIT: Deriving key
> > > > > D/TC:? 0 tee_rpmb_key_gen:308 RPMB: Using test key
> > > > > D/TC:? 0 legacy_rpmb_init:1176 RPMB INIT: Verifying Key
> > > > > F/TC:? 0 plat_prng_add_jitter_entropy:68 0x61
> > > > > D/TC:? 0 legacy_rpmb_init:1180 Found working RPMB device
> > > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > > D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
> > > > > D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 0
> > > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > > D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
> > > > > E/TC:? 0 rpmb_fs_setup:2143 **** Clearing Storage ****
> > > > > D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 2
> > > > > F/TC:? 0 plat_prng_add_jitter_entropy:68 0xD3
> > > > > D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
> > > > > D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 0
> > > > > D/TC:? 0 tee_rpmb_read:1362 Read 8 blocks at index 2
> > > > > F/TC:? 0 dump_fat:1951 flags 0x2, size 0, address 0, filename ''
> > > > > D/TC:? 0 read_fat:2221 fat_address 0
> > > > > D/TC:? 0 tee_rpmb_read:1362 Read 8 blocks at index 2
> > > > > F/TC:? 0 plat_prng_add_jitter_entropy:68 0x18
> > > > > E/TA:  read_persist_value:338 Can't open named object value, res =
=3D 0xffff0008
> > > > > D/TC:? 0 tee_ta_invoke_command:798 Error: ffff0008 of 4
> > > > > D/TC:? 0 tee_ta_close_session:460 csess 0x9e925a50 id 1
> > > > > D/TC:? 0 tee_ta_close_session:479 Destroy session
> > > > > D/TC:? 0 destroy_context:318 Destroy TA ctx (0x9e9259f0)
> > > > > Failed to read persistent value
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > > Cheers
> > > > > > /Ilias
> > > > > >
> > > > > > > =3D> optee_rpmb read test 4
> > > > > > > D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA
> > > > > > > 023f8f1a-292a-432b-8fc4-de8471358067
> > > > > > > D/TC:? 0 ldelf_load_ldelf:110 ldelf load address 0x40007000
> > > > > > > D/LD:  ldelf:142 Loading TS 023f8f1a-292a-432b-8fc4-de8471358=
067
> > > > > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > > > > F/TC:? 0 trace_syscall:147 syscall #5 (syscall_open_ta_sessio=
n)
> > > > > > > D/TC:? 0 ldelf_syscall_open_bin:163 Lookup user TA ELF
> > > > > > > 023f8f1a-292a-432b-8fc4-de8471358067 (early TA)
> > > > > > > D/TC:? 0 ldelf_syscall_open_bin:167 res=3D0
> > > > > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_comm=
and)
> > > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > > F/TC:? 0 trace_syscall:147 syscall #11 (syscall_mask_cancella=
tion)
> > > > > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_comm=
and)
> > > > > > >
> > > > > > > =3D> efidebug query -bs -rt -nv
> > > > > > > MMC: no card present
> > > > > > > mmc_init: -123, time 2002
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
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > > /Ilias
> > > > > > > > > >
> > > > > > > > > > =3D> efidebug query -bs -rt -nv
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
> > > > > > > > > > ... stuck here ... I need to reset the board
> > > > > > > > > >
> > > > > > > > > > Will continue to see if I can get more useful messages
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > >   Enric
> > > > > > > > > >
> > > > > > > > > > > Thanks
> > > > > > > > > > > /Ilias
> > > > > > > > > > > >
> > > > > > > > > > > > I'll try to add some more prints to verify if REE i=
s used as a store
> > > > > > > > > > > > system, I assume this should say something about RP=
MB. Am I right with
> > > > > > > > > > > > this?
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > And tracing the function calls gives me tha=
t:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >       tee_stmm_efi_probe() {
> > > > > > > > > > > > > > > >              tee_client_open_context() {
> > > > > > > > > > > > > > > >                optee_get_version() {
> > > > > > > > > > > > > > > >                  tee_get_drvdata(); (ret=3D=
0xffff000002e55800)
> > > > > > > > > > > > > > > >                } (ret=3D0xd)
> > > > > > > > > > > > > > > >                tee_ctx_match(); (ret=3D0x1)
> > > > > > > > > > > > > > > >                optee_smc_open() {
> > > > > > > > > > > > > > > >                  tee_get_drvdata(); (ret=3D=
0xffff000002e55800)
> > > > > > > > > > > > > > > >                  optee_open() {
> > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > >                  } (ret=3D0x0)
> > > > > > > > > > > > > > > >                } (ret=3D0x0)
> > > > > > > > > > > > > > > >              } (ret=3D0xffff000004e71c80)
> > > > > > > > > > > > > > > >              tee_client_open_session() {
> > > > > > > > > > > > > > > >                optee_open_session() {
> > > > > > > > > > > > > > > >                  tee_get_drvdata(); (ret=3D=
0xffff000002e55800)
> > > > > > > > > > > > > > > >                  optee_get_msg_arg() {
> > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > >                    tee_shm_get_va(); (ret=
=3D0xffff000002909000)
> > > > > > > > > > > > > > > >                  } (ret=3D0xffff00000290900=
0)
> > > > > > > > > > > > > > > >                  tee_session_calc_client_uu=
id(); (ret=3D0x0)
> > > > > > > > > > > > > > > >                  optee_to_msg_param(); (ret=
=3D0x0)
> > > > > > > > > > > > > > > >                  optee_smc_do_call_with_arg=
() {
> > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > >                    tee_shm_get_va(); (ret=
=3D0xffff000002909000)
> > > > > > > > > > > > > > > >                    tee_shm_get_va(); (ret=
=3D0xffff000002909060)
> > > > > > > > > > > > > > > >                    optee_cq_wait_init(); (r=
et=3D0xffff000002e55910)
> > > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=
=3D0xffff0004)
> > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=
=3D0xffff0004)
> > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=
=3D0xffff0004)
> > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=
=3D0xffff0004)
> > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=
=3D0xffff0004)
> > > > > > > > > > > > > > > >      ... continues sending this forever ...
> > > > > > > > > > > > > > > >      ... Hit ^C to stop recording ...
> > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > >                    optee_smccc_smc() {
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > [1] https://docs.u-boot.org/en/latest/devel=
op/uefi/uefi.html#using-op-tee-for-efi-variables
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Thanks in advance,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The most common problem with this is miscompi=
ling the tee_supplicant
> > > > > > > > > > > > > > > application.
> > > > > > > > > > > > > > > Since we don't know if the system has an RPMB=
, we emulate it in the
> > > > > > > > > > > > > > > tee_supplicant. How did you get the supplican=
t and can you check if it
> > > > > > > > > > > > > > > was compiled with RPMB_EMU=3D0 or 1?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I'm using the tee-supplicant provided by the fe=
dora package which is
> > > > > > > > > > > > > > built with ` -DRPMB_EMU=3D0`, I think that's co=
rrect, right?
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, this is correct. We fixed the Fedora package=
 to compile the
> > > > > > > > > > > > > supplicant correctly a while back.
> > > > > > > > > > > > >
> > > > > > > > > > > > > [0] https://www.linaro.org/blog/uefi-secureboot-i=
n-u-boot/
> > > > > > > > > > > > > [1] https://apalos.github.io/Protected%20UEFI%20v=
ariables%20with%20U-Boot.html#Protected%20UEFI%20variables%20with%20U-Boot
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Regards
> > > > > > > > > > > > > /Ilias
> > > > > > > > > > > > > > Thanks,
> > > > > > > > > > > > > >    Enric
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Thanks
> > > > > > > > > > > > > > > /Ilias
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >    Enric
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >


