Return-Path: <linux-efi+bounces-3335-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C385A89037
	for <lists+linux-efi@lfdr.de>; Tue, 15 Apr 2025 01:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB5D189BA82
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 23:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DC31F4E54;
	Mon, 14 Apr 2025 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I71bEzD3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882419DFB4;
	Mon, 14 Apr 2025 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744674210; cv=none; b=banaAUas2z327L+/xulnSYZ9Z+PQHUbf9aOY5SrsITJK44b4EhTPUSKU4fJE01ND0TgA1bZD7XMElqRoVo6eviX3yjCJBMFe1BXKBYjTuQFLujMtOFmRLtG21BctfbPwry2+s3gvnFJmtdgSY7Zzi5+jC6m/FOd+oyrPcB0aL5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744674210; c=relaxed/simple;
	bh=mYt0rbUDMBdDTLPdWGuS/Bnh03XJEhDanQRD6dzfsgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Djpwhgo8xWgkj3DAVE+u68LqLpqY3JCfRzvxPoLFvCVqMPoDRukIHqsY8y2jLUq8/Ndxa6wNszsvhv+yf/LEYi6gre9Aj/0aPeJq3MjIiE9ADTIMVu89ibiOCd+/XxUqU5Od3tW9ycEc/aUlhpZgtqiksOh7mKoz3xLx88aQrl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I71bEzD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DA3C4CEE2;
	Mon, 14 Apr 2025 23:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744674210;
	bh=mYt0rbUDMBdDTLPdWGuS/Bnh03XJEhDanQRD6dzfsgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I71bEzD3NRM2S1F1pdsYNi6bANyOji5p+V8DBDIaQJYynC5bdJ0f010MjTzjI7Kh/
	 VNWuDmkQcmFV+uUEVlruf2t+phFwZ6akclg8AJxeR9uv7OLuWkwa/0JW/UYrzuZYPD
	 bP/+j4RHpUT0K5kh+R3c6iFU5iDmIJpOP+z+s3QCX0SEkwfLubBWgauR8seemhVGms
	 kjyfxpBT1w2P+vz1QxKaxX+wY1r+FwPP+HHVdJPH9BQkl+KI19fK4BISx90WKhA6I+
	 cBxVS2fXHUWJHEIOLLLS0JkPX/ViLlc5i6kic2qCivRHJC+EldLCeIdK28uPucGqZC
	 5MKEqXtoq5feQ==
Date: Mon, 14 Apr 2025 16:43:26 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	pawan.kumar.gupta@linux.intel.com, seanjc@google.com, pbonzini@redhat.com, ardb@kernel.org, 
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-efi@vger.kernel.org, samitolvanen@google.com, ojeda@kernel.org
Subject: Re: [PATCH 6/6] objtool: Validate kCFI calls
Message-ID: <jsbau7iaqetgf6sa7pooebbbhkhnnidi24f2g7nieozeu63qes@flunkdj5eykb>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.540779611@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250414113754.540779611@infradead.org>

On Mon, Apr 14, 2025 at 01:11:46PM +0200, Peter Zijlstra wrote:
>  SYM_FUNC_START(__efi_call)
> +	/*
> +	 * The EFI code doesn't have any CFI :-(
> +	 */
> +	ANNOTATE_NOCFI
>  	pushq %rbp
>  	movq %rsp, %rbp
>  	and $~0xf, %rsp

This looks like an insn annotation but is actually a func annotation.
ANNOTATE_NOCFI_SYM() would be a lot clearer, for all the asm code.

Though maybe it's better for ANNOTATE_NOCFI to annotate the call site
itself (for asm) while ANNOTATE_NOCFI_SYM annotates the entire function
(in C).  So either there would be two separate annotypes or the
annotation would get interpreted based on whether it's at the beginning
of the function.

> +++ b/include/linux/objtool.h
> @@ -185,6 +185,8 @@
>   */
>  #define ANNOTATE_REACHABLE(label)	__ASM_ANNOTATE(label, ANNOTYPE_REACHABLE)
>  
> +#define ANNOTATE_NOCFI_SYM(sym)		asm(__ASM_ANNOTATE(sym, ANNOTYPE_NOCFI))

This needs a comment like the others.

> @@ -2436,6 +2438,15 @@ static int __annotate_late(struct objtoo
>  		insn->_jump_table = (void *)1;
>  		break;
>  
> +	case ANNOTYPE_NOCFI:
> +		sym = insn->sym;
> +		if (!sym) {
> +			WARN_INSN(insn, "dodgy NOCFI annotation");
> +			break;

Return an error?

> @@ -4006,6 +4017,36 @@ static int validate_retpoline(struct obj
> +	/*
> +	 * kCFI call sites look like:
> +	 *
> +	 *     movl $(-0x12345678), %r10d
> +	 *     addl -4(%r11), %r10d
> +	 *     jz 1f
> +	 *     ud2
> +	 *  1: cs call __x86_indirect_thunk_r11
> +	 *
> +	 * Verify all indirect calls are kCFI adorned by checking for the
> +	 * UD2. Notably, doing __nocfi calls to regular (cfi) functions is
> +	 * broken.

This "__nocfi calls" is confusing me.  IIUC, there are two completely
different meanings for "nocfi":

  - __nocfi: disable the kcfi function entry stuff
  
  - ANNOTATE_NOCFI_SYM: Regardless of whether the function is __nocfi,
    allow it to have non-CFI indirect call sites.

Can we call this ANNOTATE_NOCFI_SAFE or something?

-- 
Josh

