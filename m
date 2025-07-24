Return-Path: <linux-efi+bounces-4477-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF00B1126D
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 22:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632E33BD27D
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 20:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8462737EF;
	Thu, 24 Jul 2025 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEDgRHpi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01521771C
	for <linux-efi@vger.kernel.org>; Thu, 24 Jul 2025 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389472; cv=none; b=thy6CT9GViFLNz4sNSrnRF166Q3+eubzcEs8Rn2ghQks6ChTQ5N14cS75mVye389QpOSpfXvb4swAX03aLbU5u14bqsPKhFrPqwiByiTwDp2H+i7Hyv+ayguAtfz3SfulqS8y8lIeYNsXn6k42QvLS+37R5KK4tMCvz2lfkWoNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389472; c=relaxed/simple;
	bh=3iJhYIBCliLx6cvM/xxvbhRa/DzQUN/C5dE3qUgVnlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WCIhEqCDuxJgtfosQxLDoqdihFdJ9/2xFJOjc0AgxoA28GI5sp84XWflAcm/pWepg2tIPu+hMUHIpMaZkgo3C7H7TuJT+gdg0J6zjk6yj9A+nmKwf5Mkcb2dRIRlwOpETJZgBcGLZPxWbW1nfy8LX/3CclFWtqBn3RW+wilql0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEDgRHpi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31e3d563a53so1972752a91.3
        for <linux-efi@vger.kernel.org>; Thu, 24 Jul 2025 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753389471; x=1753994271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5BadAfBHN4AUhi6edketoROygiJlH6yDIJ6nBg0r11k=;
        b=AEDgRHpiZSiaa2R157mKgOMG31T0HVziN7qk7TufZp1bkvwwAIZbCP0d0D5jsLvp9R
         1Rp8+5y6zqe9Ojrkf5YbiN/D+oaD22iI2y0yeyHGCNOH1k5FL13YyKGiimEoPvlL+eIP
         MZ8cMaoWTsFKiKZfnWUO0nj1RdUVDhkaH5YNP5KhIkBKsPuUAZo1JWJfkNS7jU5UUZYL
         rQp3gYS81Q+guaCJUjVx95rwWqfl7j8VaAvQcQV6f/jazpC8e7bf3xFsY7z2bTvHUxZj
         o2RO/hczvkRGw8PqRTX/ejvruh6KlB4jAgM/qMEexe2TZN6AUU2aXlM5ozKI2hoTtbob
         l9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753389471; x=1753994271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BadAfBHN4AUhi6edketoROygiJlH6yDIJ6nBg0r11k=;
        b=Pq5uwZGJi8nNfrKCsGpZ/ELhm0m+yCEZwkUpeM/sTOeVeYLgHDCKjdF5+oI2BKMimo
         Lo/wceb8AqfJxjbLV7js5aBxtx40EE4d+KEKV6mWwHcsFFmY9gSB/8N1OX+K7kpc5cCH
         V5u71MzBQjz4hzzVMQUTLJ5gUqozrBsGZixKS5ynszeb44N5SGOxKxoECZWlVBbIN3Xu
         B9TnLBJFI1Xi4P6J9XlwHuOiB0A2+xyUagU1aE45HmoH7hpl9mTlvKphinDcZmOuRaDQ
         3SbWBIp7cK1oAyNOJ0MmjaPVtozKwbe67zou0Xn5baAAZ0d5ewluwAWDovw9JyrWDbvo
         Mfkg==
X-Forwarded-Encrypted: i=1; AJvYcCUULqC66wBWP5Ma9tZjjoGGUJ8norPHPWvDtSHWJ6tT6/ZG3lU+M2V2YbygCtPS62kqvrmZ67835dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaiuNDjwW7FXx2/cHsHGU/b7tBVq2yEmOz2ibdDV9bPP7CUThM
	81SWQ9rKnCW1CW9Ha9LMl2rz2JdaLzM1qT5zW+/QJPQChhb8+zzFc5QU6kUQQiqLc5VH4F7tf+0
	3N9Rj4g==
X-Google-Smtp-Source: AGHT+IHE6eAlwl7jscbkUzp5U5t1vNbnbqNXqGFHZeQed0+nu225pCuYGNqmuyqiKrC1WFWx4eys1B4+PuU=
X-Received: from pjyr5.prod.google.com ([2002:a17:90a:e185:b0:31c:2fe4:33be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5487:b0:311:f99e:7f4a
 with SMTP id 98e67ed59e1d1-31e507cddb3mr11188514a91.26.1753389470881; Thu, 24
 Jul 2025 13:37:50 -0700 (PDT)
Date: Thu, 24 Jul 2025 13:37:49 -0700
In-Reply-To: <20250714103441.496787279@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714102011.758008629@infradead.org> <20250714103441.496787279@infradead.org>
Message-ID: <aIKZnSuTXn9thrf7@google.com>
Subject: Re: [PATCH v3 16/16] objtool: Validate kCFI calls
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, pbonzini@redhat.com, 
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	gregkh@linuxfoundation.org, jpoimboe@kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	samitolvanen@google.com, ojeda@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 14, 2025, Peter Zijlstra wrote:
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -361,6 +361,10 @@ SYM_FUNC_END(vmread_error_trampoline)
>  
>  .section .text, "ax"
>  
> +#ifndef CONFIG_X86_FRED
> +
>  SYM_FUNC_START(vmx_do_interrupt_irqoff)
>  	VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
>  SYM_FUNC_END(vmx_do_interrupt_irqoff)
> +
> +#endif

This can go in the previous patch, "x86/fred: KVM: VMX: Always use FRED for IRQs
when CONFIG_X86_FRED=y".

