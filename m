Return-Path: <linux-efi+bounces-3511-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC8FAA5175
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 18:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E541C07084
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED17C1ADC93;
	Wed, 30 Apr 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSYkk2/M"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F982110;
	Wed, 30 Apr 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029981; cv=none; b=Q0KHjamYQnwEQJp0L4jrDYrXxRhPVm+rDuDTe9ur/yiwHnUi5u7OkHgDhK1A8V5L6jyMUWc1pH90z2Gvk55Qec7gfrLSe0aZgRo4WopNutOfy1LZWmXFhPVhuvrRN/MX5Xg9O4djIFmeBJTL4pJP3G7vdnrwtA3v9cAGLinH3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029981; c=relaxed/simple;
	bh=QhII5KSPufcDgWHLILC2FKo35UHyrK7O8BRAWpF54ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBxt0dq8t4iGMQBaln5Aj+lHR7lIoSjcAoisxu9rLJl9+6SVIp4CYy7ZMEY12CfE4AQKBSzBKUvKMKv66DsuPN5AU3ia7fpu8iVkwZMcAgJP/NWDthAJgJbjVCOxXbgo9LL+uzrUHU5/qY3RVQp6KDGV20hi2j5VMmNHU5GKs04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSYkk2/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BB7C4CEE7;
	Wed, 30 Apr 2025 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746029981;
	bh=QhII5KSPufcDgWHLILC2FKo35UHyrK7O8BRAWpF54ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KSYkk2/M5lKWKPjdV7+2+qFKRY7b1bJ28dhLebdYiURxcrLVygGbcouq+8SZGSgwd
	 4VkBh5rL06cel4XguxYt6/Yko3Tg1Bv6REWp7imb9aJ9m/i00lvkOGQIhJOh82aSto
	 1iY6zoQZ4ZJC1vfcgxiNXp+DIfjaA1s+RUuFQgK2tw71+u0cyrdL+5G6GPKHi1u/SG
	 5zuMXlZG2C8DvC0+MymFsS4PstE6kk3HmdHt75ZY75KTLkj/SLzRKkLQ4p+0Ga/crS
	 G+80o6u2KbikZRgNc6JBgIdbBsppRX/azjM+sBSVmEPuqSZU9VZjAMMxG0A5E5z4IO
	 OwyeTBTEI1Rqw==
Date: Wed, 30 Apr 2025 09:19:38 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, seanjc@google.com, 
	pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, samitolvanen@google.com, 
	ojeda@kernel.org
Subject: Re: [PATCH v2 02/13] x86/kvm/emulate: Introduce COP1
Message-ID: <mw73dy5rhbbdcknxjhupsgmp3wdkedtlstwaqxonjzl6z627f7@bxxop3txiom5>
References: <20250430110734.392235199@infradead.org>
 <20250430112349.208590367@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250430112349.208590367@infradead.org>

On Wed, Apr 30, 2025 at 01:07:36PM +0200, Peter Zijlstra wrote:
> +++ b/arch/x86/kvm/emulate.c
> @@ -267,11 +267,56 @@ static void invalidate_registers(struct
>  		     X86_EFLAGS_PF|X86_EFLAGS_CF)
>  
>  #ifdef CONFIG_X86_64
> -#define ON64(x) x
> +#define ON64(x...) x
>  #else
>  #define ON64(x)

Doesn't the 32-bit version need to be 

  #define ON64(x...)

since it now accepts multiple "args"?

> -FASTOP1(not);
> -FASTOP1(neg);
> -FASTOP1(inc);
> -FASTOP1(dec);
> +COP1(not);
> +COP1(neg);
> +COP1(inc);
> +COP1(dec);

I assume COP stands for "C op", but that will never be obvious.

s/COP/EMULATE/?

-- 
Josh

