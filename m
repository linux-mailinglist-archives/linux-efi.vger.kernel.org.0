Return-Path: <linux-efi+bounces-1136-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6263F8FBBE6
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 20:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838D61C23C39
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 18:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F7B14A4D9;
	Tue,  4 Jun 2024 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Md9bXG+P"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8EF13D88D;
	Tue,  4 Jun 2024 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527149; cv=none; b=E969FA7wLvx2t7jYVgNrYnBfED9kin03VE8CM4IBlUmjXsFfrB68T3T+6qR4gVGIiDyyCIc3T9vWe1YNtY+L4zkf0/+hJA83auDzaiAtw3lOuUmZIgfo+74MZdgmSO2zxIJG/5iPAqkrZhFsMgImMoTe4/9viMmy0notDGTIYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527149; c=relaxed/simple;
	bh=WWH33RP1o5Qg05eJ8r9JvDT1Wv6XYAs8lOgl4ISqoq8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nwGuS4INUhy+5uCMV3OHX79FdKIQi63oRYzKJeK/RzqSZdtnqmXoVb2rAoyhV66fVvR+qnhjzAO+5dlZDcnFXXB5yEptIOOvd/rAjYKQMUaw//EcBrGVozhCr8ilVumZXnF87fuq8rB0gXyJ7uF7F19oQob7kj2UWJAviNfuVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Md9bXG+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D612CC2BBFC;
	Tue,  4 Jun 2024 18:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717527148;
	bh=WWH33RP1o5Qg05eJ8r9JvDT1Wv6XYAs8lOgl4ISqoq8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Md9bXG+PizBDYmRG3tn1IrdW/6JZBrceK1yZ8SUCpiSSD2j81VkmKoPTgTQ25tz+t
	 8ynwvq8HMFa6OhUsZ5oHLquws90ATj8DerOaO9XHRwyBgQ3XlH1MBsHo8nLps1G7v7
	 Og2atXobM6Jo6e6tkgZErgnFD/1tVaDkpHzp+kpmU67Ne7icB6yoSbxz1TlSeC8o4k
	 2Uyu8Eu460PtoI/YSUV++IBS9gmza22773TYhbWLfuZFDnMhiIhWt/TrkxKbRq+QoA
	 /I8Rt6aJYXwmLudczPLW4emg3FGZOUMZH7FMcpnWCHmggtGM7Czq8xbNIaPckcgN4W
	 UnilDqYAur8ZQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 21:52:21 +0300
Message-Id: <D1RGK44SJ477.3BQ82NMUKH2Z8@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-7-ross.philipson@oracle.com>

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> For better or worse, Secure Launch needs SHA-1 and SHA-256. The
> choice of hashes used lie with the platform firmware, not with
> software, and is often outside of the users control.
>
> Even if we'd prefer to use SHA-256-only, if firmware elected to start us
> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
> to safely use SHA-256 for everything else.
>
> The SHA-1 code here has its origins in the code from the main kernel:
>
> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
>
> A modified version of this code was introduced to the lib/crypto/sha1.c
> to bring it in line with the SHA-256 code and allow it to be pulled into =
the
> setup kernel in the same manner as SHA-256 is.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/boot/compressed/Makefile     |  2 +
>  arch/x86/boot/compressed/early_sha1.c | 12 ++++
>  include/crypto/sha1.h                 |  1 +
>  lib/crypto/sha1.c                     | 81 +++++++++++++++++++++++++++
>  4 files changed, 96 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/early_sha1.c
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed=
/Makefile
> index e9522c6893be..3307ebef4e1b 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -118,6 +118,8 @@ vmlinux-objs-$(CONFIG_EFI) +=3D $(obj)/efi.o
>  vmlinux-objs-$(CONFIG_EFI_MIXED) +=3D $(obj)/efi_mixed.o
>  vmlinux-objs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/lib=
stub/lib.a
> =20
> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) +=3D $(obj)/early_sha1.o
> +
>  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>  	$(call if_changed,ld)
> =20
> diff --git a/arch/x86/boot/compressed/early_sha1.c b/arch/x86/boot/compre=
ssed/early_sha1.c
> new file mode 100644
> index 000000000000..8a9b904a73ab
> --- /dev/null
> +++ b/arch/x86/boot/compressed/early_sha1.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Apertus Solutions, LLC.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/linkage.h>
> +#include <linux/string.h>
> +#include <asm/boot.h>
> +#include <asm/unaligned.h>
> +
> +#include "../../../../lib/crypto/sha1.c"
}

Yep, make sense. Thinking only that should this be just sha1.c.

