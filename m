Return-Path: <linux-efi+bounces-4107-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5C6AF7E53
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 19:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB1D1C400A7
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 17:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FF62550D7;
	Thu,  3 Jul 2025 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JODN/mBG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B6255F59;
	Thu,  3 Jul 2025 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751562141; cv=none; b=h+D3i+PaB710YYbkCQNhGDZth9+QS1Jqo2NoiNcbAjT/uYRkYHXXMm2VCaSKw1eH+swCUX6z6yuhMnF4PoFeE7bc/UJFnP3fh1xGjchWH1K1ap45wBHFmuSSTLRegYmqyCwYPuIErZpI9StDJ7Lg8TgcG44MAQe59WZbIvjlDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751562141; c=relaxed/simple;
	bh=hW8gRXE5rn8Ruy5t7sRdtYCyNtZ6p1F+fSUWDln33qU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeXGX9nXF84+GaplNleUtKqnnUwaXxBPNQi4YwQYmtjbkWXrRnM6TE5aiYTdMAmy1/xzswnOuvdiN7tiSa3EU8OFdsTZhgJiH2O3Tb9ASYFDH2YR+3zE7oKXqpmx+sHZk97sYJezuZMzCMgix7fHZ9PAXYlqEH6BuJ22cnh0mRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JODN/mBG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso8930f8f.2;
        Thu, 03 Jul 2025 10:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751562138; x=1752166938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqSUbsPjahwSUAB6AZ/GxcwqbVye734kyCehbMAYMyw=;
        b=JODN/mBGGI2dPCPEc83bg2nsPpGnAlVvs2c6XZM60w1wW9fT9VttsmD+OuGBtnRiwg
         LaId9ZqGaJDUdteDXfzy7rwWivmtocqnRUaFXgXFuXKGF5ejdxkor3zm95CkkBE55Pj3
         VNc6SL9wayEn+cdF7hcgZ5Gh0TWYKfxHaZTUBSzfDc27YyGBzhWcihnGxOCiHD7laukB
         vxqV9S+kOXbAhGCYxEhK/7C1iBavPduF7VvaUwugzowR1wn3du/mvzB7B/DudhY7CJUf
         gpVP7b2IK3YGJNnKYu1jzDNeRwd6ttFobdtVxpD7nhwJH+heTpAg5QKyXP0hnn4qG/Q7
         nPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751562138; x=1752166938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqSUbsPjahwSUAB6AZ/GxcwqbVye734kyCehbMAYMyw=;
        b=nKQbA8RgXxcG7/pu8KbP7a2E1d9mtEXDkwQVB7MnZQ52YZGwIrycGETgzznE+9pTOs
         Me+xgWVQDvpUArnvbO0IgW6/LgVyzYjNC885ZLrG/gZ6uX5HPmMEI9OwMnwGrtzpHxXv
         6zGhXAGgMIdTOuhWp5gajlEUsB7I7eLzLKRffL+gX8XnppvTtsjW8TehyJoXITCEydiV
         bHtpBsUjmqjyfWoFKuzBCVV26B2NSgCpusyfL6Aw5EV1PMen6CSLRREhJjxwwFxH99fd
         mIvlEBG6GgdoAa3kZDCUeIwCD7ONFghdj2A/ItEX2kb6nIlsmGintr4+ehHSyDApg7gx
         o8dw==
X-Forwarded-Encrypted: i=1; AJvYcCUD+/6qsMcZSqTLjqkuD/vm4f/d98PkFirEcFhiFmOSyxgPZlOPZNubKF3Ps3l5oQiWFog373cnxPo=@vger.kernel.org, AJvYcCUW/PiBSuLTMR9Tlmpk45Wme8Lom/QaZRQA64d/e8qBKQzvT3xMzZRSAVHo8Elnq297FrTaU3NkwJoQMZGp@vger.kernel.org, AJvYcCWizKCKU/LPSocxgXCkNgWTEMAOjsqE27MNy/OMAOqlLlmUGUqkykdQ30LwznFDZ1tmhI0z9PeYj+4s@vger.kernel.org
X-Gm-Message-State: AOJu0YxTia20WJqRk65m4Q3nmOhhojtmyfpQEQuyWmlUGnVuAueO9YID
	/KnyHnqWd3XZc0zSrVC6i641PNdLLsWcTb8Xiy8YZ4TM/IiW1bUYm8Q/
