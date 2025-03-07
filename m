Return-Path: <linux-efi+bounces-2908-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CFBA56017
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 06:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B7E3A9728
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 05:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0BD157A48;
	Fri,  7 Mar 2025 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNW/dhx8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8407FD;
	Fri,  7 Mar 2025 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325762; cv=none; b=ms3AKUGqLnTLC6x6gNVU3vsvtoIgeZwuEBizsHxVasrcHZ9CBQ2ONPiau7sPz0Q50rzGUuBsCEWKI7l2agVOBtRpGhtFDSvGSxo9EKGcQU6E1aLe0l0jBwX7ZOr+QMYx6+bZnEIrprJhmqBPYW+wI/faOL+Iap8qk4azZX+3jsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325762; c=relaxed/simple;
	bh=boei5N6UlmoAMPlzgq5VIWFcm60SZWwfz3TA9by7qJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrlZBxzxqekOByh73t74ZCF4FB/VljbzNH4OaVMVIIquN7RSRjvG6aySYUoGuqlx+euc33rAb8KrrUdZVSrNRaWGzX5Td0bwMofsS/YYN+GlY4t4rCEsf0CevjZZdYUJ3ZiEp0klG61ePm+xLhwW9W/2YIREXIaJH1utNtpzlB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNW/dhx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74388C4CEE2;
	Fri,  7 Mar 2025 05:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741325762;
	bh=boei5N6UlmoAMPlzgq5VIWFcm60SZWwfz3TA9by7qJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNW/dhx8rYYGJtm4lQKEOrd4NYNLyuCHNrPxxXKIkBoQ1qI5F/iM3f7JroHawql6o
	 Tts5NW6ZsekGtBDkyI13pXLvEc4xBZ8nZVniSio2GtV7wPazkdIilE038S8VBfPElk
	 ErjEhC2+wnGNkIaYzHE9D+/BxyuCIHm/Rf+6OF+mBOU1eiZSijAerIMMYt2hKUXFXX
	 /f0DrZbVG2mSel8Mvu5J5YEsB5xhPTk3uFhtxbsrj3ZQFajDHKMw4dQqrapXhEt/nO
	 TBn7XuHy7WyfVXCJCTwzYogbN0jZH5mbeho/TF5v4RpjJ6FFlaMiEbbxVAeJJmAXVH
	 Tr5SLm3j3WlSg==
