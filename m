Return-Path: <linux-efi+bounces-3199-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2019A7B945
	for <lists+linux-efi@lfdr.de>; Fri,  4 Apr 2025 10:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08461B60DA5
	for <lists+linux-efi@lfdr.de>; Fri,  4 Apr 2025 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801E21C6FF0;
	Fri,  4 Apr 2025 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfpneqG/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CBF1C6FE2;
	Fri,  4 Apr 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756411; cv=none; b=HlS9Ye9nyO6O0McGV1UN7fU0i4q+WRtUbMiJCO7SgZAGaFz2QXWgHmiIEOCRzpzM5sbgh1rYD0d58SaC05nPKJ9gsmW8p99kYCUd8nWCimnXl0RFnGYRRmBX2tgnsvcgb/du5xJuWQH3+OQcVRCYYitipHiCW8f6G92fMmyDl4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756411; c=relaxed/simple;
	bh=oruYJ4UPGqAWpq8C0DxDkuEHfG7ebzIT/niVTGPPWg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMXIeT/wELNV9XSTqe5XVqCgTSLwCCyImvBc1fer6nnktU8hsm5Lwy6vFsnJfERnAvutS8f7xjnqkOcGFYehkA7CO1OmV0bCTijjIy7c92F9ZUioFFGE5b1SRjoKmERqSwP7GO6e9ingXzbSLCXY2gMzRJWNW9zQYitr2YqTMv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfpneqG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CB7C4CEE9;
	Fri,  4 Apr 2025 08:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743756410;
	bh=oruYJ4UPGqAWpq8C0DxDkuEHfG7ebzIT/niVTGPPWg8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hfpneqG/NJtjtl5xs2SoEr9Y8ZfqF/1BFgMPes2ZRRjoBs/vlGV+yBHcOb12C4llm
	 COfuO88W6RUrueGD4Iv0ct2NC1P1Y/gbzMojvOhIik2uFxGoeDI+pxCgdywGhatXAK
	 Ptxgb7drmU9vpUoTY/CTSpBvBZUeQ9v+HRvRY835eMx6rsBrwKhswZPNuwfw3HMf+U
	 z9L99ZhKMbZFrMbw/HPN/hO3PFWMkSmRus98lKWJEDaT/k6DidbvFii93HU8LExAq1
	 6MoojCVIWTp6N5kIzrtQodgzFYdAX9+gQ3hH7MvHsxnRKhSP5fisPprZ2XpN7FBk7U
	 XoNA8XbN9W2GA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso16790661fa.3;
        Fri, 04 Apr 2025 01:46:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkxWxoW8OBbB3buJrf4WH/cQjL3Uuabolm4FJnlUauxV0hP5rjU9OqcvyoO5U3fTDQBuTkXK9La8A=@vger.kernel.org, AJvYcCXKmv5YrU1qHGtZKf/EYpAD0b00AFM/V+oHMZYYZ6Qgc3kjytU/E3H34CmHeO9pTZ0+HoZKIADZGsj0o68J@vger.kernel.org
X-Gm-Message-State: AOJu0YxEyQbaoZSC5Ovl1tMikoZbpf/qxIz1ng5YYHNE8ZxPsQDh+/4c
	7PDj0LIZD757GdYpBotNjSPeW2/TihuuwgWxJqS6KSZr7iJ2Uu05MfLIZtSPMJdXSC4QcRbSZg2
	KwofQRmuuNY/5l+LUUF3p39TXlbs=
X-Google-Smtp-Source: AGHT+IHMFbScdB7rd+Blgjs/ePSg2ZPwIIHzDuqpUWS9T/vVlNWqHglbb/9TjFa/8w/VK/gB27sdI2hDE0XEqzUAqMI=
X-Received: by 2002:a2e:bd0a:0:b0:30c:b2c:edb6 with SMTP id
 38308e7fff4ca-30f0a12ef70mr8572981fa.18.1743756409111; Fri, 04 Apr 2025
 01:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404082921.2767593-5-ardb+git@google.com> <20250404082921.2767593-8-ardb+git@google.com>
 <l6izksy3qtvo6t6l3v44xhuzmrnl2ijv7fx5ypvaz7kjxvpwhh@4zwlvxyfrp43>
In-Reply-To: <l6izksy3qtvo6t6l3v44xhuzmrnl2ijv7fx5ypvaz7kjxvpwhh@4zwlvxyfrp43>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 4 Apr 2025 11:46:38 +0300
X-Gmail-Original-Message-ID: <CAMj1kXGwnTkb1bUDaRpkh3ES8thcUVQE7+qgfZQw+RORtvtv-g@mail.gmail.com>
X-Gm-Features: AQ5f1JosTfVbiB2NpcePevYdvsziEedynxTe13RMk8QMXeSVo5r9cZFz2xOWmzA
Message-ID: <CAMj1kXGwnTkb1bUDaRpkh3ES8thcUVQE7+qgfZQw+RORtvtv-g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/boot: Implement early memory acceptance for SEV-SNP
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Apr 2025 at 11:43, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Fri, Apr 04, 2025 at 10:29:25AM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Switch to a different API for accepting memory in SEV-SNP guests, one
> > which is actually supported at the point during boot where the EFI stub
> > may need to accept memory, but the SEV-SNP init code has not executed
> > yet.
>
> I probably miss the point, but why cannot decompressor use the same _early
> version of accept too and avoid code duplication?
>
> Maybe spell it out in the commit message for someone like me :P
>

I assumed there was a reason that the shared GHCB page is used early
on. Maybe it is faster than accepting memory page by page?

It also depends on how important the memory acceptance is for the
legacy decompressor - AIUI the use case is primarily kexec, but
wouldn't the first kernel have accepted all memory already? I.e., if
it is slower, we might not care if it is a rare case.

