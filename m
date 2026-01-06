Return-Path: <linux-efi+bounces-5940-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AC7CF72F6
	for <lists+linux-efi@lfdr.de>; Tue, 06 Jan 2026 09:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1DCD309EE23
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jan 2026 07:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361AB26C3BE;
	Tue,  6 Jan 2026 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R4Aibqp2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D641C63
	for <linux-efi@vger.kernel.org>; Tue,  6 Jan 2026 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686345; cv=none; b=mBhXeIUJCm5L3FHAyS+e8WB7HJjghrc3gv8UjDKofUjIhcwMjVkYKdokeUPylETbxf5RuiEfAzU9auVryosamheZZr4EF6skVutFzUkKT232vjdwdKQw8vRaQLJeP/hhyXuoRvAf5ayCt0/FdD4VEkBoGmZyLcktDJtfO4hygkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686345; c=relaxed/simple;
	bh=ylfTs8jcJ0B2D8LXLN04UjXPRiuTx9B78MmGylk3r9c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snnvEzIKjBeWxIbbHKiaP1yWxSk7IbJMjvyCpn6zfWHhSnvoDuhqAjVKvKYVvD4UBbim76KkuyQxRs6s4+cLR2Drmi6xUXxRHVHZ7ZYI32GUJZgCxN32VttYb7gd5LusTIfpRcgzR/8PjJk0RStEOXwATN63UbuZFpTQaEFOpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R4Aibqp2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso4096155e9.2
        for <linux-efi@vger.kernel.org>; Mon, 05 Jan 2026 23:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767686339; x=1768291139; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xT86fGyU8vR02LLDSOIv3YTUgVfPlh7wnV/Q4AOSXA=;
        b=R4Aibqp252PL9AydJL/We2cX8l1Awjrh3yVr7bTQvDUaivA01OYebHhqZ/k504YBGM
         HzLMOzLcC1EjCvy7iEHXSKCNNjl6X/qaWmmEIflYOLZQpPkhC/hNtvSjdxxN9rNi2YCN
         lAHySpPtwuTxGXUEZHmGBDWM6T2wax5y24pK/IGzj78uZ9/L8reM1jZepsKEj+lK/5X2
         jX0Kis5xyBA75892mmiZ3gp6R12kV/beB2Tn50Ilyf5t6CYl+/tR20IC+aZ9GPfJXZbd
         Og+Sq3nufyw+8E6Uj67KewNcewY3jc6niPAFqCuPszWJw6A42JXQI7SU/S6PEFwxyzJS
         S/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767686339; x=1768291139;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/xT86fGyU8vR02LLDSOIv3YTUgVfPlh7wnV/Q4AOSXA=;
        b=tAxkRzHBzNjOlq6xmX24WXTCEFcHF0M8gV4JZv/9off6iAI0gTQmBjd5wMSF+ZumTa
         n2AVZy/JRjHzApTbakbaxLoXemlTuhr0pB2f0K1gCZ3829e38JAtkQR4wyjetZ0CCmme
         +PdUBg5kIjwbkRN8a7eXXlynwUi9zcJOhyFH7yJpx2d7VPT1b+TL8l7Vvf5M0jdE/Gwr
         8Xs3m63X3NeySFlI+YTxzrF4OzsA0zOr8zU11md1HwBuhgvQN779hZKJf27CH14M5ibl
         r9dfp3e01XnyLu4VpHbtAgYwbKRSmqVdnTEAMlrsUDLMmhD6RH0KhJ0tFO33CR+f7+fs
         f9Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXlCFjfawAgmHjTxYYt4YpUhkfkiFxlU9HKAv1hSWYsHHFUfdFafWh0J+9JyPKNNqbri51vKyAgJV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZV9seiFZaZfI7dIKLsju9Abe4e4l/SV9k1QnkAA7BxFiIWlln
	gz18TGd4H/mU/pnYwUYDom08G6wjyVnDgsKXg5XZTqv8liredmxWLlKjMruY8dOTMuTe5LWQevs
	66UkV
