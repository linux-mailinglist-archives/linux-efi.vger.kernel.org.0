Return-Path: <linux-efi+bounces-1468-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6869378AA
	for <lists+linux-efi@lfdr.de>; Fri, 19 Jul 2024 15:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCDF6B21BD4
	for <lists+linux-efi@lfdr.de>; Fri, 19 Jul 2024 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3455F12FB31;
	Fri, 19 Jul 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxFoH0TH"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706CD13F458
	for <linux-efi@vger.kernel.org>; Fri, 19 Jul 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721396591; cv=none; b=Wn8fLN8SnFXd2z+bqZNla0RG6E8CmXcWauhEhKpsQ+anWuxu9PwTiI1EmTa0LAe9KrY+LB2agFxyqnEekdAaQtC9iPi/NT7PTLpvjTorzV6uSCsp7FfWA+jZe+C8o0o3LtmDlXun9/t0UPK/D69qfTcYvMizj8Y/uVWdOZckNco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721396591; c=relaxed/simple;
	bh=e+1c/xVqdatYxFZJSe7yh2MvBPtbNt7X3EzWei/3p2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LM1W36VCyYlwlTMAkblM4jnLmwlZKFXsnfSEZlg9EpOPeUfceCuVcGDX2BADB6OtNz6+28eh+YNG9krU44GnTdnYe/FoAsdPJGFlpY3OwwYuZD7cY7i67sYs0XUkGj1EaktgmLXw/4OWQFAIifsEMBqVf4dC/mSq9Mgozcfxdik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxFoH0TH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721396588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IakiRcZ7C7l0Ak0AGxFsoFeCcbQD2eaZffNe6UfOOc=;
	b=cxFoH0TH0NXmeP/aZxJZQceC+XGQ/IQIx/6DHlnnyzZrtmEcP9Jd4GrTfwd84IW17+WYB1
	AiPag+NsTz+6+pxZhYphzLRVxh3PLnrqDBAknzFhBmP/NQyWy+m+0Qn6UgxMw0tJXBSiKT
	f8c0kX/LkdTgczpd7PXvEptscQPtUWc=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-kRyQqVlSONeUY-9-A54gwA-1; Fri, 19 Jul 2024 09:43:07 -0400
X-MC-Unique: kRyQqVlSONeUY-9-A54gwA-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5c41e975e5aso1435921eaf.0
        for <linux-efi@vger.kernel.org>; Fri, 19 Jul 2024 06:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721396586; x=1722001386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IakiRcZ7C7l0Ak0AGxFsoFeCcbQD2eaZffNe6UfOOc=;
        b=TZBExmdFLZh6kqswLdfvs6FW155B4xSYTjTt7LV/SzHqdxHm9p81fAuVz0SqonUCzm
         ldzxSEANNXAVVL5YcDZ5KBX1PqVADjQV4MdPWt0KUrgz5jxq7AfcgPpE2FEQZ543Btjt
         bjt+zplm4ZQUiYGIanFYOziH8EZ+bxIM5bw8KMWScQyLQ7b4nk538kGHkzY3heDP4jhv
         euQhSIGX8vVLDaPcFKKtBGV/4qXwlKHPmm3GsG4C1A8acAAgzhRHbnjZ21v7HoZbKC4u
         dEMvZYkc6XMMYOZTlFJbYj7pW5BzuX8U/a5WPqOYnm8Jor7g9wYFk3oxM1n2EYgAtkSt
         1csQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMm/Bp2Q93eAKT4Q4ot2fuGUTGVedhdzXiq17I42SkYesJ+1U4as+NixMu634GvM4Cgv5z8SYXxv5yITEgF40P8Z4VSFb8uNiZ
X-Gm-Message-State: AOJu0YxyhMr3iq0tcNtKNKVHNitaxQV8WDt6ia3yi3mRiqAQPlFyKCrQ
	Vy5x6/oDOfwBbalK/Qadqj8AXWC8vIdnDD3ToJ6Rp01z5pHaZkhzUsEV48UO97ruC+mAhVguldy
	darhO/Dz7vpAnpRsuZpy6/LDSj/N4tnTzw52fq17Ddg1Oti7hDSjCjopeu9klfGHQ1NmvtLCmXz
	1AsdRKG3TITan15LWagS2EWrS0i7Uo2c0rihT1NliXUsAc1g==
X-Received: by 2002:a4a:ee87:0:b0:5cc:a794:9ea7 with SMTP id 006d021491bc7-5d41cfc7af8mr9563040eaf.7.1721396586280;
        Fri, 19 Jul 2024 06:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5CqkuClfsIUT1cL15pknD6fqtWtDqVDGYIscNJYbIpCqatUxM/gflq7La1BcA7ccVV1q/Y6Yj31pzH0VYK40=
X-Received: by 2002:a4a:ee87:0:b0:5cc:a794:9ea7 with SMTP id
 006d021491bc7-5d41cfc7af8mr9563016eaf.7.1721396585951; Fri, 19 Jul 2024
 06:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718085759.13247-1-piliu@redhat.com> <20240718085759.13247-2-piliu@redhat.com>
 <8c82c558556750751780a9d2b3a50ca548f565e8.camel@kernel.org>
In-Reply-To: <8c82c558556750751780a9d2b3a50ca548f565e8.camel@kernel.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 19 Jul 2024 21:42:55 +0800
Message-ID: <CAF+s44Sbkbv9ivB0h+1_Xmd5O0bL3Hmsk1s4-PinELurNFb5Yw@mail.gmail.com>
Subject: Re: [RFC 1/7] efi/libstub: Ask efi_random_alloc() to skip unusable memory
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 1:20=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Thu, 2024-07-18 at 16:57 +0800, Pingfan Liu wrote:
> > efi_random_alloc() demands EFI_ALLOCATE_ADDRESS when allocate_pages(),
> > but the current implement can not ensure the selected target locates
> > inside free area, that is to exclude EFI_BOOT_SERVICES_*,
> > EFI_RUNTIME_SERVICES_* etc.
> >
> > Fix the issue by checking md->type.
> >
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Jan Hendrik Farr <kernel@jfarr.cc>
> > Cc: Philipp Rudo <prudo@redhat.com>
> > Cc: Lennart Poettering <mzxreary@0pointer.de>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > To: linux-arm-kernel@lists.infradead.org
> > To: kexec@lists.infradead.org
> > To: linux-efi@vger.kernel.org
>
> I'm on holiday up until end of next week so not going to go this trough
> right now but I have minor complain ;-)
>
> Please use:
>
>        --[no-]cc-cover
>            If this is set, emails found in Cc: headers in the first patch=
 of the series (typically
>            the cover letter) are added to the cc list for each email set.=
 Default is the value of
>            sendemail.ccCover configuration value; if that is unspecified,=
 default to --no-cc-cover.
>        [from "man git-send-email"]
>
> This will make the commits less bloated and makes sure that everyone you
> might want to CC will get always the same set of patches.
>
> I'd also recommend to pick only one list for to-field because there can
> be only one maintainer that in the end would take these patches. Change
> rest to cc's. Now the process of managing these patches is ambiguous by
> definition.
>

Sorry for the unnecessary noise, I will follow your suggestion in the
next round.

Thanks,

Pingfan

> BR, Jarkko
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


