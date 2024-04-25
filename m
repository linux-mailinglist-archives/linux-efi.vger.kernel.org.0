Return-Path: <linux-efi+bounces-971-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7C68B1F4A
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 12:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AA6281AE2
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 10:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130091CFA0;
	Thu, 25 Apr 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUOm/L1E"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7795182AE;
	Thu, 25 Apr 2024 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041387; cv=none; b=UQnXpRKoUlJHSxmLbiLY8mZM7rL+aBMAfm9SYM+X/6as1NhureAwke/kaQSJeupZ7wNA57nonMeF2DQ/w84vvj+l71kCWYBfThyQo6su8VKYuKXo+qkLXhMPGAaPc/GR1EALBlJgjjve3Olke7KASvkbRvhq3CpX90WxyS5ka9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041387; c=relaxed/simple;
	bh=5Dd/24J1oE3+qYtdNEGsw0Va8YX3n8j3eqG3lOY+2C4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXTjMIIik6tJyOtKyPfHET/SRx7vvaGQyigaafUxauLEfXp+k8ewDyvdD6OPXBQDp6WnFtU4EVRdNpLU+xzgpoKYg/PNoOd3Fg9WPsuQjl7CJaUG6lL+Y8DK6h+6lqK5kmVo450u97tuJ52d0zKgcbn3ZTkZqWb8sVxakQs0ca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUOm/L1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E61C4AF08;
	Thu, 25 Apr 2024 10:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714041386;
	bh=5Dd/24J1oE3+qYtdNEGsw0Va8YX3n8j3eqG3lOY+2C4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KUOm/L1Eir3/zBWn8t5EFB2fuJIO4stOWhDvZV0VAuhw5fCMNh7smq9XQaCQdBDLu
	 /op4swuN0jEr7UWoNNuELmQA/Dl8CNa/uYkVEeNAsNfOUlts7VbmOcBYrpamlDHZQs
	 vwTVbB7jh0lQmKKcaD9ELqPTxKdhvehsomwnYOO0AzflhwByP6sJaI1+LQwMAYMjEs
	 RqUUL2ILBd8Fb031eUA8ByOLJq34W6YG1P0u2bpR68h+kqM+ZGN0FjSJDv8MwYo8Dm
	 29QrPSv+nnrnd/mc4/WGVXmfDWbsTp0J5wa6rwtTnqdDkG3I3S8F0O+51i8af9hDf3
	 Ea8Oe594YCYrA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51ac5923ef6so757361e87.0;
        Thu, 25 Apr 2024 03:36:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEwxX84A10pICHPuewnOvJqz/XpZI6NuUBTfI0eU1pT9wQEKu3dY4w642sVRFnwwbWGvS0wjnoSVEyqMnXTM+9lB1py+zF6X0K+zCoPLuFdsJgAcgSd1BQ8EgnW9yTqThaj0mEbOSCTdiDqiKD7VPoWFA5BEN2m0r9v7eW0RkXcP45hqXIb0oB
X-Gm-Message-State: AOJu0YypFh7q9/VgTy2BknTLtX7n0s0O4ePiKNaxpVfCWwp5afCEyx4g
	AuDaR61sl6EuYLT+VDIjUAso0+1K1YOWab5XmCmTx1EWVXDRt8c2QE4RKr+u7bV51URp479pn5P
	LKMIOI7WsfpV7kuVsyS18UUercHI=
X-Google-Smtp-Source: AGHT+IHC2Ju84HVBynoKj1hUrN9vLsEJVpH9b9/o/+/WlqyN+iPqJA6wb3I9r5dESbRjPG4wL26BVeNw2S+gG+Y3E8o=
X-Received: by 2002:a05:6512:2e3:b0:51c:2002:e002 with SMTP id
 m3-20020a05651202e300b0051c2002e002mr818608lfq.4.1714041384681; Thu, 25 Apr
 2024 03:36:24 -0700 (PDT)
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
 <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com>
 <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com>
 <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com> <ZiopXE6-AucAB9NM@gardel-login>
In-Reply-To: <ZiopXE6-AucAB9NM@gardel-login>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 25 Apr 2024 12:36:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXETZ3L2QEZjD8=zr9FY11FGkf5KktXoSixjpGxWS4h8sA@mail.gmail.com>
Message-ID: <CAMj1kXETZ3L2QEZjD8=zr9FY11FGkf5KktXoSixjpGxWS4h8sA@mail.gmail.com>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lennart,

Thanks to you and Mikko for providing this background.

On Thu, 25 Apr 2024 at 11:59, Lennart Poettering <mzxreary@0pointer.de> wro=
te:
>
> On Mi, 24.04.24 19:15, Ard Biesheuvel (ardb@kernel.org) wrote:
>
> > > > > > > > [    0.000000] efi: ESRT=3D0xf0ea5040 TPMFinalLog=3D0xf0ea9=
040
> > > > > > > > RTPROP=3D0xf0ea7040 SMBIOS=3D0xf0ea3000 TPMEventLog=3D0xeb3=
b3040
> > > > > > > > INITRD=3D0xeb3b2040 RNG=3D0xe5c0f040 MEMRESERVE=3D0xe5c0e04=
0
> > > > > > > >
> > > > > > > > Different boards use different TPM HW and drivers so compil=
ing
> > > > > > > > all these in is possible but a bit ugly. systemd recently
> > > > > > > > gained support for a specific tpm2.target which makes TPM
> > > > > > > > support modular and also works with kernel modules for some=
 TPM
