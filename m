Return-Path: <linux-efi+bounces-968-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FDC8B10C0
	for <lists+linux-efi@lfdr.de>; Wed, 24 Apr 2024 19:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07742B28129
	for <lists+linux-efi@lfdr.de>; Wed, 24 Apr 2024 17:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFAA16D317;
	Wed, 24 Apr 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDsUkAeb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18B815B576;
	Wed, 24 Apr 2024 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978949; cv=none; b=lZZKSED5hKSDEywelHb0fHo/2/CCOeRjjzCRJRJZZK2L7tFTi+KrTA8EkLkZFSGRusX84qeMLVPMq6xiPZIJqntYcL9y1qPQ+NQShKiWMFkS7YdJOhatChruAH+eWX9HwnXB8SHdWsh5cOyT5Pv3Wuo1Hgf2ZujdvD1YqNI6j+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978949; c=relaxed/simple;
	bh=npblAWK7DFyXQvXOQl2/avJWn4QSgquFfcdlePygbCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADKLFO/u7YYeJQXBSdL1tsN940tcTJCW/Jd5f/w7/i8LKthZWXEbp7mojMGDWEXPk2oYQ9ktEvFps2mz80HQwtng3D0+bE+UhzHDHp1lchFchXs35rrZ2sl1pY2rqz7l0oRFeEilUS7A1/XJjVTFKPgQ00Br0EazQcmzlMxdNu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDsUkAeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCF2C113CD;
	Wed, 24 Apr 2024 17:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713978948;
	bh=npblAWK7DFyXQvXOQl2/avJWn4QSgquFfcdlePygbCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aDsUkAebHzQS9aPZ5UAA9x/BNYa9s35Z/NlySbqBHZm3o5AhZ8lGrCMQroRBqjkDl
	 CsRMtgywR3Orp+kkB1kzwY+16wR5fv5x2cZBFwqXGItuhX/nj7F7S9g9Guwb7+zHhG
	 I45gi0R6iAS1q2kJvA6PqBKxiT6ZdYRFBvcwlqlcG6g78SwH0IAb8weJS8fFKrhj+J
	 O9OSIZPDdN3DRCDjHlxeVs/bFJLpuDCaXfGswKQU83dSQEvrOcg1YcJBGd4XWRukIm
	 D2NXtdjCK0MMGpNCVDh8qMOpTQdKA7FVPGp4yvpA+VyaMc7U4jEHJbTktdkULp9CuM
	 wx1buCttxSuNw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-518f8a69f82so26351e87.2;
        Wed, 24 Apr 2024 10:15:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8Pl7LOa0U1+AWCXmmH2BFgvljh40lUXDnm6oSZLiTy6pwXKlLfNPjiDrX1zrmjgvkkT/YGjGLsPoVu+tipHAFeAfRJb4EwhJW21UK0WHEk3w4VTI52VF0amQyCIa5kfEMXUS1B0Eh7HoNkdymhoHAjZ7I8BnAaK12uH2+aevZ4I92vmANV1fn
X-Gm-Message-State: AOJu0Yyf6+pMQFLX0BuWGWPfQuOZJt8fjEGrBgHfhDsX3iYQRh1jBRvo
	dSNcUr3flDWDMqL88JayIFSbXv99FZgW42tHGnqgs4kXjiLt8NEEm5rBFWAX/OC7pfIu5EG2sm3
	GRwzyFMWQ9iW5DW/palKLi/OWWr0=
X-Google-Smtp-Source: AGHT+IFByR9sAZYx99uDadvVjH6429abW58ugN7oeOIISGe6LBYkO77Hdh75n+FJj7K1fIY4Xvl2bvGC0kGF+f57Lbs=
X-Received: by 2002:a19:ca08:0:b0:51a:f3b9:f774 with SMTP id
 a8-20020a19ca08000000b0051af3b9f774mr2470034lfg.21.1713978946867; Wed, 24 Apr
 2024 10:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422112711.362779-1-mikko.rapeli@linaro.org>
 <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>
 <ZiZhSfgeAdrbnaVL@nuoska> <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
 <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
 <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
 <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com> <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com>