X-Gm-Gg: ASbGncu7h/I1mCvmcISP9rAak9aZhzxZrC+ZF0IVqBszo9jcCOzLd6SFOnUoPkMYbaM
	yYDgegBsvTzYH+d92sFCJXX0Rj++Cqcdl/nlf/2YZnVFnD2L8xncq8+CmXvPNZhgV1Azi3PWjFJ
	nOzR2O/ekLynZoFQzWd46gHJvYhezE4vgGNG3Av/x1XQxvLI8EaYI5hCozquRA4g8mUuhWrZbB6
	SahXn8pFcSs5aUFiGCcnt3EkgcuffMgx4c8rqFi8+S/tFKkopJiDhbtIMKe9i6mbkFgmFdc0IBO
	RUA55riqqXNejKkUqL+aqjRJOOcrEgGiw8DVc6elEzQqTgUHS3bQJSzeLnhYdQiVx0X646lV9Ym
	EAO5VjEAAtCNgAvpmxw==
X-Google-Smtp-Source: AGHT+IHaQgjZrXhRgzZx++9Yi/fzdCBPXdZfk6poOyduS7JH7jm8D3wKUoXwoBb3dw9YTRiJNjYZkA==
X-Received: by 2002:a05:6000:4b11:b0:3a3:7ba5:9618 with SMTP id ffacd0b85a97d-3b32e70d7d7mr3507915f8f.29.1751562137307;
        Thu, 03 Jul 2025 10:02:17 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0ed9sm279010f8f.38.2025.07.03.10.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 10:02:16 -0700 (PDT)
Date: Thu, 3 Jul 2025 18:02:13 +0100
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
Message-ID: <20250703180213.28c0e92e@pumpkin>
In-Reply-To: <uoysignw2pmdls5v57z4cty76hhz7fv7ikcih2qgeltbgnem4f@jt2r24bqvzau>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
	<20250701095849.2360685-3-kirill.shutemov@linux.intel.com>
	<20250703094417.165e5893@pumpkin>
	<uvvh6qfpan6f56fdvuch67nss2h5nqxbmocztf6v2lfbvnihbg@vtzbr6anzqnl>
	<20250703131552.32adf6b8@pumpkin>
	<uoysignw2pmdls5v57z4cty76hhz7fv7ikcih2qgeltbgnem4f@jt2r24bqvzau>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 17:10:34 +0300
"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> On Thu, Jul 03, 2025 at 01:15:52PM +0100, David Laight wrote:
> > On Thu, 3 Jul 2025 13:39:57 +0300
> > "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> >   
> > > On Thu, Jul 03, 2025 at 09:44:17AM +0100, David Laight wrote:  
> > > > On Tue,  1 Jul 2025 12:58:31 +0300
> > > > "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> > > >     
> > > > > Extract memcpy and memset functions from copy_user_generic() and
> > > > > __clear_user().
> > > > > 
> > > > > They can be used as inline memcpy and memset instead of the GCC builtins
> > > > > whenever necessary. LASS requires them to handle text_poke.    
> > > > 
> > > > Except they contain the fault handlers so aren't generic calls.    
> > > 
> > > That's true. I will add a comment to clarify it.  
> > 
> > They need renaming.  
> 
> __inline_memcpy/memset_safe()?

'safe' against what :-)
They can't be used for user accesses without access_ok() and clac.
The get/put_user variants without access_ok() have _unsafe() suffix.

