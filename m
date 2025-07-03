Return-Path: <linux-efi+bounces-4102-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D807DAF738A
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 14:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1951E3BC2DE
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 12:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357AD2E62B7;
	Thu,  3 Jul 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NapTiG/1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F75E2E62C3;
	Thu,  3 Jul 2025 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751544960; cv=none; b=YzjcPJ2CYcmdfcGHtbg6tPwlxLHh+gk/hzDJXs8tqcA0E1DRlsnblV+Gnl/fB/ZBfvI3BjWvRJt1rLBVJkppxCFUR8fKoD91XyuQFQ3jzkMDqNa4vqdG7gldyIiYErt8s1TvN+tFbungO2olEkgfOV2z+CM82Ufdj4Yb/mLKHhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751544960; c=relaxed/simple;
	bh=09+UXph/NuGkf0W53C1cHGAktW5uVCg2vwGW7KeXmF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlSZo3DN5bPvdO0i7cAm6Uvb61j4deLtshe2NDOXpurKkEYKzvt6XUSJOw5nv75cAqMlS3vb2huxuQ4hcv/KLUjXT+yDf7Kl+TYl4fN9ia4YTmgTfipzq9GZ3RzhTO9HRCrx8lmoxEzrcP0iL2vnEFHIelv2TLdEnVbjGlxe9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NapTiG/1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4537fdec33bso36595205e9.1;
        Thu, 03 Jul 2025 05:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751544956; x=1752149756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjMvLVJkG3DLR0pJeJMNsk2FIgKYYztGrqqpbhLJ8Vg=;
        b=NapTiG/1ruKxN+Pvh1PNtOCIWoQKo3nJAkxlt9LApDssI3roY0YEqFqML9HSsGD9YO
         iWqLxaW8TV72PFzx5xKDMMcvgE3/HCT0OpdAqpFvAN1mfwBzCmirbm3EKQvCRWsLdTKz
         PW4kRZ5dkLPl+QFlwcct2Y6CbXNrqPkzd+lGZ0CRv7uIgxswifHSCt8R0PcuBvCmcSlu
         Nvau0MtR2wBXx+v1kpVA3s0NUVWzup8KUUcEetuHeFrC7F5y9JLsz493gxaZ7Su69S+v
         HlGJrTfWjI48O2Wa00Qxu1zeS5TU9EY5ycGht6xZe9bzx+K7LBM2u4c1YgXHu1MvL1oi
         XvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751544956; x=1752149756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjMvLVJkG3DLR0pJeJMNsk2FIgKYYztGrqqpbhLJ8Vg=;
        b=WLxblanzrogltA3RlNlcIQXfswSCkbzP6kNXrctSyGF7AfUIpU3YoJHs3Xqx97bpfE
         egjdRfO1jZC+dyxpwzcZcNJVSPJjCTqb9cGoh7HkuIsly7Ik6qy8Kvk1kl9mtfIqqOM7
         ZCDXhdkR//XHSv9nEBjDQsaPyt+2K7xM4Aj7GukuhHpo3g7EI2tU01G24RHqX+c7a4hJ
         Co5oEopLNYC0A5tG7OFpheCkLGlnJdtRhWZME9OUnD7/WkMcNxo0Qd255KoopNoN/1SF
         PKkzUOUaFbs2Z4m/3ETRne3N/nBkkHWE0JVkZydDgcQWqHleO7NK2H4+QWbPDZMEgBNR
         YF2A==
X-Forwarded-Encrypted: i=1; AJvYcCUJV5icpG9t3CP2JyhfNRkLeStS8HcB07M4Tq7D8vxWZ2Wq7Mcpe0z0iwwZl+2iE8PZU51VpZ7Uw+c=@vger.kernel.org, AJvYcCUX7uqXa6BgVDM/b/f31hV/nvqxU7ZaZ5ReOUVWQK8Ht+4iWMY8uzUjm/8N+RdY4pCHE761WX0eWT1O@vger.kernel.org, AJvYcCWhoWn9lm033wqyU9/wZX9ooprWCYguF2tDPGj8uTvY73evLy7muztFdHs5T+sD4k7HK0qSqBL1tmKnxWFm@vger.kernel.org
X-Gm-Message-State: AOJu0YxzK24Oigz+AsUlWUARfRG1IU1remDuwbMkfzgcnvwz28h1o2DI
	/R2zUPbUasDtft2wh8F205o/h4JUf6XqcunnR85UvUARYpplUsmotZjl
X-Gm-Gg: ASbGncv+qqgI0wl3RbdKHfITg9UDr5ASdLQULNEhH91VVGhzJrBGtJyyh5LR05uQZph
	s1E3rhILpPCThaPYQDhsPyx3UyaH9rtfzgjnkTC/rgCF0W6uizUru5H0OLe/J/YxDL/k66WpdO9
	j0TXDgqmqrCNcpIqQ9MPNnO7qaLk/yykaTXn3AMqVbySZcOPdJE3eLjBix79KaC9UD/xZMNHXey
	bybrmOotorJvKN/g/7h0dzwG+YVA2ItTLqGy57K5XVZqan/746R0kGfXiCIAJ8Ly6fetrApMfxi
	SyGTtnKpk+noW3/DdJzpSAN7eOOOIE2EfasvEC0nYbggRXcaPKFJ+ZAoYXEj7i3Xgo2CHJwMKwi
	NuJA8qWXNMOxrZVin8Q==
