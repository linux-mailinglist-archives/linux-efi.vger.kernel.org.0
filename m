Return-Path: <linux-efi+bounces-2640-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3CAA126BC
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 16:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95A11889C80
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ED47C6E6;
	Wed, 15 Jan 2025 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5erU9VW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6820326;
	Wed, 15 Jan 2025 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736953259; cv=none; b=d2jyIwdM16NGrW4xs/Vi8OTKQYYeU70zfiMVtn5t4EA64J7Q1bFw5bI5ES/BddZk5qveTtEBDHfqH+oO1b/GTZ6nUSEl949mPIjbfjUXiH3gHyPjTwADWXlN62VEiuLJ6zHHVHTkdsC5soSm5pX0PT56hMKdGC5vucocP0HCokU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736953259; c=relaxed/simple;
	bh=rzLuOaiPdwdS/rezaMyvLckjQ5Y+34rOUSRjZqaFy7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEF2v0+D4tumiOGfgCZSA+2aoU5lwUbi/X717+Ta0nkZ5rKb6taBdOGjtl8P1gbRVnVtTF57R+vgSxzAoP2t1Wnb80mnISCr89fNT3fG6UtiZGrvf7yE/9bXMItR0CIeNNuxgYGg0rWj93FPXLecIuTkigWbpCYZY4w61OipGWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5erU9VW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61B5C4CEE4;
	Wed, 15 Jan 2025 15:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736953258;
	bh=rzLuOaiPdwdS/rezaMyvLckjQ5Y+34rOUSRjZqaFy7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E5erU9VWbeWtO6f3l49+pUX6rsexNgFCgf9EaezGeTIjIJ/QpFMGGDEsMEA0X2fpe
	 YAHA/lQADFMilv/nNj4S/sI8jNnQxDJbgnY5ISaGwq5TFAb6qJTLpkCxMuq9DblXBk
	 PYAHqxBVpAF0CAj+2NWzxEc17vUFWTJAhuoh+sP7mV89GsSxTHA08VzqCpXykqXA+1
	 9qO2adg//jMlo6KtT37H4IKjqP58Z5AefvaAC7XZJ7Rgbbm7jFknnduEfME1QppLxX
	 xDAiFUpjn+5nqi4SbJlXVl258pcrrotx1yPkSff1h64hvEHuB+5SB7B4/mnK2iR48I
	 OTkLECeqaajXg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30229d5b229so60002721fa.0;
        Wed, 15 Jan 2025 07:00:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfjWtQJt+ZVX+EAJOQSaRlEzkf2V3JV4IxYvutrARf0mkSLsvXeXy1rYEy6aokywriDv2QmpXb3I71piwk@vger.kernel.org, AJvYcCXCy+Jdjkt7wfIvfzGwBJwlIbgJ22VuraIM3elreUH7S5Act1T5XiCobWtiiEpP43CHDh5FnITtFKHo@vger.kernel.org, AJvYcCXw6rhs7t3ndRryN2PKjECgG7BIIL/WrhIQGvf/IJwlEdnzxfc6036YqJdLg37YuZY8VFx4VdFZA+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/BOL89+q8l9zgjiKK9m1GoU7K2AJRv9YZYmVKtAS0NOEkrOL
	6pm1Q/1dEg1k68XnXSMdbaIKQTgmMn/zM4TphwGJCPKi5GCcTivCQm3anX2OcXX2Dc6vx6mvqff
	pNolsGPiEly3AbUNbAxb9FoMPBVM=
X-Google-Smtp-Source: AGHT+IH2bz7llVEkDMwu4ric1U+RvM4avJ1zOZWbVOqq5gDbbS/ffXHQt5BCuHRYE9kiVocPYTnrHTjaE2AqQHhgTOM=
X-Received: by 2002:a05:651c:2109:b0:300:3e1c:b8b1 with SMTP id
 38308e7fff4ca-305f45da72dmr130791451fa.18.1736953256465; Wed, 15 Jan 2025
 07:00:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115141458.9182-1-o451686892@gmail.com> <28105c4069a81c017b501551df7aa67aba743241.camel@HansenPartnership.com>
 <CAHk0HovnRgxrKu0uoj1x3XSB1vrTaGtMn-7iaoSR5Fs+=EYd5g@mail.gmail.com> <ff67e26af366013478b0acab5e9ddd49316c605d.camel@HansenPartnership.com>
In-Reply-To: <ff67e26af366013478b0acab5e9ddd49316c605d.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 15 Jan 2025 16:00:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFKHe3dD1YJXODnNP9UG-5Y1r+JVvicEpNs2M0O6XPLvw@mail.gmail.com>
X-Gm-Features: AbW1kvbxRwPMSr3sifbvC2blHsA2rrYKbBiwrDwL4OsFIbXGQ3DYiS1e6yMvkW4
Message-ID: <CAMj1kXFKHe3dD1YJXODnNP9UG-5Y1r+JVvicEpNs2M0O6XPLvw@mail.gmail.com>
Subject: Re: [RFC PATCH] efivarfs: Introduce efivarfs refresh remount
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Weizhao Ouyang <o451686892@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Jeremy Kerr <jk@ozlabs.org>, 
	Tim Schumacher <timschumi@gmx.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2025 at 15:58, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2025-01-15 at 22:49 +0800, Weizhao Ouyang wrote:
> > On Wed, Jan 15, 2025 at 10:34=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Wed, 2025-01-15 at 22:14 +0800, Weizhao Ouyang wrote:
> > > > Currently, when setting efi variables through the runtime
> > > > service, efivarfs cannot sync variable updates properly.
> > > > Introduce efivarfs refresh remount to support efivarfs
> > > > information updates from other sources.
> > >
> > > What other sources could there possibly be?  While the Linux kernel
> > > has sole possession of the EFI RT interface after ExitBootServices
> > > has been called, nothing else should be able to update the
> > > variables except efivarfs.  This is a guarantee from UEFI so why do
> > > you think we can't rely on it?
> >
> > One route that may exist is: drivers/firmware/efi/test/efi_test.c
> > holds some ioctls to call runtime service.
>
> That's not supposed to be used for anything other than direct testing
> using the firmware test suite, which shouldn't impact production use of
> efivarfs because it's defined to be N in Kconfig.   However, if we
> suddenly decided there was a use case for production systems running
> the test suite, the way forwards would be a notifier that tells
> efivarfs about successful updates to variables as they occur without
> having to remount.
>

I'd argue that running efi_test while efivarfs is mounted renders your
test results useless, and so there is no need to make them play nicely
together.

