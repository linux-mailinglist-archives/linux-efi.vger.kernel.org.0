Return-Path: <linux-efi+bounces-969-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E432C8B1D26
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 10:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758C01F2119D
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 08:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8750D8005C;
	Thu, 25 Apr 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAcricNL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4364F6D1A7
	for <linux-efi@vger.kernel.org>; Thu, 25 Apr 2024 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035399; cv=none; b=mmHHbpDOdq8t+4VcVtMNIHsJY1zz9XaLy0+Df6wYRhJ+BV1y/0aKmjYB5kBP+KqAICFg/lM4wlmJk3zSRhJ9UtC2nfLOwNzsheIJCmba8rDCwhEsrIcl4iCLEURsvTMhp1pv9ihx55zUdlhWXrxY8biWoEh4NDTQnMwW/cbwp/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035399; c=relaxed/simple;
	bh=N/WOc/y37uAkYr9zVVieC5AyNNxl0w/zBIWTapyQM+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TecXMv/6X7Cd/ubPnOnqSNJ681E6HAcFzRYWuI1FYQWJsnO690vOWM+SGow/02a/cV3E3xUWvqwVerY4FAXB+Ymz4yrQqRIQoS0yqubVaTtEREaO+81FC69uZji1oz4iusNe8Q3CCiCylE98KuvGtVOwyn4zF74PZrKjW08UmJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JAcricNL; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so829218e87.1
        for <linux-efi@vger.kernel.org>; Thu, 25 Apr 2024 01:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714035395; x=1714640195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKqGqtlUD/Lz0MbLYaR+VCjUnJhIc5ox17am+QQAiwE=;
        b=JAcricNL1dfW0Uqx2Lqaxhgrqy+g1By0OFF7VYnoaFPWHGsPh3NmbKcgg3k8+fwSH4
         diO05aRoNFs4cKZQGWQnTyWJO+defY0xXt2wGXiia35c+qR873eyg1saVGsTEWnws/Qu
         JLBsCuqHy0lSHDoVrmQG4dWE+6VAgN+KU6CWb3Eo47+Clhn24VC1Z905C8gCqMsStNmp
         1wH5aCiKq94MtT/rFRMF3qHNcH6Qmp5f6Dhom0Dc9T8I0nuwKG/lZ/brBFPSesG9TZIw
         E1U/RjYzQ7kJsInCeuoFKJe5fu1bbZphqhQ8obxKfixKnJDU+2g1PV21Q/iU7P8HjY5W
         J7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714035395; x=1714640195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKqGqtlUD/Lz0MbLYaR+VCjUnJhIc5ox17am+QQAiwE=;
        b=gJc/dJgtZ//6nGdvt2i/l00JTZA/VHnxUbCFWEo7gDqrboXkEgFP/iq4ks2IOskrX6
         hYdY8lcUEKagso2PW+1MFg/QdxXAQW2gYbeB+kGAIHRaj2r2eXnu0idGhfHa08T3tqnT
         xbnvMEJ2O5aZ8UBJT5wmKAMo2xTKDfM8fb1ScMk4x6OB4XlnfINlYFcC1u6nFZfRMmS/
         OZ/MPZ4rNrABvoViQRDQdiE/S4cV7R0TqsOkS8Gui20iiXSlTCtl0GRDuX/5J2lLIsLN
         7Co6PcFb6VVYBfYObHBAEbZEz7FIv+f1ehyoJYFzBLmOlnM+q748WJszYZfF2XAXOTC+
         1f6w==
X-Forwarded-Encrypted: i=1; AJvYcCU9vmbX84DnfxQwdJJybZ/xAAPMQIySeGw78XPSyZWRB71FCZP5yZ8TG+HeWHiVonGOmqdW1BWVzMH3qUf+4rcHuO1b1dy0hx9L
X-Gm-Message-State: AOJu0Yw5Bj9+mReD75RDo7yotLMtbHY8Z/AvN6vPufTlDOUcKXBz7wbU
	zrZLvqrBWaZg9TLETnrTEcRNbBpKVr5p3kTaFvPihKIZSrOILcCL54LyVHanjr0=
X-Google-Smtp-Source: AGHT+IFCDpCuXESp5OEY/4ehtfOoWrdFjyUwXLBIWcg7XfekW3WmeuwZKKFV4eucQ+cs7rX7ODNyQQ==
X-Received: by 2002:a05:6512:36c9:b0:51b:fe4b:da45 with SMTP id e9-20020a05651236c900b0051bfe4bda45mr2796709lfs.38.1714035395091;
        Thu, 25 Apr 2024 01:56:35 -0700 (PDT)
