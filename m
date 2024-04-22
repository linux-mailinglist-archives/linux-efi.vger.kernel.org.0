Return-Path: <linux-efi+bounces-952-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D7B8ACF6D
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 16:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E344B20D49
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1F61E4A1;
	Mon, 22 Apr 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kPlce+/D";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="WsAAiU4m"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D8F10A24;
	Mon, 22 Apr 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796295; cv=none; b=Nv7FQaPwo5t6uspKDp7AJ9tBoC4niKByB5yVf3UI31YSgfyxj/W9gVojasmWvpCqSXSTNal6RejM/A940d1sWP4jPneTo+nl06NDeJd4wqu7+YiCNQ8IxIZz4qY8gvZUkvoX4Y5EyJALPCS6gH37r1pS95MvJQs+6zk/wlhrrh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796295; c=relaxed/simple;
	bh=K7wyjRLcNUykgxF/QAusCyjr8sCsvz/O1Abzbu8bRAk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pj0TWZ1no0R4BKY2ZlnOWrOA2b5zA/RlWwpweF+P+zxG7vIcXiHOk2KIDBgD6djD1o29RUEt0HwUE/Nd38vCn8e4nSjicDWFraXLXgV3Gq6vOJkDqVW8zHcNecZkKBO7iCXEvok0b3RYds/kqUbO8gs8xYKFRn/OCPpO90aN+4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=kPlce+/D; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=WsAAiU4m; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1713796293;
	bh=K7wyjRLcNUykgxF/QAusCyjr8sCsvz/O1Abzbu8bRAk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=kPlce+/DBdIm2PkNb3/TjC3aqq4tD528d1buooEpvGUHwCyeO57Muhae73VnPqmnh
	 hY8AA1bXAuWaQKvES6D9L79ytyS+k88ewelMXVWQMRitzR8gWPTRUiFX/gwMGSM1Pv
	 vbyjtbqvgpwAoOUOSwGM64DtDpPE9BYx3MyifrtM=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 18B201286027;
	Mon, 22 Apr 2024 10:31:33 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 7Q_oRP6_fizp; Mon, 22 Apr 2024 10:31:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1713796292;
	bh=K7wyjRLcNUykgxF/QAusCyjr8sCsvz/O1Abzbu8bRAk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=WsAAiU4maGb9/Xm8Xlyct31Rtt1Hel4GwRt8kpz/kf4EPfbsWneJblnewAfu3PLDQ
	 gbkXp6dPq1pBSyBSLluMbb2qkbIBZ399WzOmogk7z6HsVHIxKsSwag+yCFuhnXRkJ4
	 Iv8lf4qv0xHqlHdxtMDpzuxCjkfYD0Mdo1kNCFD4=
