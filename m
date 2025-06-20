Return-Path: <linux-efi+bounces-3880-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFD9AE219D
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 19:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C5A4C14FD
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 17:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF262E6133;
	Fri, 20 Jun 2025 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ob4hsDJj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610971DC075;
	Fri, 20 Jun 2025 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750442030; cv=none; b=SmPH2tRAXSzht6RfLW+jEwTe4pKxSgiD2v7Mi2EuXbA4iPct9p9xWX6Q6kg+MkMx4RdUZJY3tc/WxNwfL0T28WVmgvDRuxHuYY3Mh2arTBWlDm1UdZxW312FIcqsd6XQRv9BB0rVsBI2mJYJnFLJKF4m1ZSFo3aqDYmJt8Nl8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750442030; c=relaxed/simple;
	bh=3r1V8Z/Gp2YPWtaOdAZ8uyXjTfYNapOfK8bg7Thxlvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a34oyMIEH1mLYUaEPuUceojnpKRzghrkVdIGGLfOn+cuO26Funfru1JLF5jZLXrblvbDtDzUVn6o1Rysh74aCREeeBkaQZOSZLNYNtL7OWOGaNwkOxyxV5ioAAh96aFxqUHS5mDhpkwPj9pw19xk+oepTEXHsRn2sfd4m/eO6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ob4hsDJj; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750442029; x=1781978029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3r1V8Z/Gp2YPWtaOdAZ8uyXjTfYNapOfK8bg7Thxlvg=;
  b=Ob4hsDJjUZ8nkIPf24jtU7O2ACBOA3Mia5VXzNbOqElXwbUuukOMRgK0
   6Sh31tGxZ7XYw5HbAdfq5wOJ7Kh5HR29CQrxjhH2MbOvza1iXuw7JdJ0W
   YJGYeWGsUj+965FiyYi/1WVKR6G6B9968gxKbyoqWDan3adw4/IMej+z0
   LP2uZe1o6AORwYZ9VmdA3tNEeuVP2xGiMtGMhiZcPW5SAnKbVo0MAgP4o
   FiYoElUSE6BnhTEapaX9YU/wDiHr3T5YElzeAG6fhlsBgXpIzPn5vKVId
   EjY9R2V1a8qcdZZgQvDy6Pi/r2jI0vWf4OwXdTahKFNiC1ek4H6x0gF73
   A==;
X-CSE-ConnectionGUID: TSh0ciRdQpWqqzBXX7Si5Q==
X-CSE-MsgGUID: JTNBTPPZQAilPrl6eahKKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="75246061"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="75246061"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 10:53:48 -0700
X-CSE-ConnectionGUID: EmxsnnN8QjKmRLdf6pTwig==
X-CSE-MsgGUID: c3uRYrctSaq6g3uPxc3LyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="151111509"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 20 Jun 2025 10:53:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 97CC8109; Fri, 20 Jun 2025 20:53:36 +0300 (EEST)
Date: Fri, 20 Jun 2025 20:53:36 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Xin Li <xin@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>, 
	Ingo Molnar <mingo@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCHv6 13/16] x86/traps: Handle LASS thrown #SS
Message-ID: <p6nykttpomxtjw4py65ozxpuirviubhmhqu5paa75mnzk75kck@jb43wyhf5sn3>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-14-kirill.shutemov@linux.intel.com>
 <08758240-fd38-4d90-9efa-354274e8bb8e@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08758240-fd38-4d90-9efa-354274e8bb8e@zytor.com>

On Fri, Jun 20, 2025 at 08:20:12AM -0700, Xin Li wrote:
> On 6/20/2025 6:53 AM, Kirill A. Shutemov wrote:
> > From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > 
> > LASS throws a #GP for any violations except for stack register accesses,
> > in which case it throws a #SS instead. Handle this similarly to how other
> > LASS violations are handled.
> > 
> > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   arch/x86/kernel/traps.c | 34 ++++++++++++++++++++++++++++------
> >   1 file changed, 28 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 0f558d3369a3..bd8f7e72b238 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -866,6 +860,34 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> >   	cond_local_irq_disable(regs);
> >   }
> > +DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
> > +{
> > +	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
> > +		enum kernel_gp_hint hint = GP_NO_HINT;
> > +		unsigned long gp_addr;
> > +
> > +		if (user_mode(regs)) {
> > +			gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, GPFSTR);
> > +			return;
> > +		}
> 
> Please add the following FRED code:
> 
> 		if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> 		    fixup_exception(regs, X86_TRAP_SS, error_code, 0))
> 			return;
> 
> Because the following FRED fixup
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5105e7687ad3dffde77f6e4393b5530e83d672dc
> 
> is otherwise skipped, it is interpreted as a LASS #SS before reaching
> the FRED fixup (which is indeed a userspace fault but triggered from
> a specific kernel IP as described in the commit changelog).
> 
> The x86 selftest sigreturn_64 fails w/o the above fix.

Okay, will do.

> > +
> > +		hint = get_kernel_gp_address(regs, &gp_addr);
> > +		if (hint != GP_NO_HINT) {
> > +			printk(GPFSTR ", %s 0x%lx", kernel_gp_hint_help[hint],
> 
> GPFSTR?
> 
> #define GPFSTR "general protection fault"
> 
> It is misleading here, you need something like SSFSTR which tells
> exactly which exception caused it.

Yep, thanks for catching that!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

