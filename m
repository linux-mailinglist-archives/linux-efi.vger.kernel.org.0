Return-Path: <linux-efi+bounces-1565-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A3795AD4D
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 08:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FE5286328
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 06:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCA33D0D5;
	Thu, 22 Aug 2024 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XB7yHvAV"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2762D611
	for <linux-efi@vger.kernel.org>; Thu, 22 Aug 2024 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307406; cv=none; b=jCUovVy6Uk+Xi+kVaIA83CsATn5gVguoloV+2clyu9GbfqUK060d7ngDyGLKi0Mvp/6rsPcXKkL+rj7hiY/3nMhjDsha0IPugFfWZp/UgEZU5dM3XubD1aMAy4z0lVam3mHUko9qyCyqOoVBkcr3uct6gvaznRuUy7jiRFvJWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307406; c=relaxed/simple;
	bh=ZRtpR6qW3kByodhkp2S63DBeP13jYPrOQcX6IMWTzn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTPt5zGmQef13jIqFzSkVqxmilnZf61+NA/fsHBdoqorMjnhqt3RdV4bPObiPdcptvd3ca40Lv52gwCsCGjWzwFDcdg1nzsTs3UbfRd+GVj1KMvN3dcfkSX9bh1yyohCGr2s5oFglS15NbP3X0LoX/3PoJY9aUYtl9fgKw5J9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XB7yHvAV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724307403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSahsupX5qbmfW5OFxsv4IPaJH74ypJqJsCg65c2Ydw=;
	b=XB7yHvAViwB8KAiZtb2/9N+oJlDlZC6D7FFEnHhkCbUyHfgs1we+hHvtWJzc05vW/VJgo+
	PfLbOPBeiVmzOGiQIJqTgDbMEkbcSKIsiXGQkc/TmVp4qkPo4adbAYG1aC+3aVWBC2FXou
	hgTaPfFb0+bfb3AQZvCTzwuU0+pnFwI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-3Q4m3hzwOP-qkrhrSNs3Dw-1; Thu, 22 Aug 2024 02:16:42 -0400
X-MC-Unique: 3Q4m3hzwOP-qkrhrSNs3Dw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d4cef7aa7so5122125ab.0
        for <linux-efi@vger.kernel.org>; Wed, 21 Aug 2024 23:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724307401; x=1724912201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSahsupX5qbmfW5OFxsv4IPaJH74ypJqJsCg65c2Ydw=;
        b=osAwww+WjODn0NnjW5lxyQE9aAipTtdykVocsyMcud/cBsT7W3XIG5fSywlgm64iwF
         +ZAXsfaY2ZURl4my17CANH3Ta3v7vU7LyiXqnWvgjALTlD7OTQYzP9SK+lFxFZTy4WsG
         nWe9GtVL32BFnphwno9AAKiSS+6cnD/LVb1WvUotlPeOINFrk3TBMCKh+v2RSRswdzzN
         w1W6d8NMjv13PgJUqVnHogWKC1LNXIzjbfcR84q5jnhGuwi0HXBJwwlu2YvkYPM54FOT
         J+HrusxxnpG0gdiRfzt0iezHMoA5dIGwVlr98Bx1TO0DNLS0UEOaTi6X+uQeQieNm+CU
         wchQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzSESEgZaEOr0X91+Z8AZo/0hQ7YMTzBRb8l9AX19CXTHirvFTYk1B17GVdsiXqmr25unZ42hbhDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVlgJSeYQlzIJk6dLHTXGfu7+uGuCtl84fxCtqA6/Dv0N6JUN
	qEx435YU5DVGbN1Z2LBtuZavCvTlPSTM06U0LySbN9NmBp2BratjYnWKs8eOwxNc9PBthyTPfk2
	LVpTZNNwsLDKdYEu3Y0atPTTyRP9VkMczcUwkz6/99KNNAN1OKZ3uQrA4sL7yr6xOnN/2LNS4rq
	y3MOGBMwzQvW19U6MVh/SyvCr1k+Qd1qbT
X-Received: by 2002:a92:b745:0:b0:39b:3b8f:d181 with SMTP id e9e14a558f8ab-39d6c38a977mr47438665ab.16.1724307401350;
        Wed, 21 Aug 2024 23:16:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH45XUtslNPtqySBkEnjHv7Gr46zrLG1FE2KFfoX7jWbSc0uq7wXAjET+a9wR5jjhVYDVE5eNfqaZtKRehaTE8=
X-Received: by 2002:a92:b745:0:b0:39b:3b8f:d181 with SMTP id
 e9e14a558f8ab-39d6c38a977mr47438355ab.16.1724307400980; Wed, 21 Aug 2024
 23:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
In-Reply-To: <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 22 Aug 2024 14:16:52 +0800
Message-ID: <CALu+AoQRdxJUpNK_eCjKJ=ydRZ4av2S3xBaz3CYJZp12xqm=jQ@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Pingfan Liu <piliu@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Aug 2024 at 13:42, Pingfan Liu <piliu@redhat.com> wrote:
>
> On Wed, Aug 21, 2024 at 10:27=E2=80=AFPM Lennart Poettering
> <mzxreary@0pointer.de> wrote:
> >
> > On Mo, 19.08.24 22:53, Pingfan Liu (piliu@redhat.com) wrote:
> >
> > > *** Background ***
> > >
> > > As more PE format kernel images are introduced, it post challenge to =
kexec to
> > > cope with the new format.
> > >
> > > In my attempt to add support for arm64 zboot image in the kernel [1],
> > > Ard suggested using an emulator to tackle this issue.  Last year, whe=
n
> > > Jan tried to introduce UKI support in the kernel [2], Ard mentioned t=
he
> > > emulator approach again [3]
> >
> > Hmm, systemd's systemd-stub code tries to load certain "side-car"
> > files placed next to the UKI, via the UEFI file system APIs. What's
> > your intention with the UEFI emulator regarding that? The sidecars are
> > somewhat important, because that's how we parameterize otherwise
> > strictly sealed, immutable UKIs.
> >
> IIUC, you are referring to UKI addons.
>
> > Hence, what's the story there? implement some form of fs driver (for
> > what fs precisely?) in the emulator too?
> >
> As for addon, that is a missing part in this series. I have overlooked
> this issue. Originally, I thought that there was no need to implement
> a disk driver and vfat file system, just preload them into memory, and
> finally present them through the uefi API. I will take a closer look
> at it and chew on it.
>

Hi Pingfan,

If more and more stuff needs coming in,  not only the limited boot
services then it will be way too complicated and hard to maintain and
debug,  also the two kexec code paths are duplicated somehow. It is
really bad..

I forgot why we can not just extract the kernel from UKI and then load
it directly,  if the embedded kernel is also signed it should be good?

Thanks
Dave


