Return-Path: <linux-efi+bounces-4335-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEA1B03D40
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 13:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A9E18989D3
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166B624503E;
	Mon, 14 Jul 2025 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QfBzDSmt"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A3F17C77;
	Mon, 14 Jul 2025 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492093; cv=none; b=BZi8lfNrd8QaW6tQxOcjbZBslPp1OhVmRBIHhsX1yxtLyl0OBdhekucQ3WvoNgQiCkbc2ymq7oEGGYRtcESx0LWvuTkdrZlFfmNZ7nbBKiQetvxtRFXP3SwjifH+6kuL8Bbx+A69WhGjttJzeYsL4rIAmqhJwSli9cL59ZHS5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492093; c=relaxed/simple;
	bh=TOW+gFPlve+Nr1eDLYifYIvuCr4WJ+KivxoNQXF1ybY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nb6opkOi0pbRqU47WvYjZZRSIs42ELKfHEMTmXkLEy7n03NMgg9BPpjrlyp4ALTckplql1E4X2Z993cs9AcBo1NQmEWGQxoJZ8QLupVHKBup+BIqzysFPcqjHCxTkgtqxElFYKAowlFl74AW/0bRxVjNhKjjoDpfAbdqwVxHDPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QfBzDSmt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nAOSIUD6SRjN7WsA6hV7/sOUii32nWcRc+thJO3sYPU=; b=QfBzDSmtSSKgEDhJsRUiAc7HM6
	jTBPLeZmo7ov+rC8/ptBWMOTHvn5ktkGmNwW6iDXbqaSGCymcRByOOAlJxBOCcq9Y8tKehUCn5TFF
	MMnAufJdSgvhvp2apLi9XXeozlDK4m9obwLrlHuklH7j7BrvlDqEx8sUETJmfLnX9hN0lZw2OsklW
	JkvQYGQfDoaNux70S5G+iS+SCMe8+5UjA3Mp7yKYZydnqEGGlxI5sdmCtm7rBN5Lmmb6Fm6ryX+YO
	rr/Od4f3j42In1nXlTMEZ8jB6A2fBZ1VsCUBPH56yM59QCiKk524Wv47AW8N1vYbimsgBANhT32Ei
	mfSrIx9Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubHFL-00000009kzW-0g3P;
	Mon, 14 Jul 2025 11:21:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3D121300186; Mon, 14 Jul 2025 13:21:22 +0200 (CEST)
Date: Mon, 14 Jul 2025 13:21:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	seanjc@google.com, pbonzini@redhat.com, ardb@kernel.org,
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, jpoimboe@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org
Subject: Re: [PATCH v3 16/16] objtool: Validate kCFI calls
Message-ID: <20250714112122.GL1613633@noisy.programming.kicks-ass.net>
References: <20250714102011.758008629@infradead.org>
 <20250714103441.496787279@infradead.org>
 <20250714104919.GR905792@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714104919.GR905792@noisy.programming.kicks-ass.net>

On Mon, Jul 14, 2025 at 12:49:19PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 14, 2025 at 12:20:27PM +0200, Peter Zijlstra wrote:
> 
> > --- a/arch/x86/platform/efi/efi_stub_64.S
> > +++ b/arch/x86/platform/efi/efi_stub_64.S
> > @@ -11,6 +11,10 @@
> >  #include <asm/nospec-branch.h>
> >  
> >  SYM_FUNC_START(__efi_call)
> > +	/*
> > +	 * The EFI code doesn't have any CFI, annotate away the CFI violation.
> > +	 */
> > +	ANNOTATE_NOCFI_SYM
> >  	pushq %rbp
> >  	movq %rsp, %rbp
> >  	and $~0xf, %rsp
> 
> FWIW, we should probably do something like this as well.
> 
> ---
> 
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -562,6 +562,13 @@ __noendbr u64 ibt_save(bool disable)
>  {
>  	u64 msr = 0;
>  
> +	/*
> +	 * Firmware code will not provide the same level of
> +	 * control-flow-integriry. Taint the kernel to let the user know.
> +	 */
> +	if (disable || (IS_ENABLED(CONFIG_CFI_CLANG) && cfi_mode != CFI_OFF))
> +		add_taint(TAINT_CFI, LOCKDEP_STILL_OK);

Or perhaps:

	WARN_TAINT_ONCE(disable || IS_ENABLED(CONFIG_CFI_CLANG) && cfi_mode != CFI_OFF),
			TAINT_CFI, "Firmware has weaker CFI");

> +
>  	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
>  		rdmsrq(MSR_IA32_S_CET, msr);
>  		if (disable)
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -73,7 +73,8 @@ static inline void set_arch_panic_timeou
>  #define TAINT_RANDSTRUCT		17
>  #define TAINT_TEST			18
>  #define TAINT_FWCTL			19
> -#define TAINT_FLAGS_COUNT		20
> +#define TAINT_CFI			20
> +#define TAINT_FLAGS_COUNT		21
>  #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
>  
>  struct taint_flag {

