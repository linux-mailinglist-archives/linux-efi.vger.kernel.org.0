Return-Path: <linux-efi+bounces-950-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED2E8ACE78
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 15:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDCF1C213C9
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EF8150995;
	Mon, 22 Apr 2024 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="xfU48gqZ";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="xfU48gqZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1916F13E8B2;
	Mon, 22 Apr 2024 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793117; cv=none; b=iI/vvARuGFu8SjvnXr5GpBTbMfGRQTm3LPft7jWYr/rNH+f4Bp8Gdtu2FYpY0DUXd54rcpiFjqxGNszwyuHhcN7JtmqpdMc8RC/t2/LEhzXcteyTlGsqto5YbmGqoqpU9it3fuCFpYPeyopbLEXcrxlEjrQoJQTkX8ogzlGEEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793117; c=relaxed/simple;
	bh=8lGfa3wXZk/nLC2sv28ZxkuNqmYWXrbAHoJq5tn3RXo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NHrv/Ruq0fcR+LW4AUmGIsGhH6b9e7UdWQi4+QqzAoc5xKPGK9jiK/qxeDRDIHgD75t+gW0oc86re0g41x/ofm3+NKrfKAdse/nW9eofSIY/HpETbW22J/vLtQ3OuWgRhQhoYMcAHWCTXQWTxn/VKyNBTkSYVCAU8H26egLpDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=xfU48gqZ; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=xfU48gqZ; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1713793114;
	bh=8lGfa3wXZk/nLC2sv28ZxkuNqmYWXrbAHoJq5tn3RXo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=xfU48gqZMiki3eMNvn61RFINyKlSBj9X0Nt6rjTlo35IZTPRM167Dkr+8kC3jqRs7
	 AmNtjY77nV9+GvoYLLW7S0qGCkZ18zxE5V01Lmy9IAGU5Cj+rM3rUCahiqiZYtKOmT
	 hE6wQFEsvZg6io80yiKl2nWdXyiwLosqJoF7pIRg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6200912862B5;
	Mon, 22 Apr 2024 09:38:34 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id UyID5Fv5U5vd; Mon, 22 Apr 2024 09:38:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1713793114;
	bh=8lGfa3wXZk/nLC2sv28ZxkuNqmYWXrbAHoJq5tn3RXo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=xfU48gqZMiki3eMNvn61RFINyKlSBj9X0Nt6rjTlo35IZTPRM167Dkr+8kC3jqRs7
	 AmNtjY77nV9+GvoYLLW7S0qGCkZ18zxE5V01Lmy9IAGU5Cj+rM3rUCahiqiZYtKOmT
	 hE6wQFEsvZg6io80yiKl2nWdXyiwLosqJoF7pIRg=
Received: from [172.20.13.230] (wsip-184-177-54-3.hr.hr.cox.net [184.177.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8035B1286184;
	Mon, 22 Apr 2024 09:38:33 -0400 (EDT)
Message-ID: <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Mikko Rapeli
	 <mikko.rapeli@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lennart Poettering <lennart@poettering.net>, 
	linux-integrity@vger.kernel.org
Date: Mon, 22 Apr 2024 09:38:31 -0400
In-Reply-To: <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
References: <20240422112711.362779-1-mikko.rapeli@linaro.org>
	 <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>
	 <ZiZhSfgeAdrbnaVL@nuoska>
	 <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-04-22 at 16:32 +0300, Ilias Apalodimas wrote:
> Hi all,
> 
> On Mon, 22 Apr 2024 at 16:08, Mikko Rapeli <mikko.rapeli@linaro.org>
> wrote:
> > 
> > Hi,
> > 
> > On Mon, Apr 22, 2024 at 08:42:41AM -0400, James Bottomley wrote:
> > > On Mon, 2024-04-22 at 14:27 +0300, Mikko Rapeli wrote:
> > > > Userspace needs to know if TPM kernel drivers need to be loaded
> > > > and related services started early in the boot if TPM device
> > > > is used and available.
> > > 
> > > This says what but not why.  We already have module autoloading
> > > that works correctly for TPM devices, so why is this needed?
> > > 
> > > We do have a chicken and egg problem with IMA in that the TPM
> > > driver needs to be present *before* any filesystem, including the
> > > one the TPM modules would be on, is mounted so executions can be
> > > measured into IMA (meaning that if you use IMA the TPM drivers
> > > must be built in) but this sounds to be something different.
> > > However, because of the IMA problem, most distributions don't end
> > > up compiling TPM drivers as modules anyway.
> > > 
> > > Is what you want simply that tpm modules be loaded earlier?
> > 
> > Yes, ealier is the problem. In my specific testing case the machine
> > is qemu arm64 with swtpm with EFI firmware for secure boot and TPM
> > support.
> > 
> > Firmware uses TPM and does measurements and thus TPM event log is
> > available on this machine and a bunch of other arm64 boards.
> > Visible in early boot dmesg as TPMEventLog lines like:
> > 
> > [    0.000000] efi: ESRT=0xf0ea5040 TPMFinalLog=0xf0ea9040
> > RTPROP=0xf0ea7040 SMBIOS=0xf0ea3000 TPMEventLog=0xeb3b3040
> > INITRD=0xeb3b2040 RNG=0xe5c0f040 MEMRESERVE=0xe5c0e040
> > 
> > Different boards use different TPM HW and drivers so compiling all
> > these in is possible but a bit ugly. systemd recently gained
> > support for a specific tpm2.target which makes TPM support modular
> > and also works with kernel modules for some TPM use cases but not
> > rootfs encryption.
> > 
> > In my test case we have a kernel+initramfs uki binary which is
> > loaded by EFI firmware as a secure boot binary. TPM support on
> > various boards is visible in devicetree but not as ACPI table
> > entries. systemd currently detect TPM2 support either via ACPI
> > table /sys/firmware/acpi/tables/TPM2 or TPM entry or via firmware
> > measurement via /sys/kernel/security/tpm0/binary_bios_measurements
> > .
> 
> One corner case worth noting here is that scanning the device tree
> won't always work for non-ACPI systems... The reason is that a
> firmware TPM (running in OP-TEE) might or might not have a DT entry,
> since OP-TEE can discover the device dynamically and doesn't always
> rely on a DT entry.
> 
> I don't particularly love the idea that an EventLog existence
> automatically means a TPM will be there, but it seems that systemd
> already relies on that and it does solve the problem we have.

Well, quite. That's why the question I was interested in, perhaps not
asked as clearly as it could be is: since all the TPM devices rely on
discovery mechanisms like ACPI or DT or the like which are ready quite
early, should we simply be auto loading the TPM drivers earlier?

James