In-Reply-To: <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 24 Apr 2024 19:15:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com>
Message-ID: <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lennart Poettering <lennart@poettering.net>, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Apr 2024 at 17:22, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Mon, 22 Apr 2024 at 17:31, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > On Mon, 2024-04-22 at 16:54 +0300, Ilias Apalodimas wrote:
> > > Hi James
> > >
> > > On Mon, 22 Apr 2024 at 16:38, James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > >
> > > > On Mon, 2024-04-22 at 16:32 +0300, Ilias Apalodimas wrote:
> > > > > Hi all,
> > > > >
> > > > > On Mon, 22 Apr 2024 at 16:08, Mikko Rapeli
> > > > > <mikko.rapeli@linaro.org>
> > > > > wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Mon, Apr 22, 2024 at 08:42:41AM -0400, James Bottomley
> > > > > > wrote:
> > > > > > > On Mon, 2024-04-22 at 14:27 +0300, Mikko Rapeli wrote:
> > > > > > > > Userspace needs to know if TPM kernel drivers need to be
> > > > > > > > loaded and related services started early in the boot if
> > > > > > > > TPM device is used and available.
> > > > > > >
> > > > > > > This says what but not why.  We already have module
> > > > > > > autoloading that works correctly for TPM devices, so why is
> > > > > > > this needed?
> > > > > > >
> > > > > > > We do have a chicken and egg problem with IMA in that the TPM
> > > > > > > driver needs to be present *before* any filesystem, including
> > > > > > > the one the TPM modules would be on, is mounted so executions
> > > > > > > can be measured into IMA (meaning that if you use IMA the TPM
> > > > > > > drivers must be built in) but this sounds to be something
> > > > > > > different. However, because of the IMA problem, most
> > > > > > > distributions don't end up compiling TPM drivers as modules
> > > > > > > anyway.
> > > > > > >
> > > > > > > Is what you want simply that tpm modules be loaded earlier?
> > > > > >
> > > > > > Yes, ealier is the problem. In my specific testing case the
> > > > > > machine is qemu arm64 with swtpm with EFI firmware for secure
> > > > > > boot and TPM support.
> > > > > >
> > > > > > Firmware uses TPM and does measurements and thus TPM event log
> > > > > > is
> > > > > > available on this machine and a bunch of other arm64 boards.
> > > > > > Visible in early boot dmesg as TPMEventLog lines like:
> > > > > >
> > > > > > [    0.000000] efi: ESRT=0xf0ea5040 TPMFinalLog=0xf0ea9040
> > > > > > RTPROP=0xf0ea7040 SMBIOS=0xf0ea3000 TPMEventLog=0xeb3b3040
> > > > > > INITRD=0xeb3b2040 RNG=0xe5c0f040 MEMRESERVE=0xe5c0e040
> > > > > >
> > > > > > Different boards use different TPM HW and drivers so compiling
> > > > > > all these in is possible but a bit ugly. systemd recently
> > > > > > gained support for a specific tpm2.target which makes TPM
> > > > > > support modular and also works with kernel modules for some TPM
> > > > > > use cases but not rootfs encryption.
> > > > > >
> > > > > > In my test case we have a kernel+initramfs uki binary which is
> > > > > > loaded by EFI firmware as a secure boot binary. TPM support on
> > > > > > various boards is visible in devicetree but not as ACPI table
> > > > > > entries. systemd currently detect TPM2 support either via ACPI
> > > > > > table /sys/firmware/acpi/tables/TPM2 or TPM entry or via
> > > > > > firmware measurement via
> > > > > > /sys/kernel/security/tpm0/binary_bios_measurements
> > > > > > .
> > > > >
> > > > > One corner case worth noting here is that scanning the device
> > > > > tree won't always work for non-ACPI systems... The reason is that
> > > > > a firmware TPM (running in OP-TEE) might or might not have a DT
> > > > > entry, since OP-TEE can discover the device dynamically and
> > > > > doesn't always rely on a DT entry.
> > > > >
> > > > > I don't particularly love the idea that an EventLog existence
> > > > > automatically means a TPM will be there, but it seems that
> > > > > systemd already relies on that and it does solve the problem we
> > > > > have.
> > > >
> > > > Well, quite. That's why the question I was interested in, perhaps
> > > > not asked as clearly as it could be is: since all the TPM devices
> > > > rely on discovery mechanisms like ACPI or DT or the like which are
> > > > ready quite early, should we simply be auto loading the TPM drivers
> > > > earlier?
> > >
> > > This would be an elegant way to solve this and on top of that, we
> > > have a single discovery mechanism from userspace -- e.g ls /dev/tpmX.
> > > But to answer that we need more feedback from systemd. What 'earlier'
> > > means? Autload it from the kernel before we go into launching the
> > > initrd?
> >
> > Right, so this is another timing problem: we can't autoload modules
> > *before* they appear in the filesystem and presumably they're on the
> > initrd, so auto loading must be post initrd mount (and init execution)
> > but otherwise quite early?
>
> Exactly. But is that enough?
>
> >
> > This might be quite a bit of work.  Logically, just moving the matching
> > and loading code earlier might work, but we used to have a
> > load_default_modules() at the end of init/main.c and it got removed
> > (because it only eventually loaded elevator modules) everything is now
> > loaded in it's various init routines, so to get, say, TPM ACPI modules
> > loaded earlier, we'd have to run the ACPI device matching code earlier
> > and so on for every other subsystem ...
>
> Being the devil's advocate here and as I stated I don't love this but ...
> The kernel isn't technically doing anything wrong. We just expose an
> *existing* EFI config table. The kernel also exposes filesystems so
> people are free to do rm -rf *.
> The fact that applications might use it as a means of "oh there's
> probably a TPM" shouldn't be the end of the world. On top of that,
> since it's an EFI config table we can keep it around and never break
> any ABIs we create to userspace. If in the future we find a better
> way, userspace can use that?
>
> So perhaps this is ok as long as make sure we understand why systemd
> needs it that early?
>

What I would like to know is which API systemd is attempting to use,
and which -apparently- may never become available if no TPM is exposed
by the kernel.

Ideally, we should be able to take inspiration from the probe deferral
work, and return -EAGAIN to convey that it is too early to signal
either success or permanent failure.

Exposing random firmware assets directly to user space to make guesses
about this doesn't seem like a very robust approach to this issue.

