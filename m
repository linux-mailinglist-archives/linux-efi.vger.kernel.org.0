Return-Path: <linux-efi+bounces-4397-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC53B08030
	for <lists+linux-efi@lfdr.de>; Thu, 17 Jul 2025 00:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924507AD23F
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 22:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD1C1F1311;
	Wed, 16 Jul 2025 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESIrOP+e"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46238EACE;
	Wed, 16 Jul 2025 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703337; cv=none; b=SsURCfZqG8u56jhys6NvZ5tpg8vooqnx/goOeqlmW4ffUj1Icsxg/EcFewdU+az1okQ+3zhiSEl0F1txr2adoJgpSXEhx8LDCkAu95jtGHzITmHf+RJmmu/mw0hH2rKgMIQsPYV45f4lgZKrU7/uFzQ5Pi3T7HbGFYKkw4QwJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703337; c=relaxed/simple;
	bh=mcVWT+BzXhQn/dp+TWgBpdf7WK3iuCc1tmd6gdMqBlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5NPXfFysmHerBi3yEzxBNttL8ydOn/OvRBHfb2HEGO1KmTUzX5pUI0jx9EIAXfb8JK3XUR6fs7Wrg2Q34gIhEfyM7QfqmjZOOqrgg2UWvhmMB0PkDXv3sZwUqMAnlk2D9AeLfbWUl3cPhf7Rg1ynEQGiBLIOs8vxYXhwVzQ4qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESIrOP+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE63CC4AF0B;
	Wed, 16 Jul 2025 22:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752703335;
	bh=mcVWT+BzXhQn/dp+TWgBpdf7WK3iuCc1tmd6gdMqBlk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ESIrOP+euHFrjAc7fERCYG+BW6cBBfHVgr4ArMMVjvuPxiURSlrCmGI1CmwDz+WJ9
	 Y7S72+WP3+xzALr515H/gYmA0MKSx/SdRs+m3B0YX5i1t/lD88Jz9erKovyUlmImOT
	 uzecayZJtbzG5KMue0kpUhwQ+275EsheG9ZsHcQ3uLcSl9kyWhMqhEzqrrHvaxHlBK
	 Zl8Ot7CrDmSoyNN9kVitD+YIOQxE9WDO+swejBY8Ev7SvtSJh/s8RJlZ8Xm9NX7uL1
	 d0fqPgDbX7M5rLW7NFFPUgkPUgitXkxyGAT3bKXj4lsnNXzGgONhGpUDVRAe4D8Yof
	 p9wgjBDgB6Rvw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32f144d0db8so2051641fa.0;
        Wed, 16 Jul 2025 15:02:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCqBImKEuu/vMdFM6Me94JpilDrQUjXS7IRv0GUKYXNGwAmzk+1blqfJjJVOuL0gAuSm9SOH0whmU=@vger.kernel.org, AJvYcCXclpQ3BxIB4HJ4eiQkyl0pPYb15pc8EyUJ9Khlrzus8y2KMwJ/WAi9NuCVuadmPmgmD+RBpc2KfjbWJGZ1@vger.kernel.org
X-Gm-Message-State: AOJu0YwY0Q4iHbU0qtfvC7fz4m9DdrKEW2xX/HFZkTJlTOW5HSYodZys
	0fQJItXKxugjAlbcJzb32tyMTuIADqsBjqewsOQBbV1zwZQog42ebcVjAL+vVXY6YYa3tfDoTPj
	K+rSm+RgdM8HKxXLe7/kzAHQiPT2Dcck=
X-Google-Smtp-Source: AGHT+IFHCUS5lMZAkbS1BMowzuEkqGqX+RkP+At1u9zWV8/h4iBr5WfJQ7aN8cbhVM0+SKwsmribuVrPlB4dY34wLgI=
X-Received: by 2002:a05:651c:2096:b0:32b:968d:1fe4 with SMTP id
 38308e7fff4ca-33098bca422mr1474771fa.14.1752703334125; Wed, 16 Jul 2025
 15:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com> <6b5e2a11-b157-1288-f99b-cd8c7b8180d0@amd.com>
In-Reply-To: <6b5e2a11-b157-1288-f99b-cd8c7b8180d0@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 17 Jul 2025 08:02:01 +1000
X-Gmail-Original-Message-ID: <CAMj1kXFQngQodoj=Nrb_kRwHUUqqtARqt+UrMRuOgG+vffG4jA@mail.gmail.com>
X-Gm-Features: Ac12FXwzOyQA2yF-j4mKCDcg3hcugPZmmBqAeHK5bxRIexyrY1TzlI6yeiWhSFE
Message-ID: <CAMj1kXFQngQodoj=Nrb_kRwHUUqqtARqt+UrMRuOgG+vffG4jA@mail.gmail.com>
Subject: Re: [PATCH v5 00/22] x86: strict separation of startup code
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Jul 2025 at 00:27, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 7/15/25 22:18, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
>
> Hi Ard,
>
> I tried to apply this to tip/master but ran into conflicts. What commit
> is the series based on?
>

Apologies, it is based on the same commit as v4:

f339770f60d9c3312133cfe6a349476848d9b128

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=x86-startup-confine-v5

