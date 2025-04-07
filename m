Return-Path: <linux-efi+bounces-3211-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85630A7E807
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 19:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437A2173D8F
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 17:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A30A215063;
	Mon,  7 Apr 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7j3wcK1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EE1290F;
	Mon,  7 Apr 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046490; cv=none; b=rxD6aJmRy58CjZLu+pXEA690BAefHiQD5z80VsOxOGXT05Jy9uv6wQsvFx+vXLutQBtrcT8M7PDFsRTsWUxgsme3/hKNw2yKrgdiJZ1Ux/Ai5ARML3l8THqQ1RwqwNZ79EKzwDZxolpJGdSBZiXAj58dGgAx7LFCdGyYDSciqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046490; c=relaxed/simple;
	bh=6TuvDEOvwE6rzCZvIUQMKgR2bXPTiX5L8vTEyUSbe04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjbZ4iS2Amq+JfoXgs/SDjoZmM1TMvU2OyeXt3q9Yr7jsOH1YqJnKDexTmUsrqHEh47wyvYIoWnv6phH6oTQrFGrSvsmeNI6jj+3R9W+QYG0axwPAbcHVpQ/KaTmtMwUhy9H38Ed/yE3si3pgWR/qeCwcgEyNCj31RxJLP2ur0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7j3wcK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC62C4CEEA;
	Mon,  7 Apr 2025 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744046489;
	bh=6TuvDEOvwE6rzCZvIUQMKgR2bXPTiX5L8vTEyUSbe04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E7j3wcK17aMIUS5Zle4yYki3TyHEgpfM0R2uCyD2b/NQvFxJcGIIHicEUIMbaGgt1
	 QIF87TJ6gLTi7U7C+IHCCUByQ+a1U2+7IWPZZJXnrB+i5zxZoLxovNUlauieGPicP9
	 yha+WlCf8mdVEXcFjKIPOJwvGWYcmTZ3RacyDCLQTUZGM3TBV9qtwRSyiHoteVzfSH
	 dzNqM0bqv3QKQlfmbBaoMjzZ/H8nrJs5hsKdocN3017SpdifLUDUfo+SYKPfKaJNq0
	 f17FPZnp0IO/3RNop6uLKyhC1ZqII3dYhlCNt2U/h9vr41AHTpeVoDKpPDSKfbmp1S
	 2bI0scKBoZgaQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso43642351fa.3;
        Mon, 07 Apr 2025 10:21:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOfl1O7e2wZZuOZagIwLirGQIn8Z8oiUbF0XRbQpSJfsGqfFV6BDmHkpuOfIkSGOTUknT8KZOTBwo=@vger.kernel.org, AJvYcCVpN0sKD0utqwCaQ+IH9RlPcFy2QMAXnYJhjkRL+LM2BeXHGakKUdMxnl7+6OEsoqcS5iTxPm0EF6uht4wU@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZdJfXWS+BM0nDr9tvX4hjjbmNhQ//fGE+ZHU5/t6mRIXOt29
	DBA8jIPWC4hdKYGqNaYImT9QNsjGSU78+QTZ8eYg7B/5uEo0If4r4BaaQoFYBLU+DoAjo0yXF5e
	wh2RiEriBA1PxS8HqUuesaioZisw=
X-Google-Smtp-Source: AGHT+IG0z+Bar7RSCvD9eNSZbPTryngAUba/nCQRwFMtbWhDcFc4Vz2Pj4789pRs0U56B6pNIUHP4IkqWpgOhU8fIn4=
X-Received: by 2002:a2e:bd81:0:b0:30b:f775:bb25 with SMTP id
 38308e7fff4ca-30f0a190a9emr44227601fa.36.1744046488240; Mon, 07 Apr 2025
 10:21:28 -0700 (PDT)
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
 <ldrma6tce2bwhenu5kobjzvk7cz445ubfmpcynwadqudgvzuh3@aibigcdzui6m> <Z_QA6GwqoxdW6D0e@gmail.com>
In-Reply-To: <Z_QA6GwqoxdW6D0e@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 7 Apr 2025 19:21:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGWPopQupteK0=mqd5z29Oj4Ye6KyPfgup-nHQO863Qow@mail.gmail.com>
X-Gm-Features: ATxdqUE7JvfkFBgD0ctY2GHjPkEPUKpuJg91wGrLByrfqElFhaHXz7CnksqEQ4Q
Message-ID: <CAMj1kXGWPopQupteK0=mqd5z29Oj4Ye6KyPfgup-nHQO863Qow@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/boot: Implement early memory acceptance for SEV-SNP
To: Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Apr 2025 at 18:44, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:
>
> > On Fri, Apr 04, 2025 at 08:07:03AM -0700, Dionna Amalie Glaze wrote:
> > > If the GHCB is available, we should always prefer it.
> >
> > I believe we should consider the cost of code duplication in this
> > situation.
> >
> > If the non-early version is only used in the kexec path, it will not be
> > tested as frequently and could be more easily broken. I think it would be
> > acceptable for kexec to be slightly slower if it results in more
> > maintainable code.
>
> Absolutely so.
>

It would be nice if someone could quantify 'slightly slower' - I am
leaning to the same conclusion but I have no clue what the actual
performance impact is.