Date: Fri, 7 Mar 2025 07:35:57 +0200
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
Subject: Re: [PATCH v12 05/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
Message-ID: <Z8qFvYEE19yv7z-8@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-6-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-6-ross.philipson@oracle.com>

On Thu, Dec 19, 2024 at 11:42:02AM -0800, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> Secure Launch is written to be compliant with the Intel TXT Measured Launch
> Developer's Guide. The MLE Guide dictates that the system can be configured to
> use both the SHA-1 and SHA-2 hashing algorithms.
> 
> Regardless of the preference towards SHA-2, if the firmware elected to start
> with the SHA-1 and SHA-2 banks active and the dynamic launch was configured to
> include SHA-1, Secure Launch is obligated to record measurements for all
> algorithms requested in the launch configuration.
> 
> The user environment or the integrity management does not desire to use SHA-1,
> it is free to just ignore the SHA-1 bank in any integrity operation with the
> TPM. If there is a larger concern about the SHA-1 bank being active, it is free
> to deliberately cap the SHA-1 PCRs, recording the event in the D-RTM log.
> 
> The SHA-1 code here has its origins in the code from the main kernel:
> 
> commit c4d5b9f ("crypto: sha1 - implement base layer for SHA-1")
> 
> A modified version of this code was introduced to the lib/crypto/sha1.c to bring
> it in line with the SHA-256 code and allow it to be pulled into the setup kernel
> in the same manner as SHA-256 is.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/boot/compressed/Makefile |  2 +
>  arch/x86/boot/compressed/sha1.c   |  6 +++
>  include/crypto/sha1.h             |  1 +
>  lib/crypto/sha1.c                 | 81 +++++++++++++++++++++++++++++++
>  4 files changed, 90 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/sha1.c
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index f2051644de94..7eb03afb841b 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -107,6 +107,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>  vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>  
> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/sha1.o
> +
>  $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
>  	$(call if_changed,ld)
>  
> diff --git a/arch/x86/boot/compressed/sha1.c b/arch/x86/boot/compressed/sha1.c
> new file mode 100644
> index 000000000000..d754489941ac
> --- /dev/null
> +++ b/arch/x86/boot/compressed/sha1.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Apertus Solutions, LLC.
> + */
> +
> +#include "../../../../lib/crypto/sha1.c"
> diff --git a/include/crypto/sha1.h b/include/crypto/sha1.h
> index 044ecea60ac8..d715dd5332e1 100644
> --- a/include/crypto/sha1.h
> +++ b/include/crypto/sha1.h
> @@ -42,5 +42,6 @@ extern int crypto_sha1_finup(struct shash_desc *desc, const u8 *data,
>  #define SHA1_WORKSPACE_WORDS	16
>  void sha1_init(__u32 *buf);
>  void sha1_transform(__u32 *digest, const char *data, __u32 *W);
> +void sha1(const u8 *data, unsigned int len, u8 *out);
>  
>  #endif /* _CRYPTO_SHA1_H */
> diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
> index ebb60519ae93..0bd32df31743 100644
> --- a/lib/crypto/sha1.c
> +++ b/lib/crypto/sha1.c
> @@ -137,5 +137,86 @@ void sha1_init(__u32 *buf)
>  }
>  EXPORT_SYMBOL(sha1_init);
>  
> +static void __sha1_transform(u32 *digest, const char *data)
> +{
> +	u32 ws[SHA1_WORKSPACE_WORDS];
> +
> +	sha1_transform(digest, data, ws);
> +
> +	/* Ensure local data for generating digest is cleared in all cases */
> +	memzero_explicit(ws, sizeof(ws));
> +}
> +
> +static void sha1_update(struct sha1_state *sctx, const u8 *data, unsigned int len)
> +{
> +	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> +	int blocks;
> +
> +	sctx->count += len;
> +
> +	if (unlikely((partial + len) < SHA1_BLOCK_SIZE))
> +		goto out;
> +
> +	if (partial) {
> +		int p = SHA1_BLOCK_SIZE - partial;
> +
> +		memcpy(sctx->buffer + partial, data, p);
> +		data += p;
> +		len -= p;
> +
> +		__sha1_transform(sctx->state, sctx->buffer);
> +	}
> +
> +	blocks = len / SHA1_BLOCK_SIZE;
> +	len %= SHA1_BLOCK_SIZE;
> +
> +	if (blocks) {
> +		while (blocks--) {
> +			__sha1_transform(sctx->state, data);
> +			data += SHA1_BLOCK_SIZE;
> +		}
> +	}
> +	partial = 0;
> +
> +out:
> +	memcpy(sctx->buffer + partial, data, len);
> +}
> +
> +static void sha1_final(struct sha1_state *sctx, u8 *out)
> +{
> +	const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
> +	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> +	__be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
> +	__be32 *digest = (__be32 *)out;
> +	int i;
> +
> +	sctx->buffer[partial++] = 0x80;
> +	if (partial > bit_offset) {
> +		memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
> +		partial = 0;
> +
> +		__sha1_transform(sctx->state, sctx->buffer);
> +	}
> +
> +	memset(sctx->buffer + partial, 0x0, bit_offset - partial);
> +	*bits = cpu_to_be64(sctx->count << 3);
> +	__sha1_transform(sctx->state, sctx->buffer);
> +
> +	for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
> +		put_unaligned_be32(sctx->state[i], digest++);
> +
> +	*sctx = (struct sha1_state){};
> +}
> +
> +void sha1(const u8 *data, unsigned int len, u8 *out)
> +{
> +	struct sha1_state sctx = {0};
> +
> +	sha1_init(sctx.state);
> +	sha1_update(&sctx, data, len);
> +	sha1_final(&sctx, out);
> +}
> +EXPORT_SYMBOL(sha1);
> +
>  MODULE_DESCRIPTION("SHA-1 Algorithm");
>  MODULE_LICENSE("GPL");
> -- 
> 2.39.3
> 

This looks pretty good and we had already the SHA-1 discussion in
the past :-)

BR, Jarkko

