Return-Path: <linux-efi+bounces-3510-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4204AA5108
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 18:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D6A9E4612
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FB825DAF0;
	Wed, 30 Apr 2025 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkRmRwLa"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E21288DA;
	Wed, 30 Apr 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028797; cv=none; b=uZqJE4PU+YkdWDoEd4sBAdWAPRHtoFdyBEWFFgf1JYY3tRuw9ttM8FFunh9OGPEzl3w9MhEu5ZFYERovTA9Qg+s89OdPJXcSdo6/P/fmCwfS1MK9+7Zj1NcuqVvBr1VRgqBaeDJk6Kwj4WSCOVQEoAj4UX6yadUsbaPsvqybSfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028797; c=relaxed/simple;
	bh=i4QVNzm8qbgMrgm+f1BqFisRi4bGpkwU+GNeZbmeOfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/m6l9ectRmwfih07kYSp7VCUihwciN3fTPVo038cXwq7I+coZIKNNtvG/3hk3r5CdbBn5Uex2Of2LUmVtwpEpA0clkIbOzMVzlKjiLMhqK4GNMhQ78Cmxm3qylS3jWaj0rHKdHimCsaREUjSHuhOufUmTMcSaC/Z6hxhLUpQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkRmRwLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C7EC4CEEB;
	Wed, 30 Apr 2025 15:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746028796;
	bh=i4QVNzm8qbgMrgm+f1BqFisRi4bGpkwU+GNeZbmeOfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkRmRwLa2/T373ENnnLnCFjIuO0CgG2pvanCffRnnqvYOhMS5AUW7xMAcV+EQKucs
	 IKgHHIHQinrJO3eTCmmVDrcMZ7x7Xm9PfOqMWgIREHm3KRdR3StVSlk/sDc6eqT5ol
	 C5Q5X6BPhJeIeA33VoCnU5XfW7lAFLvrrSStPCRXyxzpE7aqEJHeGoLQt1PrHyhY3O
	 wI0RWDDbZsQxCioaQKKJONZC3I74bwPpfyH1dClXJFgW4HOI2LcQxzp/xsUbQykIaY
	 comuAC96EIXvNo5C2LiQ3vMRoPPNwmh3yAp7GXgn9V+9cWddlpha8P6d84AjKwUxZz
	 WqDJERF2MTF5A==
Date: Wed, 30 Apr 2025 08:59:53 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, seanjc@google.com, 
	pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, samitolvanen@google.com, 
	ojeda@kernel.org
Subject: Re: [PATCH v2 13/13] objtool: Validate kCFI calls
Message-ID: <u4v64j3wgdml5zkij43lcksknhpoaqs3jmrm5udejrg75dl2ny@x4jexlz64amd>
References: <20250430110734.392235199@infradead.org>
 <20250430112350.443414861@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250430112350.443414861@infradead.org>

On Wed, Apr 30, 2025 at 01:07:47PM +0200, Peter Zijlstra wrote:
> +	case ANNOTYPE_NOCFI:
> +		sym = insn->sym;
> +		if (!sym) {
> +			ERROR_INSN(insn, "dodgy NOCFI annotation");
> +			break;

return -1;

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
> +	 */
> +	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
> +		struct symbol *sym = insn->sym;
> +
> +		if (sym && sym->type == STT_FUNC && !sym->nocfi) {
> +			struct instruction *prev =
> +				prev_insn_same_sym(file, insn);
> +
> +			if (!prev || prev->type != INSN_BUG) {
> +				WARN_INSN(insn, "no-cfi indirect call!");
> +				warnings++;

Do we not care about indirect calls from !STT_FUNC?

-- 
Josh

