Return-Path: <linux-efi+bounces-1690-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D834972B3F
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 09:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253CF1F24EB0
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 07:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C89E17F4F1;
	Tue, 10 Sep 2024 07:55:03 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF51514DA;
	Tue, 10 Sep 2024 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954903; cv=none; b=Bq5Gke+diCcM/O/kOcGONPbRxN9iFGyYlPivjy+gTaq0gbWOrKwFI6lh97xzlMKIFLX2s82+DekyaM7CpyFMntawBwU+2qtIxd5y2BA9W9dnDEXuirgycrDiktWk+6PviUMcqheV9ypSTICZRN0GUQD1ej/QlPn4arDXodlUZy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954903; c=relaxed/simple;
	bh=dAqbUvE34+3cz9SUYngGdTclZEmS/HeIqrBNZXoOcC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTIHtJKXVnMolc1ETrb4zzZstYtW3DjFZs+6JiE/ckBA9Bo4jBMat052/cwZaomBRSsVvDOV1G0/9MPk07i/7uuh7pXLSQKDLK8eydEGf9MT+QETC8Qsqjd4QMRmNpqHyoVOPIaPwlwRAO5zYahUWLoHYSkTIwGXDe2jPoh6vpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 9711EE80261;
	Tue, 10 Sep 2024 09:54:57 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id D3D26160143; Tue, 10 Sep 2024 09:54:56 +0200 (CEST)
Date: Tue, 10 Sep 2024 09:54:56 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Philipp Rudo <prudo@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	Pingfan Liu <piliu@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <Zt_7UEdDfTAQKp4I@gardel-login>
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
 <Zt7EbvWjF9WPCYfn@gardel-login>
 <Zt7RJepoCiCMRZSu@archlinux>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zt7RJepoCiCMRZSu@archlinux>

On Mo, 09.09.24 12:42, Jan Hendrik Farr (kernel@jfarr.cc) wrote:

> On 09 11:48:30, Lennart Poettering wrote:
> > On Fr, 06.09.24 12:54, Philipp Rudo (prudo@redhat.com) wrote:
> >
> > > I mostly agree on what you have wrote. But I see a big problem in
> > > running the EFI emulator in user space when it comes to secure boot.
> > > The chain of trust ends in the kernel. So it's the kernel that needs to
> > > verify that the image to be loaded can be trusted. But when the EFI
> > > runtime is in user space the kernel simply cannot do that. Which means,
> > > if we want to go this way, we would need to extend the chain of trust
> > > to user space. Which will be a whole bucket of worms, not just a
> > > can.
> >
> > May it would be nice to have a way to "zap" userspace away, i.e. allow
> > the kernel to get rid of all processes in some way, reliable. And then
> > simply start a new userspace, from a trusted definition. Or in other
> > words: if you don't want to trust the usual userspace, then let's
> > maybe just terminate it, and create it anew, with a clean, pristine
> > definition the old userspace cannot get access to.
>
> Well, this is an interesting idea!
>
> However, I'm sceptical if this could be done in a secure way. How do we
> ensure that nothing the old userspace did with the various interfaces to
> the kernel has no impact on the new userspace? Maybe others can chime in
> on this? Does kernel_lockdown give more guarantees related to this?

Yeah, it's not a trivial thing. I.e. I guess things like sysfs and
procfs will retain ownership/access mode. sysctls and sysfs attrs are
going to retain their most recently written contents and things like
that. Synthetic network interfaces, DM devices, loopback devices all
would survive this.

So, no idea how realistic this is, but I would *love* it, not only for
this purpose here, but also for the "soft-reboot" logic we have in
system these days, which shuts down userspace and starts it up again,
as a form of super-fast reboot that doesn't replace the kernel. If we
could reliably reset sysfs/sysctl/procfs/… during this, this would be
really lovely.

Lennart

--
Lennart Poettering, Berlin

