Return-Path: <linux-efi+bounces-4492-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90931B14289
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jul 2025 21:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37973B5955
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jul 2025 19:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637D7277C96;
	Mon, 28 Jul 2025 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPnMILnS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A414F1EDA2C;
	Mon, 28 Jul 2025 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753731505; cv=none; b=jLeMV3pp6b3gCj2cKZmn8npsT3ABK+JdDzDCAFEbUjjQqfSEVtvIPdYW5/2n0VB12RhY009oXWij3U9rjNkhq/5GdzohSdCjC1LpWs50Ss4wp0IT54nqEnV7xgo/yP2DqUkhkqfi7hieIP45OuNwWOBwhMF1kpWQRLx1gWLtpoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753731505; c=relaxed/simple;
	bh=J6Nh+S/Pjb7B94BZul1UJ4/0NkrLc0b/l2wkBvsftmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ix1TfjY3hCjGYrGZptN8YSEkfMjtriQY0f04Ui1O2XfLzQXaBiife2GCXnrHFzGnp9s6fwbb3FgR9vmuoeurhRvdvulcUy785pu22alXaKOsw0nLuZq1XzeC0ET648hGxW+P5bnAODDRcCk4/kvfavKjPwfB3P5/yXB2ARK/oKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPnMILnS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a528243636so2927769f8f.3;
        Mon, 28 Jul 2025 12:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753731502; x=1754336302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1B2C+lY8Ra0bLA0xRJ+Vif1wI60/oMtTqHhEqWZBaQ=;
        b=hPnMILnSXm6vkclx0HmR9F1Yz47Ef2v/ceeREH2yftnogHlU4J549J9VeK1fKB+712
         iyXimIw8Ac9+aZDowYIUDRTQO0yRB9OOKUcw/3XOfF76Q0mGO7gkL6eU1Ha3X69skifX
         vSpxyyTXc+4RXTn+JHi1HCfVceG3Bhno4WB8Eldzhivt7VC1W+t668iI4BGs4/RHgDJ+
         RB1K7JmBjJZVLDDN1OTXWpZ60XhbK5oOgPbKMhfTFVjStyi4Vd4+mNamTOHcXKb5oUOo
         GN35IauOt5Q2U47CUbklOpxsLbNS74YcBbZnXIQs1HczYE3pNozCupNRKfkba3lLbgZV
         RXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753731502; x=1754336302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1B2C+lY8Ra0bLA0xRJ+Vif1wI60/oMtTqHhEqWZBaQ=;
        b=Z5ZGhFfHxsI15R/9cnHc8GIV0LtPhDSbkbzWmwfjPhy6QaHtww4a8n+JlSMZb37KfH
         tVpi6aFfUqYDMqYV/QBFB5QF6zYUicMQw/1g6PGiJAxUjOPnYl5tTPeyi0TwZdRCNP7s
         Xq/qz7u7J80y8K4T6KJemZiJeO1mXPDHMjKSIFW8fpjfe6X9hXhOm+2r/Hih/u7IcTOJ
         DjiwoGesVyIy2qP3T/+bBODadkZg1UicXdtYnCma4qg0e9qpwaQEBcTeBZVxevqwKYdA
         mzsu73XnaqZIwZN/MM9HpLOZj1IFDQHZ78fxhGqSx+kg53Qd7hzhjF9parMPbc2ULYSJ
         +mjA==
X-Forwarded-Encrypted: i=1; AJvYcCVK6B5IySeVfZqotrV9Tr2QmnQDFHGH4IO6CD01qsvpAOynB0y8azDf3Y8zSmicDgsBdDKdX33VhfctsJ56@vger.kernel.org, AJvYcCWIE3/1WegNu+x9ddKsgZ0LsjLzmsZQjizmoDpzoo9QnAq7aH9E0qEVih353A+ByT0Ss9Eu+YOnB6I=@vger.kernel.org, AJvYcCXQTpft2+95LQe+ZEkyBjrkkcqAlh/rdhQWcLpmsMpJwduN2oF7RXe8bOH4yoLAikzFjWZWVEGpiKq1@vger.kernel.org
X-Gm-Message-State: AOJu0YzYThVgbdKHXiSaMGtZ4KuBTttDsupjS7L/jYcTqTV2gPSgYWIN
	ylXbclFIOqR8LBz/Hr/CNCqp4CObJSQhxa3qC0Es44gY4cXtjSopsk2i
