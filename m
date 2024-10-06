Return-Path: <linux-efi+bounces-1910-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DD4991B7B
	for <lists+linux-efi@lfdr.de>; Sun,  6 Oct 2024 02:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F37B211D4
	for <lists+linux-efi@lfdr.de>; Sun,  6 Oct 2024 00:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C42D19A;
	Sun,  6 Oct 2024 00:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CyoKNuLz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C79191
	for <linux-efi@vger.kernel.org>; Sun,  6 Oct 2024 00:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728173163; cv=none; b=h9R+dXfXUOAR9Iulybou7hX6wLzNJ8PA9O6AWDqUIZj6qzgpJEu4X99R28iP6LL4N+RaFAYKGojcnuBDGtKJEHRwjNm6VLQENCrmI1QexrAFVGC689M+VmhAukHhNpmT+TH4ITOe8Zj9VtePHf+M7FpY5krH9a25INbeV6zyoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728173163; c=relaxed/simple;
	bh=7PhV7mSmrjXdm322I5AhDI6uiC32DXT2Ek81VrbJ7rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EECkkXT4YsyHkSGB5BOsoOHR6TnkFNllhzwLj5THwBkuF/sv4EClywUkK2MBRcE/9SCIH+vtQgB3YGJJu4Xk3VMsiKQYikWnJWl3P9LejT1WkJhvP2jaEnFoO9ILrQpmW5MjXGPaNlCf9jXd7/mxoZwMcpNjgGwV/GZ9RhwnR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CyoKNuLz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c882864d3aso3569091a12.2
        for <linux-efi@vger.kernel.org>; Sat, 05 Oct 2024 17:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728173155; x=1728777955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zwWtZnU6O3CUnR/7Ge8+NpuQOrJwSLSqT8+8zcDG8JI=;
        b=CyoKNuLzYWZgTc8nUn04n7kUyBrdZacKWJ6ABAR0YhqyvhUqMrWdq5po5jfyG5Xcjt
         uESCJRcfGVeiS616WzSiE0Tjd/9gU8HkoHIQgfLTO0zc9IpcH37TRSzp8PDW88e4jMeR
         SnAiXInMHIEc5gwAId3TowceTbC2I/Egg7RNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728173155; x=1728777955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwWtZnU6O3CUnR/7Ge8+NpuQOrJwSLSqT8+8zcDG8JI=;
        b=E8u4ktgT1jVddXjDQmsWrPOfPUnViPuR5RskSCH8OUe/k1Ytu4BSSrPImGy7gYl8vb
         Eqllv6B2wdbytI4DXgO+DgoTDdFTRpTjrbHKyVJP1Q7FRH0VryGJPmoAePWV8BEI3gcH
         +SN1yB0Soc58yIRm5txsW7VXNZabGUqti7FL5VfTv77MEmt5liohnc0p0enGRIgqn7UU
         ILzQddQDHiNWiRAqffVeOU4FVEH7XtDe/prGqRtoFWF63uqXIg4EMan0K9zAqCpo6pcA
         UCQOyTc8B/mivqRm3eNqRNKlaRdUYu8LU5pwUzAr4l+4KVOFTmR3O3e1fFg3l0f0A6mY
         emaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh34JUDtOsBksxmmbytQeFim9fWK9ju7vPTsBGDYopVXs1hCEYgeqCHc+Tr0PwQBE/F1OEj83CIGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7VNX83+OD9Nr+bui4ksGcjhRrZjXvhg3PMAx1IZ3iBT3myolL
	pSMwhjfXowURELdBsH7/PDnPYtQ2OU2Lj3wYXAIYNtbp0S0we/fle39g8zVz+koNIogSy8bc81g
	wGPcdbQ==
X-Google-Smtp-Source: AGHT+IHjfd+lQdzvC3lR9B6HSW/vSSFOAlI/MD5Qng5FM6oKSiMHhDBNCon3RQkA8ki88ktLy+xeSA==
X-Received: by 2002:a17:906:cae0:b0:a8d:7210:e295 with SMTP id a640c23a62f3a-a991bcfbef8mr612444466b.10.1728173155506;
        Sat, 05 Oct 2024 17:05:55 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05951b1sm1502064a12.2.2024.10.05.17.05.53
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 17:05:54 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c5bca59416so4330231a12.1
        for <linux-efi@vger.kernel.org>; Sat, 05 Oct 2024 17:05:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtfAxTI+qDr5LW6/qn1DnuwqefJTS3RR6tewYTrkGV2bhRS7nNt45rOQ8evGbYZ9RB2IlzQM7twAc=@vger.kernel.org
X-Received: by 2002:a17:907:9693:b0:a99:3d93:c8bc with SMTP id
 a640c23a62f3a-a993d93cc22mr339286866b.13.1728172818387; Sat, 05 Oct 2024
 17:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
 <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
 <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
 <CAMj1kXEU5RU0i11zqD0433_LMMyNQH2gCoSkU7GeXmaRXGF1Yw@mail.gmail.com>
 <5c7490bb-aa74-427b-849e-c28c343b7409@zytor.com> <CAFULd4Yj9LfTnWFu=c1M7Eh44+XFk0ibwL57r5H7wZjvKZ8yaA@mail.gmail.com>
 <3bbb85ae-8ba5-4777-999f-d20705c386e7@zytor.com>
In-Reply-To: <3bbb85ae-8ba5-4777-999f-d20705c386e7@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Oct 2024 17:00:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkgnyW2V4gQQTDAOKXGZH0fqN=hApz1LFAE3OC3fhhrQ@mail.gmail.com>
Message-ID: <CAHk-=wgkgnyW2V4gQQTDAOKXGZH0fqN=hApz1LFAE3OC3fhhrQ@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 16:37, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Sadly, that is not correct; neither gcc nor clang uses lea:

Looking around, this may be intentional. At least according to Agner,
several cores do better at "mov immediate" compared to "lea".

Eg a RIP-relative LEA on Zen 2 gets a throughput of two per cycle, but
a "MOV r,i" gets four. That got fixed in Zen 3 and later, but
apparently Intel had similar issues (Ivy Bridge: 1 LEA per cycle, vs 3
"mov i,r". Haswell is 1:4).

Of course, Agner's tables are good, but not necessarily always the
whole story. There are other instruction tables on the internet (eg
uops.info) with possibly more info.

And in reality, I would expect it to be a complete non-issue with any
OoO engine and real code, because you are very seldom ALU limited
particularly when there aren't any data dependencies.

But a RIP-relative LEA does seem to put a *bit* more pressure on the
core resources, so the compilers are may be right to pick a "mov".

               Linus

