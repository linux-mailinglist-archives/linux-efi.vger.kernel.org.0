Return-Path: <linux-efi+bounces-2641-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A24F6A12717
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 16:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A467A1CF9
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 15:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7F2149C7A;
	Wed, 15 Jan 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYOTg+5x"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9586814900B;
	Wed, 15 Jan 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954290; cv=none; b=sZy24erZ3EJF1i2Xf8JkkGF5PODyimZfbKWRTORo9n+Asg/AzX2q6SZSIFjrwFBZEVPVceezb5iPpfBOf1NIoaT2hjFNm34FCaGFiN+FRNtth941cjTXvOTouKbzYVLiNOP8ikisNOjP7B4oYdYeJxTnfocu7eVWIVOmzQdusOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954290; c=relaxed/simple;
	bh=ZO7/bsuk2L2kiKgFOGsFYD/hBqhJuArtrHK80zV/iiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQhFikxzy0a6E/6Bm0quwShcRSPVJn8RFALtkjYmk1xQLuHByXj+NaFieWF+ynYLNuilul+kXKq9IM4ZmuoveuVrGnQo1j3PkTjx0RNlkKDS5XJ88UzgTgoacj3nxXQ2I3K3Ll6UV6GhSVZ0fkzByPT1VrxwDeerbr/pbFpxbN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYOTg+5x; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so11772353a12.2;
        Wed, 15 Jan 2025 07:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736954287; x=1737559087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzKzBRhSNC1e6oktcNMxQLLw675AJpghbkjtUWnn7dw=;
        b=QYOTg+5xYnWmyO2eGbs/WgiW7c/DO7XA1oM7P4SdlwLCcmxgh671VHpt4/nr1U3XXM
         1o4c2FuZ6AjVMuYSQd0jtIUvhKnJfDOtYwo3qrZSK8Zs8hmYfAxgk7hVoeTZclQXabIo
         Ta/gH9Ibu+xqMSin31Jc0x1epAjO8ecTglCYOPh3gZPyPSIyTDEuBGYtCUjijeFZBN1z
         aEOc/HXfg0Bne4jVLzb2nmdnXPf3ZXSWDLm+QHe8jOjR4gv/03tl1erN8t9/bPEfnOEf
         Xkx1eNq/9bt3qvClUd/0hc7Vug3Z/sjhjVybSOjfb48W5Ww4NWLrEDylTPl098yRmYhF
         YWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736954287; x=1737559087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzKzBRhSNC1e6oktcNMxQLLw675AJpghbkjtUWnn7dw=;
        b=JYl0FZjKt2oRqZOqInEEQQ4Hx6MDMaKHxUNg+Z5dUFlelJ+C+M/+sYwI3OvYESCqTm
         x4KiyS4f5EB0FvJI5ct47HiCRjADZT9bZ+JQNr6Z7zRVYZ8wAaYjWjoA8dornAn/Vb+G
         IQqmwUETxBME4YcjVpUycjy4KaztqaQAPXTdIz4l6cmeRpevGtmkxZq6hvTxhMGA3jVx
         1+1yvFAKGigmG+0dLLTLyFkaTSu9iQcInaD1AGrkal54Yhd0oMcnmd8H92DAcbBeK9qo
         QrHYG5DlE1B+zCuW5fuaJSYpP9tAHsVPPn/BPaK8yxjAp8xLUB0SU7d4yd5qundl4qxM
         wDPg==
X-Forwarded-Encrypted: i=1; AJvYcCVkFagjz5Rab1riV30Mg/AGEwmAnHM8/MRWRWrCEBuZc4OWKPVEzo2vwgnYpnYqRC4GU6mizm8LkcE4@vger.kernel.org, AJvYcCWLkNMsPVvu244Iz/I/YR+qJNRUH6AvUQSz+7Lw1/dlu1MlaCPqgUx4hZ0ZsLbqe5y4RTCYB0kz8ac=@vger.kernel.org, AJvYcCXXj5w0v7CJhwuWsx98ZX6kxXNJfxP5BEKx1SWyJkzMWruQ1W1MZyz3qTm5/HcTc3Me5TdwQ0t6+f/tYH4z@vger.kernel.org
X-Gm-Message-State: AOJu0YzyMOt1y41GpKg9iOf+D30lRoyTH9QVtVYxpszXQ3pMJfYBHPIt
	uSZ1lvwKSwGyyHlzY6V121D6MkdYMJKp8xm4VFFqkEwICM08DjXcofRbwl3rbj00ziLlw0Bl5xa
	MIMaNwH2nobMobOT+mRuNoBR6fJ4=