Received: from [172.20.13.230] (wsip-184-177-54-3.hr.hr.cox.net [184.177.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 23B481285FD7;
	Mon, 22 Apr 2024 10:31:32 -0400 (EDT)
Message-ID: <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>, Ard Biesheuvel
 <ardb@kernel.org>,  linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lennart Poettering <lennart@poettering.net>,
 linux-integrity@vger.kernel.org
Date: Mon, 22 Apr 2024 10:31:30 -0400
In-Reply-To: <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
References: <20240422112711.362779-1-mikko.rapeli@linaro.org>
	 <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>
	 <ZiZhSfgeAdrbnaVL@nuoska>
	 <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
	 <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
	 <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-04-22 at 16:54 +0300, Ilias Apalodimas wrote:
> Hi James
> 
> On Mon, 22 Apr 2024 at 16:38, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Mon, 2024-04-22 at 16:32 +0300, Ilias Apalodimas wrote:
> > > Hi all,
> > > 
> > > On Mon, 22 Apr 2024 at 16:08, Mikko Rapeli
> > > <mikko.rapeli@linaro.org>
> > > wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > On Mon, Apr 22, 2024 at 08:42:41AM -0400, James Bottomley
> > > > wrote:
> > > > > On Mon, 2024-04-22 at 14:27 +0300, Mikko Rapeli wrote:
> > > > > > Userspace needs to know if TPM kernel drivers need to be
> > > > > > loaded and related services started early in the boot if
> > > > > > TPM device is used and available.
> > > > > 
> > > > > This says what but not why.  We already have module
> > > > > autoloading that works correctly for TPM devices, so why is
> > > > > this needed?
> > > > > 
> > > > > We do have a chicken and egg problem with IMA in that the TPM
> > > > > driver needs to be present *before* any filesystem, including
> > > > > the one the TPM modules would be on, is mounted so executions
> > > > > can be measured into IMA (meaning that if you use IMA the TPM
> > > > > drivers must be built in) but this sounds to be something
> > > > > different. However, because of the IMA problem, most
> > > > > distributions don't end up compiling TPM drivers as modules
> > > > > anyway.
> > > > > 
> > > > > Is what you want simply that tpm modules be loaded earlier?
> > > > 
> > > > Yes, ealier is the problem. In my specific testing case the
> > > > machine is qemu arm64 with swtpm with EFI firmware for secure
> > > > boot and TPM support.
> > > > 
> > > > Firmware uses TPM and does measurements and thus TPM event log
> > > > is
> > > > available on this machine and a bunch of other arm64 boards.
> > > > Visible in early boot dmesg as TPMEventLog lines like:
> > > > 
> > > > [    0.000000] efi: ESRT=0xf0ea5040 TPMFinalLog=0xf0ea9040
> > > > RTPROP=0xf0ea7040 SMBIOS=0xf0ea3000 TPMEventLog=0xeb3b3040
> > > > INITRD=0xeb3b2040 RNG=0xe5c0f040 MEMRESERVE=0xe5c0e040
> > > > 
> > > > Different boards use different TPM HW and drivers so compiling
> > > > all these in is possible but a bit ugly. systemd recently
> > > > gained support for a specific tpm2.target which makes TPM
> > > > support modular and also works with kernel modules for some TPM
> > > > use cases but not rootfs encryption.
> > > > 
> > > > In my test case we have a kernel+initramfs uki binary which is
> > > > loaded by EFI firmware as a secure boot binary. TPM support on
> > > > various boards is visible in devicetree but not as ACPI table
> > > > entries. systemd currently detect TPM2 support either via ACPI
> > > > table /sys/firmware/acpi/tables/TPM2 or TPM entry or via
> > > > firmware measurement via
> > > > /sys/kernel/security/tpm0/binary_bios_measurements
> > > > .
> > > 
> > > One corner case worth noting here is that scanning the device
> > > tree won't always work for non-ACPI systems... The reason is that
> > > a firmware TPM (running in OP-TEE) might or might not have a DT
> > > entry, since OP-TEE can discover the device dynamically and
> > > doesn't always rely on a DT entry.
> > > 
> > > I don't particularly love the idea that an EventLog existence
> > > automatically means a TPM will be there, but it seems that
> > > systemd already relies on that and it does solve the problem we
> > > have.
> > 
> > Well, quite. That's why the question I was interested in, perhaps
> > not asked as clearly as it could be is: since all the TPM devices
> > rely on discovery mechanisms like ACPI or DT or the like which are
> > ready quite early, should we simply be auto loading the TPM drivers
> > earlier?
> 
> This would be an elegant way to solve this and on top of that, we
> have a single discovery mechanism from userspace -- e.g ls /dev/tpmX.
> But to answer that we need more feedback from systemd. What 'earlier'
> means? Autload it from the kernel before we go into launching the
> initrd?

Right, so this is another timing problem: we can't autoload modules
*before* they appear in the filesystem and presumably they're on the
initrd, so auto loading must be post initrd mount (and init execution)
but otherwise quite early?

This might be quite a bit of work.  Logically, just moving the matching
and loading code earlier might work, but we used to have a
load_default_modules() at the end of init/main.c and it got removed
(because it only eventually loaded elevator modules) everything is now
loaded in it's various init routines, so to get, say, TPM ACPI modules
loaded earlier, we'd have to run the ACPI device matching code earlier
and so on for every other subsystem ...

James