Comparing this to mainly drivers/firmware/efi/tpm.c, which is not
early_tpm.c where the early actually probably would make more sense
than here. Here sha1 primitive is just needed.

This is definitely a nitpick but why carry a prefix that is not
that useful, right?

> diff --git a/include/crypto/sha1.h b/include/crypto/sha1.h
> index 044ecea60ac8..d715dd5332e1 100644
> --- a/include/crypto/sha1.h
> +++ b/include/crypto/sha1.h
> @@ -42,5 +42,6 @@ extern int crypto_sha1_finup(struct shash_desc *desc, c=
onst u8 *data,
>  #define SHA1_WORKSPACE_WORDS	16
>  void sha1_init(__u32 *buf);
>  void sha1_transform(__u32 *digest, const char *data, __u32 *W);
> +void sha1(const u8 *data, unsigned int len, u8 *out);
> =20
>  #endif /* _CRYPTO_SHA1_H */
> diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
> index 1aebe7be9401..10152125b338 100644
> --- a/lib/crypto/sha1.c
> +++ b/lib/crypto/sha1.c
> @@ -137,4 +137,85 @@ void sha1_init(__u32 *buf)
>  }
>  EXPORT_SYMBOL(sha1_init);
> =20
> +static void __sha1_transform(u32 *digest, const char *data)
> +{
> +       u32 ws[SHA1_WORKSPACE_WORDS];
> +
> +       sha1_transform(digest, data, ws);
> +
> +       memzero_explicit(ws, sizeof(ws));

For the sake of future reference I'd carry always some inline comment
with any memzero_explicit() call site.

> +}
> +
> +static void sha1_update(struct sha1_state *sctx, const u8 *data, unsigne=
d int len)
> +{
> +	unsigned int partial =3D sctx->count % SHA1_BLOCK_SIZE;
> +
> +	sctx->count +=3D len;
> +
> +	if (likely((partial + len) >=3D SHA1_BLOCK_SIZE)) {


	if (unlikely((partial + len) < SHA1_BLOCK_SIZE))
		goto out;

?

> +		int blocks;
> +
> +		if (partial) {
> +			int p =3D SHA1_BLOCK_SIZE - partial;
> +
> +			memcpy(sctx->buffer + partial, data, p);
> +			data +=3D p;
> +			len -=3D p;
> +
> +			__sha1_transform(sctx->state, sctx->buffer);
> +		}
> +
> +		blocks =3D len / SHA1_BLOCK_SIZE;
> +		len %=3D SHA1_BLOCK_SIZE;
> +
> +		if (blocks) {
> +			while (blocks--) {
> +				__sha1_transform(sctx->state, data);
> +				data +=3D SHA1_BLOCK_SIZE;
> +			}
> +		}
> +		partial =3D 0;
> +	}
> +

out:

> +	if (len)
> +		memcpy(sctx->buffer + partial, data, len);

Why not just memcpy() unconditionally?

> +}
> +
> +static void sha1_final(struct sha1_state *sctx, u8 *out)
> +{
> +	const int bit_offset =3D SHA1_BLOCK_SIZE - sizeof(__be64);
> +	unsigned int partial =3D sctx->count % SHA1_BLOCK_SIZE;
> +	__be64 *bits =3D (__be64 *)(sctx->buffer + bit_offset);
> +	__be32 *digest =3D (__be32 *)out;
> +	int i;
> +
> +	sctx->buffer[partial++] =3D 0x80;
> +	if (partial > bit_offset) {
> +		memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
> +		partial =3D 0;
> +
> +		__sha1_transform(sctx->state, sctx->buffer);
> +	}
> +
> +	memset(sctx->buffer + partial, 0x0, bit_offset - partial);
> +	*bits =3D cpu_to_be64(sctx->count << 3);
> +	__sha1_transform(sctx->state, sctx->buffer);
> +
> +	for (i =3D 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
> +		put_unaligned_be32(sctx->state[i], digest++);
> +
> +	*sctx =3D (struct sha1_state){};
> +}
> +
> +void sha1(const u8 *data, unsigned int len, u8 *out)
> +{
> +	struct sha1_state sctx =3D {0};
> +
> +	sha1_init(sctx.state);
> +	sctx.count =3D 0;

Hmm... so shouldn't C99 take care of this given the initialization
above? I'm not 100% sure here. I.e. given "=3D {0}", shouldn't this
already be zero?

> +	sha1_update(&sctx, data, len);
> +	sha1_final(&sctx, out);
> +}
> +EXPORT_SYMBOL(sha1);
> +
>  MODULE_LICENSE("GPL");

BR, Jarkko

