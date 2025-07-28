Return-Path: <linux-efi+bounces-4490-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41665B1426D
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jul 2025 21:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC113A1761
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jul 2025 19:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711E82777F3;
	Mon, 28 Jul 2025 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw4Wvb9s"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83027780C;
	Mon, 28 Jul 2025 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729903; cv=none; b=HZJJnz9y0w1va//SUSxKMZ4LDIVSqA4T/0JaGYym81vZrVNtjmxCUmLsHGHjyorh8dpRGkxmChVUAJt6elqC1b50s+r6xwhzfD7TwToAEAuVCFxcnMGtg/jtMpkAKSEWt7rl5xBBcXQhmQCEaC1CP9SkHLy2PInRIm0QhCO7kPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729903; c=relaxed/simple;
	bh=inpG/K9udlBIuzku7bqEhpSDPRRlpwOHAKo3dG0KT/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxNe45fM/6yM3nYj2y7rr+rdAKTx0xoc9Zdf9XzrbiTYihOoAIj8DNyzF1myvmZZ+8jiTcuQu7iNz7BucG5NRn52gNj/SVmjXGPWDnBYddT7pjKcQ0NMBT4MaGtpYQ/5nVaN6IZEHNtSYTDPfcoEdY+5egTWTQM5uJKBdJ/Ow4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uw4Wvb9s; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so50662015e9.3;
        Mon, 28 Jul 2025 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753729900; x=1754334700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5ujbbHitHl5dgm3mEjwmrXtoJQpOR5znmBhpKBJQ4I=;
        b=Uw4Wvb9sBokpqLDrxTT2s8iN8KzWjVDymxJ20xfTqMgsPjlgQdKBUbRZ3qEfuVUUys
         S6xxz6rmwS2BbjTLGkB6tkD3Gq0YFyEPxScqpISXqXqBfXP1XJ6HL+4fcaoYdebICAl5
         OFHgMnP5A//JWgB/0Oh0bPBbW19SsOSuCqqyNv96F0oku38k1kJsq9wy2vU7JGLNPgxH
         UnuyyHuZeolOK6OqVK+Miw7ywil0dijL4hQT1qXG5Tp23APcyN/Y7LGIsfkc4DlHi5uf
         g7OfjiTrBhdKl4kRTDsgPibpGz06m/oKPc3RE5fuLQuy53FsNGDgyP2pSPtmVuQMYWJ8
         nz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753729900; x=1754334700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5ujbbHitHl5dgm3mEjwmrXtoJQpOR5znmBhpKBJQ4I=;
        b=rWY0eV1u5GOn7jEmt+1mqm6AsnKNRcP4RGi/7q4+MWEsDztUQlj/soSjDriDfalLK2
         y0qbbaO7Np9DoJ3PBwSeDfONr9gx4sS56cwGBLEN+k1jUWV0mZ+OPuLI+5bFC5/HHT0i
         xLLitU3o5qcPFsFa0U3sex6oaDlrWqqvR8qIOtdiXov7q2dPjrabgAJAlXj7cLKaSMvB
         6I8XOCo4pjJG9kpk47bCd9/+ACTdLWztFAjtyyREOXcPFWOC42dAZyrLOBSGtj2IHWKr
         81MRf0wCxJODZQmDZarIIx0C6dCsOZnsLAwC6jqUrKubt+SJyEaAriiu+xxomfkVcS8o
         EfLA==
X-Forwarded-Encrypted: i=1; AJvYcCUZjsdeq5YgbxcYBc71Gdr7HDfu3uOwNRJwzDbVJbfpfn7H75y/7IHmAXawphdbrbN8CFCKl9+uch+XK3jc@vger.kernel.org, AJvYcCW/rWeim4mmvsirMeD5asCcISP+7Txe3elg9HVur+3AlOdOQJ4gojZlzi5/Fvly+sx8Pts/xyhXkBs=@vger.kernel.org, AJvYcCXwupViL9rMFMTv3LRY9E7k6F52XJhWCGCsshpf3nXfAwPT0rMHd2fSTZy6agPlsKTMT3HYhc8lwZ35@vger.kernel.org
X-Gm-Message-State: AOJu0YxCxuTAJLMuClrqWmAb1E37T47Jr9VQa/430U7tNElQ7Cae+UX6
	ADcU2po7iHNx4moQVaf0vcnkw9cRM/cDf5ce68e80MsFoxNI8hYo4yHj
X-Gm-Gg: ASbGncvqXYgYq3spYB0+MaUOIcVak9xsT1ufjVIUXiZDJY5FjChrTQFdCKVA0CVlDa8
	cPG+8hbbvF/3xZzjTu/oHXOUFnBDSpHzVIYTOGLprffMAm39Ey1Zw7ArH5x4aqbwnsEgVdG10B4
	5EHeU9E8zgwTvaqoSk2KWN+oCIL/SoPnTECgItweCp2tehuXVptqWfrnKDOaIe8au50EULuxOgU
	KjZKl02IMNGOlOzFzJT9tiXSr6LVmmvs/IDQ0RizYOXEAoy5nNY5FPqUW1edldocTnC/H+jkLTe
	AJufZ7DEQeosQ7uk/PM96qRM9MQ4ei6WcTTr2sR6URz5FhPiZY97P0y8VmFarXTjWlF6QWQOXEZ
	TzJ84XBaGbqYrh1YVQsr1uGclDNsUAgaGJwvmBgGqxaDcKDDe6aunkFxCHeUcdmhqBp8iul8=
X-Google-Smtp-Source: AGHT+IHDNjqJiK/x4ADgxh71DNy+TDjyb6189QbF5i6Zpg12xik0b+LlFg9st/wOQU9cpdMpTrOHEw==
X-Received: by 2002:a05:6000:430a:b0:3b7:892c:41e3 with SMTP id ffacd0b85a97d-3b7892c44d1mr3040258f8f.46.1753729899796;
        Mon, 28 Jul 2025 12:11:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587ac58045sm110653695e9.22.2025.07.28.12.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 12:11:39 -0700 (PDT)
Date: Mon, 28 Jul 2025 20:11:37 +0100
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
Subject: Re: [PATCHv9 02/16] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <20250728201137.113d0f45@pumpkin>
In-Reply-To: <20250707080317.3791624-3-kirill.shutemov@linux.intel.com>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
	<20250707080317.3791624-3-kirill.shutemov@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Jul 2025 11:03:02 +0300
"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> From: Sohil Mehta <sohil.mehta@intel.com>
> 
> For patching, the kernel initializes a temporary mm area in the lower
> half of the address range. See commit 4fc19708b165 ("x86/alternatives:
> Initialize temporary mm for patching").
> 
> Disable LASS enforcement during patching to avoid triggering a #GP
> fault.
> 
> The objtool warns due to a call to a non-allowed function that exists
> outside of the stac/clac guard, or references to any function with a
> dynamic function pointer inside the guard. See the Objtool warnings
> section #9 in the document tools/objtool/Documentation/objtool.txt.
> 
> Considering that patching is usually small, replace the memcpy() and
> memset() functions in the text poking functions with their open coded
> versions.
...

Or just write a byte copy loop in C with (eg) barrier() inside it
to stop gcc converting it to memcpy().

	David

