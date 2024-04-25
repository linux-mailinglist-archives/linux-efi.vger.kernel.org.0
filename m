Return-Path: <linux-efi+bounces-970-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DE68B1E98
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 11:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF985B256EA
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 09:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525FB84FD0;
	Thu, 25 Apr 2024 09:59:05 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9284D3C;
	Thu, 25 Apr 2024 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039145; cv=none; b=XVMmDIOFvWeAPQSskykXiZZx6gMHD3NH5PPusezzBzjuVqZ61bFcuRiBgdkmN7KcJUQGcdruYARGg0uRzxBnPYjDPlZiKEx5korzr38v02r+0brPKenjQyUKJoAo7wRaGUSxnT8coI5poL28ss2uvyz/9cLY9B9ONt0mSCIQ8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039145; c=relaxed/simple;
	bh=xHhXT4WcWwUQdi5jvWEFm+xkFr/4SW6w8eomcm5GoVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujCXhrpQIPvDO/mjtOeMQSjPg2bbWHRnNWfcXkSbPj8ObufuFhQ+evRGp2WAQ+d0sON4hE7msm70elM68VYIvsI2diH2QEZ6y5oXG4UeTgy7Ny3j4VYx7scHh8CALhUDDyqS8L79HJgncbmFXTlB5bEhfQNhs82IOAwrhWcpuLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id E1736E80EF2;
	Thu, 25 Apr 2024 11:58:52 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 43FE4160029; Thu, 25 Apr 2024 11:58:52 +0200 (CEST)
Date: Thu, 25 Apr 2024 11:58:52 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mikko Rapeli <mikko.rapeli@linaro.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
Message-ID: <ZiopXE6-AucAB9NM@gardel-login>
References: <20240422112711.362779-1-mikko.rapeli@linaro.org>
 <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>
 <ZiZhSfgeAdrbnaVL@nuoska>
 <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
 <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
 <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
 <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com>
 <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com>
 <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com>

On Mi, 24.04.24 19:15, Ard Biesheuvel (ardb@kernel.org) wrote:

> > > > > > > [    0.000000] efi: ESRT=0xf0ea5040 TPMFinalLog=0xf0ea9040
> > > > > > > RTPROP=0xf0ea7040 SMBIOS=0xf0ea3000 TPMEventLog=0xeb3b3040
> > > > > > > INITRD=0xeb3b2040 RNG=0xe5c0f040 MEMRESERVE=0xe5c0e040
> > > > > > >
> > > > > > > Different boards use different TPM HW and drivers so compiling
> > > > > > > all these in is possible but a bit ugly. systemd recently
> > > > > > > gained support for a specific tpm2.target which makes TPM
> > > > > > > support modular and also works with kernel modules for some TPM
> > > > > > > use cases but not rootfs encryption.
> > > > > > >
> > > > > > > In my test case we have a kernel+initramfs uki binary which is
> > > > > > > loaded by EFI firmware as a secure boot binary. TPM support on
> > > > > > > various boards is visible in devicetree but not as ACPI table
> > > > > > > entries. systemd currently detect TPM2 support either via ACPI
> > > > > > > table /sys/firmware/acpi/tables/TPM2 or TPM entry or via
> > > > > > > firmware measurement via
> > > > > > > /sys/kernel/security/tpm0/binary_bios_measurements
> > > > > > > .
> > > > > >
> > > > > > One corner case worth noting here is that scanning the device
> > > > > > tree won't always work for non-ACPI systems... The reason is that
> > > > > > a firmware TPM (running in OP-TEE) might or might not have a DT
> > > > > > entry, since OP-TEE can discover the device dynamically and
> > > > > > doesn't always rely on a DT entry.
> > > > > >
> > > > > > I don't particularly love the idea that an EventLog existence
> > > > > > automatically means a TPM will be there, but it seems that
> > > > > > systemd already relies on that and it does solve the problem we
> > > > > > have.
> > > > >
> > > > > Well, quite. That's why the question I was interested in, perhaps
> > > > > not asked as clearly as it could be is: since all the TPM devices
> > > > > rely on discovery mechanisms like ACPI or DT or the like which are
> > > > > ready quite early, should we simply be auto loading the TPM drivers
> > > > > earlier?
> > > >
> > > > This would be an elegant way to solve this and on top of that, we
> > > > have a single discovery mechanism from userspace -- e.g ls /dev/tpmX.
> > > > But to answer that we need more feedback from systemd. What 'earlier'
> > > > means? Autload it from the kernel before we go into launching the
> > > > initrd?
> > >
> > > Right, so this is another timing problem: we can't autoload modules
> > > *before* they appear in the filesystem and presumably they're on the
> > > initrd, so auto loading must be post initrd mount (and init execution)
> > > but otherwise quite early?
> >
> > Exactly. But is that enough?

