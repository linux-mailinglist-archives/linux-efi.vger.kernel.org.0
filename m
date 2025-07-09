Return-Path: <linux-efi+bounces-4235-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D46AFE475
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 11:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A378D4E41CD
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 09:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164AE286D7B;
	Wed,  9 Jul 2025 09:43:27 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A222836B5;
	Wed,  9 Jul 2025 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054207; cv=none; b=Xx2qg8vVX7VGO2pLjoHRrxrGrislPQS73WNhOeRrHIkCo26KanquaypcDIBm9CbBVDLkO/4ZdLBohR3PVL6d2DqPHR7p9FW6ZS/3Kgh3MHJeNwPh7r99KGe1L9D7Z6w6oDw6Mw2U3QhXcPxi/3d/rTLe4V5c0tsjzlhaN75xhX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054207; c=relaxed/simple;
	bh=5uzc0ic2FmPwqnXgV15dZx3MfYkfhUI0DTznkjWzvtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHeTuhMaaEtA4nfT2ewQUQcSFK288lSDLnWrcCIWmbFSqxEjO4Wu5QOYzoEH633TCnMPVTBJS5tHZR+IgZSdW0TctQxGdMt0zI9JMhB+P3aRvWCTGbh/jwFUELW8u4MBhkELk/4BC9Q44TjeR5RsJAzjpqsjBoGKJTZyzikuxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a589b7dd5fso84627561cf.0;
        Wed, 09 Jul 2025 02:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752054203; x=1752659003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZqsDi4cJPGlgI/KDWvuyMOnCIb8A5zf9i9HEg4Izio=;
        b=swk7Q8tXSd3gIqg2YmSyyQjMyIccGIrAl24aBOoCL2plOvxJ0+23TZMwhS3Z2tuH9M
         mvWpKHN45F+fHUy66a1HWHIPZPK3i0E11RWX8AU7MmX/JniAttml1l5H5O9WtUQgQyy8
         JPPkYxVlXSJQ9fzUsQ6LUi+WlId2HHaQmiA7pqXJOZMgJNe8K/vHxie9uQaIeEmx0mYD
         e/m4cPoeyqnZr8TAv8ymkHKtwV5jumKhFTsyTO3pkZYa/HzRcSqkacGR8+7GcPGv++Fq
         5OcOK0CuLDwr0cODTYm1Cm28XVJLR/Eu7X6JmeSU9YRM9M0IilnsTP7MDGCejtTors/i
         Ijrw==
X-Forwarded-Encrypted: i=1; AJvYcCUKI2htUZQAL24z4Ff1lZxUf4ZuL2S+V9b1uiGdunum1iaWjHP4g3EtCdhc6fsyebB9tfj/ppZ9y4A=@vger.kernel.org, AJvYcCVmQV4FovcIVlOy3Jzo/jc10JR7eaMSaIZ5dMYVsUeKEGg6+OAbUpXG1dRax4E3+VwoX2Efa/SnsNOAD9eG@vger.kernel.org, AJvYcCWE6tHXy75NpK4Kte6TRjZ4DhMUOAWHLysxnKMY9qfOzP2LlynD9wcLg7kqAnZPVa6+XjoJiU4KJzel@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3zWpvncOaTmQEhyejwn9edtKwcfBZf0sA0baifT67vpKnIc4+
	bOkLLRKh+mIRpOVRi2w6llHYCoh6ukJF71toKqqEhyCLVsDrt4oP/LP65fEoe9+Z
X-Gm-Gg: ASbGncsXedxeuRTVpBtiRSMvrxJ6YyG6cj9tLMxHzJ7Y6P19laTmm62wsqn4dwhllYM
	wWGDBJepjKnCRjdxyF/eNTupZEsr1Ma+6M9Cczh1ZEhJH/Ll+/GLWDG/gK/wY8BB4Ko6ro8aNZ0
	zkwHLhzBkU9mdbJtWLaQs11f9I4rIK0daHLi1hdVEo4KPPyfb9Wi0YV8dG8zHEZBhhOIvReguWB
	PzO7XmSntGpfI3TWreJd+qabxyTeBLjDHegAusqf3Pw1Zf3bAk4h1Dl9Sp4PLU3dkohnU/63yZ0
	KPn1x7Hn4Xq9fFhlIrCYA2GxYpyZ+QSgYcMlEZQPiplXmA4yz60+HhExSz/6K8chJcH4RIaHcd2
	w/21sqergTxpJdCTin59uRqXCzUHx