Received: from nuoska (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id bi30-20020a0565120e9e00b0051acd59ead9sm2146081lfb.169.2024.04.25.01.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 01:56:34 -0700 (PDT)
Date: Thu, 25 Apr 2024 11:56:32 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
Message-ID: <ZioawGrx8gi3mqMg@nuoska>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com>

Hi,

On Wed, Apr 24, 2024 at 07:15:35PM +0200, Ard Biesheuvel wrote:
> On Mon, 22 Apr 2024 at 17:22, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Mon, 22 Apr 2024 at 17:31, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Mon, 2024-04-22 at 16:54 +0300, Ilias Apalodimas wrote:
> > > > Hi James
> > > >
> > > > On Mon, 22 Apr 2024 at 16:38, James Bottomley
> > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > >
> > > > > On Mon, 2024-04-22 at 16:32 +0300, Ilias Apalodimas wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > On Mon, 22 Apr 2024 at 16:08, Mikko Rapeli
> > > > > > <mikko.rapeli@linaro.org>
> > > > > > wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Mon, Apr 22, 2024 at 08:42:41AM -0400, James Bottomley
> > > > > > > wrote:
> > > > > > > > On Mon, 2024-04-22 at 14:27 +0300, Mikko Rapeli wrote:
> > > > > > > > > Userspace needs to know if TPM kernel drivers need to be
> > > > > > > > > loaded and related services started early in the boot if
> > > > > > > > > TPM device is used and available.
> > > > > > > >
> > > > > > > > This says what but not why.  We already have module
> > > > > > > > autoloading that works correctly for TPM devices, so why is
> > > > > > > > this needed?
> > > > > > > >
> > > > > > > > We do have a chicken and egg problem with IMA in that the TPM
> > > > > > > > driver needs to be present *before* any filesystem, including
> > > > > > > > the one the TPM modules would be on, is mounted so executions
> > > > > > > > can be measured into IMA (meaning that if you use IMA the TPM
> > > > > > > > drivers must be built in) but this sounds to be something
> > > > > > > > different. However, because of the IMA problem, most
> > > > > > > > distributions don't end up compiling TPM drivers as modules
> > > > > > > > anyway.
> > > > > > > >
> > > > > > > > Is what you want simply that tpm modules be loaded earlier?
> > > > > > >
> > > > > > > Yes, ealier is the problem. In my specific testing case the
> > > > > > > machine is qemu arm64 with swtpm with EFI firmware for secure
> > > > > > > boot and TPM support.
> > > > > > >
> > > > > > > Firmware uses TPM and does measurements and thus TPM event log
> > > > > > > is
> > > > > > > available on this machine and a bunch of other arm64 boards.
> > > > > > > Visible in early boot dmesg as TPMEventLog lines like:
> > > > > > >
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
> >
> > >
> > > This might be quite a bit of work.  Logically, just moving the matching
> > > and loading code earlier might work, but we used to have a
> > > load_default_modules() at the end of init/main.c and it got removed
> > > (because it only eventually loaded elevator modules) everything is now
> > > loaded in it's various init routines, so to get, say, TPM ACPI modules
> > > loaded earlier, we'd have to run the ACPI device matching code earlier
> > > and so on for every other subsystem ...
> >
> > Being the devil's advocate here and as I stated I don't love this but ...
> > The kernel isn't technically doing anything wrong. We just expose an
> > *existing* EFI config table. The kernel also exposes filesystems so
> > people are free to do rm -rf *.
> > The fact that applications might use it as a means of "oh there's
> > probably a TPM" shouldn't be the end of the world. On top of that,
> > since it's an EFI config table we can keep it around and never break
> > any ABIs we create to userspace. If in the future we find a better
> > way, userspace can use that?
> >
> > So perhaps this is ok as long as make sure we understand why systemd
> > needs it that early?
> >
> 
> What I would like to know is which API systemd is attempting to use,
> and which -apparently- may never become available if no TPM is exposed
> by the kernel.

ACPI TPM table entry, available without TPM drivers.

TPM PCR bios measurement, available only with working TPM drivers.

> Ideally, we should be able to take inspiration from the probe deferral
> work, and return -EAGAIN to convey that it is too early to signal
> either success or permanent failure.
> 
> Exposing random firmware assets directly to user space to make guesses
> about this doesn't seem like a very robust approach to this issue.

As I understand, there are two questions which systemd and userspace need aswers to:

1) is there a TPM device

2) was a TPM device used by firmware to measure boot

If answer to 1) is yes, then drivers need to be loaded, but not necessarily
in early boot before main rootfs mount. If answer to 2) is yes, then
drivers and userspace components should be setup for TPM in early boot.

The x86 and server grade arm standard for 1) is ACPI table TPM entry, basically
/sys/firmware/acpi/tables/TPM2. For other HW, like embedded arm boards/SoCs,
the TPM device can be on discoverable bus (optee firmware TPM etc)
or in devicetree. These work correctly with udev etc and drivers get loaded
in normal boot and thus answer 1).

For 2), once kernel side TPM device has been initialized, driver built into the
kernel or loaded before this check, userspace and systemd can check if
/sys/firmware/acpi/tables/TPM2 is there, or alternatively if TPM driver
is already working /sys/kernel/security/tpm0/binary_bios_measurements
which indicates that firmware was measured with TPM. The latter really requires
built in TPM drivers or modules which are loaded really early in boot, almost
as first thing in userspace, before systemd does any checks for the TPM
device existance. These steps happen in initramfs so that TPM can be used
to protect main rootfs. systemd implements this with efi_has_tpm2()
function in https://github.com/systemd/systemd/blob/main/src/shared/efi-api.c#L482

