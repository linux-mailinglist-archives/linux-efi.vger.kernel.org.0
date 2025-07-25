Return-Path: <linux-efi+bounces-4482-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8370EB124F7
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jul 2025 21:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A151CE1E78
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jul 2025 19:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF44D24EABC;
	Fri, 25 Jul 2025 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5mjOzRz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610A024EA81
	for <linux-efi@vger.kernel.org>; Fri, 25 Jul 2025 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473407; cv=none; b=uk6B4Q/eRH5KsS4lIYoWzQyIM6o6UyXi+nvaklPcjqpTYG3WiP053PB/9YBRQWp9QQkbDaPSDLSag5g1d3umCJk8XJ2th/lzDeA9SFPlGcSYLPdarS3tkT5xKjCz8hAl0wEM2gYtK8N3O4Jh7Dxe7SVS9/Ka+H1lKc/qvTuG6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473407; c=relaxed/simple;
	bh=kMe0ue3soy3FIW1/fW7FKunjVHoomXH+3YQEEOAZOJI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h/of/BHiB42oCCM46FAn1Yx5f/Kjvn8Nj4dgVv6mFzQ9WBBPlaA2NX72PweE9mPYUjFQNLjkoVSYs+k1wGwlPLO5cdbjEdJXPQnppIGiYEXYYN7Fp7qu7mTIhBH02St6qpvB+kzfs26GchxULKvXVbpyESDr1YO9xquEZXi++Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o5mjOzRz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3132e7266d3so2553944a91.2
        for <linux-efi@vger.kernel.org>; Fri, 25 Jul 2025 12:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753473406; x=1754078206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ii/J/YHUTK4YRW5OzHg9e1xV7PaXyv7CpmlDeDzp5rg=;
        b=o5mjOzRzO+NlnC6K8tmSMSeTqTEgdFNxwfLjXhv18RBMmOYhM49lZ6gHA8+bXNjNJA
         5GgwTsNjBwspc9PsAI0myITXoqzBzDiShgi3Eio4l8jKX47ZzyY9CWzpguFVotRwY6Rw
         XT/Von50p0Zh4Vh7ZQtX8V4xjLDn3l1/6YVK1CDKrjxVqsQ2GCeY/O8y97xot9wzuoz3
         C7bntlMaTR94Fc7CodE8tW63Fli0efQTjop2rQuZchvHD8foVTBQ3erXnx/qoGgLiuWh
         uZXB5xn8MaJRL7Vu4HVoAYsazwnz6LLIbUsPcY5ZIOaI3i1MmeDjITI2zMChgZrmY+U/
         gLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753473406; x=1754078206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ii/J/YHUTK4YRW5OzHg9e1xV7PaXyv7CpmlDeDzp5rg=;
        b=D4YhhY+8qSwkZ7hFnYE7mj7V3ZvAKQny1NP1ekJWISEdVRaM08votHZJXVQTDruG7+
         VMQkzyESED3uv1x7nM+LIZvt65eRUuaX7TR2zIJ89TYfkZMoYllbYXMnnC4XAVisfcFS
         syrlOy8DHlyBlDN/r0B0qq6l0u6Gv/BteTm9nldAwq9TIQpcvHCHvZ7079+7H67hxlUV
         un69wKpdR5MwoFv3WJmzm90HmdalHFY/bU9N65myXUU6usPYzIvjXqTeTD9m/6lxqgGB
         Xaznk1N6ljc+JIsOMD7JfArBpne+ZccwXeryTmDbxN8E355UbR2Rp4YyIZjpxgETyuPv
         HzSw==
X-Forwarded-Encrypted: i=1; AJvYcCVOa4p4BGrm8jh6E1/0+Pb01l1T6WMFAARht5uZnMIlakx3LkHyduDtTkg20FJmfBmyQYb/1jCQvzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7t38Ux8uBFW958/Napz3EkMbvmwSlI09jJSMnXidzbVuVGxOI
	yrtxCuft7EpuEdUZkOxFZR1yUJ8wZxfn/gCX6CpNe/ZMTolSJviwavtt1v+NVPJFbSwrKQWQ6r9
	W2e+FgA==
X-Google-Smtp-Source: AGHT+IHu7FDFnNcTabtdewi4bY3hb/3jyWNKkxkjd+oq4fY81m/OoMs8YEN7TZ8oihNIY3LRn/TzU34UmaY=
X-Received: from pjuu7.prod.google.com ([2002:a17:90b:5867:b0:31c:160d:e3be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d446:b0:311:ba32:164f
 with SMTP id 98e67ed59e1d1-31e77863e01mr4894272a91.8.1753473405737; Fri, 25
 Jul 2025 12:56:45 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:56:44 -0700
In-Reply-To: <1584052d-4d8c-4b4e-b65b-318296d47636@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714102011.758008629@infradead.org> <20250714103441.496787279@infradead.org>
 <aIKZnSuTXn9thrf7@google.com> <1584052d-4d8c-4b4e-b65b-318296d47636@zytor.com>
Message-ID: <aIPhfNxjTL4LiG6Z@google.com>
Subject: Re: [PATCH v3 16/16] objtool: Validate kCFI calls
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, pbonzini@redhat.com, 
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	gregkh@linuxfoundation.org, jpoimboe@kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	samitolvanen@google.com, ojeda@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 25, 2025, Xin Li wrote:
> On 7/24/2025 1:37 PM, Sean Christopherson wrote:
> > On Mon, Jul 14, 2025, Peter Zijlstra wrote:
> > > --- a/arch/x86/kvm/vmx/vmenter.S
> > > +++ b/arch/x86/kvm/vmx/vmenter.S
> > > @@ -361,6 +361,10 @@ SYM_FUNC_END(vmread_error_trampoline)
> > >   .section .text, "ax"
> > > +#ifndef CONFIG_X86_FRED
> > > +
> > >   SYM_FUNC_START(vmx_do_interrupt_irqoff)
> > >   	VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
> > >   SYM_FUNC_END(vmx_do_interrupt_irqoff)
> > > +
> > > +#endif
> > 
> > This can go in the previous patch, "x86/fred: KVM: VMX: Always use FRED for IRQs
> > when CONFIG_X86_FRED=y".
> > 
> 
> I'm going to test patch 13~15, plus this change in patch 16.
> 
> BTW, there is a declaration for vmx_do_interrupt_irqoff() in
> arch/x86/kvm/vmx/vmx.c, so we'd better also do:
> 
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6945,7 +6945,9 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64
> *eoi_exit_bitmap)
>         vmcs_write64(EOI_EXIT_BITMAP3, eoi_exit_bitmap[3]);
>  }
> 
> +#ifndef CONFIG_X86_FRED
>  void vmx_do_interrupt_irqoff(unsigned long entry);
> +#endif

No, we want to keep the declaration.  Unconditionally decaring the symbol allows
KVM to use IS_ENABLED():

	if (IS_ENABLED(CONFIG_X86_FRED))
 		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);

Hiding the declaration would require that to be a "proper" #ifdef, which would
be a net negative for readability.  The extra declaration won't hurt anything for
CONFIG_X86_FRED=n, as "bad" usage will still fail at link time.

>  void vmx_do_nmi_irqoff(void);
> 
>  static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)

