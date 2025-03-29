Return-Path: <linux-efi+bounces-3125-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91687A757A9
	for <lists+linux-efi@lfdr.de>; Sat, 29 Mar 2025 20:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B6D188EC88
	for <lists+linux-efi@lfdr.de>; Sat, 29 Mar 2025 19:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B6613DDB9;
	Sat, 29 Mar 2025 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltYSxjaV"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9A3D3B3
	for <linux-efi@vger.kernel.org>; Sat, 29 Mar 2025 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743275286; cv=none; b=D8Pjcc+gysZopnFIG++XxxfRVouqxWazxDYc1rMwefobRfzZxmfyFl2KZhcI0HxlckqhF3tHfu1ByO0wxOpgRt3A+CtKUHiiCAMteJVAet+eQ/wgwKmlXpQjrZxyIFWwDIxnMhlGH8fK6NEJHPVSb454tdgNG9SIJm4kuS+wENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743275286; c=relaxed/simple;
	bh=88f4kxK43QaAHu4nRt+1/fEw3CB2VsGeOO6Ma5D71sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTmMCJBDPqsYU4kb5aU0Hnswd/fHgGyMFtJm73Iwy8aneizn8iMDoeQUsEH3VHQek4JbEx6tPJteo5ML4/5O92e4gBS1bIPhiD7btIlK3jCUR7I9PJ676wHNIGGOB6K+M7dwUXCfpJ+Bh5BLh6+Z8osKDvohSsNU8B0nM6EUc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltYSxjaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0271C4CEE2
	for <linux-efi@vger.kernel.org>; Sat, 29 Mar 2025 19:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743275286;
	bh=88f4kxK43QaAHu4nRt+1/fEw3CB2VsGeOO6Ma5D71sQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ltYSxjaVUfvvZ2iNVvcehU2q23UncJkRLQnVnEwHM7qvCqYR9IZUKHkUfNebsQthE
	 U0Vr3f9vNi3xvQG7GX7X6oYtlF5l7RjqyZ38BMoC9tgboVCep9MVcNGoYARI9LLqCS
	 5O8Hnu8VL02MEfhQ3udgXxzKnm1uaBDb7CdB84J1ouG5X3CgrWEhvDcQkukhvnlu7x
	 hr2r3Wwv4NzbvEBZVwBYYcdxw/X698ZdvOSzHrRNO5A/Uh6wTF9dRGf5pKGO0KuEOg
	 Fd46ANQlJWTxoOwQB2SNEsQhOPoK5v3vjdq7RuaeJyE9kq2k+AcVom4Z6XrIK31xmg
	 Z0UV4IDtldSCA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bee1cb370so30322131fa.1
        for <linux-efi@vger.kernel.org>; Sat, 29 Mar 2025 12:08:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YyL2sEIkkfEdRN6nbszcUt+Pbn6sFhD4qwOj1DeSEJp7V5viAep
	RPTUHfHcsjbTvA9yzHo/L2AfdWsz7gf00a4YXPxvRKLNwIohVdYvN8QlrL6CeZDa/jEyK4kV51T
	JVLqAm+nkKJEw0JAiDny1bqQaN+s=
X-Google-Smtp-Source: AGHT+IEXQJD2/pZqnmant8rQt4s3o3xyq4fICdTpAyJbwcpNb+gz0umuUp8OhCaU3IHme2HAo5wC1PAwtD17WYjSY9c=
X-Received: by 2002:a2e:be07:0:b0:30b:f15f:1c02 with SMTP id
 38308e7fff4ca-30de0278c24mr11680611fa.18.1743275284985; Sat, 29 Mar 2025
 12:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328070525.2248563-2-ardb+git@google.com> <CAHk-=wjc-EAEtv02iUFGej6RZs9C7ALAMtuh4rFNYs5VUt+4UA@mail.gmail.com>
In-Reply-To: <CAHk-=wjc-EAEtv02iUFGej6RZs9C7ALAMtuh4rFNYs5VUt+4UA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 29 Mar 2025 20:07:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF61PeyercrHdkevq+UdKvBsfJ4QV2RFJyXMWAYtJ95oQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpBHc_kgXyQEP7aVLMzf4l_Bj4G1dCH1z2yX1IBDEozHFkLczfe508mvZY
Message-ID: <CAMj1kXF61PeyercrHdkevq+UdKvBsfJ4QV2RFJyXMWAYtJ95oQ@mail.gmail.com>
Subject: Re: [GIT PULL] EFI updates for v6.15
To: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

(cc Ingo)

On Sat, 29 Mar 2025 at 19:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 28 Mar 2025 at 00:05, Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> >  arch/x86/boot/compressed/efi_mixed.S               | 341 ---------------------
> >  drivers/firmware/efi/libstub/x86-mixed.S           | 253 +++++++++++++++
>
> I've pulled this, but I'm not super-happy about it.
>
> We have been pretty successful in keeping assembler files in the arch/
> directory, and I really think we should strive to continue that.
>
> Do we have a few drivers that have arch-specific assembly code? Yes.
> But it certainly isn't something to make more common.
>
> And did we already do that zboot-header.S thing earlier? Also yes, but
> that one is afaik actually architecture-neutral and doesn't have any
> architecture *instructions* in it, it's just data layout afaik (and
> no, I don't know why it was done as a '*.S' file)
>
> IOW, I really wish you would move this back to arch/x86 somewhere. Please?
>

Fair enough. Note that this applies to la57toggle.S as well, which was
moved in a patch that went via the -tip tree this cycle.

It doesn't matter that much where the files live, as long as they are
disentangled from the traditional decompressor. (For C files, it is
important that they are built using the EFI stub's C flags, but for
asm files, that makes little difference)

Does arch/x86/lib sound like a reasonable place?

