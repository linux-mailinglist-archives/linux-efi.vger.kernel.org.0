Return-Path: <linux-efi+bounces-4163-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D94AFAFCA
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 11:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA92F173FCC
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 09:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAD028EA6E;
	Mon,  7 Jul 2025 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKgbf8Xd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2649528D822;
	Mon,  7 Jul 2025 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751880828; cv=none; b=Lifc9xLev+baExxBO2ZZNYPfHsjBXLQj8URiE35EWW41vCnbrgPrDy0OCpHBl20j7tCb1W7TZL4fWXm03G2lR5b3IhPtB1zeCs1qTeVb8nXVNIz2gSXWLvPGRWYt/VngjRzB622JBz4Lt5pzeTvBajwwR3R0LbO+bNQnY7soFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751880828; c=relaxed/simple;
	bh=1WrJ7B04J1OGxutjbScKVgYpfC0AM2fDlE5+oYsuxME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bte+EXLbM063liEfLnu/6NxpIxPKlXnfTIbq5F++I/7viuIMqiN+mZkwpsMoDRfFQKVCnSarPmzMecvPRT0oVSXcbHnOKw2n2ixTEbTNz2N67afEEeRCjupLa1ewKPXIEdQabWQobuqt/2ATYfpY15jiNyyBU+6cX2+XAGnep3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKgbf8Xd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4531e146a24so19375205e9.0;
        Mon, 07 Jul 2025 02:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751880825; x=1752485625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEoWclVLK++zsUvQUzM3zXvfPrVju0AfI+dssMdXZbw=;
        b=XKgbf8XdWnco1QZ+f4KI6cqw7S03UYWxOwIDLkFXAo39o0kdKXch7ucqLla9lApl1G
         FPr0rQ5FnV/S5UVQYcIFIupJKCRA0mB1XgnYYZQFqeqyMgPvPHUur5AF/2YBAqyznS99
         D8yc93STjnhVMrSjIBylTUIW4AV1/GEKK1A5yRQOS5zWrh2b5rbJlgK3RfEK8yQR92LF
         0FA6y1XVC4fezWI1dAzRUHBg+m8r5G6OchTvOhc/VI3LXarh6I0Btx9zHUdVrksqwfqe
         E9PX3FGNCb81gBRCjYC5SGUPioFqq4te8SuoW2piP5PIVAhuF+N9VrzUbsA5bBZUOVJb
         tnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751880825; x=1752485625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEoWclVLK++zsUvQUzM3zXvfPrVju0AfI+dssMdXZbw=;
        b=JsbtmEiPql/VExxW+B3d8ssumcJ5wRYviZ5JYaIVur/sZ6S8jXxhmjTKDIYtflSJfJ
         3W6Mn1efAfyWV2fdrjwCHnjylWsziPJZv5baI/L+praPUubu9ADWi9FTHXJhJ0i1J6DF
         AdBYAd6VHLwqzEnZEW98d7G+YChdc7IsUWq9jcDVPb3GrHnL/7gJOauB3lbKabuVppWK
         95yoB+D0llv9j4alWcyuwVDMChE4ymqQMsMnNyU0HKeI3LJPvapjrC899KVPAvon01jq
         Tzpl3Vc3WcgdaeU/q9RkhJwANNeU49RDyx0hZ/ko+AXraHkBKv6iDJO8kiEuI7ZV/1Jd
         5dQg==
X-Forwarded-Encrypted: i=1; AJvYcCUVnY1gQl1ELxQSlD56MvAfgAPtET1liKlhYQjByv1hSLj5GtpyiIt82d5tjawgdIR4yG7F5IB1N/bdhxZG@vger.kernel.org, AJvYcCVfEYnMeAay4SDV4qEkkl8oscJ+iqckdjywzFnAGgJdmF4mH0lF5qr7Rk7FXyadQor+IPeprby7URm/@vger.kernel.org, AJvYcCWXbb4sQUfZY4F7EwShvZp0QSf14CfxcZMIM8tB4Sq6vxNx+ZGm61lCC659/H8Uc1zPjtFUq90IljQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTB60UlPtGN6iBiu129IYirDJ9YCiXnjo1YANBGpMv6Fmsnas6
	TaVOn4Y/HTwVew7IEvWubsJKnTrmxlUWuFEjPEVRuplkTCDRHJRN7jdM
