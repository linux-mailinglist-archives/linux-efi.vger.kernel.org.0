Return-Path: <linux-efi+bounces-3364-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574FCA9369F
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 13:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E361B63928
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 11:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21312153D8;
	Fri, 18 Apr 2025 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/Ig4BN0"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27501885A5;
	Fri, 18 Apr 2025 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744976574; cv=none; b=TgmihCzYgE4f20Ocl715LIVqhc1vePASwm+pjArMWRAgl2GlI1OWVrgskFLPkjNw+IXGJOUSolVslAe4FdZFxr8zBgg7gzrmo7q5uvIu4/WZbt5MWUgEBLf1bNeYgw5StbrtaCMudEPBxfdy1cQ85Uf2eVjC1KzHvp1qMzpy3Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744976574; c=relaxed/simple;
	bh=q2HwWwZUlFfb/pfzF1pzLy9h1Mk1BDE2hl7vTSgPZYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ie/q1tFbI2ydzwd+T/tbtzqCTgY+CCU61UpcBNh5O9isx9XoShHAm6A6UWzU7T/TG9x1H/cIujmd9W9a/fri95+Rkp/ZmcYLBXpXdbqMUQMtOQGhuyDl1Jml6Al1P2XUSPGWaFsE5Stc1LMxVU+FS5SYCIU6kyl2mFLm9QkW5Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/Ig4BN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3745DC4CEED;
	Fri, 18 Apr 2025 11:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744976574;
	bh=q2HwWwZUlFfb/pfzF1pzLy9h1Mk1BDE2hl7vTSgPZYI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N/Ig4BN0ePJZGay4MCDCzIGzUWxzGIOmsjAnpZL4UnUae9T5QyEhOg8SSVhpURbtc
	 osA0xn5QsK+0czE8CxpzgayzkUqlBvxdbPAmOCuS3TkB1BNsRcyN86FfXTDGo5senV
	 pCANRi9nBb2Sidtz406nM3KH//cCeOsBZYwCqI0D6n3CkUFRGwrK6CIB7gTjmagd3J
	 v9Uqd8TFnxpddqhOpsspzkNb/V2il+AvGFTBT2X/ZM6rktr1+FyJ8NYKEjcPcrhWbD
	 ChIbsFj5dqZYHXw8sh8Mjb7MVkUYC4u6kE1WKdHZIpHKj7eaZuERF6E/OTVFvMHUav
	 4oucsFIs9Bn9A==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54c0fa6d455so2064699e87.1;
        Fri, 18 Apr 2025 04:42:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3p/QjhgOZ5T6+1QHcdmkfQoJroqSC15dgUv44RnOfHBxypWkzPzjggxkOix5PQo6Mca17ZLW4NPw=@vger.kernel.org, AJvYcCXflWUMdZnl9On5EWVSr7Eafj5s6xYv2NER9/jbxyVBtFKVP0f5tufrAdbfuclrchB/5zL/uAJ8D9s0wBlrRxDuFJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKnm1eWLZEXszC0pMOW9Jx8wVdKN+NbTogyWuwzQ4N/gOwnOF/
	BTe630GKcFfhr6lAy/1QndIEHxepptWWZLXLAFrjWpbh2HEKBZQKEQo1u15SjJLdkO80Or1Jymq
	jLKKojqgS31/nQgMzrmzB3q7NvtU=
X-Google-Smtp-Source: AGHT+IHWed/m9sFUEDIG4jqc/aGHnXjfUnlGxJYhffAfE7eyP3d9i6romOJeGyyHRnuWJaLKpeOkFxkUB9k3zyV5AOM=
X-Received: by 2002:a05:6512:114f:b0:545:8f0:e1a4 with SMTP id
 2adb3069b0e04-54d6e662ccdmr678965e87.45.1744976572543; Fri, 18 Apr 2025
 04:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410132850.3708703-2-ardb+git@google.com> <174448976513.31282.4012948519562214371.tip-bot2@tip-bot2>
 <CAMj1kXFEXZ8cGMwz6N_ToYp0Wf5Vr9UBFRueWx_MtrwbDLq+LQ@mail.gmail.com>
 <Z_rQ4eu4LYh6jGzY@gmail.com> <CAMj1kXGTP31w7vM+jWqpbJPmoyPU9vqOrmvXsueoPnBin0y_hQ@mail.gmail.com>
 <aAICRcfkBV3tHP-G@gmail.com> <aAIJ8C5Ho97geYMj@gmail.com>
In-Reply-To: <aAIJ8C5Ho97geYMj@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 18 Apr 2025 13:42:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGEmyCho_aUsTqZF+Q-CQBFmM50pd=KgVVQhJX78hNCPg@mail.gmail.com>
X-Gm-Features: ATxdqUGbVHq5MnqFFIMI4W4YfIn5qEv6b1_3THSVq7biSKYvJlYx311RB8xxH8M
Message-ID: <CAMj1kXGEmyCho_aUsTqZF+Q-CQBFmM50pd=KgVVQhJX78hNCPg@mail.gmail.com>
Subject: Re: [tip: x86/boot] x86/boot/sev: Avoid shared GHCB page for early
 memory acceptance
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-efi@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Apr 2025 at 10:14, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
...
>
> So there's this new merge commit in tip:x86/boot:
>
>    54f71aa90c84 Merge branch 'x86/urgent' into x86/boot, to merge dependent commit and fixes
>
> which brings this fix into x86/boot:
>
>    a718833cb456 ("x86/boot/sev: Avoid shared GHCB page for early memory acceptance")
>
> thus 54f71aa90c84 should be a proper base the rest of the startup/
> series, right?
>

Yes, perfect. Thanks.

