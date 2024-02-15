Return-Path: <linux-efi+bounces-553-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5727B855C29
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 09:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142362835FB
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 08:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F26A11713;
	Thu, 15 Feb 2024 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp4bxTs6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5761BBA37;
	Thu, 15 Feb 2024 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985050; cv=none; b=EhTyMeAb1uhqTGuGh3p0WkR/D2plUGrqjXAIwEC3IlZuFlvNG0qid/3HGaZ8D5YqTPSW5wct+2Wp9/pysdtqkwJPbuE+XTEZmqnD8+HgQdm1/OozmuT50tdAnMuxIFJ6Q3TOGg9ozhpCEf7vxIQRoA/PQ0OIpK6w0s2AI8S5MWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985050; c=relaxed/simple;
	bh=+P7NF3eRBh0FZLxyVDfg36fNj8Y+3yMND3DUl1RSHA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pw813ssv7SIJMKoA5m4vbN06UaSdsL5MUCN3P7YP0r/z4bF6PaIiuXOw8Z5jmQAeXs0lvCfgzfX6/4k3+WuKSMrWbvRZ54fwwxmWNobsFUaMQlAI+iov2JK3IjeJzFKYwpXpMtwJmKIV5GQDPM0ey0vruruGGkXRkAKDMQRZxgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp4bxTs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFCCC43601;
	Thu, 15 Feb 2024 08:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707985049;
	bh=+P7NF3eRBh0FZLxyVDfg36fNj8Y+3yMND3DUl1RSHA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pp4bxTs6cC7B/IK2Rd9oqNCXU7OmQGOa7A0+1pVKylChCJCpNJjB/uYO2k+Izg4Hx
	 MTV+DpCcYgnEacvbskWvbEDroLKH2YAGmIs/7kpnvz+om1Fhg76hiTdT4j36fI204Q
	 kYOn2JK6l4ceyrs10pU22Bb9NYT0qN1M64CuB08JYb1/ENiV2a7f//1j6aJDWBCpZK
	 azejBHYv5COlp4ydA0PPm0iXb0Cl9bi1B5U80940/B7vFC/CjF7e6xTJwbfpQGL6t9
	 qwf/757MkLkTbJ6fx9LfIBUS/TnWFC7tI1ri1/3Irz3JNGovvA6ZED0dU0FeJj6vKZ
	 wOFmKLTDisT1A==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5112bd13a4fso1749443e87.0;
        Thu, 15 Feb 2024 00:17:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU44Y+FewHEYeoHDI0jpKffVn7E8A0YVxXn2Vk+7/w5Wg+s+WF4hqpEkcMlGDPEOGsWsy9KBueyod9iDZLOiSumXnzAomFflBWIwALcggfGQhwoKUcXfTJd5PZufdtdZsD5NQmZ2JvHJUMRI0f7xPsyjb1RZzArQB3KInKhk+zJdbJKBU11ovdi/KDrKJanQi4+03j6hjli+p/WYOa5SlsCuVJT
X-Gm-Message-State: AOJu0YygaXe1GoWWoS6Dqb69+XrlXjLHWpf/MKw1pUAI/Qy9tJ/8z30y
	Ie6xkPUx6lzYezsT0wyK7qlBSAY8QO2WD43nD+Br6sCQxy3YelqSAjFVhDoieEoLzah3fNCetu9
	VYhi1N2zreJB3w6egE8X1QlNQzbY=
X-Google-Smtp-Source: AGHT+IFaJnFdkQY2OwbLLwiamOuZj8op08dvguEH8JXfmdLHQiJ2OW0H1ADrevkksnugXgljUbU9OZ6MaGg3BfNvJ+s=
X-Received: by 2002:ac2:41c8:0:b0:511:463c:32c1 with SMTP id
 d8-20020ac241c8000000b00511463c32c1mr1514354lfi.19.1707985047858; Thu, 15 Feb
 2024 00:17:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com> <20240214221847.2066632-7-ross.philipson@oracle.com>
In-Reply-To: <20240214221847.2066632-7-ross.philipson@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 09:17:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
Message-ID: <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch
 early measurements
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> The SHA algorithms are necessary to measure configuration information into
> the TPM as early as possible before using the values. This implementation
> uses the established approach of #including the SHA libraries directly in
> the code since the compressed kernel is not uncompressed at this point.
>
> The SHA code here has its origins in the code from the main kernel:
>
> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
>
> A modified version of this code was introduced to the lib/crypto/sha1.c
> to bring it in line with the sha256 code and allow it to be pulled into the
> setup kernel in the same manner as sha256 is.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

We have had some discussions about this, and you really need to
capture the justification in the commit log for introducing new code
that implements an obsolete and broken hashing algorithm.

SHA-1 is broken and should no longer be used for anything. Introducing
new support for a highly complex boot security feature, and then
relying on SHA-1 in the implementation makes this whole effort seem
almost futile, *unless* you provide some rock solid reasons here why
this is still safe.

If the upshot would be that some people are stuck with SHA-1 so they
won't be able to use this feature, then I'm not convinced we should
obsess over that.

