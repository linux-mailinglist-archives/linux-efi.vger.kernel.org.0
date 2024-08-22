Return-Path: <linux-efi+bounces-1566-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275A995B01B
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 10:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACDF1F23222
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 08:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64D617A584;
	Thu, 22 Aug 2024 08:23:45 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF861386D8;
	Thu, 22 Aug 2024 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315025; cv=none; b=JYGKgzaRo19jHu3cTa7ecKbbSN2wYcm+/KF9nBPKNeepGzFkUB2s1HpvLiPbol9atedbwBpvAglCTDWnZFjcSnvR7wRsBOxfeYsYDWpSZu3fp3aC3D1wXJtFUgpdVAobpwZChJiXxf+JlOhkaob/0hm2o0e8sYRsOXHRTaESC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315025; c=relaxed/simple;
	bh=1vfKuGU1Tk3yURCXes4JiLOpHAiaAyEFf6vYbfrqXyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz0GMgaIo0DCBK1pOqNSH7rVVlIwLXR4NaIBg1tYqpvkjfAFJeiE1gHWN6BDoW2GpL4lICYPaykeOPhUi6rOKye9mISCV18H6BHUvhsMhWfzLCZyjEMniG38hUuSUYvS65bvUWamZwlfyiX4POoTuR9of8AmF5HF2hKm4aVhhUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 55409E80263;
	Thu, 22 Aug 2024 10:23:39 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id CBEC216008A; Thu, 22 Aug 2024 10:23:38 +0200 (CEST)
Date: Thu, 22 Aug 2024 10:23:38 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <Zsb1isJ2cYRp2jpj@gardel-login>
References: <20240819145417.23367-1-piliu@redhat.com>
 <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>

On Do, 22.08.24 13:42, Pingfan Liu (piliu@redhat.com) wrote:

 > On Wed, Aug 21, 2024 at 10:27 PM Lennart Poettering
> <mzxreary@0pointer.de> wrote:
> >
> > On Mo, 19.08.24 22:53, Pingfan Liu (piliu@redhat.com) wrote:
> >
> > > *** Background ***
> > >
> > > As more PE format kernel images are introduced, it post challenge to kexec to
> > > cope with the new format.
> > >
> > > In my attempt to add support for arm64 zboot image in the kernel [1],
> > > Ard suggested using an emulator to tackle this issue.  Last year, when
> > > Jan tried to introduce UKI support in the kernel [2], Ard mentioned the
> > > emulator approach again [3]
> >
> > Hmm, systemd's systemd-stub code tries to load certain "side-car"
> > files placed next to the UKI, via the UEFI file system APIs. What's
> > your intention with the UEFI emulator regarding that? The sidecars are
> > somewhat important, because that's how we parameterize otherwise
> > strictly sealed, immutable UKIs.
> >
> IIUC, you are referring to UKI addons.

Yeah, UKI addons, as well as credential files, and sysext/confext
DDIs.

The addons are the most interesting btw, because we load them into
memory as PE files, and ask the UEFI to authenticate them.

> > Hence, what's the story there? implement some form of fs driver (for
> > what fs precisely?) in the emulator too?
> >
> As for addon, that is a missing part in this series. I have overlooked
> this issue. Originally, I thought that there was no need to implement
> a disk driver and vfat file system, just preload them into memory, and
> finally present them through the uefi API. I will take a closer look
> at it and chew on it.

It doesn't have to be VFAT btw. It just has to be something. For
example, it might suffice to take these files, pack them up as cpio or
so and pass them along with the UEFI execution. The UEFI emulator
would then have to expose them as a file system then.

We are not talking of a bazillion of files here, it's mostly a
smallish number of sidecar files I'd expect.

> > And regarding tpm? tpms require drivers and i guess at the moment uefi
> > emulator would run those aren't available anymore? but we really
> > should do a separator measurement then. (also there needs to be some
> > way to pass over measurement log of that measurement?)
>
> It is a pity that it is a common issue persistent with kexec-reboot
> kernel nowadays.
> I am not familiar with TPM and have no clear idea for the time being.
> (emulating Platform Configuration Registers ?).  But since this
> emulator is held inside a linux kernel image, and the UKI's signature
> is checked during kexec_file_load. All of them are safe from
> modification, this security is not an urgent issue.

Hmm, I'd really think about this with some priority. The measurement
stuff should not be an afterthought, it typically has major
implications on how you design your transitions, because measurements
of some component always need to happen *before* you pass control to
it, otherwise they are pointless.

Lennart

--
Lennart Poettering, Berlin

