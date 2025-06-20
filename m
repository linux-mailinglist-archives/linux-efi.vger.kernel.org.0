Return-Path: <linux-efi+bounces-3874-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F15AE202B
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 18:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED3B1C21B8F
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 16:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF6E2D4B6F;
	Fri, 20 Jun 2025 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HETrpudq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F6253F16;
	Fri, 20 Jun 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750437375; cv=none; b=gib8dkCwKtHFmrAgepAc9dN0T3S8MuqnPq6/snxAu/u/o+tuNSKqZPCE9Y/Ov8OsIURdBDqZ5c6iLR9wfjL0vKl68nAbGjUaDVnzPe9vDMQatt2kdhWYEYOiiqR/6Snq/2ybGTDN5CIcbWUeMyH5HDJw6/N6cjc0z9Kfs2PJLek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750437375; c=relaxed/simple;
	bh=0JBK0kjtuXTJbfe/j75WPFJur2USdSDEx+6UkmtIXHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sz6uFLiQyjPfAzCFa1J8RxBhDZhnQTPTXZDaWgMh0eesO1seSYfiTs0MlZmMk881/rL1SZ4LSGuFdFfLfbUF/+q41V/VYKV9raKTiJ/6YV26w51GGWPRt4ILHu2hRJXFnbCTHlLFgLRL2tL6of5s/xgOft8smw05XdpijjW0r0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HETrpudq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B4B5F40E01A0;
	Fri, 20 Jun 2025 16:36:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DrXHxtYlXPrM; Fri, 20 Jun 2025 16:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750437362; bh=0gF6sK4Cybkep6s2rCZ6sHaCZMCg5iNoRw7AXjmPKJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HETrpudqyEyQ6xokIZsnaHY2t+ngqKBbk6kjssgaJEns3kaWR4iy3Hqwdrsz0K/Jo
	 UtdNpfnlNK31eIIUkjiEe/4HPYYSXgmf2qHbHFP2gf9eQ9gtH2XIS9Axwmf9+iCpCk
	 lUsry8NgLUkZE33UeOSLXg5VXYsqqom4rbKymGbEl5Gwvi65rTKeC+/Y3zBdKbcPMI
	 Od/OyWAZFxxTNSdE5Z+HgWlimIxbnFc7AQ49gC+/CGjEDtf1qXeYiTFYrM5E6L1wcw
	 cwTd/8g18ne7eDMKk2jWM2jcxppk2GvIYpikLoGHiqvpsUGnVChUKI9CJpGP1VEZZ/
	 +eYzFoClsJ/QjNX6TPM3nv5Vsx0hroz/5T/QWOkOEUiAWVoX98F3hiQtsFnZfpNASd
	 BRB1M0dgBqN+EtuIgkeyBBG6VRHBpegI9FpfjrzMOYDJ+zeqf2HcAZrsxoWqUxDRmC
	 bFgykmkREk97/VvYpmRXQdHVotDhmWyiB8585U5UWJqk1RIrSRz3TMd4EfCOV7q/P5
	 chbkmDQ1eJMp+S2IdxwjzLa0V8ng4Xus8Xe/QE4SczEGkCxFOyyByEixZjFO+YHl7m
	 mB9Vxgt5iIQE4UDNvJifYpPJSYmOrPjsfpayQ1681Vr+rAk7u0Zd0qgkWLMRQAwtKK
	 fglZQsb/zCyOslnoQDRuaXnM=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 41DB640E0184;
	Fri, 20 Jun 2025 16:35:10 +0000 (UTC)
Date: Fri, 20 Jun 2025 18:35:04 +0200
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
Message-ID: <20250620163504.GCaFWNuI-8QFqAM0yI@fat_crate.local>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>

On Fri, Jun 20, 2025 at 04:53:09PM +0300, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index ee176236c2be..4473a6f7800b 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -313,6 +313,7 @@
>  #define X86_FEATURE_SM4			(12*32+ 2) /* SM4 instructions */
>  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* "avx_vnni" AVX VNNI instructions */
>  #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* "avx512_bf16" AVX512 BFLOAT16 instructions */
> +#define X86_FEATURE_LASS		(12*32+ 6) /* "lass" Linear Address Space Separation */

This needs to be in /proc/cpuinfo because...?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

