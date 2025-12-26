Return-Path: <linux-efi+bounces-5925-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81653CDE933
	for <lists+linux-efi@lfdr.de>; Fri, 26 Dec 2025 11:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41EA83007FFE
	for <lists+linux-efi@lfdr.de>; Fri, 26 Dec 2025 10:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F43A299950;
	Fri, 26 Dec 2025 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN367BKz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF57381AF
	for <linux-efi@vger.kernel.org>; Fri, 26 Dec 2025 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766743814; cv=none; b=Gfae3TRg0g6k1YsmPUb8CPQJ36R8nugGigslzBO3aE57lQ35bmUkbKXsme6ZeOOCSfPF4WtJn4BeANrth0SO2ZvhJ1h0Uy0FhERXvCznK+qLnXuf87IlXpgq+XnRsmN3/JfCV+9oPDxCQEIcf7uXxs5EX0Jp2rIT8s6CFTgapJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766743814; c=relaxed/simple;
	bh=UwdDg/vJDXLfJsPqMBXTVvRQ7kiG/4QVTGKgd2G1aQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ye0T4nhiopEyMUJ0zrFAAdFGq2PS6++D1ALE7k3DfIvLsD298/ZuiQI3XV5PRBzJJ3pnbPgtWI+Dh8MspXTx2RzssMNeG9Ag9iZf4Ce10JT1IfnP6etPh9e+XUvSphpcwd0qmExDqbL9TYf8cpsBfMFieoLhwX7fMP870gzlwkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN367BKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA5DC113D0
	for <linux-efi@vger.kernel.org>; Fri, 26 Dec 2025 10:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766743813;
	bh=UwdDg/vJDXLfJsPqMBXTVvRQ7kiG/4QVTGKgd2G1aQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UN367BKzngjMxzbnSsud+cdFVYG+xbgUlR717dQL8IGgJ6XpVU8hRSPPYIV43ktYs
	 n9OxcOKpmbRxLs23H5fmt6cTa0L24YDXiYmhoaU5tBBKaS1X3VZAqTSCHBsYPuQmzj
	 VIGkcnai1FaOdOd11OnDPm8ppOk8nAp1/LbQ3ARvK3owogswwPdaNr2udpHgB8oeSD
	 piI8thPEJoCS/cjOnPhyp0b92hJl2WVYCF0bGBhe73t8OlyTpjmm0iBaHLjg17O1mb
	 qZZ5MhzjqCHFUsQhshavikauNk+TZDS1u9RAbD0Ap7G67ABoIesTpOfMYxkaE+iHJ+
	 XQWJYdpfgSwHw==
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so7705243a91.1
        for <linux-efi@vger.kernel.org>; Fri, 26 Dec 2025 02:10:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmFqmIuIGsSnqAqzml8nvOOiEljqn4v7I78fZNKeMWdk1ASKuyOJUOUm07tyh2NjXiDxcLMNuE1gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymmtrvzjoq014prWeJkHHNUgDZ1L3+jMtgQzwT+d9qzm7GG7v6
	NgV5Z40WYxKg668UKXbZl81rv9wdzf10fPv12TyR9kqoJxRP2GhlWORujsTCkiNJ6oN8/1ZMYdw
	jUZZfFGjyJ8z6jGnqkXpWYoTOlsODRsQ=
X-Google-Smtp-Source: AGHT+IFMPUHGcCWsXnH6hVjDphxdKvFV61uRZ7+ZSF8P9bM2PyRMJ+EqfmP3JBcmRs/5dnp6pRsP7bOptzbrNoOr6jY=
X-Received: by 2002:a17:90b:4f91:b0:349:5b1b:78be with SMTP id
 98e67ed59e1d1-34e921b0557mr23396254a91.17.1766743813102; Fri, 26 Dec 2025
 02:10:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-efi_fix_619-v1-0-e0146b8b9d73@debian.org>
