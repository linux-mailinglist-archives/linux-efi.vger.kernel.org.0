Return-Path: <linux-efi+bounces-2821-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F0FA40FC8
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2025 17:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0D91751E4
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2025 16:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7843D2AE97;
	Sun, 23 Feb 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQx642xS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504FAA95C;
	Sun, 23 Feb 2025 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740328397; cv=none; b=rfpJjxuF2gaZFJTzwa5Q7L/EM+GflCaVWsXmiMyiQA24AUaM/Vh4QFZWamZfg2OxartCMtu0dktDuVHZBe9I3AqpGD+7rfIsNgwak89qzF6ONkmrqe8G8aPMacBiZkI5V7FGxBp0ZMdY982pFK51WR7zFu7X3mM/XR63aRVd+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740328397; c=relaxed/simple;
	bh=zvz4EMOXlmrWyWitNGnXAQSR2eq+1wAo7RwOrMzxhM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcJ49MPu30RnOuA/BSd2H76qFN8HKZcy1mCh6xi3bzK5L+jATyVtKqW8431QGZyBEwOS0fO7dZ55ic3rXUT4TrPZ7+98p1Jay/N/Dhut6QXYWlqfx4hO9HnDPoHvsTQ4igYVoBsf6XseUpr9bHmZjL4zMqx7wO8ht7uQ4bMrrbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQx642xS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1871C4CEE4;
	Sun, 23 Feb 2025 16:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740328396;
	bh=zvz4EMOXlmrWyWitNGnXAQSR2eq+1wAo7RwOrMzxhM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BQx642xSrYSFMkDtxUusFO9/V6dQ1ON/O8M/s0cjUx7njZBgLxImV87rB09mSCGgY
	 qezb82iTL8eoW/wpqmMpxBFG0m8+oZRfiDR34fgJpsDWm5NRTWg7djZDnuQXeS49nI
	 2Shy5/0yP77Y80mZxBS6pMEykcpE5lPSxn2LsuO04hdeHS75Epjh8W0OjdW4h6n4mO
	 JF66tUz8/DI7tymcUSKpZ/VH2+3/TfqcrQjb9zXIxPrcNCnAgf13+uuBNIsCDfnq4j
	 CiBnUnAgerP+JkoSZaYofE6Hwq558c+hgNXl1JM5J1MqJen7r1VY4/sIX4KnvDx0f1
	 gJgBDizdfHHWg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30613802a59so37232441fa.0;
        Sun, 23 Feb 2025 08:33:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtA0Q906DVRbJBQTAJmMok1W3HNKAckH5BrESbyNJBQ0wgJ5M243mfbbkgjiv5wxMS8XjQb3WiBZA02Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEBex0lfkfu8+8YuDx8cvbs6icWbrAOnOZYP8Lh/3mIl6MHzrG
	qLRpujV7LzfXp3UP1TEtKXLPUrmC6gsUnDLLhrHCfLqRjFtfWB7ClVeL9lqrhHPCjJkrkzc+uuo
	ae1xmaBjq2K7czrn0i9DFA8tAz68=
X-Google-Smtp-Source: AGHT+IHxSfX/n4BVlQUqjsVJAWfnzLoyj+d6hjxzUouO1QEH1K9ZjF6+xy/nfHvk0Tye+ZxZaBnMva9sPzAwLHEKBzg=
X-Received: by 2002:a2e:9f4a:0:b0:309:1d7b:f027 with SMTP id
 38308e7fff4ca-30a59892a72mr34357641fa.9.1740328395018; Sun, 23 Feb 2025
 08:33:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221111516.1468261-1-patrick.rudolph@9elements.com>
In-Reply-To: <20250221111516.1468261-1-patrick.rudolph@9elements.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 23 Feb 2025 17:33:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGCUZi-7Vu097BorRHGv1XmRyky1RVRR8jFehneVDD8bg@mail.gmail.com>
X-Gm-Features: AWEUYZnhXHQfcl0XFYETRkkokiLSUFI3se8ntOYsRC5VHJ03qUkpOEpZYx2NWhI
Message-ID: <CAMj1kXGCUZi-7Vu097BorRHGv1XmRyky1RVRR8jFehneVDD8bg@mail.gmail.com>
Subject: Re: [PATCH] efi/cper: Fix cper_arm_ctx_info alignment
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 12:15, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> According to the UEFI Common Platform Error Record appendix, the
> processor context information structure is a variable length structure,
> but "is padded with zeros if the size is not a multiple of 16 bytes".
>
> Currently this isn't honoured, causing all but the first structure to
> be garbage when printed. Thus align the size to be a multiple of 16.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Thanks. Both patched queued up now in efi/urgent


> ---
>  drivers/firmware/efi/cper-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
> index fa9c1c3bf168..f0a63d09d3c4 100644
> --- a/drivers/firmware/efi/cper-arm.c
> +++ b/drivers/firmware/efi/cper-arm.c
> @@ -311,7 +311,7 @@ void cper_print_proc_arm(const char *pfx,
>         ctx_info = (struct cper_arm_ctx_info *)err_info;
>         max_ctx_type = ARRAY_SIZE(arm_reg_ctx_strs) - 1;
>         for (i = 0; i < proc->context_info_num; i++) {
> -               int size = sizeof(*ctx_info) + ctx_info->size;
> +               int size = ALIGN(sizeof(*ctx_info) + ctx_info->size, 16);
>
>                 printk("%sContext info structure %d:\n", pfx, i);
>                 if (len < size) {
> --
> 2.48.1
>

