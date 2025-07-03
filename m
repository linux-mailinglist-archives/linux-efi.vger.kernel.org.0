Return-Path: <linux-efi+bounces-4106-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF72AF7E32
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 18:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3661F1BC58A8
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 16:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0C720102C;
	Thu,  3 Jul 2025 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjUAe6RA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFCC33DF;
	Thu,  3 Jul 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561547; cv=none; b=f2GQ0jt2qqcTgGIxGXrt0geriXn897yH4knn3jDBIIspW21eUij07dASjXYRz4L3y67JoWZdN66d8KOpprre4sOu24z3fFECks+dm9nY1JtsTPkGOXLF1n1FfALy0CbshzmGUWOrSA+laBIu3G1WuPyZme/HbRBlvfrTncmkBZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561547; c=relaxed/simple;
	bh=xwBMBkFLX4i0vBFJ5CXmoivb9NgZ0GfHuzL8WvJiKvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyIDtnO2sbRKTqpxylkq5XISGkyOb75ZtUKimlMmbBt4jiDf6iRglLlp4+h94AHs478E7RjVv/EGUgNBDbmwWiE5Wbhugd0AB4sUxhEs5dZ+deTOtm5HfBUR2PQvAhL4tqa+fIlH+WkegyUlYeABWWIRYUkhoLAENfvBMybC3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjUAe6RA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso16250f8f.1;
        Thu, 03 Jul 2025 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751561544; x=1752166344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dw94v4+dm+2EAGEsktndj6wIkAF7S3MInrEzqbxbZ14=;
        b=RjUAe6RAsRYe8aqOxlvkL1kRrHpYAUjXL0jEn9UxblCrCuyXAfMf/YDtx+NPfwzINV
         4B6X2Y31MjzH0WJlfrbEGTb4LL0uJl6ylwzh9wMnaWZ7flfdr1FTj/MBlu4EmRKsotkU
         oIajDo9Vt4tUK4H5nelXoxXjQ+LqO7GmidGM1IeUiMwuPkycl9bYW3mxAcaiuYOusNyR
         JdGzmbAYOqpmoMyqlsA5oxxWQWwDWCNBC1Rv9Ibe51BSiEe/vWPTxBVI9L7BmoiKrJon
         Kce2nyymf4WvuYn7kHtIfPng1vh1DVCpSW0joJcFgmKRr3sN/Adm25YKU321BcdQZ+j1
         8afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751561544; x=1752166344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dw94v4+dm+2EAGEsktndj6wIkAF7S3MInrEzqbxbZ14=;
        b=IC8JdxqJLdNBY2jOfXtU88mLHRyrkkyX934M80W9TDIItkRAVLZ2pAAwLgMZCyop0N
         s13rqH+Kycz6z7NKxOaoCK3OJInxRGXNe/DR3nZ4B5gpZzg6rxup47UrFPS6Nnm0DuMH
         ytngwbVu6XwjAE7w7/mLmBfWR4crwkJrFM27JAPB9lD27Hk/Dthh6gXRRDqIjlSBspd9
         l8OGznhXmEd5eovJZ4PdYt0FbeOKnFk3xVUDbjceRDiot7DrbLHf4af7mwBlP2A0UvPq
         Ri/tFOTWg0028R2C6rRf4/KA6J0cNULNqWbHjE5tOclD6FQ/Ez/EtFEfbHsV1QaXwd/f
         iK4A==
X-Forwarded-Encrypted: i=1; AJvYcCUwbCCFb0VhzOoCw77aBBp6kkGT240H2KTUxV7kc/EfnJwFGeQJDgzM7AiT8k5Viq1Zyro+al8EVOBBvCiW@vger.kernel.org, AJvYcCVDfshpi2FQ4Fc+dw/Fb1JMrho6dilCNwDNIKjTvbzfaF/fXilw9UwP/QKDAW1nOG6gzil9frzWgzxB@vger.kernel.org, AJvYcCWaQHOTRvXtXmH2kmHbkPQvU8G+3bXEOPb5iHC5qn1FeJkXJo+PKO2ViLQGB/AJtBxpUXVjF5gXarM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvNvXroi6Toaog9osvKjGkpuRUMR10jhGTXoBQ6tujAb0IK81J
	8f8V+1UuE8jXMAdOs0YuwMJwWhmR+3ATo4EXiVJoiTrmNIQ5gzOMMgBh
X-Gm-Gg: ASbGnctFXKq53nRrpYm8LJr23sX8e0LzpRt6jDEbcyJ7MVhDPTj6I4fZPHMMbPpw+Fw
	Wa7BbTQ4sXO7xvMuREJBEnEXqGB4d2+v5OIPUsGzKypia7PCnjOsmUUYeeLrCmrsNCSa8+3u0lD
	EfIjhgn24uLJUhHCz1wX9AZHw4Yz8YCeW2ckz+dZy24mBkfzB5Rt8HzdFWpHVhDNeiPuF7mhCx+
	DqzT3BvonBX3w+Skf7Ps06ZBvdtkPTBfn8aQ7Y1+R2QtHGFnkYETrBVkLdlN2ig5OIiWJ6RIHMb
	e4U7NbHUcUcZSjPzHF85PA+lqXbTUP1HdiVa77W/dYMRAaDOhXEpplNrdQrnxQuCrffFeI54BRS
	Mu262VhLV1i4WZfe2Bg==
