Return-Path: <linux-efi+bounces-4019-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2E0AEA258
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 17:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C583ADE2A
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFAF2E718D;
	Thu, 26 Jun 2025 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hf8qa8VF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6842EB5A4;
	Thu, 26 Jun 2025 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951187; cv=none; b=Bd6QMANLklSEigt4U9QaP9mHLFw1ZGlovF63l67lGDhrthKglRj5kv/QpfR/J7X3kPqmrj0glPAQf3WxGXBeCD4R/6Fpw/GrPZxCJ/WuMZmW5m9LHFsO5V5QjzQORFU9gr//Jaapq929SFgqeqTKodV7U+gv667Q69+k0bYuq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951187; c=relaxed/simple;
	bh=o51B7iNjd+U5WK/gVXXyYCMg+WKgROXXkbE4f+qmvug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKdgO//VFoW+kuVdeJnKJ7Wn81EM6YSfGQ8vq8FeKXONNBeEwzSLq//TBYB9S0r4oI/eEBW85aOMOTlCaKR/h9QazZfQ7TASVnB+F8QDaczLErL6rMCxwO90e1y8r2NtqWI6XltV35ZifkovGGuKRdNPXK4yKb/xYfrHykAGpy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hf8qa8VF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 462C940E0198;
	Thu, 26 Jun 2025 15:19:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PqW44RiQH6Jz; Thu, 26 Jun 2025 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750951175; bh=aEy0xE6/1EEIexhyZkFY9aUxJdMhziDSaDkTlnv5w6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hf8qa8VF8orYwOKOUtgJkEYmsjkfQbalTSkc7wTAYA2jJ/CzAYCPQlNROgWOEUfMw
	 VoeBHB5cEOMQDXEeKlqlakJFcsF8PK+GVoXJ0V7783kMDwKpbmq16/OFswms2stkHY
	 UpWy6FuRtYdBacDNGp3lNp+ddT5PqRkYVrX4nbhXbQ3gOvG1hoKC5tlw2mFZfhtvsH
	 NzZIW58fmTp/A0AmCkZnv66tlzfUNR+bhj7hErzYxRbs/IIOt8aDey6Klcr+AaEC8t
	 qAGQ40bce3WW/qTrPFphAV1ohLkxc13JTAT5pGZrj3E+TNdmn5PbgmNw79tv/qcTO8
	 miE8es+ZbHY1nsfYEFJHgk9v24neXCjLlg0ceLMxWIUnrBgeYRdnTSUM0/oW92tArv
	 kSJvVYarRjwBM6zS8jooty0pw0N845TGyAB0F0l8J/Yq0Vo0hox3/dE8WiH2JQ80JT
	 fmARjkYr+ofaimfaXPYo2VPZ4haf+Gg9y08Y45QhyJnHH9085m/BN2a1KzNAgkbjY+
	 80SGmS9MENlf+p0WZ4MNdEicxFGxV88gidcNae0lvaCoPtfVDC5GiAMURROJEmkfsW
	 p7K3WRFb8W1qGEZOoM8CusnNriv0PQWtyqixF67QK4Pi0AyZdp7VxZvR0spEk05bVC
	 O2Vl1I4mvMThn66Ll3gWP0a8=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E57C40E0169;
	Thu, 26 Jun 2025 15:18:43 +0000 (UTC)
Date: Thu, 26 Jun 2025 17:18:37 +0200
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
Message-ID: <20250626151837.GFaF1kzfLtesXLqaAQ@fat_crate.local>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <20250620163504.GCaFWNuI-8QFqAM0yI@fat_crate.local>
 <6y2iqv6c2idn7yebaec7tyhzl5zcsrwqq4lcsokumlqeophzaf@ljnmxorblgcj>
 <20250620182943.GDaFWolxhwogB2tTxb@fat_crate.local>
 <tmd5llufitosphzhiik2tlemjuwyi7xkcjlhbqhibrgjjhsqcj@b3xtgub42p45>
 <20250623102105.GCaFkqkatFSbyl1YeN@fat_crate.local>
 <ztkgdk72p2z3q6z4hslfg4gj6pejirh7cnssxhd7u72mo4enn4@viqrwrycderf>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ztkgdk72p2z3q6z4hslfg4gj6pejirh7cnssxhd7u72mo4enn4@viqrwrycderf>

On Mon, Jun 23, 2025 at 04:42:41PM +0300, Kirill A. Shutemov wrote:
> Due to SLAM, we decided to postpone LAM enabling, until LASS is landed.
> 
> I am not sure if we want to add static
> /sys/devices/system/cpu/vulnerabilities/slam with "Mitigation: LASS".
> 
> There might be other yet-to-be-discovered speculative attacks that LASS
> mitigates. Security features have to visible to userspace independently of
> known vulnerabilities.

... and the fact that a vuln is being mitigated by stating that in
/sys/devices/system/cpu/vulnerabilities/ needs to happen too.

I'm not talking about LAM enablement - I'm talking about adding a

SPECTRE_V1_MITIGATION_LASS

and setting that when X86_FEATURE_LASS is set so that luserspace gets told
that

"Spectre V1 : Mitigation: LASS"

or so.

Makes more sense?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