One problem is how to support TPM devices as kernel modules. Linux distros
should be able to build these drivers too as modules and systemd etc will
take care to load them once devices are discovered, and then queue in
other possibly complex userspace services/daemons so that TPM is useful and
rootfs can be decrypted. /sys/kernel/security/tpm0/binary_bios_measurements is
available only when the TPM driver is loaded and working. For example, if boot firmware has
optee and firmware TPM (fTPM) as an early trusted application (early TA), then this
only works when optee driver is initialized, tee-supplicant userspace daemon runs
and tpm_ftpm_tee kernel driver for fTPM has been loaded to the kernel. tee-supplicant
implements RPMB storage if board/HW does not support it directly. The optee and fTPM
kernel drivers can be built into kernel, but they still need tee-supplicant in
userspace.

To answer 2), ACPI TPM table entry works without kernel drivers, but what
about devices without ACPI support, or TPM on a discoverable bus like optee with fTPM?

Parsing devicetree in userspace is really painful, but could possible be done.
Or kernel could provide a sysfs indicator if there is a devicetree entry
for TPM. But there are some devices where devicetree does not show a TPM
device but one exists in the discoverable bus, optee fTPM.

In all, granted limited, arm64 cases which I have seen, when firmare was aware
of the TPM device and used it for measuring boot, then the TPM Event Log was
provided to the kernel. The early boot log messages like show this:

arm64 qemu with swtpm, u-boot based EFI firmware, TPM Event Log and TPM
in devicetree, no ACPI:

https://ledge.validation.linaro.org/scheduler/job/85933
[    0.000000] efi: TPMFinalLog=0xbd649040 RTPROP=0xbd647040 SMBIOS 3.0=0xbe6a9000 TPMEventLog=0xbd5b0040 INITRD=0xbd5af040 MEMRESERVE=0xbd5ae040
...
		tpm_tis@0 {
			tpm_event_log_size = <0x18f>;
			compatible = "tcg,tpm-tis-mmio";
			reg = <0x00 0x5000>;
			tpm_event_log_addr = <0x00 0x40100000>;
		};

rockpi4b with firmware TPM, u-boot based EFI firmware, TPM Event Log but
no TPM in devicetree, no ACPI:

https://ledge.validation.linaro.org/scheduler/job/85936
[    0.000000] efi: ESRT=0xf0ea5040 TPMFinalLog=0xf0ea9040 RTPROP=0xf0ea7040 SMBIOS=0xf0ea3000 TPMEventLog=0xeb381040 INITRD=0xeb380040 RNG=0xe5baf040 MEMRESERVE=0xe5bae040

synquacer with firmware TPM and real TPM, u-boot based EFI firmware,
TPM Event Log using fTPM but only real but disabled TPM in devicetree, no ACPI:

https://ledge.validation.linaro.org/scheduler/job/85934
[    0.000000] efi: ESRT=0xf9c90040 TPMFinalLog=0xf9c94040 RTPROP=0xf9c92040 SMBIOS=0xf9c8e000 TPMEventLog=0xf9bf7040 INITRD=0xf9bf6040 RNG=0xf9bf5040 MEMRESERVE=0xf9bf4040
...
	tpm_tis@10000000 {
		compatible = "socionext,synquacer-tpm-mmio";
		status = "disabled";
		reg = <0x00 0x10000000 0x00 0x5000>;
	};

kv260/zyncmp-kria-starter with real TPM, u-boot based EFI firmware,
TPM Event Log using TPM but no devicetree, no ACPI:

https://ledge.validation.linaro.org/scheduler/job/85937
[    0.000000] efi: ESRT=0x777f8040 TPMFinalLog=0x777fc040 RTPROP=0x777fa040 SMBIOS=0x777f6000 TPMEventLog=0x7775a040 INITRD=0x77759040 MEMRESERVE=0x77758040

Ampere AVA with ACPI TPM entry but support disabled in firmare,
no TPM Event Log, no devicetree, but an ACPI TPM entry:

https://ledge.validation.linaro.org/scheduler/job/85935
[    0.000000] ACPI: TPM2 0x00000000FFFEFD18 00004C (v04 Ampere Altra    00000002 AMP. 01000013)

Some of these TPM indicators could be considered firmware bugs, but in all
cases TPM firmware support can be detected via TPM Event Log
so that answers question 2).

TPM Event Log is not a random firmware interface. It is an optional interface
to make TPM usable and in practice most TPM using firmware provide it to the kernel.
The actual measurement and checks for it require the TPM HW and measurement PCRs,
but the TPM Event Log is a strong indicator from firmware to the kernel, and userspace,
that TPM is available and was used.

Kernel already knows about TPM Event Log. The proper interface to read it is from
securityfs file binary_bios_measurements implemented by loaded TPM driver.
Existence of this measurement is know before TPM driver is loaded and this change
only exports that to sysfs so that userspace can queue the TPM driver loading
and userspace services/daemons in the early initramfs before main rootfs is available.

Hope this helps,

-Mikko

