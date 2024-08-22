Return-Path: <linux-efi+bounces-1574-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 916F395B873
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 16:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16106B2A3E5
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 14:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0CB1CB333;
	Thu, 22 Aug 2024 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieUXMPKu"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC251CB135
	for <linux-efi@vger.kernel.org>; Thu, 22 Aug 2024 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336987; cv=none; b=Esyq1kjfXFsP80zuRYy9bYOnjXzCsAjS9Z7DQGGcZyJe7SMF9TRYpcrMlhmUSR1lGfkd2n6bqOka2MHTQpLOj2aWDlixycfxer+sZdWkDMW9fVGnJuKweUkvwq//U5fBwjFPRYHOOxXq9cz+VSB2jhtRaDBwkyfHtGsR1TwlCuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336987; c=relaxed/simple;
	bh=4hgjKSXqmD4wuXTEVqitwJr2+8LzfnOsifWBPu0BPjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNkgxEOmNA2g0POWEyBuO8uhoJWCkavbfwoukozIF6PyHb3vQaAa0CHeMyF7HRB+Hzg3O9RWuswIGeGioEi1vTt7dCE4+fEFnZqNwCkux+7ukhdGTas5n0/AbVLn9I7G9O2HJtFncQvvW/5ORtzXoM9MDd9nNVQHMjEtpZNfF64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieUXMPKu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724336984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/6AxOb6WsbLr7G2jGoOD1ehnx93Ji/pJCnzGUX2sbo=;
	b=ieUXMPKudHQJwcGfxF4bEEoq0HLjaseBjTYWF84/a0S7a0Gvxma/JUZkkPhHpqnHn96WhP
	1IXr3J6Qq18aO2Z6iONCskNPT4S5/kJmqQyVEd4FzC6HZRADVXthtlhgx4XJ8I/vo7gvV6
	B9GN+UIO9x7y21SZjNSHAGFNMhuYeC8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-ftONQUUdNdWtFp1vOfs18A-1; Thu, 22 Aug 2024 10:29:43 -0400
X-MC-Unique: ftONQUUdNdWtFp1vOfs18A-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5dc9ed1d3baso981442eaf.0
        for <linux-efi@vger.kernel.org>; Thu, 22 Aug 2024 07:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724336983; x=1724941783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/6AxOb6WsbLr7G2jGoOD1ehnx93Ji/pJCnzGUX2sbo=;
        b=iu2J1A4TZQBDXJSluzrf/4Z5Ugi8m8Eq+kH7Wjh12g1LMbjfnDjlw4+D3OlO0gYMh3
         XeiwB4yTTUIR6VBXSCtQiE02uazX5ffIY/IcGC/cuts+a0ULHlbrwXVj9cN6605qVVHN
         +sqUpzDAPX/BeMc+p7GQ6clcmoAqkZlS/C/1sQFPmge/27XvKhuug/pW+w1YYDR3SEEk
         +FuCvxgnGJaoAai8HNLxqWEYuhGkZZdEx1+GVYKmxV+bXd9cH1D74YfKVe3LIvOfTcdP
         rRPAPbCfYQvEi5U/9cHuYq2yr/CIH2lwBLFkQy9QEOmFImrS1Tbq7AeXDTsek1z7C1iO
         /GoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ2V8Lx9yxPUtkolrNRjikSQiRQoSD90jtFrZw4y4aPIL66vvOGsmGUEOuYB2E9Ha1VIxR2GMCbwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMrHKzT2yKt/dhpE9CidHF2Lu9COsFXxqdmzXPUB/WlAyRrsP1
	Eg13pf8DxE7eE5Wp7V/sPGBTBJZol6uwEJHZbWh6NDe3yZ2hEL6nP1cOjsWN9OJLaEdD8Dbn17J
	k8/TTRSoDXT5osSMiPs9VpNPFzH7JCIxhj+v3nEFqh524uH8yCdLINNMJXulOVHC8xM/0qQXk/Z
	EfgdBFGJ9ITZlFNa1X813qbOvRQ/glJ2Be
X-Received: by 2002:a05:6358:980d:b0:1b5:a037:f238 with SMTP id e5c5f4694b2df-1b5a037f311mr612518155d.0.1724336982765;
        Thu, 22 Aug 2024 07:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+brQfGyYU0BpsvYX3In5ntxKlxV2usDwSemakngx24acx/det+Wm07KEOH4KNbGPDEw/r7dG0Fhsa3BZCjPg=
