Return-Path: <linux-efi+bounces-978-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92CA8B231B
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 15:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13DFE1C21A71
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2454149C6E;
	Thu, 25 Apr 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="E0xL+gGF";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="FQSHp1K3"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274F149C4D;
	Thu, 25 Apr 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714052800; cv=none; b=rxXa9F9a29ahw3cV9fDfQtb8qXyEaz6kXYkaXcl31bbRZOcw9Ak4rSMaExVNn5HLvXGCS59oQ1Gy6zZ5YryYUEX98+b2tRmO9WRMtmqmPhlgup6BRozQp0ho3yV+wHgniOO6F46ora7QonoE4499ajRCfJ8Xq5pWmiV/Besop9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714052800; c=relaxed/simple;
	bh=WJfhuI9Tg/68isL1tB5Dw3Y6J43OLF5SHDXYgtY32lI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b2XjF04iv2ntp84oxbjsZRWSOppa/nbnknskj6IgPNuSM8A/CcwZX8Mqj8U8e6vSsRHM0sSPycYF/A2Pfw8mQha2fUgQq2A9EbcWf3b7GKmYe1A9m8JQs/3Zuq1trqFW2oukbBS1DtIcSLKrhckSzNxUyfKAaFKJpO765ssWxHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=E0xL+gGF; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=FQSHp1K3; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714052798;
	bh=WJfhuI9Tg/68isL1tB5Dw3Y6J43OLF5SHDXYgtY32lI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=E0xL+gGF+7r0OAPjdOhML3v32bp9TF90G6UOuTmZdHtISk3LItBLfjV7g/6h7OZX8
	 do3xpdW8d7cnnqNx5uAD7/6AimhrsqSrSfnZ4qlz8fh239xo9kbO9GroNebJFOBVhD
	 fVjKDZNgKmcX2/NEBnJ0JNJiOoauHnViqiMKLUq4=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3A120128136F;
	Thu, 25 Apr 2024 09:46:38 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id VMyDVF7ueARh; Thu, 25 Apr 2024 09:46:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714052797;
	bh=WJfhuI9Tg/68isL1tB5Dw3Y6J43OLF5SHDXYgtY32lI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=FQSHp1K3Jij9860mFInKdUB5DkFK69h8bmngIi/Htkr00/JA4t8AbzNnB/jf2nP3n
	 WCXsMRZLLh2EjE9Bl/stW5yPkWMCSno4kAA5s+tKG5bUnDQw1ViLQ5IlczBuqngrd+
	 CzIuOGTASWgfEnr8tuzkDqte/VBdJqRNdpN7NyuQ=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4CD1E1280D4C;
	Thu, 25 Apr 2024 09:46:37 -0400 (EDT)
Message-ID: <66f1d772de1df260a23d2e3c2240e064ee8f67d8.camel@HansenPartnership.com>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Lennart Poettering <mzxreary@0pointer.de>, Ilias Apalodimas
	 <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Mikko Rapeli
 <mikko.rapeli@linaro.org>,  linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-integrity@vger.kernel.org
Date: Thu, 25 Apr 2024 09:46:35 -0400
In-Reply-To: <ZipcXqpbEkwkXrMI@gardel-login>
References: 
	<CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
	 <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
	 <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
	 <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com>
	 <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com>
	 <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com>
	 <ZiopXE6-AucAB9NM@gardel-login>
	 <CAMj1kXETZ3L2QEZjD8=zr9FY11FGkf5KktXoSixjpGxWS4h8sA@mail.gmail.com>
	 <Zio6xeRbld_tzH0B@gardel-login>
	 <CAC_iWjK7s9ERvNhf6-ER1epHa3j0bBmz0Jw4v_VBbE_kwMnG7g@mail.gmail.com>
	 <ZipcXqpbEkwkXrMI@gardel-login>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-04-25 at 15:36 +0200, Lennart Poettering wrote:
> On Do, 25.04.24 14:47, Ilias Apalodimas (ilias.apalodimas@linaro.org)
> wrote:
> 
> > > Yeah, the physical address is of no interest to us. We just need
> > > to
> > > know the existance, and that independently of any actualy tpm
> > > device
> > > having shown up. i.e. existance of
> > > /sys/kernel/security/tpm0/binary_bios_measurements would be good
> > > enough for is if it was available without "tpm0" actually being
> > > around...
> > 
> > IIRC 'binary_bios_measurements' is only created after the TPM
> > drivers
> > probe the device, so that wouldn't work.
> > Ard is right though the TPMEventLog is an EFI stub construct, so
> > exposing this is Linux-specific (and stub-specific).
> > The TPMFinalLog OTOH is described by the TCG spec so exposing that
> > even using the address address would work for systemd
> 
> Hmm, let me ask explicitly: is there any good reason for
> 'binary_bios_measurements' being tied to specific TPM devices? i mean
> it just exposes some firmware-provided memory area, no?

Realistically, no.  The current mechanism for exposing it in securityfs
is tpm chip init, which means it can't appear before a TPM driver
attaches, but there's no real reason why that has to be so.

> So, if the answer to that question is "no", maybe we can just move
> the file to some generic place that is not tied to "tpm0" being
> around, and then make the current file a symlink to that new place
> for compat?

We could just keep it where it is.  I don't believe a log ever appears
at anything other than tpm0 because the event log securityfs attach is
triggered on first tpm appearance, which has to be 0.  So the name is
purely conventional and could be hard coded.  The eventlog code itself
is all linked to the actual chip device (including some of the checks
for event log type---we have to work with both 1.2 and 2.0), but it
should be possible to get the information another way.

James


> i.e. /sys/kernel/security/tpm0/binary_bios_measurements could be a
> symlink to → /sys/kernel/security/binary_bios_measurements and the
> latter could be something the kernel always exposes, before any tpm
> drivers are loaded?





