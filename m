Return-Path: <linux-efi+bounces-1572-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A01995B453
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3521C20B46
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 11:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3E81C93D3;
	Thu, 22 Aug 2024 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsHPa6S5"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD38B1C9424
	for <linux-efi@vger.kernel.org>; Thu, 22 Aug 2024 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327648; cv=none; b=QzI81bvDXwQMlHLLnGoQhhPjVCaQdgWDxtZdFL12ZcQHbcO9dtbpGYGLHBQL0yoXPq6/3hv+od7ug0SkG8vJf0/uWEWJXBpBxryR0plqzBBWEZE+JibefemQ5eY9BBK1bzIxlnrM06GR3fWdxFDOKO4oH1KxKZPdyRgxwxf3WRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327648; c=relaxed/simple;
	bh=bCsjWfU3Z+IEcntCdlQgEOKdsdOmymVV8n+g3Sl2EEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEy3Go3IapC0/Jtqe8ZbfsP7d6To9mnp/iVbXX37JPJdBHd7Xdlt3KBzXM+0kpOEYfHajn6sKPO0ILoG79u6O7u9Fep2mwlr9jdx9t/m/DMPFtvhzcGTl763HnKE1LtVcXdicU1kKMFHjD8geulRmP023bcAQTOyzbKmaETGCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsHPa6S5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724327645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMkA4XTW/po1kh224V+jp2a5m/4eGmuH04I4L7heXb4=;
	b=EsHPa6S5QD8YpAPNQuG3OjiU6uI4WPYCg8DAbZPAc+45mrw9G5KAd574Yf/9sfrun0zopL
	0btVazm8XgHF1ANqMP29zoM7pT2jlJI122qHlizs6Q/pYyEPfkfgtnbIC/qaG47N7zBD6w
	zNKx0DuAtAgn2G8KjNiOmBrAjlxXAQI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-hjVI8cnLOXKZLXIKQ-QcEg-1; Thu, 22 Aug 2024 07:54:03 -0400
X-MC-Unique: hjVI8cnLOXKZLXIKQ-QcEg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-201fa330b9dso7184525ad.2
        for <linux-efi@vger.kernel.org>; Thu, 22 Aug 2024 04:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724327643; x=1724932443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMkA4XTW/po1kh224V+jp2a5m/4eGmuH04I4L7heXb4=;
        b=DTQnAr3D9bTkj35YtX3lEYc8E6iR4zw88lXbwWzwcqCA9NrQa6v74hfxKaenn7jm6P
         vLkAzT3AiQJum3Zuek50E1iJHI59b3uY8yQmXNxV243kACmAixk5vX1S86oGYPOaJed6
         Mku6X0l5HCmcCqDRt4mffwXmuD7G+8NVHukXr/jA8A7fevgF+Q9GidRBPYuDBwTrqf6C
         iw2ZEEHgLc2V0Y4RhheQxeFnaokcDJagfm++UMsoo725DvfQ7LCEGkH5AdDdbBqtuAxM
         5y3YFswHY2/LV5ic1qXJEvvdl1mJWZOZY6QLpcexbZs9bgkMjGKDKlDrTqtqVBAPNGHz
         2AIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrsoMQBvtOkDGKEe6lC/n1WwMcT+hwond/rUhdhfTqyMJoqDI8be+8XN2ju1intINtPVaFwj4dZ44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5J0WUkisVt+86qvaWXIyCmwhSDtZWMiUv9InCuUOTFSKcEEBn
	oo7tgvA9SrH1JWQvSLfFxr3r+mjZagh2VWJvARO0oRwEy2OCRroz6O3zJ6qn9x1JJMSFX7n9o80
	SbqFfXxBgatA9pTYcbG/fdZYWBdp/Y6hMUWpB5vWCLhaa7EwgayczF/kY6p8CODbqKdgNearZcD
	EyMb1mB+JDDFyJwhlY/t04Mw32QpaBVR8b
