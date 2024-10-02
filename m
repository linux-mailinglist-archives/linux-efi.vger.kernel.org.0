Return-Path: <linux-efi+bounces-1886-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A21FC98E3D1
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 22:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7AD1F258A4
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 20:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69D4216A22;
	Wed,  2 Oct 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BoiWZdB1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3B1946D0
	for <linux-efi@vger.kernel.org>; Wed,  2 Oct 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899337; cv=none; b=TvVJB6OElucCtE1MnWB6hqO8qGQKWj88S4LdWMBfX6VYPHwkW/EoIG1S7vpNkzco6i9F2FEYwD8Afp/HCwhcJgDY/40TNzbOWw3reo8Tx/gMvA+kTP6kVn9k+h1EEMIxMyvtTufP9z2RLP9KsHya5H751yJt/isUDx+FfxhBVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899337; c=relaxed/simple;
	bh=26ch3VLdZlgASzApmc+sdmN42sQrSbzi8ri/yXB2hcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBnfehUnktm+vnQwOrjmTGYtsYDZek4W4MkapUGowN5YTsdcsfSsnGuDNalpwiAOTwOzxReB+Qlwe4mqpZWS5Jyi5GblBOHp5tm2XRNffmg5kiQEIXT+tQG4dGoM1FM0KQrqjhcim3r7KKqorTu/raNEC3TaoqIXtN9nzN/1eB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BoiWZdB1; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53992157528so162068e87.2
        for <linux-efi@vger.kernel.org>; Wed, 02 Oct 2024 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727899334; x=1728504134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=felyUMZ1epn3qYN0qQZjWDzIrXK7nsXRUmOCiXehfgQ=;
        b=BoiWZdB1jaLgrdVieRqNpte70TeVVoJoB4Ot0U9FGSx2154Hp1pYAcQkDqc4jKQJMY
         uL4H578yrhuGWa+A0JLPhYcOyCewydT+LMUPWVI5wJxrFbe/sZI08XV+EuzQLkI8fXbc
         ccHBuSYLT84e10Eu0V+VqaDZFSKqJNv7tlGZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899334; x=1728504134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=felyUMZ1epn3qYN0qQZjWDzIrXK7nsXRUmOCiXehfgQ=;
        b=loJVyHQ2a5xD3eV8BHVRV8laX8tpuKvmGg2JQUeNfRKSTp9U+QS/8gI0FvSaxRjDj7
         kMBH1Gh73U5G4vivR/6WORN0tzb5iXFtouyQfyw9kWhMMN5s7TBO2/5WmL/edR4sbbXp
         nTN+EMEbwCeM61N9f12YiXzpDcEPrCXmQx68JC58oRBNdfdSnuNI4csSOAuU7hHxuT91
         78m4qVkoc3rsTf55oK4+dfx8dE03RYI3FMgGmGiByIhp8F3XfdW5AYpRLgFXjxqBjYn9
         TA8lKbZnqkDq0KjS5oaMgeIu3S0ZFf7xkGbH54qhIoqkF2npzBNMTe8W0vWOb4MMEf2B
         LFvA==
X-Forwarded-Encrypted: i=1; AJvYcCWAWAAEb1QMFeBULcG5vDmmA9TFceknJoSZixoAgH5f03JH5IAN+FXqpbuzlMJeRWHAXHXrxGDZ7Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99p7zlawXdYh6HNnM6sD0lpeoslndGN17XqWdESP2LWtUGJbt
	FoBoKn1+7FTYoUuc1Z8wHvwzCRcbO2qMWvfTPd7EGy9EqbD5KvW/+UtoJt1h6vFv26Lc4u8uOxS
	EmyAiBA==
X-Google-Smtp-Source: AGHT+IH2f9hKO2b4y5VaWAccK07HL2f9AFpuUAzbSmWnQxec6qChpYNZKG9Au73w0RVF3FcJninvNw==
X-Received: by 2002:a05:6512:110f:b0:52e:be84:225c with SMTP id 2adb3069b0e04-539a0684ff3mr2582224e87.33.1727899333678;
        Wed, 02 Oct 2024 13:02:13 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a4fa5ef7sm176155e87.190.2024.10.02.13.02.09
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:02:09 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2facf481587so1697071fa.1
        for <linux-efi@vger.kernel.org>; Wed, 02 Oct 2024 13:02:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuqXYiYlRVjomLWko1tfYRt+N2FFFvuquLJEMI5Y4XLAWEqSmpsR6TX0p+/vp55r1YEOjt7jN/Wis=@vger.kernel.org
X-Received: by 2002:a05:6512:e9e:b0:535:6795:301a with SMTP id
 2adb3069b0e04-539a079eb59mr2506573e87.47.1727899328912; Wed, 02 Oct 2024
 13:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
 <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
In-Reply-To: <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Oct 2024 13:01:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
Message-ID: <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
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

On Wed, 2 Oct 2024 at 08:31, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> I guess you are referring to the use of a GOT? That is a valid
> concern, but it does not apply here. With hidden visibility and
> compiler command line options like -mdirect-access-extern, all emitted
> symbol references are direct.

I absolutely hate GOT entries. We definitely shouldn't ever do
anything that causes them on x86-64.

I'd much rather just do boot-time relocation, and I don't think the
"we run code at a different location than we told the linker" is an
arghument against it.

Please, let's make sure we never have any of the global offset table horror.

Yes, yes, you can't avoid them on other architectures.

That said, doing changes like changing "mov $sym" to "lea sym(%rip)" I
feel are a complete no-brainer and should be done regardless of any
other code generation issues.

Let's not do relocation for no good reason.

             Linus

