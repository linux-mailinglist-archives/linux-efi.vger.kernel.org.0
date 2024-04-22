Return-Path: <linux-efi+bounces-951-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F2B8ACED1
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 15:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1151F22117
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86551150987;
	Mon, 22 Apr 2024 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q7w4Ko1U"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BDC14F124
	for <linux-efi@vger.kernel.org>; Mon, 22 Apr 2024 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713794107; cv=none; b=CaW+MtS84AED10vNT028zWWeBYOAFsAudhE6dgmJaHl6sB71F9B4u+4dwKP280QUtmGaWzTuOeN/T1q+/8ZIrN76obkGkP7Jwu7VY8g8nO5NAbotOOz928abkJsITfWLmLSr+vx7hg3VQX01z2PhnXDhWq9LkQoPgn4MNRRz8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713794107; c=relaxed/simple;
	bh=qdxEzvr6nvLKZQIAmlq3J0QgmLEaC1FRhBzYdR4eq8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYsrWet4+D2//JTW5X931iZBUwlAgA0WeVomBLQqcn3L4k5Qyw5cAkzQjYlEPg0wL0baCZ7/U18iJU3y94ip8PZvuaQHzBGeDlu7QVjTRaCCgWchjfCBbc+VWcB4QO+ozHrpiFkE+dF7YKaKas/PPCgB0IHE/8VEvXNgo3uD+gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q7w4Ko1U; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51abd9fcbf6so5553653e87.1
        for <linux-efi@vger.kernel.org>; Mon, 22 Apr 2024 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713794104; x=1714398904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2wUr8A6N46atUY/DKzgo42AitBlyVp1xej9/CqcLFTk=;
        b=Q7w4Ko1U7CqmIN6Rew/VcwKD6Cmk4JdYB0kzU/jGZ10TjYAyxkhAa1H5+SjCL/cP5G
         /st1GOrKn2TOA+dUBEGQHS46PvkcuoBzLspLzv8OANBb3+i71ijtGDD4GtiD7vO0qA+o
         fIvIGXwW0ewNUoEXLSXOZPv36EswcwguK7X469yBqVv9qks0sVatAdRaGMuqA5oMN+YL
         FEmPgsYrJKRqKgEiIBJG8nlPtn1pJzeNo4vismhpx7lIPRS2h9kk6W2kJokEar4t9gtU
         L1/x4krqYsDO5W5N2otsvEoWfVctIajXWN52+YopV0kHMON4EzZobb8kgAi/TvC1t+8Y
         Jh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713794104; x=1714398904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wUr8A6N46atUY/DKzgo42AitBlyVp1xej9/CqcLFTk=;
        b=Pw7uecfSmiRaDdRdwj4m3t0VKnwoT06J0oULcD5U1ww2mSKVZg5a+J4o9Syrnk72WK
         1ChagU3DrONbImlxxaxgvWF0pcT+OcynJPARUe2WPxRS81eyw+V4Wvks0BFQkJ1+nr+e
         mKVFRNlQ2Ip0rbn0bqJLPaHMY3kIAni/nrWS7KGd10BqD4e5PWVrCetGhu7K8RkF/BPY
         kXGDFTLm9tpU9COuxb94vNUeAgslEfjPkFvbBGcF0b5UI+xSyPKdMCbegacJB4/7l1+/
         832BueMly0y5rNZAq4rQLuCvqx8UMd5ySEhm+sWHrj7L4R0GvQQMSdbSV3L2AokyJHac
         LiPg==
X-Forwarded-Encrypted: i=1; AJvYcCV5iqkDgUidLZbefzC4oh8bCoJ2tON3tG0RG2j+6agoLCafXYPUzcCYceCWnMcSOWSyCk2OePlh46YRKzTarLqP6GI0kffTRLKX
X-Gm-Message-State: AOJu0YwL2vUMssKZfWRvohQB54LswCbI8wZhJS/eUWPYrizaQxGHR0KA
	080WvUAdwOfvHMzIa3Al6fSX8kAHVuzxk1lb9Wkqf68LTRyFumwvox2/vYW8zrxq0EuQi6mwlAU
	WO6tZDOY1Vt/QHUaoXIWKgHp7RcSr++L9kT719n0CMeTyURF0FGQ=
