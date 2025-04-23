Return-Path: <linux-efi+bounces-3431-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ADFA98FC7
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 17:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AC61B81619
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DE527D763;
	Wed, 23 Apr 2025 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouW/wBxa"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6BC26A082;
	Wed, 23 Apr 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420517; cv=none; b=qB7YNcUXXJywqXZbtM7Dtlw2ryXuqVdztym6Xnffok4pSNHL/As2a6elFkmmI8Do7T1Xt1m1NnC9Ll8inATWi81sl5W8X22oyMgymPQ3k95JY6IKjZ9nxjjk1tQsLTnm2UuSmhoRW+voKDpzLkB9nCk5eTn+8b71t/OWBGIR078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420517; c=relaxed/simple;
	bh=tQ5WuliRJvwcD2ksGop6yO+1sA09407P6BEmUGUWq6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkLxneXKuHLB7SojBonmVl6plW12QuX/dcv8yRI6C4yWsEqFGF4T4d6dU1kjoSXKAZzGcZodXnTi6G6drm+x8RaQLpqNCi/Uh9tUOD0TiqdYbyEaYv1wXhN8ffGxBjCIfPSnS2g+xUNBAl0P/35AbcuSOc8Qh7TQM9zx50n30+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouW/wBxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2566FC4CEE3;
	Wed, 23 Apr 2025 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745420515;
	bh=tQ5WuliRJvwcD2ksGop6yO+1sA09407P6BEmUGUWq6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ouW/wBxaeKMwR+BAXHBjp5BVlj55baRrrgszNZrGVrX/kM6VVON224jd5YIUIEHgg
	 7jmVxxS0JK7d9CrLm2vgvIqapsdckKNdSOXwcsVOWiTZYdVjIARRgS59otjCgHtEaz
	 zRJZD6TeZwHsfFq46GPZoh6O5eMeuzCJ5/X4Of8LyYsJmxK67jhRoMWcU5JrGOFCv8
	 Z1geBlk/c2zmSlcaB9rMbbOImOuoER6okmb3Lb1LeXMgVu5cYNRw+ogLypNaW5Lo5F
	 +F24d/CFcsQyrINp2P6JZpX+4lI+5Eo3AmJELd3IDlBh03jDJMi2f7GeYcn/rU6QIr
	 YqNr0trcKyBuw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bf1d48843so56600271fa.2;
        Wed, 23 Apr 2025 08:01:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhKO8b8tu6q3gOa36jaBQ319Zc43E8T7HtDQOMujMwecGqTeJqCQ6fkjr4msMboqGCLjUSFHqInQaEOoBSWsAGaHQ=@vger.kernel.org, AJvYcCVwle+dMfq2Zo3H25AHTnOvC5n7koUV4B0PWa1S5KF1KkSwyBV/VTKLbS/aMNTqxNlVDLPU35465xcNG5eY@vger.kernel.org, AJvYcCVxjWgVqnmRjsz7tMKWhBzphAfeaLHceYLtNa1VamWHq7bxiU4WjBYgB6JwiA5qdexHoZ6MnIi4oYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwcYDzkxMJztmEoPzrhnCzbaSRY1Dnmnq+K5q6FYSrYoV0v1PW
	mPG6KQf5m1pg7iCwlZdEGpxELIJ5MDAVs2MtffKGxY5rkmUfRX9X9BddhiWibpEdhgG/McSPBTF
	1JwBg6Rt6W33S9791UwYNFbRtOy4=
X-Google-Smtp-Source: AGHT+IG2CDF+UodCIQHaafpJRyR/ccpNZb7CjOiGJ6oVpwDftbX6t5n1A8Nk9bWvGYjTETNxukRBteMmCOyyzvR34NQ=
X-Received: by 2002:a05:651c:1592:b0:30b:ed8c:b1e7 with SMTP id
 38308e7fff4ca-310904f0efbmr53117761fa.18.1745420513361; Wed, 23 Apr 2025
 08:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422210510.600354-2-ardb+git@google.com> <174539448176.31282.2929835259793717594.tip-bot2@tip-bot2>
 <odoambb32hnupncbqfisrlqih2b2ggthhebcrg42e5fg25uxol@xe5veqq52xif>
In-Reply-To: <odoambb32hnupncbqfisrlqih2b2ggthhebcrg42e5fg25uxol@xe5veqq52xif>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 23 Apr 2025 17:01:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFpE=P0_a3fTAnb7qQmXLt19dCtuEcd5U8xwYzAcO=ufQ@mail.gmail.com>
X-Gm-Features: ATxdqUEFwtCb4nqIi7NO0Py2cAxP4hjMqkFdrhvexGPyj24fTTWcg1ZgiO_bY9E
Message-ID: <CAMj1kXFpE=P0_a3fTAnb7qQmXLt19dCtuEcd5U8xwYzAcO=ufQ@mail.gmail.com>
Subject: Re: [tip: x86/boot] x86/boot: Disable jump tables in PIC code
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: tip-bot2 for Ard Biesheuvel <tip-bot2@linutronix.de>, linux-tip-commits@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-efi@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 16:55, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Wed, Apr 23, 2025 at 07:48:01AM +0000, tip-bot2 for Ard Biesheuvel wrote:
> > The following commit has been merged into the x86/boot branch of tip:
> >
> > Commit-ID:     121c335b36e02d6aefb72501186e060474fdf33c
> > Gitweb:        https://git.kernel.org/tip/121c335b36e02d6aefb72501186e060474fdf33c
> > Author:        Ard Biesheuvel <ardb@kernel.org>
> > AuthorDate:    Tue, 22 Apr 2025 23:05:11 +02:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Wed, 23 Apr 2025 09:30:57 +02:00
> >
> > x86/boot: Disable jump tables in PIC code
> >
> > objtool already struggles to identify jump tables correctly in non-PIC
> > code, where the idiom is something like
> >
> >   jmpq  *table(,%idx,8)
> >
> > and the table is a list of absolute addresses of jump targets.
> >
> > When using -fPIC, both the table reference as well as the jump targets
> > are emitted in a RIP-relative manner, resulting in something like
> >
> >   leaq    table(%rip), %tbl
> >   movslq  (%tbl,%idx,4), %offset
> >   addq    %offset, %tbl
> >   jmpq    *%tbl
> >
> > and the table is a list of offsets of the jump targets relative to the
> > start of the entire table.
> >
> > Considering that this sequence of instructions can be interleaved with
> > other instructions that have nothing to do with the jump table in
> > question, it is extremely difficult to infer the control flow by
> > deriving the jump targets from the indirect jump, the location of the
> > table and the relative offsets it contains.
> >
> > So let's not bother and disable jump tables for code built with -fPIC
> > under arch/x86/boot/startup.
>
> Hm, does objtool even run on boot code?
>

This is about startup code, not boot code. This is code that is part
of vmlinux, but runs from a different mapping of memory than the one
the linker assumes, and so it needs to be built with -fPIC to
discourage the compiler and linker from inserting symbol references
via the kernel virtual mapping, which may not be up yet when this code
runs.