X-Gm-Gg: ASbGnctpsbnzmdVdO9SEFjprf4tmUJ6YUS+E4IwYJH+gf29NqyhHez77nYBytYwieib
	2Ey48+cAY46eT7A+ENrrMFAXAkyrTtlnfXOQFag==
X-Google-Smtp-Source: AGHT+IGynUaPOnmHBFsETM9XG5VrVgoqmHKFJObZ58v0SipLeL/0H7XaMn4e6vcz8Eq0F2eGzbotc0zTrryXwYYKvzU=
X-Received: by 2002:a05:6402:430c:b0:5d3:e45d:ba7c with SMTP id
 4fb4d7f45d1cf-5d972e7148bmr26613189a12.29.1736954286264; Wed, 15 Jan 2025
 07:18:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115141458.9182-1-o451686892@gmail.com> <28105c4069a81c017b501551df7aa67aba743241.camel@HansenPartnership.com>
 <CAHk0HovnRgxrKu0uoj1x3XSB1vrTaGtMn-7iaoSR5Fs+=EYd5g@mail.gmail.com>
 <ff67e26af366013478b0acab5e9ddd49316c605d.camel@HansenPartnership.com> <CAMj1kXFKHe3dD1YJXODnNP9UG-5Y1r+JVvicEpNs2M0O6XPLvw@mail.gmail.com>
In-Reply-To: <CAMj1kXFKHe3dD1YJXODnNP9UG-5Y1r+JVvicEpNs2M0O6XPLvw@mail.gmail.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Wed, 15 Jan 2025 23:17:54 +0800
X-Gm-Features: AbW1kvYnYOY5dLMtvY8VJyZWbzfmOgcILTWLevC7_9WW9hJ78EZBDe2a0SYc8vU
Message-ID: <CAHk0Hov3nOS4HJGOeYxvTnn5--=E00YihpS7T3i5Lv8Y9OHuxA@mail.gmail.com>
Subject: Re: [RFC PATCH] efivarfs: Introduce efivarfs refresh remount
To: Ard Biesheuvel <ardb@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jeremy Kerr <jk@ozlabs.org>, Tim Schumacher <timschumi@gmx.de>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 11:00=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Wed, 15 Jan 2025 at 15:58, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > On Wed, 2025-01-15 at 22:49 +0800, Weizhao Ouyang wrote:
> > > On Wed, Jan 15, 2025 at 10:34=E2=80=AFPM James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > >
> > > > On Wed, 2025-01-15 at 22:14 +0800, Weizhao Ouyang wrote:
> > > > > Currently, when setting efi variables through the runtime
> > > > > service, efivarfs cannot sync variable updates properly.
> > > > > Introduce efivarfs refresh remount to support efivarfs
> > > > > information updates from other sources.
> > > >
> > > > What other sources could there possibly be?  While the Linux kernel
> > > > has sole possession of the EFI RT interface after ExitBootServices
> > > > has been called, nothing else should be able to update the
> > > > variables except efivarfs.  This is a guarantee from UEFI so why do
> > > > you think we can't rely on it?
> > >
> > > One route that may exist is: drivers/firmware/efi/test/efi_test.c
> > > holds some ioctls to call runtime service.
> >
> > That's not supposed to be used for anything other than direct testing
> > using the firmware test suite, which shouldn't impact production use of
> > efivarfs because it's defined to be N in Kconfig.   However, if we
> > suddenly decided there was a use case for production systems running
> > the test suite, the way forwards would be a notifier that tells
> > efivarfs about successful updates to variables as they occur without
> > having to remount.
> >
>
> I'd argue that running efi_test while efivarfs is mounted renders your
> test results useless, and so there is no need to make them play nicely
> together.

Emm, yeah, so far this leans more towards a hacking scenario than a
production scenario.

BR,
Weizhao

