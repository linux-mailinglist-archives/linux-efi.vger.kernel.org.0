Return-Path: <linux-efi+bounces-3061-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E853AA6C2ED
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 20:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAEE18916A3
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 19:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F71EA7D7;
	Fri, 21 Mar 2025 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQb5Jn26"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293D86250;
	Fri, 21 Mar 2025 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583649; cv=none; b=TPWKdafgYZKO5m10jt2D8RNsPTf59VHxSJZaEqY252onh/71wuo1w21ROkynVJJUtAbGGHCc4oweNptS3vUrlW2F1Dew/2E58ZfjHogWVqJqVb+8s8Aep/eVsVmcnzeXxy65dQPJDs9wffjo7ox5bhN72r6vEmzo5e7vhzQB91M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583649; c=relaxed/simple;
	bh=kI8/Ktbo4bXHZBHuFJiJpt1zlW7YKWggmvRDSjyVR/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWeEwVKLgNNd3MIBga4S3tZgQDHhaWdxQs5vO+x1iQz9iB21xYRRs9yUdTwvVbTIQqv0mIx2nomAdZlq5KT11ldhLu7LdYJTnIBauD4t9qWmTcS+E0j6ZdySi1M6Cce7ADD7cnw/hXeHPTR+Ay5Lxsk+AMGzclXXD/PUTz6Mx1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQb5Jn26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9610EC4CEEA;
	Fri, 21 Mar 2025 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742583648;
	bh=kI8/Ktbo4bXHZBHuFJiJpt1zlW7YKWggmvRDSjyVR/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YQb5Jn26+WwIClqQvwYcBQaD3iMrUoa4kE3yiwhdLPCIk2E6Trjl/YjTnbAvdLzW4
	 ryrjhKnBpXMHja6g1OZkvHkXVjOjRtaANc9FmmbmX0B/jTYy3t4uRSsg64M99G6IUq
	 tepc9tvcrXRjl9lM+1PsSnxWijVD08xhP0hkoM4R/kJmrmJCF1i4+1dU34miQwhT3u
	 foAMF7lnq1+xvyXQMzKE7Pwu9crqbgdvOeKP9lc2+YcspZRxG+XG40r+sDx4SPLLCs
	 41rmFVHXm46xtXmBOkz9L8/H3795j4cj4xqCS83wFcezxM99OziNY1pz2HMqW+IoOQ
	 EJqdeBlbnFLAg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-543d8badc30so2671763e87.0;
        Fri, 21 Mar 2025 12:00:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJ+AFq01b6IUVfGt8s19ivjyYkkt+qFiD5yMcjvMonXeBSz//zOi5fChYTU+jR7HUfPZ3SP/079vCe7xoY@vger.kernel.org, AJvYcCXmmHujUFI5/TC+qhC4GenhHLJrAJHKBUBMHDPauspw0Tk1Q9U1iifPQNZUAezDaJMxlGAWBFyHSHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyEP5ltnbMnE5c2oXHKme+SM7WG/QjPxBj1+bWKp5AP9olA0+i
	7ZGbg3zd21isaD8YE6HKQmSj47yTJ2cfpGrK5yJ+UkQNPvfacy8n88zDinu9NNiVNrGcKpfbFI2
	4nPd6uIz612gC0tpfpOKJVh8hIOA=
X-Google-Smtp-Source: AGHT+IHVtFvm9jig31iFYh/ebZbe5ZEY4GpJWCcsd3+Ea0fK5mulYd2Ssx1Wy7Nqbzs6Z0uJWKxSLgFdGiz8PKTAK5g=
X-Received: by 2002:a05:6512:3da1:b0:545:8c5:44cb with SMTP id
 2adb3069b0e04-54ad649651emr1899366e87.31.1742583646891; Fri, 21 Mar 2025
 12:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321184028.1797879-1-sdl@nppct.ru>
In-Reply-To: <20250321184028.1797879-1-sdl@nppct.ru>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 21 Mar 2025 20:00:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEatQ6o8dt7x-1mkX0+ct01ThbXDE-kmctWtEnZbC1gEQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jrsqm5ZKw1ssQ6i1BzrR7cxcAa9fGii9HAvF6CAdcYyX2Hh7WEQJN-jTCo
Message-ID: <CAMj1kXEatQ6o8dt7x-1mkX0+ct01ThbXDE-kmctWtEnZbC1gEQ@mail.gmail.com>
Subject: Re: [PATCH 6.1] efivarfs: Move efivarfs list into superblock s_fs_info
To: Alexey Nepomnyashih <sdl@nppct.ru>
Cc: Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, 
	syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com, 
	syzbot+246ea4feed277471958a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Mar 2025 at 19:40, Alexey Nepomnyashih <sdl@nppct.ru> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> commit cdb46a8aefbf7fd36772bb206aaaf7e45d7cf8f6 upstream.
>
> syzbot reports issues with concurrent fsopen()/fsconfig() invocations on
> efivarfs, which are the result of the fact that the efivarfs list (which
> caches the names and GUIDs of existing EFI variables) is a global
> structure. In normal use, these issues are unlikely to trigger, even in
> the presence of multiple mounts of efivarfs, but the execution pattern
> used by the syzkaller reproducer may result in multiple instances of the
> superblock that share the global efivarfs list, and this causes list
> corruption when the list is reinitialized by one user while another is
> traversing it.
>
> So let's move the list head into the superblock s_fs_info field, so that
> it will never be shared between distinct instances of the superblock. In
> the common case, there will still be a single instance of this list, but
> in the artificial syzkaller case, no list corruption can occur any
> longer.
>
> Reported-by: syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Reported-by: syzbot+246ea4feed277471958a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=246ea4feed277471958a
> Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
> ---
>  fs/efivarfs/inode.c    |  3 ++-
>  fs/efivarfs/internal.h |  9 ++++++---
>  fs/efivarfs/super.c    | 26 +++++++++++++++++---------
>  fs/efivarfs/vars.c     |  5 +++--
>  4 files changed, 28 insertions(+), 15 deletions(-)
>

The original commit has

 fs/efivarfs/inode.c    |  3 ++-
 fs/efivarfs/internal.h |  6 +++---
 fs/efivarfs/super.c    | 19 ++++++++++---------
 fs/efivarfs/vars.c     |  5 +++--
 4 files changed, 18 insertions(+), 15 deletions(-)

so you will need to explain where those extra 10 lines came from.

