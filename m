Return-Path: <linux-efi+bounces-975-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2DB8B22EF
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 15:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6269E1C212D0
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868DC149C41;
	Thu, 25 Apr 2024 13:36:38 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD6F3717F;
	Thu, 25 Apr 2024 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714052198; cv=none; b=D7PSJj7UZfavbV3HyENWgHS74f1BQgmtPUc/OWPysKYTKVmt81t+7TqR/HHVt6pOpTWmHoYWQT+3Is+Rrp4vn6KWPXXNBsMP0llk7gXDf/FiSe9tF58WaEnIuBeXYlbflj6oNzxOSyIzf4nvbECElLb+UMe/iVLlRmxnHNl2Dns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714052198; c=relaxed/simple;
	bh=WIHy+O7SQ3pXn8pbT1UfZprqhJH5m5djH0Bwidq4l50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPWllPNRuNO6lBDuqu8hHzOMbUIHXkodDf4/F4g0ohK/7ObyV4fyIPW/zk5SnhcjsD2IqIl/sev1BN5oO0ztB5trCBybhdsWG84CeAvPneOKPqCrgnRL5YSxgDFEzCdygcmLXaFz5c8/NJak08Jj5WQDQoJLc8R6r9n4neVS9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 06EDAE80EF2;
	Thu, 25 Apr 2024 15:36:31 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 802E2160029; Thu, 25 Apr 2024 15:36:30 +0200 (CEST)
Date: Thu, 25 Apr 2024 15:36:30 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mikko Rapeli <mikko.rapeli@linaro.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
Message-ID: <ZipcXqpbEkwkXrMI@gardel-login>
References: <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
 <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
 <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
 <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com>
 <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com>
 <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com>
 <ZiopXE6-AucAB9NM@gardel-login>
 <CAMj1kXETZ3L2QEZjD8=zr9FY11FGkf5KktXoSixjpGxWS4h8sA@mail.gmail.com>
 <Zio6xeRbld_tzH0B@gardel-login>
 <CAC_iWjK7s9ERvNhf6-ER1epHa3j0bBmz0Jw4v_VBbE_kwMnG7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_iWjK7s9ERvNhf6-ER1epHa3j0bBmz0Jw4v_VBbE_kwMnG7g@mail.gmail.com>

On Do, 25.04.24 14:47, Ilias Apalodimas (ilias.apalodimas@linaro.org) wrote:

> > Yeah, the physical address is of no interest to us. We just need to
> > know the existance, and that independently of any actualy tpm device
> > having shown up. i.e. existance of
> > /sys/kernel/security/tpm0/binary_bios_measurements would be good
> > enough for is if it was available without "tpm0" actually being
> > around...
>
> IIRC 'binary_bios_measurements' is only created after the TPM drivers
> probe the device, so that wouldn't work.
> Ard is right though the TPMEventLog is an EFI stub construct, so
> exposing this is Linux-specific (and stub-specific).
> The TPMFinalLog OTOH is described by the TCG spec so exposing that
> even using the address address would work for systemd

Hmm, let me ask explicitly: is there any good reason for
'binary_bios_measurements' being tied to specific TPM devices? i mean
it just exposes some firmware-provided memory area, no?

So, if the answer to that question is "no", maybe we can just move the
file to some generic place that is not tied to "tpm0" being around,
and then make the current file a symlink to that new place for compat?

i.e. /sys/kernel/security/tpm0/binary_bios_measurements could be a
symlink to → /sys/kernel/security/binary_bios_measurements and the
latter could be something the kernel always exposes, before any tpm
drivers are loaded?

Lennart

--
Lennart Poettering, Berlin