> > > > > > > > use cases but not rootfs encryption.
> > > > > > > >
> > > > > > > > In my test case we have a kernel+initramfs uki binary which=
 is
> > > > > > > > loaded by EFI firmware as a secure boot binary. TPM support=
 on
> > > > > > > > various boards is visible in devicetree but not as ACPI tab=
le
> > > > > > > > entries. systemd currently detect TPM2 support either via A=
CPI
> > > > > > > > table /sys/firmware/acpi/tables/TPM2 or TPM entry or via
> > > > > > > > firmware measurement via
> > > > > > > > /sys/kernel/security/tpm0/binary_bios_measurements
> > > > > > > > .
> > > > > > >
> > > > > > > One corner case worth noting here is that scanning the device
> > > > > > > tree won't always work for non-ACPI systems... The reason is =
that
> > > > > > > a firmware TPM (running in OP-TEE) might or might not have a =
DT
> > > > > > > entry, since OP-TEE can discover the device dynamically and
> > > > > > > doesn't always rely on a DT entry.
> > > > > > >
> > > > > > > I don't particularly love the idea that an EventLog existence
> > > > > > > automatically means a TPM will be there, but it seems that
> > > > > > > systemd already relies on that and it does solve the problem =
we
> > > > > > > have.
> > > > > >
> > > > > > Well, quite. That's why the question I was interested in, perha=
ps
> > > > > > not asked as clearly as it could be is: since all the TPM devic=
es
> > > > > > rely on discovery mechanisms like ACPI or DT or the like which =
are
> > > > > > ready quite early, should we simply be auto loading the TPM dri=
vers
> > > > > > earlier?
> > > > >
> > > > > This would be an elegant way to solve this and on top of that, we
> > > > > have a single discovery mechanism from userspace -- e.g ls /dev/t=
pmX.
> > > > > But to answer that we need more feedback from systemd. What 'earl=
ier'
> > > > > means? Autload it from the kernel before we go into launching the
> > > > > initrd?
> > > >
> > > > Right, so this is another timing problem: we can't autoload modules
> > > > *before* they appear in the filesystem and presumably they're on th=
e
> > > > initrd, so auto loading must be post initrd mount (and init executi=
on)
> > > > but otherwise quite early?
> > >
> > > Exactly. But is that enough?
>
> General purpose distros typically don't build all TPM drivers into the
> kernel, but ship some in the initrd instead. Then, udev is responsible
> for iterating all buses/devices and auto-loading the necessary
> drivers. Each loaded bus driver might make more devices available for
> which more drivers then need to be loaded, and so on. Some of the
> busses are "slow" in the sense that we don't really know a precise
> time when we know that all devices have now shown up, there might
> always be slow devices that haven't popped up yet. Iterating through
> the entire tree of devices in sysfs is often quite slow in itself too,
> it's one of the most time consuming parts of the boot in fact. This
> all is done asynchronously hence: we enumerate/trigger/kmod all
> devices as quickly as we can, but we continue doing other stuff at the
> same time.
>
> Of course that means that other stuff sometimes has to *wait* for
> devices to show up. For example, if a harddisk shall be mounted, it
> needs to be found/probed/kmod'ed first. Hence that's what we do: the
> fscking/mounting of a file system is delayed exactly as long as it
> takes for the block device it is for to show up.
>
> systemd these days makes use of the TPM =E2=80=94 if available =E2=80=94 =
for various
> purposes, such as disk encryption, measuring boot phases and system
> identity and various other things. Now, for the purpose of disk
> encryption, we need to wait for two things: the hard drive, and the
> TPM to be probed/driver loaded/accessible. /etc/fstab tells us pretty
> explicitly what bloock device to wait for, hence it's easy. But
> waiting for a TPM is harder: we might need it for disk encryption, but
> we don't know right-away if there actually *is* a TPM device to show
> up, and hence don't know whether to wait for it or not.
>

I take it this means that the LUKS metadata lacks a 'this key is
sealed into the TPM' bit?

Could you elaborate a bit on how the early boot code manages this?
...
> > Exposing random firmware assets directly to user space to make guesses
> > about this doesn't seem like a very robust approach to this issue.
>
> If you give us a generic flag file that says "firmware found and used
> a tpm" somewhere in sysfs that abstracts the details how it detects
> that is enough for us. i.e. i don't care if the kenrel abstracts this
> or if we do more explicit checks in userspace. All i care is that it's
> just a few access(F_OK) checks away for us.
>

So exposing the physical address of the TPM event log is probably not
what we want here.

Note that the TPM event log table is a Linux/efistub construct,
whereas the TPM final log table actually comes from the firmware
directly. So the former only exists if the EFI stub executed first,
and managed to invoke the TCG protocol etc. OTOH, the TPM final log is
TPM2 only, so it doesn't exist on TPM 1.2

Another thing we need to consider is TDX, which exposes a pseudo-TPM
which does not support sealing, along with a CC protocol similar to
the TCG2 protocol. This code will use the event log infrastructure as
well: there are discussions going on at the moment whether we can
improve the way these protocols are combined.

So we should define a scope here:
- do we need TPM1.2 support?
- do we need non-EFI boot support?
- do we need to do anything in particular for FDE on TDX, which has a
TPM event log but no TPM is likely to appear.

I am fine with adding a sysfs node under /sys/firmware/efi that
exposes some of this information, e.g.,
linux_efi_tpm_eventlog::version, but not the physical address of the
table.

