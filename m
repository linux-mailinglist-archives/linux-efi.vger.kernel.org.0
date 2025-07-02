Return-Path: <linux-efi+bounces-4089-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7C3AF5F95
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 19:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710B317D56C
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 17:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0E72FF473;
	Wed,  2 Jul 2025 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Hjeif9o6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ACF2D3745;
	Wed,  2 Jul 2025 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476333; cv=none; b=jstQBhV5EFb84MFNn1Iu5HXXN1/PCcJvujgUlXDB8c1n3PMwjgZRRTi2/5RUU+rgLNlKwT/L6zuzDMte+3t8zlvy2gX7IDgVb2zNcR9MeuufdSySdKAUjAj15rbTdIzMcztvqLMyfNApeIO+YB45yF4l0D1IDT2L/D96P5wDW2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476333; c=relaxed/simple;
	bh=kNg/g5ljt7nOKC7WSIlXA9rxszXt9xhQVAALjJf2IYA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MnZ8vVppVsiuHXQ1esa2BucPlq2sZcQSX6sW8/FgPwQoqY/pq3d3Rrl0bY14XWUgIdBVnNN3pXJl9PgIa69aUaoti9rifAa+qlSNuhdiuPO8XRKyt9+kMRb7BbkWWPJWEf4GIfpT3Y/7V3v1Buj5htoxBi7Wtw78SG3m5nawu+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Hjeif9o6; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 562HB06T746462
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 2 Jul 2025 10:11:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 562HB06T746462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1751476264;
	bh=kNg/g5ljt7nOKC7WSIlXA9rxszXt9xhQVAALjJf2IYA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Hjeif9o6GyWihjdMk5Hc7VaQ50WO7uLC7HzqhSUd/55fcAhpCapeTKEfyaM12BtdP
	 gz0aCmWronOAjPiG8PFmpiKZLUUgms/EB+TluNZQGC0t+htsKumiZnB19lwpJm1lxd
	 XipDNLBIhgIcXXTJhTEB18mKX4956sMHLlVhGHa3qP/+Tiib0YjFSP0gCwRtwX3qxg
	 H7VtggQXp62qQ8Jqi8JutBAsT2f6+dw6WmZeAyLVZxFy8adB2lc64rl5Z9r44BAKHM
	 PNEhOVUevuJ8BvcGjrd/U9juT59nGLE4xRb5fFJw+aOnp+kFWiq/gGuEEHgXZCkIF+
	 GnxnsUEIyZMbQ==
Date: Wed, 02 Jul 2025 10:10:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>,
        Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>,
        Breno Leitao <leitao@debian.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
        Juergen Gross <jgross@suse.com>,
        Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>,
        Eric Biggers <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>,
        Huang Shijie <shijie@os.amperecomputing.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv8 14/17] x86/traps: Handle LASS thrown #SS
User-Agent: K-9 Mail for Android
In-Reply-To: <6vihhfk5z33nrpy53ck2c6tkscjas4fhi6hqorenknbnjo4k3j@ywybd4obx76m>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com> <20250701095849.2360685-15-kirill.shutemov@linux.intel.com> <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com> <4DE45AFD-C1E0-4FB8-BE01-44A72C5C6E1E@zytor.com> <5q2zbkzyjknusd3feqolycqialetqfe52yfyzasnr6zp24pmej@4cg2r2hi4pf2> <DF2E7B41-46C9-4DAC-A671-EC8D6F53F496@zytor.com> <6vihhfk5z33nrpy53ck2c6tkscjas4fhi6hqorenknbnjo4k3j@ywybd4obx76m>
Message-ID: <498F5590-2711-47E9-A58F-CC9EB41D71AA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 2, 2025 7:47:30 AM PDT, "Kirill A=2E Shutemov" <kirill=2Eshutemov@l=
inux=2Eintel=2Ecom> wrote:
>On Wed, Jul 02, 2025 at 07:37:12AM -0700, H=2E Peter Anvin wrote:
>> A LASS violation of any kind in the kernel (unless handled by fixup,
>> including user access fixup) ought to be fatal, correct?
>
>Yes, LASS violation is fatal for !user_mode(regs), unless addressed by
>fixups=2E
>
>For user_mode(regs), emulate_vsyscall_gp() is the notable exception=2E
>

Note also that for FRED we can have separate kernel and user space paths b=
asically "for free"=2E I'm not sure if we do that yet (if the infrastructur=
e is there), but we could=2E=20

Not that it matters for this case=2E This is a slow path=2E

