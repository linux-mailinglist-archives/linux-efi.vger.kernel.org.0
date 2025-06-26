Return-Path: <linux-efi+bounces-4021-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50856AEA337
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 18:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACD15655E6
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF691EA7CC;
	Thu, 26 Jun 2025 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UdM9RDU2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A02B8632C;
	Thu, 26 Jun 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750954094; cv=none; b=Dc2Im1kOrE4vlFAiqcv5dgWU39OeJsgOrnzbkJKhEYRLs60UHqGhbRljgDOLSHPBUBWYWj9/V0ZNkZlVXUx2Ie+DJSBPFHW7T1BcWl7JKyte6dLLnMlHEJowAYRcDEmzeRdtYsXe+FC2MjIqBh8zliB4dNjaqWqwUFJEFqtV0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750954094; c=relaxed/simple;
	bh=mVij+1mJYiU7KiC9KgEWv6lkALXa985KRaTH+SKKVmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoXgF9B/d+OHxACpKlAAAwQmyk0bPxB4ShUfW5SswoztmcOyReuAhjPQkPioqaVVMXT0+QzMqgbZsVIVGVMj5NyIEW/criSKeE2opBk660dlQH54GLZ7rIMfTCt/iU+l/HbG03b1OT18C4Ezgly4jtVbgaCku33XVdukjVP0nFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UdM9RDU2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 88D9040E0198;
	Thu, 26 Jun 2025 16:08:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id d27j2SDuiiUA; Thu, 26 Jun 2025 16:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750954085; bh=ey/0N+jDaY5gfxzHF/D4iEvZW+QximCjhExZabKqdbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdM9RDU2kssGc5k5nLmCb5hScgD3tQlB8CPvccj8PdIso8WGYKw/Ki9Wk1obduEYN
	 /puQYSCCX4yOLXrMBqlfCoMK6U288RkmugqH36a5BZBhK0MbsFHPy0hqrfZvFQhZYe
	 rqyoUB/QroIqXFskEXP+R3Im0+LqJ9FKYTUut5C+l3B6QhidXaUB7jgovpLmpdDNMn
	 o3f7vS9y4QtiCw6BMmdOl1abZbCNb1SA2ZYCaJ4OaIgIJ2e8RlRqUFcFuUzF35PmvW
	 7MlRiZgREaAcP42pNtMJWF9hCp6BMR8/7+DrFzQmrMkuEWFs8nTC4fwGQi1dgJn8Zv
	 qayX3l+x0uxwJCjbR139FuPjKAS+Z4CAkt14qEdg125GMvwP0sX6OQcjV9kUKzOHHa
	 OOoibMNVbOFsKwo4hKDub4p8/SNIKaD0bsoEtoJrekqiKJtwKapu3OuO6cr+yq/FG2
	 adyakMEsG6hSRwCKwoXNIMYRJSmOGjQgvVYhhV71/uqFRkHkmHdwYr2XWMt9z8F0u8
	 YH3Wg9/xPTAmLSl3ZNV6x+Kc/Cw2zHzaDofZzVeTK0jO9fgiYvXa9bU0w8Xo4lmkWH
	 0vErkvciaQAW2pbRgLWodPb2lPhNyO+MNOd11UJh/yebytCxlb+2v1GUWaEBDbeQy9
	 jHtDe9M/LqeeJI3rxnXPSGOM=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0804740E00CE;
	Thu, 26 Jun 2025 16:07:13 +0000 (UTC)
Date: Thu, 26 Jun 2025 18:07:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Breno Leitao <leitao@debian.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
	Juergen Gross <jgross@suse.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-mm@kvack.org,
	Yian Chen <yian.chen@intel.com>
Subject: Re: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
Message-ID: <20250626160707.GGaF1wK5tW37P6xt0O@fat_crate.local>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <20250620163504.GCaFWNuI-8QFqAM0yI@fat_crate.local>
 <6y2iqv6c2idn7yebaec7tyhzl5zcsrwqq4lcsokumlqeophzaf@ljnmxorblgcj>
 <20250620182943.GDaFWolxhwogB2tTxb@fat_crate.local>
 <tmd5llufitosphzhiik2tlemjuwyi7xkcjlhbqhibrgjjhsqcj@b3xtgub42p45>
 <20250623102105.GCaFkqkatFSbyl1YeN@fat_crate.local>
 <ztkgdk72p2z3q6z4hslfg4gj6pejirh7cnssxhd7u72mo4enn4@viqrwrycderf>
 <20250626151837.GFaF1kzfLtesXLqaAQ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250626151837.GFaF1kzfLtesXLqaAQ@fat_crate.local>

On Thu, Jun 26, 2025 at 05:18:37PM +0200, Borislav Petkov wrote:
> On Mon, Jun 23, 2025 at 04:42:41PM +0300, Kirill A. Shutemov wrote:
> > Due to SLAM, we decided to postpone LAM enabling, until LASS is landed.
> > 
> > I am not sure if we want to add static
> > /sys/devices/system/cpu/vulnerabilities/slam with "Mitigation: LASS".
> > 
> > There might be other yet-to-be-discovered speculative attacks that LASS
> > mitigates. Security features have to visible to userspace independently of
> > known vulnerabilities.
> 
> ... and the fact that a vuln is being mitigated by stating that in
> /sys/devices/system/cpu/vulnerabilities/ needs to happen too.
> 
> I'm not talking about LAM enablement - I'm talking about adding a
> 
> SPECTRE_V1_MITIGATION_LASS
> 
> and setting that when X86_FEATURE_LASS is set so that luserspace gets told
> that
> 
> "Spectre V1 : Mitigation: LASS"
> 
> or so.
> 
> Makes more sense?

I meant this crap, ofc:

        switch (bug) {
        case X86_BUG_CPU_MELTDOWN:
                if (boot_cpu_has(X86_FEATURE_PTI))
                        return sysfs_emit(buf, "Mitigation: PTI\n");

This should say "Mitigation: LASS" if LASS is enabled...

Which begs the question: how do LASS and PTI interact now?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

