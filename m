Return-Path: <linux-efi+bounces-5277-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8C2C23767
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 07:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8785C188D13F
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 06:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C4F2F6190;
	Fri, 31 Oct 2025 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev8bWVRC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E662ED872
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761893544; cv=none; b=qGQXl6eib7pA+9MYa2JjdAHfbMABaL1cZ3TJ//O2F7NxtnyIIN1hnUDKaWyEYC7VEn0uA11nC6tMgd7TdnQhz9GJutp0TV538gI9KdkHP6lurjKuhl4uOP+aNxHke8q7QSP1ProrIvQLPyskk6NLfU3NYTXQWfM3tDQ3ZAmI+dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761893544; c=relaxed/simple;
	bh=ksx4g+Jh2oVtltJZWL+FIC5BrFeq4u4rjwvhozEkK1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtPY2sbiZOxO7AqMOuS4y28whcm4lSq4GMLHcGk9vMyr6sT3cvL+afPtiLfQ4RApPZC/S8Ok8pPQ7jE2I52xRL6xnP3WnznuDx5pyoyg/eDDjeYoJgdnjjMWf1UandmGpVB1BGgsmVZZObCaiSz0qdD+a9hg6kJRQSPOYMXEchc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev8bWVRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB60C4AF09
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 06:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761893544;
	bh=ksx4g+Jh2oVtltJZWL+FIC5BrFeq4u4rjwvhozEkK1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ev8bWVRC1tbtlXw/rhWi9pOl0IDaJ4iq9Kfdw7R+PaAuYXp/MdcoYuZ7mTkrooNNK
	 N48R+m2bU+huj2o9GITfLGpO17xhbgRaPQKHoVPsaaLTfch0TQCV6mZNBubWGGCSh7
	 dc5/9uCluvY72tU3dZt42zcfOBp7N9UFBuDwa/c1aikOy+6sdcyy00zgNGTF92+zUi
	 tVK934J0IB5ndU1tvQOAsqw/Cdzdp1UdD6tKz+tfQxV/l+Nvhd/g0OLzC+puGkqLL0
	 Tn2EhcLlbYcomRlD2OUeVZj6X0Q4wgZOEQF6yIa0vexIUdlqXamd+6X5EIvpElhbsv
	 8d9YwWpqB5Jog==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-592f600acb3so2669377e87.2
        for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 23:52:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkYIi3KxVs7rRRDQcoW4jaPaKj3EujnTKs9+YvZGHJwx6NsgjlS+qnbtIlPJUqMgnq1c89G8BDQBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyeyInBHzvyglnsAbLpfyz9JE9VIz1Zikzad00rM2tZFpl4+Mg
	9Be8bWPqvFioxtTvw+MoEevnmv8Iq9aZnLbdPUJznKhfUo4nK71dsZGt32WRnpcanRJGcJmwS0q
	fjAauuuLLZ1qU226RLIkecwCP3GEjrio=
X-Google-Smtp-Source: AGHT+IGNsOV4X6EuU2Cx9uru+UgCvt2SHFfMKSEOF6DN6EwXXCSpNdERHV1a1hygRioO3zt9qFaRgV8Lq6fjNY7CVCE=
X-Received: by 2002:a05:6512:238c:b0:579:fb2b:d280 with SMTP id
 2adb3069b0e04-5941d56502fmr862097e87.42.1761893542935; Thu, 30 Oct 2025
 23:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031024328.735161-1-maqianga@uniontech.com> <aQQ3KUap1cB73HOm@pie>
In-Reply-To: <aQQ3KUap1cB73HOm@pie>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 31 Oct 2025 07:52:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGxP_8FhZgD42iD-7pnnZgjez3mXkTZz69YAc5FPkLBMA@mail.gmail.com>
X-Gm-Features: AWmQ_bkTKSyKxtWJ5rxc0jSzCLTGDjPaQTsOxTi8sBWFe8oDoA4aQMGWz-6rHWs
Message-ID: <CAMj1kXGxP_8FhZgD42iD-7pnnZgjez3mXkTZz69YAc5FPkLBMA@mail.gmail.com>
Subject: Re: [PATCH] efi/riscv: Remove the useless failure return message print
To: Yao Zi <ziyao@disroot.org>
Cc: Qiang Ma <maqianga@uniontech.com>, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, linux-efi@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 05:12, Yao Zi <ziyao@disroot.org> wrote:
>
> On Fri, Oct 31, 2025 at 10:43:28AM +0800, Qiang Ma wrote:
> > In the efi_create_mapping() in arch/riscv/kernel/efi.c,
> > the return value is always 0, and this debug message
> > is unnecessary. So, remove it.
>
> Should we make efi_create_mapping() return void at the same time, if it
> will never fail?
>

No.

