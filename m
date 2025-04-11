Return-Path: <linux-efi+bounces-3295-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB16A865DA
	for <lists+linux-efi@lfdr.de>; Fri, 11 Apr 2025 21:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8949A85F0
	for <lists+linux-efi@lfdr.de>; Fri, 11 Apr 2025 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31C21F428F;
	Fri, 11 Apr 2025 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5oU6vI2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B22191F79;
	Fri, 11 Apr 2025 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398064; cv=none; b=mnEeJccNjpa80jzjenGepPYWU2XyEzcdRKlhFGh93kA32YwXoC72/tH6XhHh9DqTJM2MOSnu09nOnwI7fzbVgGzg+E3K4VRl2/SASYZF9DF1HtT5QDy83Op8X1/hRoDjwKYVIgBy/3QIePuEGKRt3gxdJCoS390yPPpmr5tEaQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398064; c=relaxed/simple;
	bh=bA/5WEimXXiOEnOaGbvLbtwN7B1q9uAdOIOO11zIg+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4Tygf4WsbhuZiY1ZOncjecMGRxwwotXiM0xrqZYUJCuM/gwt9ToDgvnaQP9P63GGJVGFHfTF6+MFkGHXD7ne/TPf659/vttksqCp+DAZOdPxOF3iRCOfo97jwSgB5U+uUaknXfTYW6HJ0K5b3QJ90GxEH/DEde4D7ppcs72K+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5oU6vI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B67C4CEE8;
	Fri, 11 Apr 2025 19:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744398064;
	bh=bA/5WEimXXiOEnOaGbvLbtwN7B1q9uAdOIOO11zIg+g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o5oU6vI2CU4Avy7kOSP81GaXT2299B0OY2Qc9I/AdjT/17RA7zTRqks6CV62SkHoW
	 ITy/lyp/pdLPQBtESBtj1WfSh/3dvsnKiK2lppsRHgQqiAcWPBAmZFxNe7EU2KckYC
	 2JA253XjoNXdA5ip/OQc4utI4+qAfHOfeOL3namcFnJeryJNStXHuO0q8c5CNAsuet
	 YEBM/RyxLUoXJGn+39TzcqzR/hLIqDRZrhDdbx98u4luR0CnbnphOnA+82kewy3odJ
	 7+Cag3eoexQd51XgIjwlG3CdHdQhjV+Xqa/AV4GBnUFBdT5YKYZneNLIOT9VOvWW6g
	 fwTI9//uC8TcQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54954fa61c9so2932721e87.1;
        Fri, 11 Apr 2025 12:01:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQr1JkeocG1aw14PKLp0x7sCD7opHIutXqw/3lhGybyaPfc7m2xqlD7zLnudy6MmAScQpU4m39BgT0D4Tl@vger.kernel.org, AJvYcCX5jnSQNXWWR2CpCBlEF456Xf52N0uw7PbrhEevljksLJkJlA8nSlQWqgOuMd0tV4gu6atnfd2IQME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrhF68MRdzG8q6uZh7tHHyn+kxo2v4NkEU5MaupWXY0smK0zC3
	0B0gzpTD4pA1cNdOavCPxJikiyWEFkItg6zE34rYdJBcHUcQgE8ejOQliWxqed35+Ab347FcrO2
	uCTrdQ4tOcBYjZOC873OoAtMBsH8=
X-Google-Smtp-Source: AGHT+IEHsyq+bbG/5UAaR/57DsRaAfwOrpsrneGZs1xAL1OhptlCEMpu+Ug0gD3uTWxdFKyGZvOAMotnuxyDkn7kIqc=
X-Received: by 2002:a05:6512:308e:b0:545:2fa9:8cf5 with SMTP id
 2adb3069b0e04-54d452d5446mr1162079e87.49.1744398062721; Fri, 11 Apr 2025
 12:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410132850.3708703-2-ardb+git@google.com> <20250411184113.GBZ_liSYllx10eT-l1@renoirsky.local>
In-Reply-To: <20250411184113.GBZ_liSYllx10eT-l1@renoirsky.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 11 Apr 2025 21:00:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEqWxokyJf_WUE5Owwz3fO6b-Wq8sSNxFmMVAA+Q47uPQ@mail.gmail.com>
X-Gm-Features: ATxdqUF-Svulb1Ys9eutZeJMowuBftp7WxY3FOYeIKtyx48grGphQUWINjGEMCI
Message-ID: <CAMj1kXEqWxokyJf_WUE5Owwz3fO6b-Wq8sSNxFmMVAA+Q47uPQ@mail.gmail.com>
Subject: Re: [PATCH v3] x86/boot/sev: Avoid shared GHCB page for early memory acceptance
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, x86@kernel.org, 
	mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Apr 2025 at 20:40, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Apr 10, 2025 at 03:28:51PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Communicating with the hypervisor using the shared GHCB page requires
> > clearing the C bit in the mapping of that page. When executing in the
> > context of the EFI boot services, the page tables are owned by the
> > firmware, and this manipulation is not possible.
> >
> > So switch to a different API for accepting memory in SEV-SNP guests, one
>
> That being the GHCB MSR protocol, it seems.
>

Yes.

> And since Tom co-developed, I guess we wanna do that.
>
> But then how much slower do we become?
>

Non-EFI stub boot will become slower if the memory that is used to
decompress the kernel has not been accepted yet. But given how heavily
SEV-SNP depends on EFI boot, this typically only happens on kexec, as
that is the only boot path that goes through the traditional
decompressor.

> And nothing in here talks about why that GHCB method worked or didn't
> work before and that it is ok or not ok why we're axing that off.
>

---%<---
The GHCB shared page method never worked for accepting memory from the
EFI stub, but this is rarely needed in practice: when using the higher
level page allocation APIs, the firmware will make sure that memory is
accepted before it is returned. The only use case for explicit memory
acceptance by the EFI stub is when populating the 'unaccepted memory'
bitmap, which tracks unaccepted memory at a 2MB granularity, and so
chunks of unaccepted memory that are misaligned wrt that are accepted
without being allocated or used.
---%<---

> I'm somehow missing that aspect of why that change is warranted...
>

This never worked correctly for SEV-SNP, we're just lucky the firmware
appears to accept memory in 2+ MB batches and so these misaligned
chunks are rare in practice. Tom did manage to trigger it IIUC by
giving a VM an amount of memory that is not a multiple of 2M.

