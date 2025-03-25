Return-Path: <linux-efi+bounces-3074-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4DDA6EA6C
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 08:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8206F1891E94
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 07:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2371F03E5;
	Tue, 25 Mar 2025 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLq5OZeJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B12F1D7E37
	for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887384; cv=none; b=vE52oOyVKzUl+ZLkMCZx7DZwJqenXB+T3z0pe/yR5jcMA+/MRfky3dtrwmgcpeD6ILCdCHtnKSMmyu1oo12bYYBTXeLvMfH9iouv5a4SAx9zEHm9dmSNr87Dd7GK5QuGPclxcCbB4RlibHWGLsy1514isxkHBWA8QnEgJRzY7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887384; c=relaxed/simple;
	bh=kIFLQ6QUfPfpBlVuvPWNElwgYOQJPwa/W8Jh5YJHISI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AghaJIWfbjyykJKeWafw4UsTtdwYf5krm1Wm092qc6/8TDG+QUaFWugRBQvD9ddpRxnWievW8rvqdSpXaEYGI79A8sSBKGDAPBiKey6ZE1LYUXdsE05tyRKx36sDrVlp1mbne6bYxsWA1eOU2pNblXbHBxkwILEM7TiM/EgmdeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLq5OZeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE92C4CEEA
	for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 07:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742887383;
	bh=kIFLQ6QUfPfpBlVuvPWNElwgYOQJPwa/W8Jh5YJHISI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tLq5OZeJUmiP5NJxVOB2a2sn/L9qaFspiFATIPVoc//uAzKfKO7CYPWZvtpjXbZfx
	 sjDCCH4RKawKECmrtDhLV/rNHyXOnBUmwnfW4i7FgNQhhS0s6oiYRCKHVbLk5mA/Ke
	 j7AwpFBDX4gzyp2F+ZkPaKyWr4PeuLzRFlCPOpJuorKmzsRDyHSKbvK2RT/sfVl1eM
	 w/7f7KhtOy5VHXuv+RaPzlhTkO8pNh8I6bKf1cWLJNyn3WXN3w6iybkcVw2XmtK30x
	 xATn8WhRBruK8tuKeZswNuhhQ0rHa0qnVayVmYI+IlVopbsOTW7upMeXqKx6IwK7rV
	 p5v2ix5aUGBtA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30c461a45f8so52678341fa.1
        for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 00:23:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YybEpfTvbK1047+fCKU/JkN7xZdZqeatjadAZCS6jT67uVDkK0F
	PaKFUzEv1wSHDMiPGxDyt2zynJf200sU0Gyngn2NZN1pm3NfLt/C7rW+youbLaCwqtP6J2jDLru
	qqP688lbQUfnZQlLi/8c1uU0ktIU=
X-Google-Smtp-Source: AGHT+IG6MGwpDjaFb1imc2Jkdpsg8r8/f3BEeq+lthPLHB5UXqCtGTT7lo60Lt6ya5HVferokVNM2U45FBWFMTHjndk=
X-Received: by 2002:a05:651c:1189:b0:30c:160b:c766 with SMTP id
 38308e7fff4ca-30d7e22790emr49313841fa.14.1742887382039; Tue, 25 Mar 2025
 00:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXHacRusnpmGJecMU3L2CCyQtopBL6KqoSVuF7tDW85TUg@mail.gmail.com>
 <874299e9-eb4f-7775-4ea4-69d449ca1e05@amd.com>
In-Reply-To: <874299e9-eb4f-7775-4ea4-69d449ca1e05@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 25 Mar 2025 08:22:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGu-2KNKLwYvRYRv7sd3d2XR8Q0wDOdRK84FYXOirO54g@mail.gmail.com>
X-Gm-Features: AQ5f1JozlpH1oFPXtCUplyKr25fV8VIVVMTKYURtWnnZHHtxv711_AYohazzVFw
Message-ID: <CAMj1kXGu-2KNKLwYvRYRv7sd3d2XR8Q0wDOdRK84FYXOirO54g@mail.gmail.com>
Subject: Re: query regarding SEV logic in early boot
To: Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-efi <linux-efi@vger.kernel.org>, linux-coco@lists.linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

(cc Kirill)

On Mon, 24 Mar 2025 at 20:14, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 3/24/25 12:28, Ard Biesheuvel wrote:
> > L.S.,
> >
> > As I am trying to disentangle the Linux early SEV boot code, the
> > legacy decompressor and the EFI stub, I noticed something that looks
> > broken to me, but I'm not quite sure how to fix it.
> >
> > When booting via the EFI stub, the following call chain may occur:
> >
> > setup_e820()
> >  process_unaccepted_memory()
> >   arch_accept_memory()
> >    snp_accept_memory()
> >     early_setup_ghcb()
> >      set_page_decrypted()
> >       set_clr_page_flags()
> >
> > where the latter function relies on mapping_info to remap the GHCB
> > page as unencrypted. However, when entering via the EFI stub, this
> > struct is never initialized, and so I am struggling to see why this
> > works at all.
>
...
> So, yes, this does appear broken.
>

OK, thanks for the analysis.

> The latter function reads from the target page so that the page gets
> faulted in via do_boot_page_fault(). do_boot_page_fault() calls
> kernel_add_identity_map(), which calls kernel_ident_mapping_init() and
> initializes the mapping_info struct.
>
> At least that is how it is supposed to happen coming through the
> decompressor. I couldn't recreate the path you sited until I tried an odd
> size memory argument that was not 2M aligned (using 4097M on the qemu
> command line fixed that). However, even that causes issues, because the
> SEV_STATUS MSR doesn't get read until sev_enable() is called, which is
> called after setup_e820(), so we actually can't even take the
> snp_accept_memory() path.
>

So we should never hit the page fault that triggers
kernel_ident_mapping_init() because all memory is already mapped (and
boot_ghcb_page is part of the image so it will definitely be mapped
even when not booting via EFI)

(For future reference, could you share the QEMU command line that you used?)

> But faking the SEV_STATUS MSR value does cause the code to get down to the
> set_clr_page_flags() function and reading the input address contents
> doesn't trigger do_boot_page_fault() to run because load_stage2_idt()
> hasn't been called, which probably wouldn't matter anyway since the code
> is running under the EFI page tables.
>

Exactly, and that was the whole point of separating those code paths,
i.e., to get rid of all the demand paging logic and execute under the
EFI page tables (which use strict permissions for code and data, which
is a Microsoft requirement for secure boot signing)

So in a nutshell, the problem is that snp_accept_memory() calls into
the SEV code before sev_enable() has been called. But I wonder why
accepting memory is needed in the EFI stub at all?
(asking Kirill) Is it just to ensure that all unaccepted memory is at
the granularity provided by the bitmap? That could explain why nobody
ever noticed this.

Is there a problem with being conservative in the bitmap, and marking
misaligned chunks of accepted memory as unaccepted? AIUI, that would
remove the need entirely to accept any memory in the EFI stub - only
the decompressor code path would have a need for it.

