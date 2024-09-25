Return-Path: <linux-efi+bounces-1828-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEBD98652C
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2024 18:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881AF1F27F5B
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2024 16:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEF06E614;
	Wed, 25 Sep 2024 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D99dvrX6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822516A357
	for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282865; cv=none; b=EFH+XtMRKXhqeRWFTclMExXnSR/HXoXsZ2Q6kQdoTC+Ba++J02aKF5CP+xaXFdDLkw6QfyhQJpaLolsi7aXX7lx6Y75frA4feKezZ0hHlmt8D61XC+B9Nlw9EfMxSlX77EJCrt5wlocqPUAOXb47Bgg611j7V+8SxJncF7tGV9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282865; c=relaxed/simple;
	bh=/t+YSp2gvbsBW9hsAIIEsn2fOHY2XQVupxHXFI22op4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWy1xhC5QIgVJSSUQeOyO1GQViMHnQ3QvJhjib5MSuCEgV36lr/QmJQ9Obma8V2aES1BTS0V7mXBiPYjppWbDHIiiW2mstNbPUGueoUj9B6QG2K3lMPw8uMrpz1ciP1gglqGfDibEzVc7UFbkcCJluLaMI0MiJBsRqZVxA3epSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D99dvrX6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d4979b843so6425266b.3
        for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2024 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727282862; x=1727887662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nj8+qG2S/Bk0hHBrSluJoVQqRkgSfLVqxLrwhmmQqfQ=;
        b=D99dvrX6DktbRoqB9B/v533rxL+jqzPpZkdTCZkhlXx8HvBAcocKmu8aewevKhTv5E
         y/VnJPUgXkMbYwVLpNUeM+i1svw66UfJUs5fXfg+MBv0txo7ZFg+SwYvtX0g2AF5v/QN
         OYfGXyKoC4/LuGvYtEOT8Hut4JZaeGwkmWDTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727282862; x=1727887662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj8+qG2S/Bk0hHBrSluJoVQqRkgSfLVqxLrwhmmQqfQ=;
        b=iSriW8B/27hlIWmgqfEV7fTEf6MXowcAyhhPBRqV8ueQVMNW6tf4+QsVZX8yu8f5nM
         Gy3kiBkrV2kf4IeOD8YXvTdr/lwmgjdGm/BVWfYM7h5i8D4GLX57SiUUTNSnWl9KOerx
         sWdyRGd4a9/nlbyhUviHXvYdB6ipgRYAmwVOUGyXioBXy6IA1fsAthzEXQ+6kxHuzTNI
         9oYtlkHupRhojw28/zEMb+BJitlLpSKy2QPCDtc4Skvp9jM6AzQkZ55WrerI25kHgFUH
         3bTsZvag2SYd0Fqjn/TsxE2KWN+cprvVx17guuTrcLD9CC12kFBWqWkYALIri9Y3bvMy
         vxBw==
X-Forwarded-Encrypted: i=1; AJvYcCVNbHulbfKj21ue5S3n3OpZcTzUvu63akmxM73o4qqOhqE4KGp6Su20N11sabaaYqKJsqS7B2TaOuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlGBhTaJyr7VD/QgXV2L263ym7S0ChsqAcP6VRP4w1JaMvFbjf
	uvvY2ZmW3heRlHfoTIlaKhLZ0plXB+Cqafxk+wriI7NVf7LBQMnavQfLnaaQe7HkrPJSNEjAoaE
	T4Ejh/w==
X-Google-Smtp-Source: AGHT+IHJEt3DpnN7yq6vd17xrWdn/OH+8ZhLbaBJR67egZPBdLyhAehDfkOTtgIQxMJ+OiEu7YakLA==
X-Received: by 2002:a17:907:c891:b0:a8d:5351:bb22 with SMTP id a640c23a62f3a-a93a06e2792mr299425966b.65.1727282861571;
        Wed, 25 Sep 2024 09:47:41 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f7ba4sm229454466b.159.2024.09.25.09.47.40
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:47:41 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d29b7edc2so7486266b.1
        for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2024 09:47:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSVmxZhIOeMAPcNnknitTK0Z4IT7vX53URI24gPnXW6KUVa7Nx5OQ9UGuBbDiPOEuLnGDYQ0nCjUg=@vger.kernel.org
X-Received: by 2002:a17:906:f5a9:b0:a86:9d39:a2a with SMTP id
 a640c23a62f3a-a93a0330c37mr309689066b.8.1727282382886; Wed, 25 Sep 2024
 09:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com> <20240925150059.3955569-44-ardb+git@google.com>
In-Reply-To: <20240925150059.3955569-44-ardb+git@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Sep 2024 09:39:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLYCoGSnqqPq+7fHWgmyf5DpO4SLDJ4kF=EGZVVZOX4A@mail.gmail.com>
Message-ID: <CAHk-=wiLYCoGSnqqPq+7fHWgmyf5DpO4SLDJ4kF=EGZVVZOX4A@mail.gmail.com>
Subject: Re: [RFC PATCH 14/28] x86/rethook: Use RIP-relative reference for
 return address
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
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

On Wed, 25 Sept 2024 at 08:16, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> Instead of pushing an immediate absolute address, which is incompatible
> with PIE codegen or linking, use a LEA instruction to take the address
> into a register.

I don't think you can do this - it corrupts %rdi.

Yes, the code uses  %rdi later, but that's inside the SAVE_REGS_STRING
/ RESTORE_REGS_STRING area.

And we do have special calling conventions that aren't the regular
ones, so %rdi might actually be used elsewhere. For example,
__get_user_X and __put_user_X all have magical calling conventions:
they don't actually use %rdi, but part of the calling convention is
that the unused registers aren't modified.

Of course, I'm not actually sure you can probe those and trigger this
issue, but it all makes me think it's broken.

And it's entirely possible that I'm wrong for some reason, but this
just _looks_ very very wrong to me.

I think you can do this with a "pushq mem" instead, and put the
relocation into the memory location.

                 Linus

