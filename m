Return-Path: <linux-efi+bounces-5197-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7647FC14F18
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 14:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA14189A928
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB6613D51E;
	Tue, 28 Oct 2025 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRDzqMF0"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1E1D9663
	for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659051; cv=none; b=hbpFiqn3zt8nVSz4nOCLc7p84qnOYvuqW29x0yzmbF9NH/wDU1ypEigxkq/D8ba5qZN1kV0usTaW0tAQ17Z4TiZYYY6bnZ4MtD3lwJ2Aygf4BlXgKTEpyomuGjW6FUKZDsM1eFtpJNdt+p06sFrYJd1NN8ct7gJQU2sxSj0uuqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659051; c=relaxed/simple;
	bh=vq7T4W4n4gFEeGmD5D9ZAEQSp3CgtmtOG1ytOpkrNN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwJNMZBE677eCO3c34TLSmyZrzJc9qG6i4nvWlb/iJ83iqEpeKDy41mRtQEJrPGXkFSZaK1uQmIE8cAlboMxFa3n2FG6QtsGSl1h9VSdJWEUuAcZfxGNRkrK1foWEn9zhTDddCsvuPAULNh1XAEX49B3CgTpxB0TqiVMz0nleCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRDzqMF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7124CC19423
	for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 13:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761659050;
	bh=vq7T4W4n4gFEeGmD5D9ZAEQSp3CgtmtOG1ytOpkrNN8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tRDzqMF04MfY2WABSfrSRLnse3Mgy6EyOrn+Pu/r2gl3ZU7GpIRzzFU0uoEfeR58y
	 R6/haR5AacQd+5TK5tBYlytXZ5HqX3Q/9LdQ+u3w+WCTeKz1Ubv7+SnJBLqKMnLUs4
	 S6aLZ88fNGvt9aPOgisbxVOzDxREYfpD/KYOVlyyncrHL0U7VKN1q1pnv1UKEQs4ro
	 QmoAdD9kd6m3f0GQ3Oem6zlRiXXTMXK6HtDXRcLigd8bpltHGQku47sLa+00QfopHG
	 4CgPWqWOrkwecvRvwyEAAILOUWjkSJJ1dWkG6AI0f75nWk7fFRW6NNdWRqEdfI1VLs
	 taRZ5F67AA7Bw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-378cfbf83f2so64855861fa.1
        for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 06:44:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgpLkKYQmx7XewBg6RbBbvUA9PbN7qsMDOiC8U3flpdbnIq3Vm9v4WsZvqB9yWq+Rd2GjPvCZ5hrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymP0OCDycVL5QPt+MlEigCXzmH9PloN/KC9LO1oFZJqmLod9cN
	x0sf/zZanzH2MYGEfRQf/DtuTjOACAsq3aWvIa+ahtwlibKaP38I/Em+aDxcjBnHZrCLsWXMiew
	BnPphS/cqZgT+CmRosspHShRt65vkJAY=
X-Google-Smtp-Source: AGHT+IGTtAcYuWKCVE8+/H7SGfbZK6Sf2oprOXFQDJmCdFXXr46QXur27Rti4tOTdg2Rzm12P4PmA+AtrxWWOPEyz6s=
X-Received: by 2002:a05:651c:4409:10b0:378:d24d:c717 with SMTP id
 38308e7fff4ca-379076be226mr9072081fa.7.1761659048628; Tue, 28 Oct 2025
 06:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028105637.769470-1-usamaarif642@gmail.com>
In-Reply-To: <20251028105637.769470-1-usamaarif642@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 28 Oct 2025 14:43:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH8ogAzr-_yCWgqzj+NLVpvBGkm_XOJppSm2jcS4P8eUQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnMdAxOYX25sIeGClZxQEY4KScBSwX7A3mccGkwB8TL2Tox5hNBUjWVOII
Message-ID: <CAMj1kXH8ogAzr-_yCWgqzj+NLVpvBGkm_XOJppSm2jcS4P8eUQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86: Fix kexec 5-level to 4-level paging transition
To: Usama Arif <usamaarif642@gmail.com>
Cc: dwmw@amazon.co.uk, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org, 
	apopple@nvidia.com, thuth@redhat.com, nik.borisov@suse.com, kas@kernel.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, kernel-team@meta.com, 
	Michael van der Westhuizen <rmikey@meta.com>, Tobias Fleig <tfleig@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 11:57, Usama Arif <usamaarif642@gmail.com> wrote:
>
> This series addresses critical bugs in the kexec path when transitioning
> from a kernel using 5-level page tables to one using 4-level page tables.
>
> The root cause is improper handling of PGD entry value during the page level
> transition. Specifically PGD entry value is masked with PAGE_MASK instead of
> PTE_PFN_MASK, failing to account for high-order software bits like
> _PAGE_BIT_NOPTISHADOW (bit 58).
>
> When bit 58 (_PAGE_BIT_NOPTISHADOW) is set in the source kernel, the target
> 4-level kernel doesn't recognize it and fails to mask it properly, leading
> to kexec failure.
>
> Patch 1: Fixes the x86 boot compressed code path by replacing direct CR3
> dereferencing with read_cr3_pa() and using PTE_PFN_MASK instead
> of PAGE_MASK.
>
> Patch 2: Applies the same fix to the EFI stub code path. (Done in a
> separate patch as Fixes tag is different).
>
>
> Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Reported-by: Michael van der Westhuizen <rmikey@meta.com>
> Reported-by: Tobias Fleig <tfleig@meta.com>
>
> The patches are based on aaa9c3550b60d6259d6ea8b1175ade8d1242444e (next-20251022)
>
> v1 -> v2:
> - Remove patch 3 from v1 to fix kexec for source kernel in 5-level to 4-level
>   transition where the 4 level kernel doesnt have patch 1 and 2 (Dave Hansen)
> - Add include for asm/pgtable.h to fix build for x86_64-allnoconfig (kernel test bot)
> - Use native_read_cr3_pa and for both paths (Ard Biesheuvel)
>
> Usama Arif (2):
>   x86/boot: Fix page table access in 5-level to 4-level paging
>     transition
>   efi/libstub: Fix page table access in 5-level to 4-level paging
>     transition
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