X-Google-Smtp-Source: AGHT+IGnYhO6DF8rf/vix23pw7PU1TOj4z0AMLGliJdBWETP/xtVPlXDLeW4xLBB4gVGMioeSiwBvA==
X-Received: by 2002:a05:622a:255:b0:4a5:8b39:626b with SMTP id d75a77b69052e-4a9decf87b9mr22529571cf.27.1752054203417;
        Wed, 09 Jul 2025 02:43:23 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a8cdc4sm92870901cf.60.2025.07.09.02.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 02:43:23 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a7f61ea32aso105949771cf.3;
        Wed, 09 Jul 2025 02:43:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZNWp+xPMDQ9ncs5XGJqP4zsfA87RCp5xMbgPSRv1qbOBL6m601FZLR0CNt4Pp2yCQ6t9zawa2cnYZ@vger.kernel.org, AJvYcCV5nVkbbaEl7IuI+zwKBcaAssWTGpgNjheY/MvHjtSdbUMlfRkMgDI4KRtilH6fJta7mGOiYpvEFgc=@vger.kernel.org, AJvYcCVRWJxu36SNeKZM8EGD9vKsHzwiMK3JfFTsqAeLIgu39xq/vm6NS8UZyUUNAHWRNfV9ca3BFI5IADcnKBhY@vger.kernel.org
X-Received: by 2002:a05:6102:5113:b0:4e4:5ed0:19b2 with SMTP id
 ada2fe7eead31-4f5414b7eaamr875062137.9.1752053799069; Wed, 09 Jul 2025
 02:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-12-kirill.shutemov@linux.intel.com>
 <a14155b7-65ff-4686-b6ba-a6900549864c@intel.com> <xy2ocwstdf44diw5p5hisjwvx467fyhm7bljz5xg72cmnhdfok@7pe3vmht6vcq>
In-Reply-To: <xy2ocwstdf44diw5p5hisjwvx467fyhm7bljz5xg72cmnhdfok@7pe3vmht6vcq>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 Jul 2025 11:36:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXpW0re633tW9MsN-+A521Xytoicd-T0L7r7PAwJ-B0+Q@mail.gmail.com>
X-Gm-Features: Ac12FXzhSGHLdm6kLZFXquKo1YsS99gZt-VKBXVubQkHxm__bRsl73xUeT8gKHo
Message-ID: <CAMuHMdXpW0re633tW9MsN-+A521Xytoicd-T0L7r7PAwJ-B0+Q@mail.gmail.com>
Subject: Re: [PATCHv9 11/16] x86/traps: Communicate a LASS violation in #GP message
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, 
	Eric Biggers <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi Kirill,

On Wed, 9 Jul 2025 at 11:31, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> On Tue, Jul 08, 2025 at 07:40:35PM -0700, Sohil Mehta wrote:
> > > @@ -664,14 +673,23 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
> > >             return GP_NO_HINT;
> > >
> > >  #ifdef CONFIG_X86_64
> >
> > Might as well get rid of the #ifdef in C code, if possible.
> >
> > if (!IS_ENABLED(CONFIG_X86_64)
> >       return GP_CANONICAL;
> >
> > or combine it with the next check.
>
> I tried this before. It triggers compiler error on 32-bit:
>
> arch/x86/kernel/traps.c:673:16: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>   673 |         if (*addr >= ~__VIRTUAL_MASK)
>       |                       ^~~~~~~~~~~~~~
>
> __VIRTUAL_MASK is not usable on 32-bit configs.

arch/x86/include/asm/page_32_types.h:#define __VIRTUAL_MASK_SHIFT       32
arch/x86/include/asm/page_32_types.h:#define __VIRTUAL_MASK_SHIFT       32
arch/x86/include/asm/page_64_types.h:#define __VIRTUAL_MASK_SHIFT
 (pgtable_l5_enabled() ? 56 : 47)
arch/x86/include/asm/page_types.h:#define __VIRTUAL_MASK
 ((1UL << __VIRTUAL_MASK_SHIFT) - 1)

Given __VIRTUAL_MASK_SHIFT is 32 on 32-bit platforms, perhaps
__VIRTUAL_MASK should just be changed to shift 1ULL instead?
Or better, use GENMASK(__VIRTUAL_MASK_SHIFT - 1, 0), so the
resulting type is still unsigned long.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

