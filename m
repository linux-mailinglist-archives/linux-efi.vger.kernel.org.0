Return-Path: <linux-efi+bounces-2709-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF19A1928D
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 14:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D6518827BA
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9030238DF9;
	Wed, 22 Jan 2025 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2GaD4ng"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511671E4AB;
	Wed, 22 Jan 2025 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552667; cv=none; b=K2I4TeGAkX8BpaKqTEnC06EDE9mQ8By6cQuFMMQsTgmDljodOhQguPxMI5H9bKVPTPS79AM7HzlYEO2di/03CT2y19GdLx1hQoy6rhM5zAjzKJKZt7uD8ykmFNML4LGKfH7iQz90LI5oAXAvs2Ndhv2numLhMjycS0CupMxleDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552667; c=relaxed/simple;
	bh=LhnVHj7/w6MmA7Ef3xCvMNQ5H+ZeFX2reDpyaZCxhzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLStwzqTlmuVGldw9eaPmWd9yCH6s2ViIUK4HpPDYhqmHzYb00SHg/hW6dyBgfov4iZ15ce4wBJ3A4mbChlJ85z9PBbjUO/M72TVhUBsOVkeYPJJYLjAJxYArygb9MR92fkdgwxzOkFnUBHiEqmYo/nTg4v76Jz4GN7JFDdFBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2GaD4ng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19EBC4CEE2;
	Wed, 22 Jan 2025 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737552666;
	bh=LhnVHj7/w6MmA7Ef3xCvMNQ5H+ZeFX2reDpyaZCxhzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a2GaD4ngb8M3KS1JNRxn4krQn7nT9EhxppJYPV9VxDAXT2xcLLyeNhjrsOW4k270C
	 SJYwEAxfYie0aLrxn0ClaB8oWzBSVIrX0otSXrjR54TLMOg0FWGlk23+Og8+FvwyYK
	 7/Izopsz1THteWLMPzgQA9SV74iJtKuAWWEqoETnpDfDLb7khqUqeHoOLij2UovALW
	 FTdzS+4WkBmyANqi4F5L+Lzx2ayh8hj94JhXdfMljolb5VKIJEjy5I4r5sSuFcbjFm
	 aYBcIt00jAab4VWt6XnjJWm6MXO9o4WjqlusZGFMoCBbphHvQLH5X4OW1OXJCgoRc3
	 23DeTJ/oFtEpA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso7392258e87.0;
        Wed, 22 Jan 2025 05:31:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6dEdPfqs3dkIzeWWAKS9S9BHNp2bWkNQymtYYMSxcXzaBzEQWbk4RLEnqXcF9wcOBhN4xwA2IQGA=@vger.kernel.org, AJvYcCUWFa79VSeNtD7x9EY4t4y7fKD/KQkB11/9Tbq3oYBw0oHB0+HY4ipJFQ6v+CimnHijMuC8pU4svc472Jgx@vger.kernel.org, AJvYcCV5FryzE0EfOQN1lrzQfkgqniRA3GhIC8q9XAKnamhOpL/dQ/V1dzo644+41Sx8nN1GY82phv3dDHiE0S99@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg/Bcri/mqd2Do8JXJJRgU/jzgf1H03sSD+8IGhdAFB69CNXo1
	YxctUO2r2rJG7mjNa4WP57U3C10LWJqs/YYBc+2vHMOrWZVJR/RRqLhKo+r3Xz6/9I1Ke5DC/1M
	ncUxX0VGV9fK9S9+nACI+FIFyEcU=
X-Google-Smtp-Source: AGHT+IHYqOJc2GNA6pw3RGBn3c/7uybx/iFCZe1yyY9Eq4w8BhpW+Y82xKA+2xmsmRLNGMmTNi2SstOrTc/T79hXGCo=
X-Received: by 2002:ac2:5d6e:0:b0:542:2972:4e59 with SMTP id
 2adb3069b0e04-5439c249f21mr7015360e87.28.1737552665106; Wed, 22 Jan 2025
 05:31:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121-kernel-compress-fast-v1-1-fa693b6167d4@google.com>
In-Reply-To: <20250121-kernel-compress-fast-v1-1-fa693b6167d4@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 22 Jan 2025 14:30:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF-GSB9Ty7X1h4u1uA6qhO1Y1UvVrNF=R+hk3PENRz7WA@mail.gmail.com>
X-Gm-Features: AbW1kvaUL7vB4-PXnsAYQI9FovTnhkdw6qZWe0EEWaHtkD_IQz9_yU0vcB3uWyg
Message-ID: <CAMj1kXF-GSB9Ty7X1h4u1uA6qhO1Y1UvVrNF=R+hk3PENRz7WA@mail.gmail.com>
Subject: Re: [PATCH RFC] x86: Add CONFIG_KERNEL_UNCOMPRESSED support
To: Jann Horn <jannh@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-efi@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jann,

On Tue, 21 Jan 2025 at 23:16, Jann Horn <jannh@google.com> wrote:
>
> Support storing the kernel uncompressed for developers who want to quickly
> iterate with one-off kernel builds.
> Store it in the usual format with a 4-byte length suffix and keep this new
> codepath as close as possible to the normal path where decompression
> happens.
>
> The other compression methods offered by the kernel take some time;
> even LZ4 (which the kernel uses at compression level 9) takes ~2.8
> seconds to compress a 110M large vmlinux.bin on my machine.
>
> An alternate approach to this would be to offer customization of the LZ4
> compression level through a kconfig variable; and yet another approach
> would be to abuse the existing gzip decompression logic by storing the
> kernel as "non-compressed" DEFLATE blocks, so that the decompression code
> will essentially end up just doing a bunch of memcpy() calls.
>

This all seems pretty complicated, and adding yet another
(pseudo-)compression method is not great in terms of maintenance
burden, especially because there are other consumers of the compressed
images (both for bzImage and EFI zboot)

Did you try running gzip with -1 instead of -9? On my build machine,
this reduces the compression time of a defconfig bzImage build from
4.3 seconds to 0.9 seconds.

