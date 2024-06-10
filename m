Return-Path: <linux-efi+bounces-1190-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D08A9027AC
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 19:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EAE1C21121
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 17:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FD3145FEF;
	Mon, 10 Jun 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9J8mSpl"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28FD145B38
	for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040217; cv=none; b=fGh7Mfpurq5WxIWKP1cgryfko1ToVmfCInGyoSO53tJ/n1xyPeuvLqSuMu04Y2j6XwALj6kdI6TXXBBUyhbO2AaSNEzbUzNxK5yJDgnXEBZEiJuO8E97DclaiSKGDuX9GafEVM3evf3eNRVezadn3s1lrkjonCFeoqix+Ugdo5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040217; c=relaxed/simple;
	bh=w+17CjTD4uvJd3xmHE9UcJGpJC/q4HNz1mgDliauiLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqmcEDPT7xC/trpeCiJFl8jEp1DtieI/SSUbcZ68fAEePSwKd9RInXOvukP9jmEZcIwOw9OOwjYzlaQKNRs+KnAD27rwDScdRPpf1Z9nWwRN1ytv3lwj+liMRtgDiQTPsWPnXvC6+PnGJDFcujCF4v5I9JIpFBAdbP63LMuP0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9J8mSpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3371BC2BBFC
	for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 17:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718040217;
	bh=w+17CjTD4uvJd3xmHE9UcJGpJC/q4HNz1mgDliauiLM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o9J8mSplWtqf4VEt3US/MI35OSlY1yDSbwNfEsONMsQpV++GbZOc4ZwMNakoIDxEk
	 /xsT/bUHAQUlb0djNA1FCzmLLgcUy0PGbEiunIsJx+UMVgtlRvREOCokEKHlHxDNdj
	 iJs/bscpZYomRn+JBkeguXE5/+3QBNQ8TXoAFQKH4tC4nsw7M9kODBTjX0JPREgC8C
	 AmWeHfT1xUky0tUYZ3tK4dXto++xp6tbpM2jxlx9BDEB8/Py6ZBd9JN4WNvU3kax9l
	 ADVJcqc8eUptwXyb9Bxxrv8njrqsNqdCXv9+BGZa93r4ngNwsJpjoy/ZHAoiCNQ6Cm
	 T/5j1xXD8UHVw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52c525257feso2950703e87.1
        for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 10:23:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YxG1fe9mWPZYlqMxWI3TS6IedOSC/oiBpuWfobDjrOSriN3jcc8
	VHLQt8FmSZTZhMk8+rXvwgA+4q+FUYJoI/isBgOIWKPCnuxGwAFoAKE/ldks2VOdnfgTwF+PcVR
	WqH3RF6ZdJMhfUy2mu3F6eX3Qqzc=
X-Google-Smtp-Source: AGHT+IGr4+baK0osJIGvRlQjAyUG+V1g0sByl8Tiu33GKemlrZSmU/l8xUuN62Utrxu6JuwaEGYUnrnCBdGe5/JtJ/8=
X-Received: by 2002:a05:6512:1596:b0:522:3551:35f5 with SMTP id
 2adb3069b0e04-52bb9f66b02mr7927206e87.14.1718040215565; Mon, 10 Jun 2024
 10:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAzv750HTnposziTOPDjnUQM0K2JVrE3-1HCxiPkp+QtWi=jEw@mail.gmail.com>
In-Reply-To: <CAAzv750HTnposziTOPDjnUQM0K2JVrE3-1HCxiPkp+QtWi=jEw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 10 Jun 2024 19:23:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGvdRwboAZZGEvOh2_wFjzhc1OY2F5BBcYJF5ZhT8=Bzg@mail.gmail.com>
Message-ID: <CAMj1kXGvdRwboAZZGEvOh2_wFjzhc1OY2F5BBcYJF5ZhT8=Bzg@mail.gmail.com>
Subject: Re: EFI mixed mode boot failure
To: Nicholas Bishop <nicholasbishop@google.com>
Cc: linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 18:41, Nicholas Bishop <nicholasbishop@google.com> wrote:
>
> I'm seeing problems booting the kernel in EFI mixed mode (tested latest
> torvalds/master, 83a7eefedc9b). I'm attempting to boot the 32-bit compat
> entry point, not the handover protocol.
>
> It seems decompression is failing, and some print debugging pointed me
> at [1], free_mem_ptr is not initialized to zero so that branch is not
> taken. I figured that might imply BSS isn't getting zeroed, which led
> me to where the BSS is conditionally zeroed in efi_pe_entry [2].
>
> That conditional was added in df7ecce842b8 "x86/efistub: Don't clear BSS
> twice in mixed mode". I verified that prior to that commit I can boot
> successfully in mixed mode, after I cannot. The commit message says that
> "efi_pe_entry() is also used as an entrypoint by the mixed mode startup
> code, in which case BSS will already have been cleared", but I couldn't
> find where that would occur. I do see a BSS clear in efi_mixed.S, but
> it's gated on CONFIG_EFI_HANDOVER_PROTOCOL [3].
>

Thanks for the report, and for the analysis.

That commit definitely fixed an issue I encountered with the mixed
mode build, but I am struggling to reproduce that at the moment.

Which platform/EFI implementation are you using?

In any case, it seems your analysis is correct, and no BSS clearing is
performed on the compat entry point boot path. So please check whether
something like the below fixes your issue as well.

diff --git a/arch/x86/boot/compressed/efi_mixed.S
b/arch/x86/boot/compressed/efi_mixed.S
index 876fc6d46a13..ebff2a915ce0 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -303,6 +303,18 @@ SYM_FUNC_START(efi32_pe_entry)
        movl    $0x80000003, %eax               // EFI_UNSUPPORTED
        jnz     2f

+       call    1f
+1:     pop     %ecx
+
+       /* Clear BSS */
+       xorl    %eax, %eax
+       leal    (_bss - 1b)(%ecx), %edi
+       leal    (_ebss - 1b)(%ecx), %ecx
+       subl    %edi, %ecx
+       shrl    $2, %ecx
+       cld
+       rep     stosl
+

