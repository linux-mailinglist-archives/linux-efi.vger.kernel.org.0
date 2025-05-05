Return-Path: <linux-efi+bounces-3607-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE74AA9E1B
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 23:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81711189BB24
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 21:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753432701BA;
	Mon,  5 May 2025 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zg6B/WN4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694C1C1F12
	for <linux-efi@vger.kernel.org>; Mon,  5 May 2025 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480420; cv=none; b=tVqJ6Fmg2ZmVvdDQJnGkWySe35TVZ885W9WsGGGSs901cVm8Vxsx6FdBMDlFMG0IaAJgPm2KAoJfiYZXxIxx+ktQyDkwVBLx06g5O/dG5lcTnqkuwUecFm9vKEKmkkTm2rXnrzd6NL4UkPUr9diCv/ONG8mwxZPfMAD8eYGx/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480420; c=relaxed/simple;
	bh=8tIV1iyrJQBLcayr0q2mWHnEzttQRdpT4PvsD60taOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWj4fDAHhFlOAw+15GeABcXUWpHewd95KPTeHVoRv+hdhM3dP8y1n0SDzu4Y9YuvoXPjLLZyS95OC8uMVxgt8cL2XvRU/lT9ldzySBjzZVsShDoHqFtKKxdVEnl/ZtBDDbwDTNb+Nr9a1R0AJ0HoPEuVfLl/bLdaP8/okfFjhe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zg6B/WN4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad1b94382b8so324090666b.0
        for <linux-efi@vger.kernel.org>; Mon, 05 May 2025 14:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1746480416; x=1747085216; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qXgSUq4mwPPXkiPTyjzaOpkSyMaUC7J+gL7QQfgAQ34=;
        b=Zg6B/WN4vykSfusH3GUZwUay+pTZFEFhoKc9kFxN7015ROufcU7Cqyv7TIxcyaFGdV
         oBsVWUdSnPCSvgzKVTwkHs0OnBgpdwOhyiQI064lJXckCh0kkNXQKnm9SruIjzu00RtQ
         t6ubVnsZkum/yAGKIoIewjKgkh3mpFKJ1R3ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746480416; x=1747085216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXgSUq4mwPPXkiPTyjzaOpkSyMaUC7J+gL7QQfgAQ34=;
        b=k9pcRApKbolfH9rmkrFxaS8qd1/UH1XA+aMt2DSJBr37LT15rdYwMpboLLy4lPA6uM
         4buROzfHRTdSSwpINT6KJd2iljXUAHLARZ9DsJuVssNieKyBnlAmSzYoBeCA2ZcTXhg8
         Xr3gPhhy/F1E+k/7qQLf/o4r3/yo+C3RaUN6O5/Zujx5ki9zYTnH5SumR+Mq/Iz56EYU
         qykhxvwUV2gbNcOY6OHuch6/Cmm5IZVZaovpW6kYcBYtj7+xmARLilOAYlECGzh8oBay
         3GLX+8KZ6YQscScMUHYVHDvXKB2nvR17ZEdSyPbVbCXW6asfoldihJ0qUWHjyeQ1FpXu
         MacA==
X-Forwarded-Encrypted: i=1; AJvYcCVh8dRpYv4vD5kyMpF4fHqLO4UxbuJzcRJC+4ZFG9iq4wZQ61XROxmb+zxPRlV2H1BTtDBFRlsjaQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkIRorzjyWr/b/DukvAKgEenne9D8VWK6TnRwb7FBTT7nt2rys
	BL+QwFam6xErLiXzB2L7oSj2y//qrO/jofz2iQC8NwkIxy76od5OOV3n+NlQFOAWBOuxJy51Yrc
	kl48=
X-Gm-Gg: ASbGncspJHEcnCci4OAVhleBntbfPSWZ4DS1m/W7eyoE70/gW4wd4si1N+UEUl/ggyl
	H+bGRsQ9l26ymDto9UMikcvEkTd96eYB6U3psQosOQhQZU5rrs4bDvmVxdOsA3U0c+l+tggWeqX
	HD7AHSsw1mbsYqUcMi0ddsLsWNLytkhgEh4FCoBaitJEdg2klx80dpS2LJ67fUUZ2qL3uFixTOt
	tbMygSzzm+nhW64lQSiKrY24A+2hfUdrOaVvcO8eXxLKoclYm5er6v1YvRKNaMVzE2/BifKZwNE
	x2gKRN9NzWJH5QmPr/egsvF7Bv8BloCjopD8Sm9ZNeZjyDolOhLciyOM6V+YtXOAjAd8w6AJB6A
	qeE+EvReL+WD//50=