X-Gm-Gg: ASbGncsEzjBO+GWWyhMXtUf6utnIlGIXXRzHvVu6SmekLPaYBiJcFdJf8sn++8dOJS0
	FepFzKQjRdFGNcNmL/YTc30Ev9dQsnP6hvSSLs3xf1T4FFmQdG+ba/5teoAnSPYKCZaqgI79cnz
	jF1hAHJKw0x9QS1rxd1wXKeJFG+13MBRubor98tcpp5knSo5s+sz4tiQj79Jw8IHVX6DkTQkmv9
	vtZXoMzlPn2dUwJ2UDxJw1JCFEwvNj2ZC6IvudfNzCtqQOa+B4ksLlqkDVeuKtbR86/WsnKSZ45
	Liqj1quME9yB8HlrW3Jnncstq6nqq+JjctTqQAMwPQu6BYGJdM/+zBqv2rYRNE9tdAbl4wH4YkL
	GdJsRmU4JKucJBP1JsDfMzV9J+XSvpgRCxvV4nmxUNA7KAS6dINHSUC1/biD+
X-Google-Smtp-Source: AGHT+IHvIOBr6JyAvhaG41eHAIA1V3mtOhIAa1HkfuIyT7tnwt3aoMI/rHcc0qmMJHOGXfw3hW6a5w==
X-Received: by 2002:a5d:5d86:0:b0:3b7:8fc4:2f4c with SMTP id ffacd0b85a97d-3b78fc430e0mr118658f8f.1.1753731501747;
        Mon, 28 Jul 2025 12:38:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b77db8a944sm8455273f8f.52.2025.07.28.12.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 12:38:21 -0700 (PDT)
Date: Mon, 28 Jul 2025 20:38:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Peter Zijlstra
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
Subject: Re: [PATCHv9 02/16] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <20250728203809.7bebf01c@pumpkin>
In-Reply-To: <98BE7799-DA6C-4267-9E03-E6F68263D250@zytor.com>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
	<20250707080317.3791624-3-kirill.shutemov@linux.intel.com>
	<20250728201137.113d0f45@pumpkin>
	<98BE7799-DA6C-4267-9E03-E6F68263D250@zytor.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 12:28:33 -0700
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On July 28, 2025 12:11:37 PM PDT, David Laight <david.laight.linux@gmail.com> wrote:
> >On Mon,  7 Jul 2025 11:03:02 +0300
> >"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> >  
> >> From: Sohil Mehta <sohil.mehta@intel.com>
> >> 
> >> For patching, the kernel initializes a temporary mm area in the lower
> >> half of the address range. See commit 4fc19708b165 ("x86/alternatives:
> >> Initialize temporary mm for patching").
> >> 
> >> Disable LASS enforcement during patching to avoid triggering a #GP
> >> fault.
> >> 
> >> The objtool warns due to a call to a non-allowed function that exists
> >> outside of the stac/clac guard, or references to any function with a
> >> dynamic function pointer inside the guard. See the Objtool warnings
> >> section #9 in the document tools/objtool/Documentation/objtool.txt.
> >> 
> >> Considering that patching is usually small, replace the memcpy() and
> >> memset() functions in the text poking functions with their open coded
> >> versions.  
> >...
> >
> >Or just write a byte copy loop in C with (eg) barrier() inside it
> >to stop gcc converting it to memcpy().
> >
> >	David  
> 
> Great. It's rep movsb without any of the performance.

And without the massive setup overhead that dominates short copies.
Given the rest of the code I'm sure a byte copy loop won't make
any difference to the overall performance.

	David

