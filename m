Return-Path: <linux-efi+bounces-1044-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F2E8C7B27
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 19:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756701C2155B
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 17:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA6156661;
	Thu, 16 May 2024 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5EImDGb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E59C1553BD;
	Thu, 16 May 2024 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715880661; cv=none; b=F17XP6OXoR1lPAK/cNFvZdw5QabWrkApCrtNm6JBgexQs7rxamxOZ9u1uJHTNYQWF9CsLD4Q0QXAc60E81Px1MgwCqC3ir8N0o+uS7aHNCMxAueb2E60rohE5vo1YiPta9xlIjAQGVy6YaIwfreTvHOvmmXmQB2x4mlKx/aYRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715880661; c=relaxed/simple;
	bh=AzdaOrhGtep2kiJJKcuHoTinfqmwfr6/5CJDCo9riY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBzVMabozkfLhsvRw58ZLnaHnrtG+rqYzxjjEPAexaWwc+5hLc1yVj22HeJ8+EixUXa1ttImoY/pWyHy6kaavvCHpqtkXKUhCDxnI6OOgrmXQbwXfICC7epRpmoeAMu8ZLGpaGncbS1axMR5jjmZWVYSYhm2hCznfDLFiM3M/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5EImDGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66B6C113CC;
	Thu, 16 May 2024 17:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715880660;
	bh=AzdaOrhGtep2kiJJKcuHoTinfqmwfr6/5CJDCo9riY8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S5EImDGbO+wSPMgV91SqzCPyo8jC5cJS7Dg67yVG83Zg6Egrh+DePKJ8dVkw5pGHM
	 swsedIWMLMX0JXjjMpLyX9YidwdlVz6PCc26m/Fl4HsYKjN10H77FayTIm+ez/pNTk
	 1bBxT4HlzvptNcj1s7adQZFPgahiWm7w/HrfGWA5bF/6xnCek55xeqZ7BEFEXsfZLT
	 368ZoGbEonq9T/Ft5dRntO8fqKx3dx2BG6QwjfZk8KqHGdMr0t8TOb0yuYGl3fAJsc
	 340m/V0MZ4wtCllD/5dO/xSAd5X9i2eOUlmUgRLYtU0ayqnaw4lF9T10hIA2WLUjUT
	 BgV2N+Bh1l7pQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52192578b95so1325134e87.2;
        Thu, 16 May 2024 10:31:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxPFcZa4d9DdrOMr3kgwOSR2W+FaEHcUkI0oYsyNZzMhZUaqo+q4VAAxlABL3KPf50lveWqUFVJfYqsuA5Jghu68RKt91fGBIYYBghNU29Ozu7y5HNrh0Rcbw6K1gTX8rHuQmpoZ27C3S/QeQu3h2U3RcV/Pjsjx1ySyfkmO6M
X-Gm-Message-State: AOJu0YyufCdrk9vH4Q/IchPg9BvQyv8KHm4ifVwRGAnmVDZjDrxNAwvo
	zj/AyCd+xC5mjXXkib8mOads1v1+7bA8brusH0eIQOqhu5kln7xHPGhycr6icQotpcbZO/bLC4R
	XNCj1Ikjgad/uwDLmzw6g7g4ayjM=
X-Google-Smtp-Source: AGHT+IGz2QoIsDKre6EENPFRqf4/Pb2krkDKRrigOkWAH6mdXxplQWwG2Z5weUsJewdlutu18655swmaj7R/Guf9P/A=
X-Received: by 2002:a05:6512:3b20:b0:51d:2eba:614 with SMTP id
 2adb3069b0e04-5220fe7a025mr15549611e87.53.1715880659275; Thu, 16 May 2024
 10:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516090541.4164270-2-ardb+git@google.com> <FBF468D5-18D6-4D29-B6A2-83A0A1998A05@akamai.com>
In-Reply-To: <FBF468D5-18D6-4D29-B6A2-83A0A1998A05@akamai.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 16 May 2024 19:30:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG1TLKR1ukg7Vn3rgAC2opL1LN6EX9L9XVxZQ3s+6wuBQ@mail.gmail.com>
Message-ID: <CAMj1kXG1TLKR1ukg7Vn3rgAC2opL1LN6EX9L9XVxZQ3s+6wuBQ@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: Omit physical KASLR when memory reservations exist
To: "Chaney, Ben" <bchaney@akamai.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "keescook@chromium.org" <keescook@chromium.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 19:29, Chaney, Ben <bchaney@akamai.com> wrote:
>
> > +static efi_status_t parse_options(const char *cmdline)
> > +{
> > + static const char opts[][14] = {
> > + "mem=", "memmap=", "efi_fake_mem=", "hugepages="
> > + };
> > +
>
> I think we probably want to include both crashkernel and pstore as arguments that can disable this randomization.
>

The existing code in arch/x86/boot/compressed/kaslr.c currently does
not take these into account, as far as I can tell.

