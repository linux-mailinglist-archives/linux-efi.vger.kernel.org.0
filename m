Return-Path: <linux-efi+bounces-3908-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2388BAE3C21
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 12:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A724516B9D5
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971C523958A;
	Mon, 23 Jun 2025 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HbQHWs/l"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84380239E8A;
	Mon, 23 Jun 2025 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674139; cv=none; b=h7GjhgEas2p/Hi+U1a44coAeMcrYeZcCZieT+Zs2caEcx8q9bYO2G2oOpKeAVE/Ptsr14wgFHLi4VYjKQAPyH2ZGsD3x+Hucw61hd2HugYqJR+6PGNpIG5hZPHgOCiVOq0uKP+e669HDaWnpcctjfYQWp8DzbLdgklnUAtNy21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674139; c=relaxed/simple;
	bh=buTQECq2VCKD1ICDi23k4UJqMyJjcgNtn8vEOvOp9lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHkltSuOZ4uPNMOZYpeRb+TRzmY8ONmb9XF4Z+dFp7izlXx0ztNGRWOOVYPbLFAGgzmZtYykN7QYnikgXn9vsIWL8R7J/ZodD5zkrCm4uKTzfek5aiuE89z9bCSKVVEvuxYAdjNOOA1UHBo56YBNq0/cJriVLjJ6Nf22fwVMTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HbQHWs/l; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6633040E019C;
	Mon, 23 Jun 2025 10:22:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id X3JkVTcSfEkT; Mon, 23 Jun 2025 10:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750674123; bh=bit8kbTV4D3YTiOYptKHmiW7XfvgF+MCkFLAQajwdzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HbQHWs/ls8gZcfaGZhZv31VGHo7gwnSdUS6tcGx5ju6fZNZNY7nrxFpxNwZjLu2Oh
	 XS7v/Ipqm7R5Gt4bJzO3gvfy9+TK/sEn4+UhrNhM2kODyyMDVofQNtyFmoAmi4pUvu
	 7Bof7QehSI7Qhhp6CaQIgBS2XBwOGZTRQHy9D3jF2xfNhlFkQphtrKTYysOrLuQlcd
	 5DZW3HGSwtZej+UmB3Q7HkqF9IHfDm5nYLDrrCzgOrASUWqXO4WHmmFy2xLrJ3Y4LB
	 +J9SiPoSMBzFfPPuo/wXAZzC1UYbclUgVJJV0P+iFAo0GOH9d0cw3TvPC97R/QbMe+
	 kfoFG7keh2xnoyupNaPcs/pZm2+ZEEFNlcrVOP07MwYrwdVqsTN++R93nArt0KvMOY
	 ydmbpOUhFb7ypo+ObodoI3r5FfJABlmwGtjNbrPsgjLll9uf+hsXla0XB1hZesRsII
	 0eAaH/vcQNEBsfbaHJk/dOvuGpSfecQHK5l+IqHnYT4NReLwCFb8yC7BhdFDlja4sv
	 s4a0Hdz4FbszW8nVDNGvy3o+s+gonkxnzBWmVYIyqizfNXpKKqigDzu+ChQ2Na2PP+
	 ToXCf8yvBgwWs7vd0+P4AcRe9tvgUAkqSUj/RpcQUgLU50z0XqT5EuTjBVWrshIEVU
	 ciO9IULS86WrYB8ItxO4v1dc=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D19B440E01A0;
	Mon, 23 Jun 2025 10:21:10 +0000 (UTC)
Date: Mon, 23 Jun 2025 12:21:05 +0200
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
Message-ID: <20250623102105.GCaFkqkatFSbyl1YeN@fat_crate.local>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <20250620163504.GCaFWNuI-8QFqAM0yI@fat_crate.local>
 <6y2iqv6c2idn7yebaec7tyhzl5zcsrwqq4lcsokumlqeophzaf@ljnmxorblgcj>
 <20250620182943.GDaFWolxhwogB2tTxb@fat_crate.local>
 <tmd5llufitosphzhiik2tlemjuwyi7xkcjlhbqhibrgjjhsqcj@b3xtgub42p45>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tmd5llufitosphzhiik2tlemjuwyi7xkcjlhbqhibrgjjhsqcj@b3xtgub42p45>

On Mon, Jun 23, 2025 at 11:17:02AM +0300, Kirill A. Shutemov wrote:
> What about this:
> 
> LASS provides protection against a class of speculative attacks, such as
> SLAM[1]. Add the "lass" flag to /proc/cpuinfo to indicate that the feature
> is supported by hardware and enabled by the kernel. This allows userspace
> to determine if the setup is secure against such attacks.

Yeah, thanks.

I'm still not fully on board with userspace determining whether they're
mitigated or not but that's a general problem with our mitigations.

Also, I haven't looked at the patchset yet but I think it should be also
adding code to bugs.c to make all those vulns which it addresses, report that
they're mitigated by LASS now in

grep -r . /sys/devices/system/cpu/vulnerabilities/

output.

Which makes your cpuinfo flag not really needed as we already have a special
method for the mitigations reporting.

But ok, it has gotten kernel enablement so stating so in cpuinfo is ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

