Return-Path: <linux-efi+bounces-4180-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DF4AFBFAE
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 03:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E5D1AA3877
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 01:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437B21E2838;
	Tue,  8 Jul 2025 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucErcMOW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E7535893;
	Tue,  8 Jul 2025 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937210; cv=none; b=eyq11UA87rIOJv/jiQiTYfm2kxpgMQh2FS0SpyHo7wNJny08KZ16umElshyulNymJBsFeqevjzBY/YjVXPe/J0Za/r2CC20EMxQDznZ6uJeZV+JJHWEaN3peHI9YQZdwJ5XKZxVxnxv/LV2vXjLDWHO2mOvbNQ07+V/DIvEL9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937210; c=relaxed/simple;
	bh=iPodmZohmSa31e+By01I1tCZZleFo6T1wFvi9no0O2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfYMqsGe98WnynzBLFz8zHxK1V7ZOcNKQqSj8Gc1X9SS9S25U4QUDTHOLrVeTSWrAa99n30lhNDZ8WkSLe/nOgGhLtv+EPE+eGWYjNF31+vFfDQs2Y+AlQ7Bvr8L0Len/l1ERxUwOmAWTE4pgwEkvzuRGpbBcEIUGRPeIv6UpMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucErcMOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46F5C4AF09;
	Tue,  8 Jul 2025 01:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937209;
	bh=iPodmZohmSa31e+By01I1tCZZleFo6T1wFvi9no0O2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ucErcMOWnScg0VJtBHtMIuIwnc4gOBW3HGDeqvukg4nA1IZNaGGPFoo5j2IzLE5d7
	 A5RCasoCOF1kpnM39cMYE1A112pn+BdrKaWSD9UQ5/zbOBy4UjpJcAoiP7ML8RHFUR
	 SqN0Nc5Z0RbOXylJcPiGm22m4HcMeKvYewOMdNCvl4IooVRRZwT3xKUR5aQn6iZ0wk
	 riZnsbHsyP3UH5z3ItHjfi1q9Sn9/HcwFKoljkJBCgiY3vpP8Yma1O//BuBbx366Yw
	 GQbUB3otL04evcUdkGdGFDG/bALGNDUrYRFKFlepZCS1QjaXKVvnMbpaLTDucIdeD9
	 YNitdUsp4gdQw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32ce1b2188dso36355511fa.3;
        Mon, 07 Jul 2025 18:13:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4v6dxR+tnbv9eyebImhq+K8Wzlro3GInbWSZl1phfNogl2iKjv3e0UdjaOez4ovBYZd7jpIDFU9ZX7Rwf@vger.kernel.org, AJvYcCXmFTXE1Kbd8phDPUVjX8UWDysIFWD9YSbu5GgODWThI3w7RlYiv4tk2aEKAsSpd0S1nNioQ2wfiEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEVlnbb6LCQtT8A/DPS+Bhygz7qNmDXmuPqXjvA4LcDy88fjx5
	QB0aJgPBa/4X20wixNwmPpoCph4k/pcFr91s33rEFUBAGF8hXHEIpgjO5wSJbZLEEMILtVtrYGk
	WdOh7jMX0kOsbRpB9PbtOFiQykKjhegI=
X-Google-Smtp-Source: AGHT+IHfCFdtnG1WPE1YHD1I9AO09IXZjLeoSWqh/sTSdfozG/IHbenZmNc+ALg/MxWLMeyzI2SRRpUrdsXlwPkt6P4=
X-Received: by 2002:a05:651c:41c9:b0:32e:deb2:f75 with SMTP id
 38308e7fff4ca-32f39ad0a8dmr1664961fa.23.1751937207992; Mon, 07 Jul 2025
 18:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
In-Reply-To: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 8 Jul 2025 11:13:16 +1000
X-Gmail-Original-Message-ID: <CAMj1kXEjgFarhn4FNOMfCfrh1_DR9L-MNZBiZq83pg2i=RE08A@mail.gmail.com>
X-Gm-Features: Ac12FXy70wEa8uRpKo6gT5MueTy0Q2ZIgEQp_8wVncqO7RC_E0zDip1k6PBM92Q
Message-ID: <CAMj1kXEjgFarhn4FNOMfCfrh1_DR9L-MNZBiZq83pg2i=RE08A@mail.gmail.com>
Subject: Re: [PATCH 0/8] arm64: set VMAP_STACK by default
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, leo.yan@arm.com, kernel-team@meta.com, 
	mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 02:01, Breno Leitao <leitao@debian.org> wrote:
>
> Hi all,
>
> This patchset select VMAP_STACK on arm64 by default, and cleans up the
> code by removing all associated CONFIG_VMAP_STACK conditionals.
>
> This is a suggestion from Will Deacon from another discussion[1].
>
> With VMAP_STACK now always enabled on arm64, the code can be
> significantly simplified, reducing complexity and potential for
> misconfiguration.
>
> Overview of Changes
>
>     * Remove all #ifdef CONFIG_VMAP_STACK and related runtime checks
>       throughout the architecture codebase.
>     * Replace runtime checks with build-time assertions where
>       appropriate.
>
> Link: https://lore.kernel.org/all/aGfYL8eXjTA9puQr@willie-the-truck/ [1]
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Breno Leitao (8):
>       arm64: Enable VMAP_STACK support
>       arm64: efi: Remove CONFIG_VMAP_STACK check
>       arm64: Remove CONFIG_VMAP_STACK conditionals from THREAD_SHIFT and THREAD_ALIGN
>       arm64: remove CONFIG_VMAP_STACK conditionals from irq stack setup
>       arm64: remove CONFIG_VMAP_STACK conditionals from traps overflow stack
>       arm64: remove CONFIG_VMAP_STACK checks from stacktrace overflow logic
>       arm64: remove CONFIG_VMAP_STACK checks from SDEI stack handling
>       arm64: remove CONFIG_VMAP_STACK checks from entry code
>

For the series,

Acked-by: Ard Biesheuvel <ardb@kernel.org>

