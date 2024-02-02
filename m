Return-Path: <linux-efi+bounces-461-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5776847771
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 19:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDCC1F24DA0
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 18:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B16D14C5B6;
	Fri,  2 Feb 2024 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iS18l0nn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4381214A4DB;
	Fri,  2 Feb 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898548; cv=none; b=UeW6ERBg8LLkRd830BgP7yaj3pZr24aWRI8VY74HkSRSnFDTuxE0j9TZqWg1/5lIGE+042/fbuXeTC/SSjhPX6iupyT6q5gjUkl1C7qnfaf16TFeuBsTrVJYoznU8zFEhy9nuquVM256O1AozbgtiQXMCG1fh81nHqrmVpiXuto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898548; c=relaxed/simple;
	bh=1zslocAyDz7T0m3A7m1ZKz5UdxjqSVhRiZTB0J75KZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTMOZ4W8ofmqdBt98GCmSPGUVEzjFLLsiYe5J2pmP0nEF+YoU6Xz3n8V5nnabtK84shGlCOCAsTB+UiWaxAUTovX9rqymCMDKpef/rsDArEtz2ngxCrRrZcIOfxl1j9Muju5hAE3D4HXCyHpsacfFlWQVH4QOnf/PYs69qzIGEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iS18l0nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18CEC433A6;
	Fri,  2 Feb 2024 18:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706898547;
	bh=1zslocAyDz7T0m3A7m1ZKz5UdxjqSVhRiZTB0J75KZs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iS18l0nnP+SmAJmWyQRIfxT2qLS40WOWuolrE7ToKRmSKZKOKFy4d7503KFS3Y5Ob
	 xotbpYOir87hFxJ9mwrnKizU3vaaEM6UvZYB5ajBkzHc+pxtQX+yRu649cqHDlYXo2
	 xq4IRqFDWJsO8GzAmRV0gH5AEdlx8KjYFqFRJulp3wCGlrVLq4KhUdtbGU80RQUx/+
	 0y0GSbaxu7UCjiAJChAwcSiO6Trg7u0NkzaB60/tQvQFnpZmwE3qrcqHneiWVsgjZh
	 qeyjkMN5q7Ib84M4qb8nT0n/4hL5/S2u9CujMdQrircDsMjiiAeJ9kH5lQLX+BiN6k
	 kXPVZjsPC7Zzg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51025cafb51so3687744e87.2;
        Fri, 02 Feb 2024 10:29:07 -0800 (PST)
X-Gm-Message-State: AOJu0YzSItJR9RFDQasdyStxShz6xXxZD9GfzmIsAZfLdKnvaQkc5eWB
	03G7/9NKlQJjDjcxnlihJjhDg1cTeNj77QrWLVafig57i0wz13BZKFJHa1ZLKmD3tdakLBWuYr+
	b0LwO53wUrBFW4UVeeMfRaCCL4nk=
X-Google-Smtp-Source: AGHT+IH+n8H/ORElgf5m2gXQY6sqR48Q3+f+kf6ZpB0C/kjWL2lSD2YZqWyf3o0pk2DZ8Cf03zThQiXTZBwYfj9R5Is=
X-Received: by 2002:ac2:562f:0:b0:511:1ed7:61b9 with SMTP id
 b15-20020ac2562f000000b005111ed761b9mr1845123lff.39.1706898545983; Fri, 02
 Feb 2024 10:29:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202180704.808766-1-abrestic@rivosinc.com>
In-Reply-To: <20240202180704.808766-1-abrestic@rivosinc.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 2 Feb 2024 19:28:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEQdGKzoZjaZwa-SRhnwTwvaR_-SY7YtfKsUfEBc952_g@mail.gmail.com>
Message-ID: <CAMj1kXEQdGKzoZjaZwa-SRhnwTwvaR_-SY7YtfKsUfEBc952_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] efi: Fixes for EFI_MEMORY_SP memory on RISC-V and ARM64
To: Andrew Bresticker <abrestic@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 19:07, Andrew Bresticker <abrestic@rivosinc.com> wrote:
>
> Two small fixes to enable the use soft-reserved/special-purpose memory
> (EFI_MEMORY_SP) with dax_kmem on RISC-V (and ARM64, I think, though I
> don't have a platform to test it on).
>
> Patch 1 fixes a trivial integer narrowing bug. Patch 2 prevents adding
> memblocks for soft-reserved memory so that it can later be hotplugged by
> dax_kmem.
>
> Tested on a RISC-V platform that presents a range of EFI_MEMORY_SP with
> Bjorn's MEMORY_HOTPLUG series[0] applied.
>
> [0]: https://lore.kernel.org/lkml/20230512145737.985671-1-bjorn@kernel.org/
>
> v1->v2: address comments from Ard
>
> Andrew Bresticker (2):
>   efi: runtime: Fix potential overflow of soft-reserved region size
>   efi: Don't add memblocks for soft-reserved memory
>

Thanks, I'll take these both as fixes.

