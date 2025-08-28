Return-Path: <linux-efi+bounces-4624-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C618FB39591
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 09:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B337068337A
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 07:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440C52ED151;
	Thu, 28 Aug 2025 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbiKZCZC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751A2EB857;
	Thu, 28 Aug 2025 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366590; cv=none; b=YWKOuN5OfI1/gNeVhXEwtgVPJ+eL/RnulB+EoMSMgnYs/CUe4HWb4EwUA8CHX7WG/WKL80vM989ZKCb/+8Zpa0zPHRYhOjtE3hRqJUGLJoxwNAid0LrTVrTFl7DDcgWbWDub04m0pmuqQMll2FS8NIDkvYZsU4mcpYrB/IOs/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366590; c=relaxed/simple;
	bh=eG24upzL3ZfnzWnDwgoCUkzHYlB1tE2FpKQJiSrvhP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5AhGbEuZ9lT8Ysx0KYUPp7q/G5L/goLv8xWxZLwqp2QVomcNada2gE7bj1dgXWGzFKQAx+pZfPvyurjrgHb0HcHj625FlKunxc5ofZmTrZRDXlfNFKDFeXMXgAf5VKADVFaXgui6v9A/nB0YoYHyI4VAHHzwW/BdgQIlxsa5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbiKZCZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96126C4CEF6;
	Thu, 28 Aug 2025 07:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756366588;
	bh=eG24upzL3ZfnzWnDwgoCUkzHYlB1tE2FpKQJiSrvhP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FbiKZCZCqwOf5zo3UzCuoo7H4lCpWhOowZo/h21ucKQjupl1hbTz6BidSEb662+c2
	 pr3hltnMXfRDL58shWnRkoyk5mAiDkG8PIUeYu7l67uWcE1G3BiKJ5BcNabwpeDvKG
	 sLPWtPVL2n4AMl/Ty7pRTup/K7SwVe43PtMkr/3m+I+DxJkteSwOverXa7hojslViF
	 RDBdsDm5+UUnTj1AgaCmNklvDIRC3Z/hcUBkDVjvjjMRa8zfo6BR3fChW6YDeALR8I
	 Aq7WFqCOCnoY/TJmZ3S7qQFQss18gGtCxMJzLHKJS5Bu+mbiMWJLOfbVUttg/xBe/j
	 ttrif1doYeBFg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-33663b68b06so4209271fa.1;
        Thu, 28 Aug 2025 00:36:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwbJLsX9ioqfP488DqU9o2NyhJEUTx1vAh8cJvMZQlKSTJ/2vqyq4TJIMqLlfRcqlVGIbJEmOKYc0=@vger.kernel.org, AJvYcCXQdMuZOaNWxMl6uUFzLR70OspRWKT4CqhbJUx13/3NYGwu29jWv6WnDLDHqJq0ykfqyC769msz9zVtRKDU@vger.kernel.org
X-Gm-Message-State: AOJu0YwIKgxiecHllUn76FQaVz1ZEoEpod1GCV8ZY9qhmQvhN3mkGumw
	Jkauu4XXluotKs0v9YLSkQOjGG+UeqlSfGy4x0cRMoofU37zRKUIZDCAZSILeCl/jYz1nuQEcfb
	uoykNKk/Wg4Y568lqD9Sys/DFYjdc8as=
X-Google-Smtp-Source: AGHT+IH0vnKMJnsgtrK+zCirslWcbDAKvWEdT20oGO5PTcKxps2JEuiJiZbHx1deqXjL7jb84msPwqdPs9VyP1tITJ4=
X-Received: by 2002:a05:651c:3255:10b0:332:4238:4f46 with SMTP id
 38308e7fff4ca-33650d77263mr49395401fa.3.1756366586943; Thu, 28 Aug 2025
 00:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
 <20250722072708.2079165-34-ardb+git@google.com> <20250811063026.GMaJmOAoo-PhdXcLZX@fat_crate.local>
In-Reply-To: <20250811063026.GMaJmOAoo-PhdXcLZX@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 28 Aug 2025 09:36:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHr1tcV5SpkhENANUs1Y_nvC4Wh_7Q=UN+2RPVHFC4O_Q@mail.gmail.com>
X-Gm-Features: Ac12FXxKxl6V_V2tbiBuP85354GjoIgj9YQWQ6Nzb4u1vEVAd51t97Z68ko62N0
Message-ID: <CAMj1kXHr1tcV5SpkhENANUs1Y_nvC4Wh_7Q=UN+2RPVHFC4O_Q@mail.gmail.com>
Subject: Re: [PATCH v6 10/22] x86/boot: Drop redundant RMPADJUST in SEV SVSM
 presence check
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Aug 2025 at 08:30, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jul 22, 2025 at 09:27:19AM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > snp_vmpl will be assigned a non-zero value when executing at a VMPL
> > other than 0, and this is inferred from a call to RMPADJUST, which only
> > works when running at VMPL0.
> >
> > This means that testing snp_vmpl is sufficient, and there is no need to
> > perform the same check again.
>
> Remind me again pls: the startup code is going to be executed unconditionally,
> even by the decompressor, right?
>
> Because if it is an alternative path, we can't do the below.
>

The rmpadjust() call has no meaningful side effects - it is only the
distinction between its success or failure that tells us which VMPL
the guest is running at. The value of snp_vmpl has already been set
based on the same criteria.

The decompressor is completely independent when it comes to
initializing the SEV-SNP context, and the core kernel will redo
everything from scratch. This is needed because the decompressor takes
over exception handling in order to be able to handle page faults and
lazily populate the identity mapping. IOW, the core kernel does not
care whether the decompressor has executed and does not reuse any of
the context that it has created.

This double initialization is no longer needed when booting via EFI,
and so once these changes are in, I will go back and resubmit some of
my previous work that removes the call to sev_enable() from the EFI
stub entirely. Non-EFI boot via the legacy decompressor (which
includes kexec boot, which makes it relevant for SEV-SNP guests) will
retain this redundant boot flow, unless we find a way to mandate a
complete 1:1 mapping from the boot chain (which EFI already
guarantees).