X-Received: by 2002:a05:6358:980d:b0:1b5:a037:f238 with SMTP id
 e5c5f4694b2df-1b5a037f311mr612515255d.0.1724336982430; Thu, 22 Aug 2024
 07:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com> <Zsb1isJ2cYRp2jpj@gardel-login>
In-Reply-To: <Zsb1isJ2cYRp2jpj@gardel-login>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 22 Aug 2024 22:29:31 +0800
Message-ID: <CAF+s44SQtRxZz=2eSJ-xP44ORLqvq0doEQ8qrw+1RaKFhoje8w@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 4:23=E2=80=AFPM Lennart Poettering <mzxreary@0point=
er.de> wrote:
>
> On Do, 22.08.24 13:42, Pingfan Liu (piliu@redhat.com) wrote:
>
>  > On Wed, Aug 21, 2024 at 10:27=E2=80=AFPM Lennart Poettering
> > <mzxreary@0pointer.de> wrote:
> > >
> > > On Mo, 19.08.24 22:53, Pingfan Liu (piliu@redhat.com) wrote:
> > >
> > > > *** Background ***
> > > >
> > > > As more PE format kernel images are introduced, it post challenge t=
o kexec to
> > > > cope with the new format.
> > > >
> > > > In my attempt to add support for arm64 zboot image in the kernel [1=
],
> > > > Ard suggested using an emulator to tackle this issue.  Last year, w=
hen
> > > > Jan tried to introduce UKI support in the kernel [2], Ard mentioned=
 the
> > > > emulator approach again [3]
> > >
> > > Hmm, systemd's systemd-stub code tries to load certain "side-car"
> > > files placed next to the UKI, via the UEFI file system APIs. What's
> > > your intention with the UEFI emulator regarding that? The sidecars ar=
e
> > > somewhat important, because that's how we parameterize otherwise
> > > strictly sealed, immutable UKIs.
> > >
> > IIUC, you are referring to UKI addons.
>
> Yeah, UKI addons, as well as credential files, and sysext/confext
> DDIs.
>
> The addons are the most interesting btw, because we load them into
> memory as PE files, and ask the UEFI to authenticate them.
>
> > > Hence, what's the story there? implement some form of fs driver (for
> > > what fs precisely?) in the emulator too?
> > >
> > As for addon, that is a missing part in this series. I have overlooked
> > this issue. Originally, I thought that there was no need to implement
> > a disk driver and vfat file system, just preload them into memory, and
> > finally present them through the uefi API. I will take a closer look
> > at it and chew on it.
>
> It doesn't have to be VFAT btw. It just has to be something. For
> example, it might suffice to take these files, pack them up as cpio or
> so and pass them along with the UEFI execution. The UEFI emulator
> would then have to expose them as a file system then.
>
> We are not talking of a bazillion of files here, it's mostly a
> smallish number of sidecar files I'd expect.
>
> > > And regarding tpm? tpms require drivers and i guess at the moment uef=
i
> > > emulator would run those aren't available anymore? but we really
> > > should do a separator measurement then. (also there needs to be some
> > > way to pass over measurement log of that measurement?)
> >
> > It is a pity that it is a common issue persistent with kexec-reboot
> > kernel nowadays.
> > I am not familiar with TPM and have no clear idea for the time being.
> > (emulating Platform Configuration Registers ?).  But since this
> > emulator is held inside a linux kernel image, and the UKI's signature
> > is checked during kexec_file_load. All of them are safe from
> > modification, this security is not an urgent issue.
>
> Hmm, I'd really think about this with some priority. The measurement
> stuff should not be an afterthought, it typically has major
> implications on how you design your transitions, because measurements
> of some component always need to happen *before* you pass control to
> it, otherwise they are pointless.
>

At present, my emulator returns false to is_efi_secure_boot(), so
systemd-stub does not care about the measurement, and moves on.

Could you enlighten me about how systemd utilizes the measurement? I
grepped 'TPM2_PCR_KERNEL_CONFIG', and saw the systemd-stub asks to
extend PCR. But where is the value checked? I guess the systemd will
hang if the check fails.

Thanks,

Pingfan


