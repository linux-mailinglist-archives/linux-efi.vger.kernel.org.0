Return-Path: <linux-efi+bounces-5481-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E1BC52A34
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 15:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7ED4A23EE
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C986D246BA7;
	Wed, 12 Nov 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0+bzhmf"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42C21EB9E3
	for <linux-efi@vger.kernel.org>; Wed, 12 Nov 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955829; cv=none; b=BJqs1hUh/seVCIiXwTn2TF5rBfmtAIjoJUi76iwQiXpMI8auJBBQwIodbDLnNxm5Ko1R4q0TXHC1ByctihnhrtoUMhp4i8XdroI4+v94JKICz3zx/MGwfTmVPh1Njp/RuZL21mVkJp3gPJvSjnA/7PRzE9ojVAmd9sh8PdRYoZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955829; c=relaxed/simple;
	bh=tHJOhNS/6u7uEkNaEtbiVXZYwmle7ISnqeBqpq4Kzqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsNj8uYIHNT7Wm+6zoaUHZ6bDk46H3sTks4fxrYbCp0Ob0QQDSOy29NUtH177k0b+oPFpTqf472miqQEPYvhCKxcG48/sig51OCATxeCsq+VZcDw7bMYdE0PTSTrEoO4Lqjix27ZFrMbCU6zRvyVWoZZJjx5pX3E63mIu46VEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0+bzhmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F89CC2BCB5
	for <linux-efi@vger.kernel.org>; Wed, 12 Nov 2025 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762955829;
	bh=tHJOhNS/6u7uEkNaEtbiVXZYwmle7ISnqeBqpq4Kzqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i0+bzhmfH+HLeWm0uKObuaWSWRc0W6RKTiqRycwokn7J5y5oLchhYcULZPj7KAFDV
	 KVuu7nIHBL88/86KpDQbsAi3c13LFhUxmTR2yCadOkuyGkVIj1IIQg5gjGFwi1Rf2c
	 C/2uPp0goT3yK6/70Mr6YYvKi5Z0rStqanY7+viwju7Lkpxrg3A6geiqg/6u2iHcHg
	 YHMRC1qifEFBCN5LTJn8CEu/PCyaITvcqnj5wYvSdpQlZqjtB0DdeWEqxLZrLJNKH4
	 VpcjosnnYCAinQ/pU13vVlvcEpYn+hYOta5IYt7KkC3onY9ODOmeg1BxWjM1AMdQJE
	 O+VLOogz4IPcQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-594516d941cso953409e87.0
        for <linux-efi@vger.kernel.org>; Wed, 12 Nov 2025 05:57:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGc0OHrnzI8JNma1yyOpakRXgNmuBGcJbPo0HIMdAryC0bGwx9+8x1f4tIYq7995RkvGPBHb0Re1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu60/nTRwxGXpVY/8MjNiyZ0/tOA0VpwEUwgm7zFy6oei+DE9y
	Xe14Uhz6q34zv3q3h/dwPkf47/iVUG13wBXy95p9aAR/u1sRdnT1pt8gX8F2A3iEDnkiqvmyM2b
	heUujp4ELyhkta/ogta2Di5TByefFlqc=
X-Google-Smtp-Source: AGHT+IGXAF4rUi9O4+ZXVKR3NNYktKS/FyFWJQfBYe693cP1LOAh54szQzCs9X+fzOsFf3NVrgtQ+SBmqveiSr5SGIo=
X-Received: by 2002:a05:6512:400c:b0:595:765f:a5de with SMTP id
 2adb3069b0e04-59576e653aemr992791e87.42.1762955827202; Wed, 12 Nov 2025
 05:57:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-5-sohil.mehta@intel.com> <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com>
In-Reply-To: <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 12 Nov 2025 14:56:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHvfgMqFncvP5A6ed=2qEPkNkS8ecoM6iXMect51Tpz4w@mail.gmail.com>
X-Gm-Features: AWmQ_blXGWjy7m-ZL23HpefUvy7djJ90ttXhT8zFrf_zvGN5o6-zn9r3GtsUR7Y
Message-ID: <CAMj1kXHvfgMqFncvP5A6ed=2qEPkNkS8ecoM6iXMect51Tpz4w@mail.gmail.com>
Subject: Re: [PATCH v11 4/9] x86/alternatives: Disable LASS when patching
 kernel code
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, 
	"H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Sean Christopherson <seanjc@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Nov 2025 at 19:15, Sohil Mehta <sohil.mehta@intel.com> wrote:
>
> Hi Boris,
>
> On 10/29/2025 2:03 PM, Sohil Mehta wrote:
> > +/*
> > + * LASS enforcement is based on bit 63 of the virtual address. The
> > + * kernel is not allowed to touch memory in the lower half of the
> > + * virtual address space.
> > + *
> > + * Use lass_disable()/lass_enable() to toggle the AC bit for kernel data
> > + * accesses (!_PAGE_USER) that are blocked by LASS, but not by SMAP.
> > + *
> > + * Even with the AC bit set, LASS will continue to block instruction
> > + * fetches from the user half of the address space. To allow those,
> > + * clear CR4.LASS to disable the LASS mechanism entirely.
> > + *
>
> Based on the EFI discussion,

Which discussion is that?

> it looks like we would now need to toggle
> CR4.LASS every time we switch to efi_mm. The lass_enable()/_disable()
> naming would be more suitable for those wrappers.
>

Note that Linux/x86 uses SetVirtualAddressMap() to remap all EFI
runtime regions into the upper [kernel] half of the address space.

SetVirtualAddressMap() itself is a terrible idea, but given that we
are already stuck with it, we should be able to rely on ordinary EFI
runtime calls to only execute from the upper address range. The only
exception is the call to SetVirtualAddressMap() itself, which occurs
only once during early boot.