X-Gm-Gg: AY/fxX62kLsDqggQa8SyFxFewo4FFCCQC7g4Cuog0KQ1+lM0wJ8cwlQc11CE32HUo2z
	l/B3ya9GbwySPq9dyhNPgeIPDpmj7JnBoofYzWYqLTrFXQtCEd5KNPKxAvayyGBTItxQFSl+nGe
	HrshWJ1vuUZfLQP6OpMjMf2+HXLh+212T6GM+7cnzy2gdkcb2u83GlrELrHnRLabJeCjwSADQTw
	0ZHo3c5kZJxzEY0Ktm7udrr4HtyjEinProO0a2B0iwK6BFwsnNibJXS2lD00Zr/fSzNV52JuQlT
	V00C6+4GLDyx5pWzrozHnSs//lgyB95rLlIeFbOnnzBOAKe62UsP74SUO2KyREmMC5yeypknL/4
	IKre/S2fJAXLKgjMB4QAvm7k4KIQJl/eKrVYpfATWq7Bjg/FsijjuqeGoD/7t5LBldYbrhGeQ0c
	kXgBVlp8UPKIHVWp8lnCKHRUgl4RKjdFSXCoxzKpEASA==
X-Google-Smtp-Source: AGHT+IHBJ6fsCXy9NO/d28W93MTm63DgHduveSL/TEkdamQz+BL02b7OzR0NOgGoMHSHrSsYeON5Iw==
X-Received: by 2002:a05:600c:444d:b0:477:97c7:9be7 with SMTP id 5b1f17b1804b1-47d7f0671fdmr23249935e9.1.1767686339113;
        Mon, 05 Jan 2026 23:58:59 -0800 (PST)
Received: from r1chard (1-164-79-94.dynamic-ip.hinet.net. [1.164.79.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59da826sm1286179b3a.46.2026.01.05.23.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 23:58:58 -0800 (PST)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Tue, 6 Jan 2026 15:58:54 +0800
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Ben Horgan <ben.horgan@arm.com>, linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
	catalin.marinas@arm.com, will@kernel.org, Mark.Rutland@arm.com
Subject: Re: [PATCH v1] arm64/efi: Don't fail check current_in_efi() if
 preemptible
Message-ID: <aVzAvqv8JnjrjJbF@r1chard>
References: <20260105135847.1585034-1-ben.horgan@arm.com>
 <aVvPIdREAdweYqZf@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVvPIdREAdweYqZf@e129823.arm.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

This change is good to me.
Reviewed-by: Richard Lyu <richard.lyu@suse.com>

On 2026/01/05 14:48, Yeoreum Yun wrote:
> LGTM. feel free to add:
> Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> > As EFI runtime services can now be run without disabling preemption remove
> > the check for non preemptible in current_in_efi(). Without this change,
> > firmware errors that were previously recovered from by
> > __efi_runtime_kernel_fixup_exception() will lead to a kernel oops.
> >
> > Fixes: a5baf582f4c0 ("arm64/efi: Call EFI runtime services without disabling preemption")
> > Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> > ---
> > On the partner platform I was testing on this issue caused the boot to fail.
> > ---
> >  arch/arm64/include/asm/efi.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> > index aa91165ca140..e8a9783235cb 100644
> > --- a/arch/arm64/include/asm/efi.h
> > +++ b/arch/arm64/include/asm/efi.h
> > @@ -45,7 +45,7 @@ void arch_efi_call_virt_teardown(void);
> >   * switching to the EFI runtime stack.
> >   */
> >  #define current_in_efi()						\
> > -	(!preemptible() && efi_rt_stack_top != NULL &&			\
> > +	(efi_rt_stack_top != NULL &&					\
> >  	 on_task_stack(current, READ_ONCE(efi_rt_stack_top[-1]), 1))
> >
> >  #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
> > --
> > 2.43.0
> >
> 
> --
> Sincerely,
> Yeoreum Yun
> 