X-Google-Smtp-Source: AGHT+IEfYzYNHskkjMopZDkiD6vt30AL7CljW6eMrkWgYUBJuc1mMqLG2Auf4XrY9mLpdN+g6feDIw==
X-Received: by 2002:a17:907:c08b:b0:ac7:18c9:2975 with SMTP id a640c23a62f3a-ad1d467afd3mr52418066b.48.1746480415816;
        Mon, 05 May 2025 14:26:55 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189540ea1sm552578166b.184.2025.05.05.14.26.53
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 14:26:54 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f7ec0e4978so4183992a12.1
        for <linux-efi@vger.kernel.org>; Mon, 05 May 2025 14:26:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9D2RWj/8u15fQRHh0CdkMy3EBqYYrve7DabI4Zsyv95jABMSpQena7eDGEULhwJ9fGfOtvXlSdNA=@vger.kernel.org
X-Received: by 2002:a05:6402:2755:b0:5fb:3ad3:cfb with SMTP id
 4fb4d7f45d1cf-5fb70d52653mr415902a12.31.1746480412818; Mon, 05 May 2025
 14:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250504095230.2932860-28-ardb+git@google.com> <aBdwwR52hI37bW9a@gmail.com>
 <CAHk-=wiaEzS_7CBVTz3RYnDt5zJus_GsPtfSjojkqiiMU-vSHQ@mail.gmail.com> <aBkogDfWB14qkY4g@gmail.com>
In-Reply-To: <aBkogDfWB14qkY4g@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 May 2025 14:26:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVfjzxBeR9ypA6Y5dRbyKpZvQO8nsAPcFRAABW8QVzTw@mail.gmail.com>
X-Gm-Features: ATxdqUHwQ7H4IdtWIpmw2YUesU-ykS1suBpDPxucG6m-nzzuBAUCBQodQRLW3FA
Message-ID: <CAHk-=wjVfjzxBeR9ypA6Y5dRbyKpZvQO8nsAPcFRAABW8QVzTw@mail.gmail.com>
Subject: Re: [RFT PATCH v2 03/23] x86/boot: Drop global variables keeping
 track of LA57 state
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 May 2025 at 14:07, Ingo Molnar <mingo@kernel.org> wrote:
>
>  - MAX_PHYSMEM_BITS: (inlined 179 times)
>
>        arch/x86/include/asm/sparsemem.h:# define MAX_PHYSMEM_BITS       (pgtable_l5_enabled() ? 52 : 46)
>
>    This could be implemented via a precomputed, constant percpu value
>    (per_cpu__x86_MAX_PHYSMEM_BITS) of 52 vs. 46, eliminating not just
>    the CR4 access, but also a branch, at the cost of a percpu memory
>    access. (Which should still be a win on all microarchitectures IMO.)

This is literally why I did the "runtime-const" stuff. Exactly for
simple constants that you don't want to load from percpu memory
because it's just annoying.

Now, we only have 64-bit constant values which is very wasteful, and
we could just do a signed byte constant if we cared.

(We also have a "shift  32-bit value right by a constant amount",
which actually does use a signed byte, but it's masked by 0x1f because
that's how 32-bit shifts work).

I doubt we care - I doubt any of this MAX_PHYSMEM_BITS use is actually
performance-critical.

The runtime-const stuff would be trivial to use here if we really want to.

>  - PGDIR_SHIFT: (inlined 156 times)

Several of those are actually of the form

   #define PGDIR_SIZE      (1UL << PGDIR_SHIFT)

so you artificially see PGDIR_SHIFT as the important part, even though
it's often a different constant entirely that just gets generated
using it.

>  - p4d_offset(): (inlined 60 times)
>    Here pgtable_l5_enabled() is used as a binary flag.

static branch would probably work best, and as Ard says, just using
cpu_feature_enabled() would just fix it..

>  - pgd_none(): (inlined 49 times)
>    Binary flag use as well, although the compiler might eliminate the
>    branch here and replace it with 'AND !native_pgd_val(pgd)'

This could easily be done as runtime-const.

But again, I doubt it's all that performance-critical.

>  - PTRS_PER_P4D: (inlined 46 times)
>    This too could be implemented via a precomputed constant percpu
>    value (per_cpu__x86_PTRS_PER_P4D), eliminating a branch,
>    or via an ALTERNATIVE() immediate constant.

Again, we do have that, although the 64-bit constant is a bit wasteful.

The reason runtime-const does a 64-bit constant is that the actual
performance-critical cases were for big constants (TASK_SIZE) and for
pointers (hash table pointers).

           Linus

