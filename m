Return-Path: <linux-efi+bounces-3218-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A893A7EE59
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 22:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A791896BF5
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 20:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ED2218AC4;
	Mon,  7 Apr 2025 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpRX+AW+"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC316F8F5;
	Mon,  7 Apr 2025 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056001; cv=none; b=LVxwyoKznQDSAyMMgxVciamUnP9yJuW5MtvEWAWbJxTg0xBhwYPoYmgBhP6Gw2x5TnH1dDD6p3MX7ppyjNrCjhvVWjOVI46WSWXCC3fM5VS7qK/3p47Z6Xfi0ymDRuUhwZkoEdpegD1ghEo4s+a5eKMLEW4bV2iQs8S4T90fCFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056001; c=relaxed/simple;
	bh=jPRArkwWUfbOU/XmMI296o3CkNdz7RofAbOMlmEBgxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/CvN0i0ca5v8yvXZX+QwBmbHLGHNwKyH367TGJlCBS06xsRd6y6pIpyOR8g41J925wq7Jr7XVCMSjV9kgU2nkxGt+KLjzlbLvuwjtEe682dqjq9uyDf7o33e1Re69RbGnJdOkkbtNIfZURGMwtUd/VZ5eUfLpoQXcQAzNfvaKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpRX+AW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4783C4AF09;
	Mon,  7 Apr 2025 20:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744056000;
	bh=jPRArkwWUfbOU/XmMI296o3CkNdz7RofAbOMlmEBgxA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mpRX+AW+s+M2LcUkMmxAunMhDtp1Xiz6r4EwypsJgEsqgNPrptJs0BHOY7iVf8VTB
	 mfTVytkN21wXnNsJCvnYMM76Q4ssPaTgHk3S5etCv0opm8fRK4ln2WLpJFCi9gXyaP
	 E8mP94s1QRkBY8Kwxw3k7f/MyhOmgnJXGg3b+Y1Gef+HGCgfISXCiRDUUOS6HsCLCP
	 HT+WQKs+ya/HJSI77BGctITUwvzvfnkNgxuxd1NBDWcqOvsJJcErowmqTqhDb0DLzZ
	 ly5dCECd7q9B6loPNsVW0ebBCV6s6zXx5g+5IYGkyok3q0wkZa3PrutU3K/p+UsIws
	 i+qLylMJDk/ow==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso46078151fa.3;
        Mon, 07 Apr 2025 13:00:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWI1MaezShBg2AqkAoTYKwA5bPL2WEylSiLVj6Qt8tF10YtTdPoNtgDIXGqP/DaaKjNy3Mwp0jC5DE=@vger.kernel.org, AJvYcCXfZGDp2DD9PxWAjEnpzalJtHcP3O+OfwOgHsx+hZORv0+TfuKbjKZsxfgpXxHwKyD1AuuykuHEg/3pvHty@vger.kernel.org
X-Gm-Message-State: AOJu0YwUPhrw3StAuu6i7JR1smqZaZZgOklc3Hy5UjMAyKZ2aQac9jGT
	DWBlpo3cytAksP+mQvRW2HZDSmnqCmQy828AQeVgDHWuDrhcQ/pnJjeoQ/BaUKten56GE21aoEs
	iURSuwXg+ITTorQqLHUCLwAdy8HY=
X-Google-Smtp-Source: AGHT+IFoDfcm0yl+QexjJ4s3y8T2IraFKcLrX17H37lK1ZDrd+qbjAVpTBnzZ03NtT9f6RWVYq1+KQ62wdWkXhCWgJ8=
X-Received: by 2002:a2e:bd13:0:b0:30c:523a:a84 with SMTP id
 38308e7fff4ca-30f0c050547mr45773741fa.32.1744055999296; Mon, 07 Apr 2025
 12:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404082921.2767593-5-ardb+git@google.com> <20250404082921.2767593-8-ardb+git@google.com>
 <l6izksy3qtvo6t6l3v44xhuzmrnl2ijv7fx5ypvaz7kjxvpwhh@4zwlvxyfrp43>
 <CAMj1kXGwnTkb1bUDaRpkh3ES8thcUVQE7+qgfZQw+RORtvtv-g@mail.gmail.com>
 <CAAH4kHbxMDGQy3v9ef1ZdqK0TNzpm==BJgx1KiUpRP-CRKDx4w@mail.gmail.com>
 <ldrma6tce2bwhenu5kobjzvk7cz445ubfmpcynwadqudgvzuh3@aibigcdzui6m> <9f689ba2-add6-cca2-e7b3-fa0393fe2b98@amd.com>
In-Reply-To: <9f689ba2-add6-cca2-e7b3-fa0393fe2b98@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 7 Apr 2025 21:59:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXERL=8Y51RUJSqgLWVMs4PJa9aQK0puvKaCpg6eRu0t8g@mail.gmail.com>
X-Gm-Features: ATxdqUHe-N-0lwN7IIcNDq9Z-VBGM7h6JMwe_XEsIq9i5_R6mnOjPGjaytAjlUk
Message-ID: <CAMj1kXERL=8Y51RUJSqgLWVMs4PJa9aQK0puvKaCpg6eRu0t8g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/boot: Implement early memory acceptance for SEV-SNP
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Apr 2025 at 20:05, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 4/7/25 04:25, Kirill A. Shutemov wrote:
> > On Fri, Apr 04, 2025 at 08:07:03AM -0700, Dionna Amalie Glaze wrote:
> >> If the GHCB is available, we should always prefer it.
> >
> > I believe we should consider the cost of code duplication in this
> > situation.
> >
> > If the non-early version is only used in the kexec path, it will not be
> > tested as frequently and could be more easily broken. I think it would be
> > acceptable for kexec to be slightly slower if it results in more
> > maintainable code.
> >
>
> Is accept_memory() in the decompressor or efistub only used in the kexec
> path?
>

The EFI stub does not call accept_memory(), only the decompressor
does. The only use case for explicit memory acceptance in the EFI stub
is process_unaccepted_memory(), which accepts the misaligned chunk of
memory that cannot be described at 2M granularity by the accepted
memory table.

Remember that the EFI stub no longer calls into the legacy
decompressor at all - it decompresses the kernel while executing the
EFI boot services and branches straight to it.

