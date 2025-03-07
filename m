Return-Path: <linux-efi+bounces-2909-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B12A5601E
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 06:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0331772A9
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 05:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE88157A48;
	Fri,  7 Mar 2025 05:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlkIHdXP"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF8B7FD;
	Fri,  7 Mar 2025 05:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325810; cv=none; b=alF5PFGJ861MmiR+5P5E9ezk2+fDeQqWfugmRViqc9yhbnXMYzpbrilzYmFdyOUaSFiRLSs9/Rezbv9gPQQ51ialw8D4OkSk5m+SdhUPbXEPNUx18lsAuRImwl17lq8iV1DwzdJW6GgVqS8hUvV4nYKcLWvwr7KkXTDTSJsEfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325810; c=relaxed/simple;
	bh=9QaH+vm07d39qN8cufv/JiMHH2odvyuaWM82iz6NdKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVm1wLGMwD6WHKsIVjo5qIS2/fxt9WBTF0ukI7L77hlyVo+Yw+l12keOsABFvYllnsNrL20yWgkC8P3yRZ7vQFF5PjmcbCRlNzJACJNyK35c9w+ixPREmLRoTcYAU5USWt7A38WzJS317m8Htt3HuSXqKfA3MhrwA5PAOyP+ntA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlkIHdXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C5AC4CED1;
	Fri,  7 Mar 2025 05:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741325810;
	bh=9QaH+vm07d39qN8cufv/JiMHH2odvyuaWM82iz6NdKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlkIHdXPGM9njYUBUxDdK8xs8t3idwKwsPWkP2wvPc9oP4CJW/dRs+TgER9Jn2xOB
	 MZNqRpx2aDzy0328cV+FGog7U5h/vMcQ1kklrSf010F2CRP/wMCHzRM1VukWA79/TF
	 dUCBmloSPeRxFQmIzoPezNvhu8NXdUCtmYjtj5XXcuOESSXwWA96wPoRFpzTLco91O
	 PxnVuGWfYh9u/UcZKpyVz3KD+bVyfidrclafPFfkmhgI6QB+tXzRp1aR5Qmt7oFEp6
	 6XVX4IHGLOLWOqkxkQVq+gHhQUzlZvHtsXUN5al4RN7xUQ0NOw1B57mwfjGtVQTs20
	 PYouPxJKYv1cQ==
Date: Fri, 7 Mar 2025 07:36:45 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 06/19] x86: Add early SHA-256 support for Secure
 Launch early measurements
Message-ID: <Z8qF7bP7vSL6c_Z9@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-7-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-7-ross.philipson@oracle.com>

On Thu, Dec 19, 2024 at 11:42:03AM -0800, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> The SHA-256 algorithm is necessary to measure configuration information into
> the TPM as early as possible before using the values. This implementation
> uses the established approach of #including the SHA-256 libraries directly in
> the code since the compressed kernel is not uncompressed at this point.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/boot/compressed/Makefile | 2 +-
>  arch/x86/boot/compressed/sha256.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/boot/compressed/sha256.c
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 7eb03afb841b..40dc0b9babd5 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -107,7 +107,7 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>  vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>  
> -vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/sha1.o
> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/sha1.o $(obj)/sha256.o
>  
>  $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
>  	$(call if_changed,ld)
> diff --git a/arch/x86/boot/compressed/sha256.c b/arch/x86/boot/compressed/sha256.c
> new file mode 100644
> index 000000000000..293742a90ddc
> --- /dev/null
> +++ b/arch/x86/boot/compressed/sha256.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Apertus Solutions, LLC
> + */
> +
> +#include "../../../../lib/crypto/sha256.c"
> -- 
> 2.39.3
> 

Ditto, nothing particular on this at this point of time. Probably 80-90%
what it should be. 

BR, Jarkko