> 
> > ...  
> > > > > diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
> > > > > index a508e4a8c66a..47b613690f84 100644
> > > > > --- a/arch/x86/lib/clear_page_64.S
> > > > > +++ b/arch/x86/lib/clear_page_64.S
> > > > > @@ -55,17 +55,26 @@ SYM_FUNC_END(clear_page_erms)
> > > > >  EXPORT_SYMBOL_GPL(clear_page_erms)
> > > > >  
> > > > >  /*
> > > > > - * Default clear user-space.
> > > > > + * Default memset.
> > > > >   * Input:
> > > > >   * rdi destination
> > > > > + * rsi scratch
> > > > >   * rcx count
> > > > > - * rax is zero
> > > > > + * al is value
> > > > >   *
> > > > >   * Output:
> > > > >   * rcx: uncleared bytes or 0 if successful.
> > > > > + * rdx: clobbered
> > > > >   */
> > > > >  SYM_FUNC_START(rep_stos_alternative)
> > > > >  	ANNOTATE_NOENDBR
> > > > > +
> > > > > +	movzbq %al, %rsi
> > > > > +	movabs $0x0101010101010101, %rax
> > > > > +
> > > > > +	/* RDX:RAX = RAX * RSI */
> > > > > +	mulq %rsi    
> > > > 
> > > > NAK - you can't do that here.
> > > > Neither %rsi nor %rdx can be trashed.
> > > > The function has a very explicit calling convention.    
> > > 
> > > What calling convention? We change the only caller to confirm to this.  
> > 
> > The one that is implicit in:
> >   
> > > > > +	asm volatile("1:\n\t"
> > > > > +		     ALT_64("rep stosb",
> > > > > +			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRM))
> > > > > +		     "2:\n\t"
> > > > > +		     _ASM_EXTABLE_UA(1b, 2b)
> > > > > +		     : "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
> > > > > +		     : "a" ((uint8_t)v)  
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
> Okay, I see what you are saying.
> 
> > > > It is also almost certainly a waste of time.
> > > > Pretty much all the calls will be for a constant 0x00.
> > > > Rename it all memzero() ...    
> > > 
> > > text_poke_memset() is not limited to zeroing.  
> > 
> > But you don't want the overhead of extending the constant
> > on all the calls - never mind reserving %rdx to do it.
> > Maybe define a function that requires the caller to have
> > done the 'dirty work' - so any code that wants memzero()
> > just passes zero.
> > Or do the multiply in the C code where it will get optimised
> > away for constant zero.
> > You do get the multiply for the 'rep stosb' case - but that
> > is always going to be true unless you complicate things further.    
> 
> The patch below seems to do the trick: compiler optimizes out the
> multiplication for v == 0.
> 
> It would be nice to avoid it for X86_FEATURE_FSRM, but we cannot use
> cpu_feature_enabled() here as <asm/cpufeature.h> depends on
> <asm/string.h>.
> 
> I cannot say I like the result.
> 
> Any suggestions?
> 
> diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/string.h
> index becb9ee3bc8a..c7644a6f426b 100644
> --- a/arch/x86/include/asm/string.h
> +++ b/arch/x86/include/asm/string.h
> @@ -35,16 +35,27 @@ static __always_inline void *__inline_memcpy(void *to, const void *from, size_t
>  
>  static __always_inline void *__inline_memset(void *addr, int v, size_t len)
>  {
> +	unsigned long val = v;
>  	void *ret = addr;
>  
> +	if (IS_ENABLED(CONFIG_X86_64)) {
> +		/*
> +		 * Fill all bytes by value in byte 0.
> +		 *
> +		 * To be used in rep_stos_alternative()i
> +		 */
> +		val &= 0xff;
> +		val *= 0x0101010101010101;
> +	}

That won't compile for 32bit, and it needs the same thing done.
	val *= (unsigned long)0x0101010101010101ull;
should work.
I don't think you need the 'val &= 0xff', just rely on the caller
passing a valid value - nothing will break badly if it doesn't.

	David

> +
>  	asm volatile("1:\n\t"
>  		     ALT_64("rep stosb",
>  			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRM))
>  		     "2:\n\t"
>  		     _ASM_EXTABLE_UA(1b, 2b)
>  		     : "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
> -		     : "a" (v)
> -		     : "memory", _ASM_SI, _ASM_DX);
> +		     : "a" (val)
> +		     : "memory");
>  
>  	return ret + len;
>  }
> diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
> index 47b613690f84..3ef7d796deb3 100644
> --- a/arch/x86/lib/clear_page_64.S
> +++ b/arch/x86/lib/clear_page_64.S
> @@ -58,23 +58,15 @@ EXPORT_SYMBOL_GPL(clear_page_erms)
>   * Default memset.
>   * Input:
>   * rdi destination
> - * rsi scratch
>   * rcx count
>   * al is value
>   *
>   * Output:
>   * rcx: uncleared bytes or 0 if successful.
> - * rdx: clobbered
>   */
>  SYM_FUNC_START(rep_stos_alternative)
>  	ANNOTATE_NOENDBR
>  
> -	movzbq %al, %rsi
> -	movabs $0x0101010101010101, %rax
> -
> -	/* RDX:RAX = RAX * RSI */
> -	mulq %rsi
> -
>  	cmpq $64,%rcx
>  	jae .Lunrolled
>  