X-Received: by 2002:a17:902:e884:b0:202:4666:f02a with SMTP id d9443c01a7336-20388b3c2b1mr15102825ad.43.1724327642737;
        Thu, 22 Aug 2024 04:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqIxoPVl/clLryQj7xWyVLRy3Hsg4AUrm+9Ysi+nMqgTtlGHdBJiaIQ4nEYKjGb/jdpxZULpzyBvbnFMX5EiY=
X-Received: by 2002:a17:902:e884:b0:202:4666:f02a with SMTP id
 d9443c01a7336-20388b3c2b1mr15102615ad.43.1724327642165; Thu, 22 Aug 2024
 04:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <CALu+AoQRdxJUpNK_eCjKJ=ydRZ4av2S3xBaz3CYJZp12xqm=jQ@mail.gmail.com> <CAF+s44TCvG3knnqyRbw=reaCRfh0_J76HO=ykF+J=ZFyoYZOCA@mail.gmail.com>
In-Reply-To: <CAF+s44TCvG3knnqyRbw=reaCRfh0_J76HO=ykF+J=ZFyoYZOCA@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 22 Aug 2024 19:54:12 +0800
Message-ID: <CALu+AoRMFRjnp5CB1zyCrEePmqbwoWjpABNmfxRrJA8b9nv9qA@mail.gmail.com>
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

On Thu, 22 Aug 2024 at 18:51, Pingfan Liu <piliu@redhat.com> wrote:
>
> On Thu, Aug 22, 2024 at 2:17=E2=80=AFPM Dave Young <dyoung@redhat.com> wr=
ote:
> >
> > On Thu, 22 Aug 2024 at 13:42, Pingfan Liu <piliu@redhat.com> wrote:
> > >
> > > On Wed, Aug 21, 2024 at 10:27=E2=80=AFPM Lennart Poettering
> > > <mzxreary@0pointer.de> wrote:
> > > >
> > > > On Mo, 19.08.24 22:53, Pingfan Liu (piliu@redhat.com) wrote:
> > > >
> > > > > *** Background ***
> > > > >
> > > > > As more PE format kernel images are introduced, it post challenge=
 to kexec to
> > > > > cope with the new format.
> > > > >
> > > > > In my attempt to add support for arm64 zboot image in the kernel =
[1],
> > > > > Ard suggested using an emulator to tackle this issue.  Last year,=
 when
> > > > > Jan tried to introduce UKI support in the kernel [2], Ard mention=
ed the
> > > > > emulator approach again [3]
> > > >
> > > > Hmm, systemd's systemd-stub code tries to load certain "side-car"
> > > > files placed next to the UKI, via the UEFI file system APIs. What's
> > > > your intention with the UEFI emulator regarding that? The sidecars =
are
> > > > somewhat important, because that's how we parameterize otherwise
> > > > strictly sealed, immutable UKIs.
> > > >
> > > IIUC, you are referring to UKI addons.
> > >
> > > > Hence, what's the story there? implement some form of fs driver (fo=
r
> > > > what fs precisely?) in the emulator too?
> > > >
> > > As for addon, that is a missing part in this series. I have overlooke=
d
> > > this issue. Originally, I thought that there was no need to implement
> > > a disk driver and vfat file system, just preload them into memory, an=
d
> > > finally present them through the uefi API. I will take a closer look
> > > at it and chew on it.
> > >
> >
> > Hi Pingfan,
> >
> > If more and more stuff needs coming in,  not only the limited boot
> > services then it will be way too complicated and hard to maintain and
> > debug,  also the two kexec code paths are duplicated somehow. It is
> > really bad..
> >
> OK, I will try to keep things easier. And what do you mean about " two
> kexec code paths"?

I mean we have the EFI and non-EFI kexec implementation. Also for the
EFI kexec code for X86 there is something we passed from 1st kernel to
2nd kernel due to no EFI firmware phase, anyway this part can be
cleaned up if the emulator can be done gracefully.

>
> > I forgot why we can not just extract the kernel from UKI and then load
> > it directly,  if the embedded kernel is also signed it should be good?
> >
>
> I think the main concern is about the signature.

I thought for the minimum case of kdump, we may just live with kernel
signed only and leave the initrd/cmdline unsigned.   Anyway for kexec
reboot it is a problem.

>
> Thanks,
>
> Pingfan
>


