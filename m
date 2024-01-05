Return-Path: <linux-efi+bounces-340-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC23825C3B
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jan 2024 22:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A1D285ACB
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jan 2024 21:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC1F2D780;
	Fri,  5 Jan 2024 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqKFe3dT"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA922EEF;
	Fri,  5 Jan 2024 21:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8506C433CB;
	Fri,  5 Jan 2024 21:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704491427;
	bh=IdUsCMJ/vqOhBPKNbHGvLL4LIHpK7zjcsFeMXwJmk8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eqKFe3dTU5AlHizIphVnFxETIy8JPb1Td00q8vgFuanO5pGzF3YJ/3Z7VMKLUIK1u
	 bRxRgzdOvQL8B5zUIMSWO6di7VQIoYRKRU1BSbVyd95ox8XfOkeeQIJlsZOfXn8KP2
	 p8NHd+m9KITKwgRmy0kHW14CyWCTtFFYVIG3b9+0S3Yz+RzM3BafXvTrp5rtbsJ0iZ
	 tDcCnI6rB/QXs3i/KH3JzDoHfVJaLIul+YMYfdsHbBTeBa/6a0SZ5m7bE7xG4AygMd
	 TawnKjFUCImNv9TMi0hWfB8Z0K0VQ+lZxrIBUhRpwHslHFAEQvh7M1PYUrnPZe/uov
	 HvqnLo6rrB6YA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C002DDCB6FD;
	Fri,  5 Jan 2024 21:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/4] riscv: Use READ_ONCE()/WRITE_ONCE() for pte accesses
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170449142778.26226.7492189738418488414.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 21:50:27 +0000
References: <20231213203001.179237-1-alexghiti@rivosinc.com>
In-Reply-To: <20231213203001.179237-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux@armlinux.org.uk,
 ryan.roberts@arm.com, glider@google.com, elver@google.com,
 dvyukov@google.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, anup@brainfault.org, atishp@atishpatra.org,
 ardb@kernel.org, ryabinin.a.a@gmail.com, andreyknvl@gmail.com,
 vincenzo.frascino@arm.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-efi@vger.kernel.org, linux-mm@kvack.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 13 Dec 2023 21:29:57 +0100 you wrote:
> This series is a follow-up for riscv of a recent series from Ryan [1] which
> converts all direct dereferences of pte_t into a ptet_get() access.
> 
> The goal here for riscv is to use READ_ONCE()/WRITE_ONCE() for all page
> table entries accesses to avoid any compiler transformation when the
> hardware can concurrently modify the page tables entries (A/D bits for
> example).
> 
> [...]

Here is the summary with links:
  - [v2,1/4] riscv: Use WRITE_ONCE() when setting page table entries
    https://git.kernel.org/riscv/c/c30fa83b4989
  - [v2,2/4] mm: Introduce pudp/p4dp/pgdp_get() functions
    https://git.kernel.org/riscv/c/eba2591d99d1
  - [v2,3/4] riscv: mm: Only compile pgtable.c if MMU
    https://git.kernel.org/riscv/c/d6508999d188
  - [v2,4/4] riscv: Use accessors to page table entries instead of direct dereference
    https://git.kernel.org/riscv/c/edf955647269

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



