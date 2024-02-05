Return-Path: <linux-efi+bounces-481-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 749DE849D5F
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 15:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC2C2884D4
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D662D04A;
	Mon,  5 Feb 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ9E9xF8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AD2D046
	for <linux-efi@vger.kernel.org>; Mon,  5 Feb 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144633; cv=none; b=b45HpWGcnwQmjzu0wUnftSrge34ZGqdcB82Nf76QeVud6rCHzNgq4OoYHfQD7TrOOSAHdTCB7PqhKtJ2QgffwBkMSdaMk/5jYw2qBnzWVx1Y+kErTk6Et+xIjQq44qImuhFXZXrqUfksjMGxvjAd6tpzn/l8sIdN1qeoDBvVglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144633; c=relaxed/simple;
	bh=v7z9gMHF/RhVC7L8CqF/6+YJ4KPwW3B5vbJXboB3J9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjQI5kMSXLvfvXZJp0SQBkmcmOdFk8iDyps4JM0QafxnDP7J8cNL0dH6wUxOnYNTfglXHpx43UTquG5jvTGNzUVKfU3xqt3PlROiffIdzsCetMM2tikCG2GOWEYXQITfYCR++PH7viOCkcQb4ipKn7LpO5DBPXlF2TnmYaT9NEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ9E9xF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D90C433C7
	for <linux-efi@vger.kernel.org>; Mon,  5 Feb 2024 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707144631;
	bh=v7z9gMHF/RhVC7L8CqF/6+YJ4KPwW3B5vbJXboB3J9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YQ9E9xF8xOqhCRRV6plUDODWJejYccruBcl9ihTa2q23ol0NxkypXEjHh6HscAO3r
	 XU8Z6nS5TcFzd5frgUtv9q5E19pkJ40yGrem9sv5ks6KGEuqZO2mSsMFKPjIGlUnqt
	 CyvEtdxbMWimnRM8QRbnW2J6qNfp9IkdznX8zrGWqo68Sd3fBR5Wprgjo7vQbBT8f5
	 T9omh7wN1j6WXyupggPiW8PXoKJxiQfEelBY5Wiyr0AFmGHopifGe9a09vNVp2G+hR
	 1f+K4mbcYddft6W5s0J3bdBhZ7DugEDtFId8wZpZuRiOIFa3dR/HVkBog/QMUfl1yP
	 u2VhXs/X7UAJg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso56373111fa.3
        for <linux-efi@vger.kernel.org>; Mon, 05 Feb 2024 06:50:31 -0800 (PST)
X-Gm-Message-State: AOJu0YytgIKFmtHqhC9/1Zumbc9h5KHIVabkpsj8ll0mcikTu3UPX6RP
	qKJgfP8uLDlMDEWQVPSug1xBsKRfBJM8GMyEZdG7CmAv1tmsRS5RlRkLhnu6s9veeFob4fCPvpF
	fc8POFEoFc7jVHu4U4NAIGq0Yupg=
X-Google-Smtp-Source: AGHT+IG0y8toW5W8eFpdsvCe1fQRU++du7bguiRlXKxtPLYdgRVdo+1MtoYPmuL58UIfylv6XxSJn6rF88OzzGkz+SI=
X-Received: by 2002:a2e:a694:0:b0:2d0:6c48:8777 with SMTP id
 q20-20020a2ea694000000b002d06c488777mr4577lje.27.1707144630185; Mon, 05 Feb
 2024 06:50:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707141974.git.baskov@ispras.ru> <9b99e3e3c2c6c32a674ffa3272f85fa9443e33a0.1707141974.git.baskov@ispras.ru>
In-Reply-To: <9b99e3e3c2c6c32a674ffa3272f85fa9443e33a0.1707141974.git.baskov@ispras.ru>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 5 Feb 2024 14:50:19 +0000
X-Gmail-Original-Message-ID: <CAMj1kXEZeEu=NLBzgeJvsfBiGJt-DUNCRr=M-CohkM6LnVCffA@mail.gmail.com>
Message-ID: <CAMj1kXEZeEu=NLBzgeJvsfBiGJt-DUNCRr=M-CohkM6LnVCffA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/boot: Align .compat virtual size
To: Evgeniy Baskov <baskov@ispras.ru>
Cc: Mike Beaton <mjsbeaton@gmail.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 14:44, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Even if this section is discardable, it still needs to have virtual memory
> size aligned on section alignment to be compliant.
>

It does not. The PE/COFF spec does not require a section to end on an
address that is aligned to the section alignment of the image.

> Align compat section on section alignment. This adds ~4k of memory after
> the kernel image during EFISTUB execution but, it's not a problem on
> x86 architecture.
>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/boot/header.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 097b84ab288c..128e35f5c89b 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -184,7 +184,7 @@ section_table:
>  #ifdef CONFIG_EFI_MIXED
>         .asciz  ".compat"
>
> -       .long   8                               # VirtualSize
> +       .long   pecompat_vsize                  # VirtualSize
>         .long   setup_size + ZO__end            # VirtualAddress
>         .long   pecompat_fsize                  # SizeOfRawData
>         .long   pecompat_fstart                 # PointerToRawData
> --
> 2.43.0
>

