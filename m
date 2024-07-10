Return-Path: <linux-efi+bounces-1407-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A57E92D761
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 19:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE97B209B1
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 17:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFC4194A6E;
	Wed, 10 Jul 2024 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UNR7ijrZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697EB192483;
	Wed, 10 Jul 2024 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632128; cv=none; b=HJNR9Hq//Gaq4z2pR3C6/gd87u13bye9oUuzNcmKOpKauv7Ugr+5e7Be73AzJCt+bI1CkOz0beTC5ZdmHM/5QCmryEL2+UNKSmvPb0CEexWJimF54gzeHi9IP7+YOkBPJMe3Vk4cP8HNXHu6MVLewly1FSV0zk37D0ccU6g1oiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632128; c=relaxed/simple;
	bh=GKBilYZzZSvzFe9eBoJB8C4sbemHoQd1ohpfDLjVs4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUsDgp09x66AQgNXWUEhg2mpbjL+v3tgMbvNrKyU7k6cxhLbSN9o2V2Sd82KTvsd49RNF2o9AN7htY/HhlV0jH3ME6Wqzw4mBJnh1iUHEKGWh2OeM7DQ79ytsd+8eKAq90Y+9SroDkRnIFQZJ8pfHK+PIWNpeoITtV2FsDUJWio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UNR7ijrZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C165940E019C;
	Wed, 10 Jul 2024 17:22:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7OnBJBiEPE2j; Wed, 10 Jul 2024 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720632120; bh=A47f9h7AWiBXL3tI1gj46//myn+haFpb6GR9nxNA+H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UNR7ijrZGmPUBwT5PPtNVjeDFrDBY3dtwNkHSGB5Eq3igELvuNSYjZ3fqCAOCUOXp
	 SEwZvHwD8zudUj8ZCzXUor9FSkKT7jvtFANhcory0A6HYJqt7yFWwnozNXkTqiigMj
	 OWEVveZn7dV0DR9C4zqENdC3GzOpdFmM+93n9Q+SIbc7vNZ3DZcIu9Hvf1xxGRuZIT
	 d/Q8cKEn/nxBKUY/vBLK47O50Ei+HXzhl2EB7dc1RPRc94oeJ9d0TEf9VsKfF2e89p
	 j2R+YrX6bk94cPrCjTZPsVUrGQyleAxh/CqUHXxLnIitp1UDR5Sjbs43dvdIsdxZRY
	 0APwEgSdIHcXg0p0pB+jra/4vSZNfWLGI5Bz5+ZRXTS20rAtQTil146NOdZPbLaRTE
	 jb1XYrmgrFbnOuTU2y8KrEOO67dE4lVCEYersZOm5VV923UdUq95epZBwnXqVfiYMj
	 ctSWKh+V4eaW0UQST7NYmlkAZ8E6mTrflawIK3kEw9hihr+W3p0BsWqlKyN5kL7PG+
	 1szhiojgCZiNmtXA1KPqp3JeXk780H6ChzsVi9C8b5nEBMfQPw/gbK2E4Hh2M+gWI+
	 aITqkbqFeEGJoJaCGJ45TJVEtFEdbAiaE5s/asUtV2XmYOSOr1jY78pHPag9A0fm4Z
	 oizOcgxSMHzz5aAGztCobSP8=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7AC6240E019D;
	Wed, 10 Jul 2024 17:21:08 +0000 (UTC)
Date: Wed, 10 Jul 2024 19:21:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
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
	Tony Luck <tony.luck@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Breno Leitao <leitao@debian.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Yian Chen <yian.chen@intel.com>,
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
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 05/16] x86/cpu: Remove redundant comment during
 feature setup
Message-ID: <20240710172107.GHZo7DA3pQ1Mkj8gy7@fat_crate.local>
References: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
 <20240710160655.3402786-6-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240710160655.3402786-6-alexander.shishkin@linux.intel.com>

On Wed, Jul 10, 2024 at 07:06:41PM +0300, Alexander Shishkin wrote:
> From: Sohil Mehta <sohil.mehta@intel.com>
> 
> The code below the comment is self explanatory. Instead of updating the
> comment with the newly added LASS feature, it is better to just remove
> it.
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/common.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index dcf61a66e462..33a76256a6f5 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1841,7 +1841,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>  	/* Disable the PN if appropriate */
>  	squash_the_stupid_serial_number(c);
>  
> -	/* Set up SMEP/SMAP/UMIP */
>  	setup_smep(c);
>  	setup_smap(c);
>  	setup_umip(c);
> -- 

A separate patch just for that?! You're kidding, right?

Just merge it with the previous one.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