X-Google-Smtp-Source: AGHT+IElDtHA2WFmwHu4o3MV34ywEDMh9iovZJESp8B/R96ozaKKHeX6jEGVW4eSH8VBE8AYODi+pXPn/RdrqYaMbqU=
X-Received: by 2002:a05:6512:370f:b0:518:c8e1:478 with SMTP id
 z15-20020a056512370f00b00518c8e10478mr7686445lfr.58.1713794103828; Mon, 22
 Apr 2024 06:55:03 -0700 (PDT)
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
In-Reply-To: <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Apr 2024 16:54:26 +0300
Message-ID: <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lennart Poettering <lennart@poettering.net>, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi James

On Mon, 22 Apr 2024 at 16:38, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2024-04-22 at 16:32 +0300, Ilias Apalodimas wrote:
> > Hi all,
> >
> > On Mon, 22 Apr 2024 at 16:08, Mikko Rapeli <mikko.rapeli@linaro.org>
> > wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Apr 22, 2024 at 08:42:41AM -0400, James Bottomley wrote:
> > > > On Mon, 2024-04-22 at 14:27 +0300, Mikko Rapeli wrote:
> > > > > Userspace needs to know if TPM kernel drivers need to be loaded
> > > > > and related services started early in the boot if TPM device
> > > > > is used and available.
> > > >
> > > > This says what but not why.  We already have module autoloading
> > > > that works correctly for TPM devices, so why is this needed?
> > > >
> > > > We do have a chicken and egg problem with IMA in that the TPM
> > > > driver needs to be present *before* any filesystem, including the
> > > > one the TPM modules would be on, is mounted so executions can be
> > > > measured into IMA (meaning that if you use IMA the TPM drivers
> > > > must be built in) but this sounds to be something different.
> > > > However, because of the IMA problem, most distributions don't end
> > > > up compiling TPM drivers as modules anyway.
> > > >
> > > > Is what you want simply that tpm modules be loaded earlier?
> > >
> > > Yes, ealier is the problem. In my specific testing case the machine
> > > is qemu arm64 with swtpm with EFI firmware for secure boot and TPM
> > > support.
> > >
> > > Firmware uses TPM and does measurements and thus TPM event log is
> > > available on this machine and a bunch of other arm64 boards.
> > > Visible in early boot dmesg as TPMEventLog lines like:
> > >
> > > [    0.000000] efi: ESRT=0xf0ea5040 TPMFinalLog=0xf0ea9040
> > > RTPROP=0xf0ea7040 SMBIOS=0xf0ea3000 TPMEventLog=0xeb3b3040
> > > INITRD=0xeb3b2040 RNG=0xe5c0f040 MEMRESERVE=0xe5c0e040
> > >
> > > Different boards use different TPM HW and drivers so compiling all
> > > these in is possible but a bit ugly. systemd recently gained
> > > support for a specific tpm2.target which makes TPM support modular
> > > and also works with kernel modules for some TPM use cases but not
> > > rootfs encryption.
> > >
> > > In my test case we have a kernel+initramfs uki binary which is
> > > loaded by EFI firmware as a secure boot binary. TPM support on
> > > various boards is visible in devicetree but not as ACPI table
> > > entries. systemd currently detect TPM2 support either via ACPI
> > > table /sys/firmware/acpi/tables/TPM2 or TPM entry or via firmware
> > > measurement via /sys/kernel/security/tpm0/binary_bios_measurements
> > > .
> >
> > One corner case worth noting here is that scanning the device tree
> > won't always work for non-ACPI systems... The reason is that a
> > firmware TPM (running in OP-TEE) might or might not have a DT entry,
> > since OP-TEE can discover the device dynamically and doesn't always
> > rely on a DT entry.
> >
> > I don't particularly love the idea that an EventLog existence
> > automatically means a TPM will be there, but it seems that systemd
> > already relies on that and it does solve the problem we have.
>
> Well, quite. That's why the question I was interested in, perhaps not
> asked as clearly as it could be is: since all the TPM devices rely on
> discovery mechanisms like ACPI or DT or the like which are ready quite
> early, should we simply be auto loading the TPM drivers earlier?

This would be an elegant way to solve this and on top of that, we have
a single discovery mechanism from userspace -- e.g ls /dev/tpmX.
But to answer that we need more feedback from systemd. What 'earlier'
means? Autload it from the kernel before we go into launching the
initrd?

Thanks
/Ilias
> James
>