X-Gm-Gg: ASbGncvvxXufSQFI280ksiVNTZFzTybQR8e7NHOU1NHgx2rdJpKNOSC8OA0qzetHHl1
	tbCMQ4lvrVUQ7SvQRx7d+9hO1gNushze9iGoTvwhbNeq3aoEVAicIq/bkpRlrSOMhSxcri/RTwT
	TBLpcei8HpyfXtCsuFKe0JD1LVk28Q20c3ppJL3qZYoXg8YxwcTI3rS7qZdOIBS/xgyb2qEMiJP
	tDcaFzNzpH1nDop5WC+uOcuw7xh4ooneVEogRm3mejbkMkPp6gcoQD7AIXfZGSnKzVnLyQfAsO4
	kSO/SbIWfad0FYbZSCqI4xlPiw7IwUm3I2YMEt8DFFXL3tvNpB/oNbjKS3l0IpJ7M/8cM/CZOhz
	4dx1mmbZiOmtfv0yg2g==
X-Google-Smtp-Source: AGHT+IHF0gd8h6xxh8ABQxf8dvl1fyJrOmaLW4qZUtyuz1wiG1CAh6xJm3NrUh0NSfp36G2rhnaGbg==
X-Received: by 2002:a05:600c:4f4f:b0:453:23fe:ca86 with SMTP id 5b1f17b1804b1-454c1ff149emr38396685e9.4.1751880825029;
        Mon, 07 Jul 2025 02:33:45 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454adc71aadsm124445815e9.25.2025.07.07.02.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 02:33:44 -0700 (PDT)
Date: Mon, 7 Jul 2025 10:33:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
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
Message-ID: <20250707103341.62934795@pumpkin>
In-Reply-To: <eq5h4a5dvlkncthg3lic3go22op2docbhdaolpfwrq2ieai3qo@j3b26mmhf52q>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
	<20250701095849.2360685-3-kirill.shutemov@linux.intel.com>
	<49f7c370-1e28-494b-96a9-f45e06ed4631@intel.com>
	<20250706101342.069b5068@pumpkin>
	<eq5h4a5dvlkncthg3lic3go22op2docbhdaolpfwrq2ieai3qo@j3b26mmhf52q>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Jul 2025 11:02:06 +0300
"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> On Sun, Jul 06, 2025 at 10:13:42AM +0100, David Laight wrote:
> > On Thu, 3 Jul 2025 10:13:44 -0700
> > Dave Hansen <dave.hansen@intel.com> wrote:
> >   
> > > On 7/1/25 02:58, Kirill A. Shutemov wrote:  
> > > > Extract memcpy and memset functions from copy_user_generic() and
> > > > __clear_user().
> > > > 
> > > > They can be used as inline memcpy and memset instead of the GCC builtins
> > > > whenever necessary. LASS requires them to handle text_poke.    
> > > 
> > > Why are we messing with the normal user copy functions? Code reuse is
> > > great, but as you're discovering, the user copy code is highly
> > > specialized and not that easy to reuse for other things.
> > > 
> > > Don't we just need a dirt simple chunk of code that does (logically):
> > > 
> > > 	stac();
> > > 	asm("rep stosq...");
> > > 	clac();
> > > 
> > > Performance doesn't matter for text poking, right? It could be stosq or
> > > anything else that you can inline. It could be a for() loop for all I
> > > care as long as the compiler doesn't transform it into some out-of-line
> > > memset. Right?
> > >   
> > 
> > It doesn't even really matter if there is an out-of-line memset.
> > All you need to do is 'teach' objtool it isn't a problem.  
> 
> PeterZ was not fan of the idead;
> 
> https://lore.kernel.org/all/20241029113611.GS14555@noisy.programming.kicks-ass.net/
> 
> > Is this for the boot-time asm-alternatives?  
> 
> Not only boot-time. static_branches are switchable at runtime.
> 
> > In that case I wonder why a 'low' address is being used?
> > With LASS enabled using a low address on a life kernel would make it
> > harder for another cpu to leverage the writable code page, but
> > that isn't a requirement of LASS.  
> 
> Because kernel side of address space is shared across all CPU and we don't
> want kernel code to be writable to all CPUs

So, as I said, it isn't a requirement for LASS.
Just something that LASS lets you do.
Although I'm sure there will be some odd effect of putting a 'supervisor'
page in the middle of 'user' pages.

Isn't there also (something like) kmap_local_page() that updates the local
page tables but doesn't broadcast the change?

> 
> > If it is being used for later instruction patching you need the
> > very careful instruction sequences and cpu synchronisation.
> > In that case I suspect you need to add conditional stac/clac
> > to the existing patching code (and teach objtool it is all ok).  
> 
> STAC/CLAC is conditional in text poke on LASS presence on the machine.

So just change the code to use byte copy loops with a volatile
destination pointer and all will be fine.

	David
 