> ---
>  arch/x86/boot/compressed/Makefile       |  2 +
>  arch/x86/boot/compressed/early_sha1.c   | 12 ++++
>  arch/x86/boot/compressed/early_sha256.c |  6 ++



>  include/crypto/sha1.h                   |  1 +
>  lib/crypto/sha1.c                       | 81 +++++++++++++++++++++++++

This needs to be a separate patch in any case.


>  5 files changed, 102 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/early_sha1.c
>  create mode 100644 arch/x86/boot/compressed/early_sha256.c
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index f19c038409aa..a1b018eb9801 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -118,6 +118,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>  vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>
> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
> +
>  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>         $(call if_changed,ld)
>
> diff --git a/arch/x86/boot/compressed/early_sha1.c b/arch/x86/boot/compressed/early_sha1.c
> new file mode 100644
> index 000000000000..0c7cf6f8157a
> --- /dev/null
> +++ b/arch/x86/boot/compressed/early_sha1.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Apertus Solutions, LLC.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/linkage.h>
> +#include <linux/string.h>
> +#include <asm/boot.h>
> +#include <asm/unaligned.h>
> +
> +#include "../../../../lib/crypto/sha1.c"
> diff --git a/arch/x86/boot/compressed/early_sha256.c b/arch/x86/boot/compressed/early_sha256.c
> new file mode 100644
> index 000000000000..54930166ffee
> --- /dev/null
> +++ b/arch/x86/boot/compressed/early_sha256.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Apertus Solutions, LLC
> + */
> +
> +#include "../../../../lib/crypto/sha256.c"
> diff --git a/include/crypto/sha1.h b/include/crypto/sha1.h
> index 044ecea60ac8..d715dd5332e1 100644
> --- a/include/crypto/sha1.h
> +++ b/include/crypto/sha1.h
> @@ -42,5 +42,6 @@ extern int crypto_sha1_finup(struct shash_desc *desc, const u8 *data,
>  #define SHA1_WORKSPACE_WORDS   16
>  void sha1_init(__u32 *buf);
>  void sha1_transform(__u32 *digest, const char *data, __u32 *W);
> +void sha1(const u8 *data, unsigned int len, u8 *out);
>
>  #endif /* _CRYPTO_SHA1_H */
> diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
> index 1aebe7be9401..10152125b338 100644
> --- a/lib/crypto/sha1.c
> +++ b/lib/crypto/sha1.c
> @@ -137,4 +137,85 @@ void sha1_init(__u32 *buf)
>  }
>  EXPORT_SYMBOL(sha1_init);
>
> +static void __sha1_transform(u32 *digest, const char *data)
> +{
> +       u32 ws[SHA1_WORKSPACE_WORDS];
> +
> +       sha1_transform(digest, data, ws);
> +
> +       memzero_explicit(ws, sizeof(ws));
> +}
> +
> +static void sha1_update(struct sha1_state *sctx, const u8 *data, unsigned int len)
> +{
> +       unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> +
> +       sctx->count += len;
> +
> +       if (likely((partial + len) >= SHA1_BLOCK_SIZE)) {
> +               int blocks;
> +
> +               if (partial) {
> +                       int p = SHA1_BLOCK_SIZE - partial;
> +
> +                       memcpy(sctx->buffer + partial, data, p);
> +                       data += p;
> +                       len -= p;
> +
> +                       __sha1_transform(sctx->state, sctx->buffer);
> +               }
> +
> +               blocks = len / SHA1_BLOCK_SIZE;
> +               len %= SHA1_BLOCK_SIZE;
> +
> +               if (blocks) {
> +                       while (blocks--) {
> +                               __sha1_transform(sctx->state, data);
> +                               data += SHA1_BLOCK_SIZE;
> +                       }
> +               }
> +               partial = 0;
> +       }
> +
> +       if (len)
> +               memcpy(sctx->buffer + partial, data, len);
> +}
> +
> +static void sha1_final(struct sha1_state *sctx, u8 *out)
> +{
> +       const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
> +       unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> +       __be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
> +       __be32 *digest = (__be32 *)out;
> +       int i;
> +
> +       sctx->buffer[partial++] = 0x80;
> +       if (partial > bit_offset) {
> +               memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
> +               partial = 0;
> +
> +               __sha1_transform(sctx->state, sctx->buffer);
> +       }
> +
> +       memset(sctx->buffer + partial, 0x0, bit_offset - partial);
> +       *bits = cpu_to_be64(sctx->count << 3);
> +       __sha1_transform(sctx->state, sctx->buffer);
> +
> +       for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
> +               put_unaligned_be32(sctx->state[i], digest++);
> +
> +       *sctx = (struct sha1_state){};
> +}
> +
> +void sha1(const u8 *data, unsigned int len, u8 *out)
> +{
> +       struct sha1_state sctx = {0};
> +
> +       sha1_init(sctx.state);
> +       sctx.count = 0;
> +       sha1_update(&sctx, data, len);
> +       sha1_final(&sctx, out);
> +}
> +EXPORT_SYMBOL(sha1);
> +
>  MODULE_LICENSE("GPL");
> --
> 2.39.3
>