X-Google-Smtp-Source: AGHT+IEbZue8yadMnQtopoEHxvAnbFuBwD4toLz97BG9bsjvN++9UjAqjnNo7mMwutXFoxmlxqUMSg==
X-Received: by 2002:a05:600c:c085:b0:453:9bf:6f7c with SMTP id 5b1f17b1804b1-454a36e2a5fmr58086605e9.9.1751544956230;
        Thu, 03 Jul 2025 05:15:56 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997b492sm25326485e9.13.2025.07.03.05.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:15:55 -0700 (PDT)
Date: Thu, 3 Jul 2025 13:15:52 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
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
 <jgross@suse.com>, Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook
 <kees@kernel.org>, Eric Biggers <ebiggers@google.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, Huang
 Shijie <shijie@os.amperecomputing.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Namhyung Kim <namhyung@kernel.org>, Arnaldo
 Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv8 02/17] x86/asm: Introduce inline memcpy and memset
Message-ID: <20250703131552.32adf6b8@pumpkin>
In-Reply-To: <uvvh6qfpan6f56fdvuch67nss2h5nqxbmocztf6v2lfbvnihbg@vtzbr6anzqnl>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
	<20250701095849.2360685-3-kirill.shutemov@linux.intel.com>
	<20250703094417.165e5893@pumpkin>
	<uvvh6qfpan6f56fdvuch67nss2h5nqxbmocztf6v2lfbvnihbg@vtzbr6anzqnl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 13:39:57 +0300
"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> On Thu, Jul 03, 2025 at 09:44:17AM +0100, David Laight wrote:
> > On Tue,  1 Jul 2025 12:58:31 +0300
> > "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> >   
> > > Extract memcpy and memset functions from copy_user_generic() and
> > > __clear_user().
> > > 
> > > They can be used as inline memcpy and memset instead of the GCC builtins
> > > whenever necessary. LASS requires them to handle text_poke.  
> > 
> > Except they contain the fault handlers so aren't generic calls.  
> 
> That's true. I will add a comment to clarify it.

They need renaming.

...
> > > diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
> > > index a508e4a8c66a..47b613690f84 100644
> > > --- a/arch/x86/lib/clear_page_64.S
> > > +++ b/arch/x86/lib/clear_page_64.S
> > > @@ -55,17 +55,26 @@ SYM_FUNC_END(clear_page_erms)
> > >  EXPORT_SYMBOL_GPL(clear_page_erms)
> > >  
> > >  /*
> > > - * Default clear user-space.
> > > + * Default memset.
> > >   * Input:
> > >   * rdi destination
> > > + * rsi scratch
> > >   * rcx count
> > > - * rax is zero
> > > + * al is value
> > >   *
> > >   * Output:
> > >   * rcx: uncleared bytes or 0 if successful.
> > > + * rdx: clobbered
> > >   */
> > >  SYM_FUNC_START(rep_stos_alternative)
> > >  	ANNOTATE_NOENDBR
> > > +
> > > +	movzbq %al, %rsi
> > > +	movabs $0x0101010101010101, %rax
> > > +
> > > +	/* RDX:RAX = RAX * RSI */
> > > +	mulq %rsi  
> > 
> > NAK - you can't do that here.
> > Neither %rsi nor %rdx can be trashed.
> > The function has a very explicit calling convention.  
> 
> What calling convention? We change the only caller to confirm to this.

The one that is implicit in:

> > > +	asm volatile("1:\n\t"
> > > +		     ALT_64("rep stosb",
> > > +			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRM))
> > > +		     "2:\n\t"
> > > +		     _ASM_EXTABLE_UA(1b, 2b)
> > > +		     : "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
> > > +		     : "a" ((uint8_t)v)

The called function is only allowed to change the registers that
'rep stosb' uses - except it can access (but not change)
all of %rax - not just %al.

See: https://godbolt.org/z/3fnrT3x9r
In particular note that 'do_mset' must not change %rax.

This is very specific and is done so that the compiler can use
all the registers.

> > It is also almost certainly a waste of time.
> > Pretty much all the calls will be for a constant 0x00.
> > Rename it all memzero() ...  
> 
> text_poke_memset() is not limited to zeroing.

But you don't want the overhead of extending the constant
on all the calls - never mind reserving %rdx to do it.
Maybe define a function that requires the caller to have
done the 'dirty work' - so any code that wants memzero()
just passes zero.
Or do the multiply in the C code where it will get optimised
away for constant zero.
You do get the multiply for the 'rep stosb' case - but that
is always going to be true unless you complicate things further.  

	David