In-Reply-To: <20251223-efi_fix_619-v1-0-e0146b8b9d73@debian.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 26 Dec 2025 11:10:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE2rN-erQNnSZ5-CGKWw6fCQ6Hvz-2BU1pn-Vy7ftneQA@mail.gmail.com>
X-Gm-Features: AQt7F2pi64AhAkoQfxWEexPYGpeqDBFCLyEwaxZhaOVOJRaCzCp2dk7zUJsXPCA
Message-ID: <CAMj1kXE2rN-erQNnSZ5-CGKWw6fCQ6Hvz-2BU1pn-Vy7ftneQA@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: efi: Fix NULL pointer crash in 6.19-rc2
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	riel@surriel.com, puranjay@kernel.org, usamaarif642@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Dec 2025 at 11:56, Breno Leitao <leitao@debian.org> wrote:
>
> I am seeing the following crash on arm64 with 6.19-rc2 (commit 9448598b22c5
> ("Linux 6.19-rc2"))
>
>         Unable to handle kernel NULL pointer dereference at virtual address 00000000000000c8
>
>         Call trace:
>         cap_capable (security/commoncap.c:82 security/commoncap.c:128) (P)
>         security_capable (security/security.c:?)
>         ns_capable_noaudit (kernel/capability.c:342 kernel/capability.c:381)
>         __ptrace_may_access (./include/linux/rcupdate.h:895 kernel/ptrace.c:326)
>         ptrace_may_access (kernel/ptrace.c:353)
>         do_task_stat (fs/proc/array.c:467)
>         proc_tgid_stat (fs/proc/array.c:673)
>         proc_single_show (fs/proc/base.c:803)
>         seq_read_iter (fs/seq_file.c:209)
>         seq_read (./include/linux/ioprio.h:59 ./include/linux/ioprio.h:84 ./include/linux/fs.h:2177 fs/seq_file.c:158)
>         vfs_read (./arch/arm64/include/asm/uaccess.h:46 fs/read_write.c:560)
>         ksys_read (fs/read_write.c:705)
>         __arm64_sys_read (fs/read_write.c:722)
>         invoke_syscall (arch/arm64/kernel/syscall.c:46)
>         el0_svc_common+0x90/0xe0
>         do_el0_svc (arch/arm64/kernel/syscall.c:150)
>         el0_svc (arch/arm64/kernel/entry-common.c:724)
>         el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:743)
>         el0t_64_sync (arch/arm64/kernel/entry.S:596)
>
> This was bissected to commit a5baf582f4 ("arm64/efi: Call EFI runtime services without
> disabling preemption").
>
> After the commit above, it crashes arm64 with a NULL pointer dereference in
> cap_capable() when running below (ocassionally). Unfortunately I still don't
> have a simple reproducer, and it takes about 10 minutes to crash on my systems.
> it always crash with below[1] application.
>
> From my investigation, the root cause is that efi_mm lacks user_ns
> initialization. When kthread_use_mm(&efi_mm) temporarily adopts efi_mm
> for EFI calls, LSM hooks expect mm->user_ns to be valid for credential
> checks. With it being NULL, capability checks crash.
>
> This series contains two patches:
>
> 1. efi: Initialize efi_mm.user_ns to &init_user_ns (the actual fix)
> 2. kthread: Add WARN_ON_ONCE() to catch similar bugs early (RFC)
>
> The second patch is mostly an RFC that adds a warning in
> kthread_use_mm() to detect any mm_struct missing user_ns initialization,
> helping prevent similar NULL pointer crashes in the future.
>
> Link: https://github.com/facebookincubator/below [1]
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Breno Leitao (2):
>       arm64: efi: Fix NULL pointer dereference by initializing user_ns
>       kthread: Warn if mm_struct lacks user_ns in kthread_use_mm()
>

Thanks for the report - I've queued these up in the EFI fixes tree.


>  drivers/firmware/efi/efi.c | 1 +
>  kernel/kthread.c           | 1 +
>  2 files changed, 2 insertions(+)
> ---
> base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
> change-id: 20251223-efi_fix_619-3891ca7d2914
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
>

