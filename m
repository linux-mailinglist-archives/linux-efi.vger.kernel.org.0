Return-Path: <linux-efi+bounces-4132-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBD3AFA3FB
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 11:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4B0A7A9868
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 09:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6855A1EA7C4;
	Sun,  6 Jul 2025 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyIFBnFQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66401E9919;
	Sun,  6 Jul 2025 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751793740; cv=none; b=lzGj9DILl33YEkwEOS9M68M+bYSGoP8hRf6fEpoHPMQ0dVz7Q/lCfhIEbBc24aLiLmfZyv+WNFaibmfIGm0HQGY6uHmRTfcrxmwgvJOtdxuv1FCzvD6SC9PDOPC9Vqn0eU4tJN621b+YCR1Li7pwrmr1RcoGBcB+D2q6novdPOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751793740; c=relaxed/simple;
	bh=R8WY5LnC71QUM9WkLu00Q23TO+cZs7clzgEGxmiFpd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJcweqzm8S4bmQ0L0QRrTYZI5HPi1SX8gn8T2toPA+EBuIZV0wfIvfiCPtAt5Lw1uHdaDNh30ek05oN4zK6finBlmwco5hhM5nGIZLxOZnz58ximj08qqIa1HN94sX3ORQKsxTcRCeNqrfEAqeM26ihJUyUPz1rfc4zTAQguAhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyIFBnFQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cfb79177so11631345e9.0;
        Sun, 06 Jul 2025 02:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751793737; x=1752398537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3am1YwKRHmoKxmbDLF2S7QLxv9dWwL5mPkPdSFFbqg=;
        b=dyIFBnFQSkJIPARulEKiMOqSF+hHYBeL6aVayEskLh6jhjGKPBJfXJQDfEljwJPf3n
         B5eSdW8iu3DVMJwMRddWEiwZCzZ30iIWITANYdDSKvYl0Id/UtP57OaAyba7DaMoGCKC
         mVTfd0v4qeiH2i+rbz/9TORDznAHxuJ1yhnf5GoPf/xxSaPyv6Dd5FyJMlNDlsRY5N3S
         bp+Cz8mH/eBavYOvYp1/y3TavpahDXkapcfrXR4tcwB8o46bYckw73iDQ3BfTBMxZ+hB
         SdeNthe7DKKcdQOAz7RkN8aG21ZXnDg3AJwcv/TsWCBQTyX9M+XmAK3Rcg1NLyiNLhs3
         WgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751793737; x=1752398537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3am1YwKRHmoKxmbDLF2S7QLxv9dWwL5mPkPdSFFbqg=;
        b=tNLpObkegEF602dmb9c+JAvyN0g2r8Ks2wR9vf+4VDXhua0gCYfYvppB8YdfP79yzx
         Hs3mSecFkqVS69zCw4AxnjU1QZQp0Dwi5HLhEWYfl6ayU8DSUCJvUX1SkN6QQdRjan5F
         HTbIXUsWBcxWoXlrbdpJuKah1aetCn8GNpBrYIokeaUoJYkfbr8Lyf0WocBE8EX/QZI8
         safINvkHynnGPy5VsGADS5TZKkPhy1SMglCVNXhlwZ2+6Hv7h4RLPJO1RtjoEx+fbDGB
         +lGjK4nCXxswYYn7XzOyWmOVlRQ11WZfaTQlSkgervqCZtsqTFEmIamm/P/uev4UrC76
         uHzg==
X-Forwarded-Encrypted: i=1; AJvYcCUpkgha8joefDBb4uzbOpjauEjXjtmvMQK/32uLwefoXOo37HqtwvdeH6EUa3vKANJNOKqQtc12QhqX@vger.kernel.org, AJvYcCVuLbE2czg2AOWG91lOpvNUsD/X2+3EX4oWJIvFt0ajBmoDPE5I+c+W0A3WJgAWJZH0H+F+oUduO2RqlZWH@vger.kernel.org, AJvYcCWKUz4ggOqGR7HNIur4kly8T6uRIexvqpCSQyuLT+lGqb8fZvINJaxEObKLxjZSpxmyY0h6ADkDzN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9XHgmA9T7UlYJc+Iihee5uVVUwv684dmnknyiXdxjUoOli6qx
	u1ctVwo7QjpoHyKO/CfvzxFXORF3r3GVdakkJH9UvVIBD+E0GmJweDdz
X-Gm-Gg: ASbGncsyL80MWoH08Rh1bRfE5uS09c+1tPZCQ3sjoNhVaQ0iFKWt7ceAdvZoEfpGL/G
	etNzRn4XY1hqJWZo8GfPG17cwcJtBlCxAdwLOHLAYPowin6arWSoUk4RMo5xgRL2lItXiGa//2y
	G10eobip/Z9Q1GvFDfP398krJ0J08n1TKQxzdTSc2itm5Dah4NMNvp8qb+wkZqNqLK01cw9aziq
	/wDrSia4FJ6VRGethmLL5WoXVBztvTnAcq3XUekkhqYaEQkpp+JI4BWe+PmR+uTvx3Uon2N19m0
	+gZUe9Yol3ucAKjIQbBYz2Sh5hOKn/pOGEPZPEFfgeajKVCpxxpVJ16SJbP7SLKWwsfodPuNPEI
	mXV1HQsGVEuAPqcxcdE+wAnYP5euq
X-Google-Smtp-Source: AGHT+IEVwZsmFeJW6bRGYTrQU07475HhM5KVyiCb1XYh0+njq/Er/htdLi/iXsSzv2IQX8CWTP5tvA==
X-Received: by 2002:a05:600c:6096:b0:445:49e:796b with SMTP id 5b1f17b1804b1-454c0a8a0a8mr23528185e9.17.1751793736774;
        Sun, 06 Jul 2025 02:22:16 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b168664bsm78214565e9.20.2025.07.06.02.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 02:22:16 -0700 (PDT)
Date: Sun, 6 Jul 2025 10:22:13 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
 <ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
 <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
 <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
 <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
 <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, Sandipan
 Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, Rick
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
Subject: Re: [PATCHv8 14/17] x86/traps: Handle LASS thrown #SS
Message-ID: <20250706102213.4ab365d7@pumpkin>
In-Reply-To: <4DE45AFD-C1E0-4FB8-BE01-44A72C5C6E1E@zytor.com>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
	<20250701095849.2360685-15-kirill.shutemov@linux.intel.com>
	<95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com>
	<4DE45AFD-C1E0-4FB8-BE01-44A72C5C6E1E@zytor.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Jul 2025 19:06:10 -0700
"H. Peter Anvin" <hpa@zytor.com> wrote:
...
> Note: for a FRED system, ERETU can generate #SS for a non-canonical user space
> RSP even in the absence of LASS, so if that is not currently handled that is an active bug.

Is that a fault in kernel space, or a fault in user space. 

Some of the traps for 'iret' happen after the transition to user space,
so the kernel doesn't have to handle them as special cases.
(I simplified (and fixed) one version of that code.)

	David


