Return-Path: <linux-efi+bounces-385-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF9482A557
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jan 2024 01:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B15F1C22D92
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jan 2024 00:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FD7ED6;
	Thu, 11 Jan 2024 00:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iLYMN66F"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2917136A
	for <linux-efi@vger.kernel.org>; Thu, 11 Jan 2024 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9b1589a75so2376345b3a.3
        for <linux-efi@vger.kernel.org>; Wed, 10 Jan 2024 16:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704933967; x=1705538767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gueNhZrbsNiJzCN2gb4yLrjECQBWf6cwwXnoTcfXIT4=;
        b=iLYMN66FKBdyLftqxvShVV6YPPjxaiH0A4bEAzAFXUh07Rtw7cg392gFExYv4aTjPp
         8ZhTs0xsPpn6Xt3z7ZSCx9+l33aZXrNwfon+LzcPDHf5jEjnvZK8v7t2AiI8yLH+ugI3
         SAixjT3vhp/BZBahYdq2dQahnHiGSuF9qMJow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704933967; x=1705538767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gueNhZrbsNiJzCN2gb4yLrjECQBWf6cwwXnoTcfXIT4=;
        b=OWcCt6nBr6gljVjp7RO2B/vNUz9FZrj65kV1Q09G/X2CxFGDFMoj5alosRtvGkBydp
         2BX0zNLjPvFGSkfgWbShJwHDeD6arc9xkontl4jFUA8FZTmRDZVe97mGfiQeiek/2w6Y
         QIIN2l4UTFBC1nXCL9c6EgsJ6me/olx+fXm1cKr+ISggwcfrN8ujxkYbBuKXb8p+swUg
         +kOWqFwGxW2bf+6lGyCpHrP59cYEsJOCSUCYLOcxwz9j4eUbBUaD8maVE5LxqFgSF3HT
         yxDQo2m2RvOYiAteiK33YV3DlXir9gnfuqkbsP0ZMP1/3UnlcWIaotpbAQ71e8Y9OGcb
         7ZQw==
X-Gm-Message-State: AOJu0Yz3VesRn3ddhrTw2H+74suZGs9tAZCURxAQEq1aiMqyIIdpSw7Q
	ImNg22RDag/t6FI04c8/pEb4jDlr3SoM
X-Google-Smtp-Source: AGHT+IGkiZ1hknB2+0UC/gxIH8jrVZxWAA/1vUWxP929828CA6Qm4M9e8Oxn46aJ8qOxkFFVf4GTPg==
X-Received: by 2002:aa7:90d3:0:b0:6d9:a64c:c5d1 with SMTP id k19-20020aa790d3000000b006d9a64cc5d1mr504196pfk.26.1704933967538;
        Wed, 10 Jan 2024 16:46:07 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y2-20020a62b502000000b006dac91d6da5sm4071344pfe.68.2024.01.10.16.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 16:46:06 -0800 (PST)
Date: Wed, 10 Jan 2024 16:46:06 -0800
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: akpm@linux-foundation.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-efi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, mykolal@fb.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/3] Update LLVM Phabricator and Bugzilla links
Message-ID: <202401101645.ED161519BA@keescook>
References: <20240109-update-llvm-links-v1-0-eb09b59db071@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109-update-llvm-links-v1-0-eb09b59db071@kernel.org>

On Tue, Jan 09, 2024 at 03:16:28PM -0700, Nathan Chancellor wrote:
> This series updates all instances of LLVM Phabricator and Bugzilla links
> to point to GitHub commits directly and LLVM's Bugzilla to GitHub issue
> shortlinks respectively.
> 
> I split up the Phabricator patch into BPF selftests and the rest of the
> kernel in case the BPF folks want to take it separately from the rest of
> the series, there are obviously no dependency issues in that case. The
> Bugzilla change was mechanical enough and should have no conflicts.
> 
> I am aiming this at Andrew and CC'ing other lists, in case maintainers
> want to chime in, but I think this is pretty uncontroversial (famous
> last words...).
> 
> ---
> Nathan Chancellor (3):
>       selftests/bpf: Update LLVM Phabricator links
>       arch and include: Update LLVM Phabricator links
>       treewide: Update LLVM Bugzilla links
> 
>  arch/arm64/Kconfig                                 |  4 +--
>  arch/powerpc/Makefile                              |  4 +--
>  arch/powerpc/kvm/book3s_hv_nested.c                |  2 +-
>  arch/riscv/Kconfig                                 |  2 +-
>  arch/riscv/include/asm/ftrace.h                    |  2 +-
>  arch/s390/include/asm/ftrace.h                     |  2 +-
>  arch/x86/power/Makefile                            |  2 +-
>  crypto/blake2b_generic.c                           |  2 +-
>  drivers/firmware/efi/libstub/Makefile              |  2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |  2 +-
>  drivers/media/test-drivers/vicodec/codec-fwht.c    |  2 +-
>  drivers/regulator/Kconfig                          |  2 +-
>  include/asm-generic/vmlinux.lds.h                  |  2 +-
>  include/linux/compiler-clang.h                     |  2 +-
>  lib/Kconfig.kasan                                  |  2 +-
>  lib/raid6/Makefile                                 |  2 +-
>  lib/stackinit_kunit.c                              |  2 +-
>  mm/slab_common.c                                   |  2 +-
>  net/bridge/br_multicast.c                          |  2 +-
>  security/Kconfig                                   |  2 +-
>  tools/testing/selftests/bpf/README.rst             | 32 +++++++++++-----------
>  tools/testing/selftests/bpf/prog_tests/xdpwall.c   |  2 +-
>  .../selftests/bpf/progs/test_core_reloc_type_id.c  |  2 +-
>  23 files changed, 40 insertions(+), 40 deletions(-)
> ---
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> change-id: 20240109-update-llvm-links-d03f9d649e1e
> 
> Best regards,
> -- 
> Nathan Chancellor <nathan@kernel.org>
> 

Excellent! Thanks for doing this. I spot checked a handful I was
familiar with and everything looks good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

