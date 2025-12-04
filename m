Return-Path: <linux-efi+bounces-5797-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781E1CA3A78
	for <lists+linux-efi@lfdr.de>; Thu, 04 Dec 2025 13:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 760FB3034DCD
	for <lists+linux-efi@lfdr.de>; Thu,  4 Dec 2025 12:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7411D312827;
	Thu,  4 Dec 2025 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zflf3ko1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7152D7394
	for <linux-efi@vger.kernel.org>; Thu,  4 Dec 2025 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852462; cv=none; b=F0XbYS3hcWhE9fhQBsOE6LNRKL9b3yGh8nUuCu7DawJAQbJ7ol1DyHkpNv5bTjSeNwnoNO8k4Q1bpvZ0XF2ERIlwtbnqAc3UDzG2o829feNlxUjQWxPYMD93P1IkWrhnyK72bdwkN6DAk/Z9ZoByZjCagE5t9kywNd/JJ+H4o1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852462; c=relaxed/simple;
	bh=Bp5V8MZ0KAqAzujq8gt5YLEhkw9TRblDujQQQnPcDKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URj3+bBf9+mVfK60OtDv0PEXLB9zezNmQgJs2vpsRNvxxTlog4Up4mMy5KOIcmCSKcYMc2zrLhr7E9YZa7HuyleclvpaxSBYjvkIxOVcw4y3p4+CGBULcwVYvzWQc0ngqww9nY9rj5LZDYCGMt85pnZyfW1KJunO7uApgENKsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zflf3ko1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEA8C113D0
	for <linux-efi@vger.kernel.org>; Thu,  4 Dec 2025 12:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764852461;
	bh=Bp5V8MZ0KAqAzujq8gt5YLEhkw9TRblDujQQQnPcDKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zflf3ko1/M5I4AAW0lxKgSKJrIeZ5AT13Hta3cJ9eaoaEILihqfJ91eQiKHEED3pN
	 OCzG0wPqFowJJX0cM5JUjKEQlCql7iawgNo4T4AcYcu3H0tyVBgAc7v97moqLfgDBp
	 5cirz3ecoXPr5VsAvsUPthDmCVamIXHdehuSsoOOHFxiVwsEKtiiU5EmByqBDwnodA
	 H6u6iT/1zyGotd5R1S5HSh+k3bAzFFX7ggHjgC/wtCv+083SJSDJ0jwdS8rIJEA/jx
	 +ExxUcr4dcALnqmiqhOvQhc8MqyF0VIXwpEKobPrSz0Bk2r2WDXtl4IWFUswcyoT2X
	 1kS9JYLSDMjjQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5957753e0efso899728e87.1
        for <linux-efi@vger.kernel.org>; Thu, 04 Dec 2025 04:47:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJeX8LfLRIbpK9iniUuk2M+dWnl22/12jao8B7Lh12lnKHUxpULbKY2B44dZAZbyhzceCAk8MKdiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/6btFD1M7FrO/Wo1PG8w+PvJ68obFKQD25u7wxjiuT+xmiCI5
	gOhnt+v+caf4KUYjRjObnD1FoHnVn03wl4fM+sxkvhvPIwNvDtGe2wI6VF5zgsukO0UX5qObwQY
	c+82d4bSLM56YbTZXHjAhmIkkUxNKWPo=
X-Google-Smtp-Source: AGHT+IGhUxsw2EU/zA12mRpW0o5VtvMBxS2+ptARH5WKiuIRDrs6lWv7OGyhiew9pKovxm0YcyqtA4/ZQrfJcr0tIjw=
X-Received: by 2002:a05:6512:334d:b0:597:d6d0:58d5 with SMTP id
 2adb3069b0e04-597d6d05a1fmr661830e87.31.1764852460199; Thu, 04 Dec 2025
 04:47:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204072143.3636863-1-sohil.mehta@intel.com>
In-Reply-To: <20251204072143.3636863-1-sohil.mehta@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Dec 2025 13:47:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFicnmVUeoRsMNbBgDN20fCN+R01H9shcgOJMD2Nzn8Cg@mail.gmail.com>
X-Gm-Features: AWmQ_bm4iUFaneMj_OFCdP8f6DbBblPoRHpxW-NetYs8jI8uBn5aMFOqN_lpj2k
Message-ID: <CAMj1kXFicnmVUeoRsMNbBgDN20fCN+R01H9shcgOJMD2Nzn8Cg@mail.gmail.com>
Subject: Re: [PATCH 0/3] x86: Extend LASS support to EFI configurations
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Tony Luck <tony.luck@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Sohil,

On Thu, 4 Dec 2025 at 08:23, Sohil Mehta <sohil.mehta@intel.com> wrote:
>
> Linear Address Space Separation (LASS) is currently disabled [1] when
> support for vsyscall emulation or EFI is compiled in. This series
> extends LASS support to EFI-enabled configurations.
>
> Issues with EFI
> ---------------
> EFI boot and runtime services are incompatible with LASS because they
> end up accessing addresses with bit 63 cleared, which is blocked by LASS.
>
>   1) The most obvious one is the SetVirtualAddressMap() runtime service,
>   which is expected to be called in EFI physical mode [2].
>
>   2) Boot services code and data are referenced long after
>   ExitBootServices(). For example, efi_check_for_embedded_firmwares()
>   accesses boot services memory even after SetVirtualAddressMap().
>

These accesses use the kernel direct map, so I don't think they come
into play here.

>   3) Some runtime services fail to switch to virtual mode properly and
>   continue referencing physical addresses [3]. The kernel maintains a
>   1:1 mapping of all runtime services code and data regions to avoid
>   breaking such firmware.
>

In [3], I mainly elaborated on why it is still necessary to call
SetVirtualAddressMap(), and why it needs to be called with a mapping
in the upper address range.

For this particular call, there is no choice but to disarm LASS, given
that the lower mapping is still active at this point.

However, that does not imply that we have to assume that systems that
support LASS (which are fairly recent AIUI) are buggy in the same way,
i.e., that they access addresses in the 1:1 region after
SetVirtualAddressMap() completes.

In fact, we might attempt to use the availability of LASS as a
preliminary cutoff point for disabling this hack entirely, and only
backpedal if we get actual reports where this is still a problem. Note
that even if it is true that many PC vendors typically only test their
systems with Windows, its security posture has improved considerably
in recent years, and I wouldn't be surprised if such firmware bugs now
cause problems with Windows as well.

