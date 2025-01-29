Return-Path: <linux-efi+bounces-2730-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC0BA21934
	for <lists+linux-efi@lfdr.de>; Wed, 29 Jan 2025 09:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17D2164776
	for <lists+linux-efi@lfdr.de>; Wed, 29 Jan 2025 08:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AC419DF4D;
	Wed, 29 Jan 2025 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEQeMiYo"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4EE42A92;
	Wed, 29 Jan 2025 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738140251; cv=none; b=pgGRpyQ2JBbpjdtHZry83LjDIh5g8UlUaKMQwnYM85vtoTQOFfXSSHUQJG/K2c/+rWFdeXHpTfouClJZv5k8ortWLRLsm+GIzoQKY6xg9ZoBW8MTIqCCM27Roi2elGg4LUu5xUWYTsqpjVRoXtL3mzRS99J4vKoN5tRX7J/UwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738140251; c=relaxed/simple;
	bh=UT3TLr5ueHbHqAiqwesmewCMS0aQd6BVne7B2ma2WOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKl7RcJtA+p9svFJ1AYxur3yi1bt/beL+oNEITgMoAK8Yb3j/1s5LPoX1prTZH83mR7YzqRPFexGRpuTSVQaQFsL05qVqTSyi6YAIBIHLRRdU0s3infqy0i/kuysSj4X5wcfdrFH4KQDbfI0hU1KlXwypkAuSrOnCiWwTGCCPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEQeMiYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE6AC4CEE7;
	Wed, 29 Jan 2025 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738140249;
	bh=UT3TLr5ueHbHqAiqwesmewCMS0aQd6BVne7B2ma2WOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qEQeMiYoJsgwgQnRaGxodar7Al03dZgxLnPmBQDX99qYLZsMAtBk0eMt0gPgyT9pQ
	 NJlz1ElylGlbpJf437cF3Fl8u9usIxh7GnNzJSSZMcbObD+OBTM0II6TQTGEzzDDKC
	 nPKYpkyM0WF/bXhKl42py/XPXnI1GrdhImq34eU0rgVIafT8Kc12OS4zJTN05eJGtj
	 yYLIUhJNqv45Z7BGlUF/QP7Rm0CPLLJqZGuDJFB2tk5Un0VN5v49y7OTurmkZzzzbz
	 z6AzzUt9gWu7asDQlV7KnX1WTnHw59QOhQaarLTr5Lu/clwfHwKhOnV4PoKUsOyNzB
	 VSOuPUliOBBkg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3072f8dc069so68108561fa.3;
        Wed, 29 Jan 2025 00:44:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUp6XgW+ALZzNCxVimqLS+WfDq0rDNI3ugCPjmscWH1vBFQg+J21Ie65ytpVYa3Fo3QKPIhfN7Q@vger.kernel.org, AJvYcCVvFvlBAMcmej8Frz6PrcQMdbau/RKIZGAuCRqjCLbm3DtFcoqtrI7UKojFq/cE2Y9LJ43Libs8Pw5PxsJD@vger.kernel.org, AJvYcCXHo5OgBUuxR/IjXI31cIGAzSA23Y58e1yPRS23B4LW8dpLlZxRSs9XzMZlZ0DvDCgrmEKO8CTBr7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0KyrFDcWlKJTKWUoyrbZx1I3qj2wPQGJlYQiHN2/iqZZHBwLs
	mUzDnckex3+bJFm5JK7XQanLEWWXqtPS4ses4VdB40CwH9WZElcNNXg/M0VcIrOGLgauHJC8SAx
	JfZanKGU2u7XVXJ1JtpAnBtBSv18=
X-Google-Smtp-Source: AGHT+IHwJeLWZnk8hHbTDJ2PE/9ykld0OMKpXVsfTxGHZxtkWjxlK0KtWZALol56Pqmz0Xab3nCDQZ6doKqi/HfsIbI=
X-Received: by 2002:a2e:be91:0:b0:302:1d8e:f4fd with SMTP id
 38308e7fff4ca-30796975c27mr7644151fa.35.1738140247879; Wed, 29 Jan 2025
 00:44:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121-x86-use-std-consistently-gcc-15-v1-0-8ab0acf645cb@kernel.org>
 <20250121-x86-use-std-consistently-gcc-15-v1-1-8ab0acf645cb@kernel.org>
In-Reply-To: <20250121-x86-use-std-consistently-gcc-15-v1-1-8ab0acf645cb@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 29 Jan 2025 09:43:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHG-dyF=6CezF1exgnfodjQyuWY9ha8s6+TXBRVKbsO=A@mail.gmail.com>
X-Gm-Features: AWEUYZnXtZyJ4-f9u0mOukWJtvDgnbqEXa9U9ySG5wvsjbWWi3ITgwpTu1_3rdw
Message-ID: <CAMj1kXHG-dyF=6CezF1exgnfodjQyuWY9ha8s6+TXBRVKbsO=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/boot: Use '-std=gnu11' to fix build with GCC 15
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Kees Cook <kees@kernel.org>, 
	Sam James <sam@gentoo.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	stable@vger.kernel.org, 
	Kostadin Shishmanov <kostadinshishmanov@protonmail.com>, Jakub Jelinek <jakub@redhat.com>, 
	Daan De Meyer <daandemeyer@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jan 2025 at 02:12, Nathan Chancellor <nathan@kernel.org> wrote:
>
> GCC 15 changed the default C standard version to C23, which should not
> have impacted the kernel because it requests the gnu11 standard via
> '-std=3D' in the main Makefile. However, the x86 compressed boot Makefile
> uses its own set of KBUILD_CFLAGS without a '-std=3D' value (i.e., using
> the default), resulting in errors from the kernel's definitions of bool,
> true, and false in stddef.h, which are reserved keywords under C23.
>
>   ./include/linux/stddef.h:11:9: error: expected identifier before =E2=80=
=98false=E2=80=99
>      11 |         false   =3D 0,
>   ./include/linux/types.h:35:33: error: two or more data types in declara=
tion specifiers
>      35 | typedef _Bool                   bool;
>
> Set '-std=3Dgnu11' in the x86 compressed boot Makefile to resolve the
> error and consistently use the same C standard version for the entire
> kernel.
>
> Cc: stable@vger.kernel.org
> Reported-by: Kostadin Shishmanov <kostadinshishmanov@protonmail.com>
> Closes: https://lore.kernel.org/4OAhbllK7x4QJGpZjkYjtBYNLd_2whHx9oFiuZcGw=
tVR4hIzvduultkgfAIRZI3vQpZylu7Gl929HaYFRGeMEalWCpeMzCIIhLxxRhq4U-Y=3D@proto=
nmail.com/
> Reported-by: Jakub Jelinek <jakub@redhat.com>
> Closes: https://lore.kernel.org/Z4467umXR2PZ0M1H@tucnak/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/x86/boot/compressed/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed=
/Makefile
> index f2051644de94..606c74f27459 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -25,6 +25,7 @@ targets :=3D vmlinux vmlinux.bin vmlinux.bin.gz vmlinux=
.bin.bz2 vmlinux.bin.lzma \
>  # avoid errors with '-march=3Di386', and future flags may depend on the =
target to
>  # be valid.
>  KBUILD_CFLAGS :=3D -m$(BITS) -O2 $(CLANG_FLAGS)
> +KBUILD_CFLAGS +=3D -std=3Dgnu11
>  KBUILD_CFLAGS +=3D -fno-strict-aliasing -fPIE
>  KBUILD_CFLAGS +=3D -Wundef
>  KBUILD_CFLAGS +=3D -DDISABLE_BRANCH_PROFILING
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