General purpose distros typically don't build all TPM drivers into the
kernel, but ship some in the initrd instead. Then, udev is responsible
for iterating all buses/devices and auto-loading the necessary
drivers. Each loaded bus driver might make more devices available for
which more drivers then need to be loaded, and so on. Some of the
busses are "slow" in the sense that we don't really know a precise
time when we know that all devices have now shown up, there might
always be slow devices that haven't popped up yet. Iterating through
the entire tree of devices in sysfs is often quite slow in itself too,
it's one of the most time consuming parts of the boot in fact. This
all is done asynchronously hence: we enumerate/trigger/kmod all
devices as quickly as we can, but we continue doing other stuff at the
same time.

Of course that means that other stuff sometimes has to *wait* for
devices to show up. For example, if a harddisk shall be mounted, it
needs to be found/probed/kmod'ed first. Hence that's what we do: the
fscking/mounting of a file system is delayed exactly as long as it
takes for the block device it is for to show up.

systemd these days makes use of the TPM — if available — for various
purposes, such as disk encryption, measuring boot phases and system
identity and various other things. Now, for the purpose of disk
encryption, we need to wait for two things: the hard drive, and the
TPM to be probed/driver loaded/accessible. /etc/fstab tells us pretty
explicitly what bloock device to wait for, hence it's easy. But
waiting for a TPM is harder: we might need it for disk encryption, but
we don't know right-away if there actually *is* a TPM device to show
up, and hence don't know whether to wait for it or not.

In systemd we hence check early if firmware reported that it measured
something into a TPM during early boot. If not, then we have no
measured boot, and we don't have to wait for the TPM. (Of course,
there could possibly be a TPM that the firmware didn't use, but even
if, there's no real point in waiting for it, since a TPM is not that
interesting if your firmware didn't protect the boot with it/filled
the PCRs with data). If however we see that firmware measured
something into the TPM, then we deduce from that that Linux will probably
find the device too sooner or later, we just need to give the udev
enumerate/trigger/kmod logic enough time. And so we tell the disk
encryption stuff to wait for a TPM to show up before we continue. This
works quite well in the x86/acpi/uefi world.

There, we check for the efi tpm event log + the ACPI TPM table as
indication whether TPM was used by firmware. Note that we are not
interested in the *contents* of the log or the table to determine if
we shall wait for a tpm device, we just care about the
*existence*. i.e. it's two access() calls that check if the two
things exist in sysfs.

On ACPI-less arm platforms this check doesn't work. And we are looking
for a sensible replacement: i.e. something that tells us that the
firmware found, initialized, and measured stuff into a TPM and that is
enough for us to assume that sooner or later it will also be probed
and be accessible in Linux/udev/…, too.

This check is done very very early in userspace (early initrd), at a
moment in time where no devices have been probed yet.

How precisely we do the check is up for discussion. All we care about
is an answer to the question "Did firmware find and make use/measure
into a TPM device? yes/no". And we want to be able to answer that
question very early in userspace, without having to actually probe
hardware/busses/drivers/….

And yes, the test we implemented on x86/acpu/uefi might actually come
to the wrong conclusion, because Linux might lack a driver for a TPM
the firmware supports. But right now there are few reports this is
actually a problem, Linux TPM support seems to be quite OK
IRL. Moreover, there's an override via the kernel cmdline
(systemd.tpm2_wait=0) for the cases where the logic fails.

> What I would like to know is which API systemd is attempting to use,
> and which -apparently- may never become available if no TPM is exposed
> by the kernel.

We want a trivial check whether it's likely Linux is going to expose a
TPM device eventually.

And yes, as mentioned, there might be cases where Linux lacks a driver
for something the firmware support. But as long as this is not the
common case we are good.

> Ideally, we should be able to take inspiration from the probe deferral
> work, and return -EAGAIN to convey that it is too early to signal
> either success or permanent failure.

We need an early check, so that we can dealy FDE setup, that we can
delay our first boot phase measurements and so on. An kernel interface
that just tells us "we don't have a tpm yet, we might have one one
day, or not, we don't know yet" is useless to us.

> Exposing random firmware assets directly to user space to make guesses
> about this doesn't seem like a very robust approach to this issue.

If you give us a generic flag file that says "firmware found and used
a tpm" somewhere in sysfs that abstracts the details how it detects
that is enough for us. i.e. i don't care if the kenrel abstracts this
or if we do more explicit checks in userspace. All i care is that it's
just a few access(F_OK) checks away for us.

Lennart

--
Lennart Poettering, Berlin