X-Google-Smtp-Source: AGHT+IEwxwpPMNgiW5OZzNxrC0UFXM2KJ10ptvxCCiTuN7vhdgd4/rcD6AlW0fW1gF7+O5XydxM1/A==
X-Received: by 2002:a05:6000:2f85:b0:3a6:d5fd:4687 with SMTP id ffacd0b85a97d-3b1fe6b72c6mr7061097f8f.18.1751561543434;
        Thu, 03 Jul 2025 09:52:23 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030cdf5sm254497f8f.1.2025.07.03.09.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 09:52:23 -0700 (PDT)
Date: Thu, 3 Jul 2025 17:52:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
 <ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
 <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
 <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
 <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar
 <mingo@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Daniel
 Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross
 <jgross@suse.com>, Kees Cook <kees@kernel.org>, Eric Biggers
 <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu
 (Google)" <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du
 <changbin.du@huawei.com>, Huang Shijie <shijie@os.amperecomputing.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Namhyung Kim
 <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv8 02/17] x86/asm: Introduce inline memcpy and memset
Message-ID: <20250703175220.1cb05c1b@pumpkin>
In-Reply-To: <78aab15e-5bc2-47cc-ac1c-5a348bff0e17@oracle.com>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
	<20250701095849.2360685-3-kirill.shutemov@linux.intel.com>
	<20250703094417.165e5893@pumpkin>
	<uvvh6qfpan6f56fdvuch67nss2h5nqxbmocztf6v2lfbvnihbg@vtzbr6anzqnl>
	<20250703131552.32adf6b8@pumpkin>
	<78aab15e-5bc2-47cc-ac1c-5a348bff0e17@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 15:33:16 +0200
Vegard Nossum <vegard.nossum@oracle.com> wrote:

> On 03/07/2025 14:15, David Laight wrote:
> > On Thu, 3 Jul 2025 13:39:57 +0300
> > "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:  
> >> On Thu, Jul 03, 2025 at 09:44:17AM +0100, David Laight wrote:  
> >>> On Tue,  1 Jul 2025 12:58:31 +0300
> >>> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:  
> >>>> diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
> >>>> index a508e4a8c66a..47b613690f84 100644
> >>>> --- a/arch/x86/lib/clear_page_64.S
> >>>> +++ b/arch/x86/lib/clear_page_64.S
> >>>> @@ -55,17 +55,26 @@ SYM_FUNC_END(clear_page_erms)
> >>>>   EXPORT_SYMBOL_GPL(clear_page_erms)
> >>>>   
> >>>>   /*
> >>>> - * Default clear user-space.
> >>>> + * Default memset.
> >>>>    * Input:
> >>>>    * rdi destination
> >>>> + * rsi scratch
> >>>>    * rcx count
> >>>> - * rax is zero
> >>>> + * al is value
> >>>>    *
> >>>>    * Output:
> >>>>    * rcx: uncleared bytes or 0 if successful.
> >>>> + * rdx: clobbered
> >>>>    */
> >>>>   SYM_FUNC_START(rep_stos_alternative)
> >>>>   	ANNOTATE_NOENDBR
> >>>> +
> >>>> +	movzbq %al, %rsi
> >>>> +	movabs $0x0101010101010101, %rax
> >>>> +
> >>>> +	/* RDX:RAX = RAX * RSI */
> >>>> +	mulq %rsi  
> >>>
> >>> NAK - you can't do that here.
> >>> Neither %rsi nor %rdx can be trashed.
> >>> The function has a very explicit calling convention.  
> 
> That's why we have the clobbers... see below
> 
> >> What calling convention? We change the only caller to confirm to this.  
> > 
> > The one that is implicit in:
> >   
> >>>> +	asm volatile("1:\n\t"
> >>>> +		     ALT_64("rep stosb",
> >>>> +			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRM))
> >>>> +		     "2:\n\t"
> >>>> +		     _ASM_EXTABLE_UA(1b, 2b)
> >>>> +		     : "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
> >>>> +		     : "a" ((uint8_t)v)  
> > 
> > The called function is only allowed to change the registers that
> > 'rep stosb' uses - except it can access (but not change)
> > all of %rax - not just %al.
> > 
> > See: https://godbolt.org/z/3fnrT3x9r
> > In particular note that 'do_mset' must not change %rax.
> > 
> > This is very specific and is done so that the compiler can use
> > all the registers.  
> 
> I feel like you trimmed off the clobbers from the asm() in the context
> above. For reference, it is:
> 
> +		     : "memory", _ASM_SI, _ASM_DX);

I'm sure they weren't there...

Enough clobbers will 'un-break' it - but that isn't the point.
Linux will reject the patch if he reads it.
The whole point about the function is that it is as direct a replacement
for 'rep stos/movsb' as possible.  

> 
> I'm not saying this can't be optimized, but that doesn't seem to be your
> complaint -- you say "the called function is only allowed to change
> ...", but this is not true when we have the clobbers, right?

You can't change %rax either - not without a clobber.

Oh, and even with your version you only clobbers for %rax and %rdx.
There is no need to use both %rsi and %rdx.

The performance is a different problem.
And the extra clobbers are likely to matter.
x86 really doesn't have many registers.

	David

> 
> This is exactly what I fixed with my v7 fixlet to this patch:
> 
> https://lore.kernel.org/all/1b96b0ca-5c14-4271-86c1-c305bf052b16@oracle.com/
> 
> 
> Vegard


