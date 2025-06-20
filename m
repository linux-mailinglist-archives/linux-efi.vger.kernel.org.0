Return-Path: <linux-efi+bounces-3883-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDD7AE2236
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 20:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92ABB1632CC
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 18:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503BB21FF51;
	Fri, 20 Jun 2025 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QaYmmYJ1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB1D1E835D;
	Fri, 20 Jun 2025 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750444251; cv=none; b=iSwnxKjFNu+0phZoc1/tJ96dp13s4V5BJLqKmR+h3xSsDfWxxyLc6B4Y2yixqW5V6dobylmj/Fy0wZoh2D7NEC88/amPeTPEJlQ/hiNsCqAWX5OH5GN85tgW1hyyetIF0RckPuM9PqT1IRgf8JR5m33IFj70E/b6sp0L8RhUMLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750444251; c=relaxed/simple;
	bh=K7Y/oWXq0aqoZQgybeVaMPCKLk+0xYO3ucR0VKjjHqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdAWb0DxqKczOp1jYz+2xr9gDyCPHXDnx3dtDUaLrY7HjE+pN85Gn0Kl0OVlvC7JAu05iRfem51xnZ9AMMxR2djHmATEM/HxkaKYRRXJyx8TiIjpBsV9wjrtKrjnA2O5mtr11qNYAWmxSCn2FxSYdM7siBrwrxuBKTOt1VYbZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QaYmmYJ1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1DFD540E019D;
	Fri, 20 Jun 2025 18:30:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jRf7-SZaFYZz; Fri, 20 Jun 2025 18:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750444241; bh=m68liJooLhlG7wL7oAtHDxeahc+z03MHlUQPUJGShk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QaYmmYJ13ZaVCMtrMyehdjWorlcAO+/xFuLeFvWKtBciydtISQzw5YLxfbvBeJ/Ga
	 CiizMn/LD1OXXu/0hq4bVNe8I5ylle279+5lRiGn1quKKdqExHFSOGJlXQZ9UlY2fN
	 +AN3FEQdF98eUGxJ3NnEgwV7nXiGyFX7p5/Kj2wMi9QmoN1DO3/kcMTrjd3JN3J/U4
	 osb6/CB/JXfcRIEoOEJP2Ad90RQ1uHl5rmt7bS8k/Szfv8GlTHX6vrBMnbKI+UqPrB
	 YLTv7iNJ8P4hfuFPk/4SVFFvjrmhsFSHwRj0SoRD1xV15lJfBV2lN+py1nnqMxxMCP
	 XBdd8IQD9Ma0pWs+02/R+Qplxm3u+sue88giJsDDa1a8UMDNfZuj0RIRffaAzuSuiP
	 qS/KmFI6h5J2TMH8OxhX0XTFg8mpjKxlSdenbBEMaAoFVhFhA9rMu+Hyq6H2WCrG5h
	 tHZP/Q9bX/STS5A0+jRKdLrphcAHorNAep82OJHaONmsBOb5XSV4slFqrdosUKs29Q
	 /1VwwTJikNkhk7Yxyt5dIBdl7nq8Dq4xlLah3UQYvw4hqHHAXdTukkrsOvQqr3mBvI
	 MjSWW9mT+f/DPscsJKf9OK0bi3Hr6VwN0qPJe4+B5b/0MmCKi9GK+b2l/SpsBL9sAF
	 kRxsQYDSUT9ZNVhWrmdqVs1g=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0674540E00DA;
	Fri, 20 Jun 2025 18:29:49 +0000 (UTC)
Date: Fri, 20 Jun 2025 20:29:43 +0200
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
Message-ID: <20250620182943.GDaFWolxhwogB2tTxb@fat_crate.local>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <20250620163504.GCaFWNuI-8QFqAM0yI@fat_crate.local>
 <6y2iqv6c2idn7yebaec7tyhzl5zcsrwqq4lcsokumlqeophzaf@ljnmxorblgcj>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6y2iqv6c2idn7yebaec7tyhzl5zcsrwqq4lcsokumlqeophzaf@ljnmxorblgcj>

On Fri, Jun 20, 2025 at 08:33:36PM +0300, Kirill A. Shutemov wrote:
> What is current policy around it ?

Documentation/arch/x86/cpuinfo.rst

> I think it is useful to advertise security features in cpuinfo.

Because who's going to consume them?

Don't get me wrong - I am trying to see whether the whole use case for this is
well thought out. Because it becomes an ABI.

But if no one is going to use it, why bother?

Arguably, for this thing the argument would be - as it is put in that file
above:

"So, the current use of /proc/cpuinfo is to show features which the
kernel has *enabled* and *supports*."

as it has been enabled by machinery.

So that's ok. I'm just making sure we're on the same page and you're not
aiming at something completely different with this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

