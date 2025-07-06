Return-Path: <linux-efi+bounces-4131-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B03AFA3F1
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 11:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8AA1896D4A
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 09:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC4A1F4706;
	Sun,  6 Jul 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyJMtP5J"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250661FF7BC;
	Sun,  6 Jul 2025 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751793247; cv=none; b=lPUcHd7RaIlQtiZ1Xh1T4edF1r4cXLgCeSeQf6rLH2K35OagxUg2as83X0jpofCKFeEJuBUQ7tQB1HwfLLGJ6GRuhJcTnzsR5W/CX3BjTiU7NgADfjjVNeup7tOAzxY/GCQnXVfqfdiiPEeChspMh92zY0JG3aLCFpVz6CLEU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751793247; c=relaxed/simple;
	bh=Lmw0fPu+AVGOqr6cYQJpWJ0LkeLPvRD+9pIdzZknj3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5Iq/HkhtflQhQK9LvpKmsPGXTAx6fvX0Si1+5qm3yRk8o6oqgkSyDFA1xUcDR+Z+BbTJOMoHQKyuShNXykJbrunrb1tPprhOFX8mTYYgetxvlHdmOVPNLOtimjadOWSyjA5FSL2KbxIzdGnVzY389wOaBFMoEkZaZZKJYPtMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyJMtP5J; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d6ade159so17727525e9.1;
        Sun, 06 Jul 2025 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751793243; x=1752398043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8hlSgBV1+bYygrl+ZccylfC3/K7ixgrATl9jQwn0YA=;
        b=PyJMtP5JWR5WpJQRsubaLdd5BRbo5C9UfacfdUgx6DY0Mz0krO2llVIeYUZWYDBXNK
         OFH2o4dA9X9Uc08T/LhWTqWVqV8a1WX86Gucup80+sWEJ8XDXnOrXbd2HARhnIzizfCr
         6fc46BNwy5EfViAipcKawQ5nNRias9OFsIjwe4MM5yVMG5d+jyQGjXG/ptgLvIfeJQzx
         Qd1bJPXjmBTZQZuCr60i8m3KXFh/yWwo8713Kxr51fRbtz21Rtzm4PSaVkRHI+WXLqrn
         VQUnloUD9OtRloBN2WHIN0C5pkgslpKdL3M1y6kvUMFZRk2HwlW0nf1H/5scOMTkB6Nb
         OTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751793243; x=1752398043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8hlSgBV1+bYygrl+ZccylfC3/K7ixgrATl9jQwn0YA=;
        b=L9LbaWbg2q708OA3cKplhKduNa2t8da7DEx6BOaOTt+4JfZl2xTGDWqARfp7Ew+q4k
         crNzarg7WTD/y5AzlSCOAtbbOszep5MKcbPrWrPf6iPmBNFeQdEdihs8z4ai+9dIuZSF
         YTkwMIlZFJFhUPPWm3A6qKxr4ebkQyFcon44alQFM1e9zf+q0q54Fncpy+sa52xe7y9K
         B73zJpYyhOSp8BBuSPbsxyNFmuqkMLxrn2hFhGDTYZckJGQzhhVKTnDPHPsOPrZDPH/Q
         zejNwgBkC8M5yXuATXDZL4ss88sLYeephMdn+Z6tYF1VKEjs/SZURqpdxZi1nnvlXfuT
         7J6w==
X-Forwarded-Encrypted: i=1; AJvYcCWFKSazqhA5mpw6p5ZQMKfRn/2KUT6+Bit5R00yr6yHRKIHNwYN2YbZE4SXzHpap48XfCXhzVF4Glf+@vger.kernel.org, AJvYcCWeXtzcxb/bQRtaqDlNvAKb+tolo9pNSeK6ZNnGj+GLvB6HR1JL9qx5ep2L/yZJuGaIbfHUOLk25bhLkTI9@vger.kernel.org, AJvYcCXDI9cDlCXMQBAFggFCdrflnUm47BelExGYb9yUs6Ubu4Lfo556tLtuYujQozb9WZDUQoOjRhmeAao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfetLqIzCpONTyAKpcjJAQNbLIXgEIjAktX7kSSdGOk1dkWa40
	NA4kxL5nkWFkyB9misBp3huQtdZURfsHiLfJQ2UsBKRYbTJ65tobTY2X
X-Gm-Gg: ASbGncvyX61d3X974RVBibBW1oZ/kJlEubabKb3jxIuDL/CGX/9DuzU7CwLwM7Z9Who
	9BnaJdu+yXlM2gWFbag83zrCRgBAigTw2HZRF+8lXf2intXe0wzR3bUERoTqrnhjQ0HLVaLMhRt
	81AWLiHrUnDN0L2XePiZ6iBDaysa+PCaEs+4i+RDwHvo75DtfHWddOezLBUb5nwHqiwLE9CcSbG
	sjL37q+9kjXLdp/QbeB5TgiRnK6DzehJsv4nVBSAeEZ9uNZQObB07nDbDAjIMRetpJ6YAOTuWMH
	GbmcldIQjckhZ50q6njSILsAUfzOIKsACAgVisSRJhd5CG9kEmpZkHxvUF25+ypCgvzJzd4eTTn
	jH9pdpxMS7B/reD8E7g==
X-Google-Smtp-Source: AGHT+IE/TXS+sz7Mby0dfZERmdqKJhVpm0cyrlWbJ+f/VwJHOVGQVE9NJpn97WFCi+JJaWJyaqs25w==
X-Received: by 2002:a05:600c:4f45:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-454b4e6849dmr63131615e9.6.1751793243088;
        Sun, 06 Jul 2025 02:14:03 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1695577sm76992715e9.27.2025.07.06.02.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 02:14:02 -0700 (PDT)
Date: Sun, 6 Jul 2025 10:13:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
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
Message-ID: <20250706101342.069b5068@pumpkin>
In-Reply-To: <49f7c370-1e28-494b-96a9-f45e06ed4631@intel.com>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
	<20250701095849.2360685-3-kirill.shutemov@linux.intel.com>
	<49f7c370-1e28-494b-96a9-f45e06ed4631@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 10:13:44 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 7/1/25 02:58, Kirill A. Shutemov wrote:
> > Extract memcpy and memset functions from copy_user_generic() and
> > __clear_user().
> > 
> > They can be used as inline memcpy and memset instead of the GCC builtins
> > whenever necessary. LASS requires them to handle text_poke.  
> 
> Why are we messing with the normal user copy functions? Code reuse is
> great, but as you're discovering, the user copy code is highly
> specialized and not that easy to reuse for other things.
> 
> Don't we just need a dirt simple chunk of code that does (logically):
> 
> 	stac();
> 	asm("rep stosq...");
> 	clac();
> 
> Performance doesn't matter for text poking, right? It could be stosq or
> anything else that you can inline. It could be a for() loop for all I
> care as long as the compiler doesn't transform it into some out-of-line
> memset. Right?
> 

It doesn't even really matter if there is an out-of-line memset.
All you need to do is 'teach' objtool it isn't a problem.

Is this for the boot-time asm-alternatives?
In that case I wonder why a 'low' address is being used?
With LASS enabled using a low address on a life kernel would make it
harder for another cpu to leverage the writable code page, but
that isn't a requirement of LASS.

If it is being used for later instruction patching you need the
very careful instruction sequences and cpu synchronisation.
In that case I suspect you need to add conditional stac/clac
to the existing patching code (and teach objtool it is all ok).

	David

