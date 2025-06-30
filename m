Return-Path: <linux-efi+bounces-4047-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0FAAED750
	for <lists+linux-efi@lfdr.de>; Mon, 30 Jun 2025 10:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521C43B7148
	for <lists+linux-efi@lfdr.de>; Mon, 30 Jun 2025 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A57221ABB1;
	Mon, 30 Jun 2025 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLhAvjaa"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4463987D;
	Mon, 30 Jun 2025 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272245; cv=none; b=MgPTbhzlIQCzwsBPhjlPpGYpMNLoHj1WAAKy2uE1XC35L0OsITLoPZzidenCE/Na4PtGLSRnis3w+vOz74BHC9SW/b+czP89OiT/0sHcUKZQt7o0uGlIqcLGHucSQXqYO9tr9qw7gnVn6a4Q+Xa0upYhRk0UnxLnYDKGlFJb3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272245; c=relaxed/simple;
	bh=Sa8TOB1LjTlsgmaE/M2lm/qcOWG4+0jaPoEkqBHbA/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmKvRuAWDveYDdhYAH5gH7PAbQPU7l5uf3/t3Z0xd/eUel20nnhKi22V+tgBtr+45SANL355kHpZ9wpDa9blHfMYkBlw26mLDstQQO2LDpFXvcSNc1UiXvsyG3+yugfVh6vAj9LxlXP6oX6uVCHaD/PgRKQWLe6zDEPPydk0XxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLhAvjaa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so22973015e9.2;
        Mon, 30 Jun 2025 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751272241; x=1751877041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh3XzmTIrjcBc87AWD2M6G0OROu2+1bNESz7HfCbh6I=;
        b=DLhAvjaaPpUpLxLseHygDGZvKJhKgFNwuqdVzwWa/TfVSuY1ZdW22EOF5DzmZPjx7k
         oIn1Dh5Tn6bwcZHRbHK2R3XZpUcIyLGLLjk7H722Sf98dX1QQEB7K3YSW+9BnSpZ07Jr
         hJ7xjcOwBwT0M1tEdtLMaGh/quDTJ0uazpTUsGpoLaeYiZw4yMpr8GFz7MAYsiF0TpfT
         mT23N3ieGFqWzSrbmqlI1mG8hBBPSxE6jsAyCMNghiJrMuFFHb+76JhadwjAEIHscIqw
         QmeXmADTlnDnLgnHxbLpA/07z1Oxco1GdO5bux5ulYWIy+xdy7VZCikgIrKOlysQvOud
         MJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751272241; x=1751877041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eh3XzmTIrjcBc87AWD2M6G0OROu2+1bNESz7HfCbh6I=;
        b=Zevq+ccyhPgiz3s4ey564Ty8JcUCqKCJqLvU+22+0Lgj0hmGPElhwu8fuzwQyRG8Me
         aSQMEn+o1pJVrMtNjLu1VVf6a7FXGpw6Q2gG+FycwCiYJA7Yb/Wj8o4W+77lQ7nSPQZ2
         KHBACZLmeWwUSXyW0sW9it7zU16S6bsOseklauxLcqfHfKkDinSjO6hQUA5iS+4VVZfe
         9erqTs3a3DqeUaSuNFYwr9b75h5XIdnY/aqaRF5GF7OFwNhLODX/ZCJ8pfDxQulbbbj/
         ZOYDXkn7XlFh7bX/PaytAm+8gJz67kCyiqdIIKhBg0InIoESmTQpQ8BKuRB+AxNbyzBA
         8H3A==
X-Forwarded-Encrypted: i=1; AJvYcCV/vnNbAj/YtTFXNw6q587gFraHigLq9DHArdSmw5AAGLe+MExDOCOcfT3OAcxNnhK5VHfc1DTgJFAsqs+0@vger.kernel.org, AJvYcCXEu1QDD+Hau5PYJT7usP+gvQwfd/JE0TIJrshSevh8jUym/SB9n7eXjW9ir9Sw22VJhIJw5N8Sxs4=@vger.kernel.org, AJvYcCXWr6eB9bhoMTI2pEjohvTkUYZeRIWNCXZWPKbrEI4sZNOnSz2YMpLwDTmItv1QGFx2gvTSOBf3gkjs@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQlyUFnI/QV9TyqF59Fe6tqMRbv0XN5fR1T6aiDNWZoB6kKzH
	tZwSfcG47J3OD7fhzzafRDRtN2bppZQ9MZsNuHu4N9W5rsXZFxlgbX/a
X-Gm-Gg: ASbGncvOUCRDc9sd1x2UkWFvztEsSlmxcrgcBPX0E3pgR28WAUezpsSZzrQM2Xkd6WC
	Kkns7IlDGo+BXMOiAllYH0mH/Sh++qERjbRA02SyU7ta9l9L2gDbkcrvVrDOoXcuVL97ud2ObAT
	PJstLtXiwnvr8aV4H9z7V3LMWx1iloP+ycMcW3nnAsMUMfmHBuHn176FFpIyqKqAop/jTXwORP+
	CDyUFPxiPHcIuzOiXJyskS5vzh/YG5GOKy3bmRAkVILHJy5BCF3Av6fpapIbShOVIz7C3khbM9H
	LhhhfFILt7ZsgsRoaI2w/x8hrf1A00A9YjCShrrUYxxzNFIxEF1erhwCM9niYhwpM9GHnLQiGki
	c5PgFKPmMueSt7RRRPg==
X-Google-Smtp-Source: AGHT+IGc6v8XBFxsBrb7Jlxx/vC4rlmTNkaDJ1L+bRlKdmVKXfY6cWVY8NH6+NgGUaeOf/EOeryD6w==
X-Received: by 2002:a05:600c:c4ac:b0:44a:ac77:26d5 with SMTP id 5b1f17b1804b1-4538ee59610mr127692885e9.14.1751272240450;
        Mon, 30 Jun 2025 01:30:40 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3b2fd7sm129422525e9.17.2025.06.30.01.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:30:39 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:30:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: Re: [PATCHv7 13/16] x86/traps: Handle LASS thrown #SS
Message-ID: <20250630093027.38cd1ebc@pumpkin>
In-Reply-To: <lvutnc4et6r4a5eayoweb5butpspvop2m2pjioiudjwa3mkpo7@drcsdchj66w5>
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
	<20250625125112.3943745-15-kirill.shutemov@linux.intel.com>
	<c704ea9a-8c73-46c2-80d1-f7b93a221908@zytor.com>
	<lvutnc4et6r4a5eayoweb5butpspvop2m2pjioiudjwa3mkpo7@drcsdchj66w5>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 13:31:44 +0300
"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> On Thu, Jun 26, 2025 at 10:57:47AM -0700, Xin Li wrote:
> > On 6/25/2025 5:51 AM, Kirill A. Shutemov wrote:  
> > > LASS throws a #GP for any violations except for stack register accesses,
> > > in which case it throws a #SS instead. Handle this similarly to how other
> > > LASS violations are handled.
> > > 
> > > In case of FRED, before handling #SS as LASS violation, kernel has to
> > > check if there's a fixup for the exception. It can address #SS due to
> > > invalid user context on ERETU[1]. See 5105e7687ad3 ("x86/fred: Fixup  
> > 
> > Forgot to put the link to [1]?  Maybe just remove "[1]"?  
> 
> I will add the link. It is important context.

Will the link still be valid in 5 years time when someone
is looking back at the changes?

	David

