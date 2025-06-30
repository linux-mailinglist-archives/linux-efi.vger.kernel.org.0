Return-Path: <linux-efi+bounces-4048-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A94AED908
	for <lists+linux-efi@lfdr.de>; Mon, 30 Jun 2025 11:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0765C175015
	for <lists+linux-efi@lfdr.de>; Mon, 30 Jun 2025 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1EE222585;
	Mon, 30 Jun 2025 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXhXt573"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC2C23AB8D;
	Mon, 30 Jun 2025 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751277017; cv=none; b=B56a89g46dW+rgbuGHiLdNMCwsF8oS5vAtBv+/FUi69TpcqqwniPC8m8vVziruFG0GDman83Bo9dCO2pnXCEFYJPde9oppNQvn12Bb/ROLF0AS0TyqKUX5wkly3atdAAMKCUFXMuO+8xaCS2v2a9aOWJT3hqPYbHo4uHS8FSK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751277017; c=relaxed/simple;
	bh=fn460stx93A77T5TqdGbNur4jkXpBAZ87mWiNl6p0wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPRXBseUN6gL0VJyE4RPQl+7Ybxd/ooXI8qiSWDFhPY1p6Mp2sFHYMTxvZQi63mLO9ZHqpv6WoKkSJXdO43d4PzXlI6zvUFDwOJE2NoxOkKAp7UUinqNYtYp/FUzIxg0mTJkogbSpwThtUtKfFbaAQ4NlyZiXuyvMrLxs7aj43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXhXt573; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751277016; x=1782813016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fn460stx93A77T5TqdGbNur4jkXpBAZ87mWiNl6p0wI=;
  b=LXhXt573ZtM7ZUGScnT+rPT47bBBaOZjxob5lAgZYoKnvvy38cEwWmiM
   RpVSX0D6k+aUeyrTrjh/hjqif8c1bSqaSaIK/0zbZbhZfPDwr1NbGfU9y
   AGRHBj8fX7e7GlX1t9JT4mRsKCUMjY9qsmm9wKEy4Neu+fODxm1dk6wlh
   jJTXvlnoFosgGCqse0x942amneLL0VEnXNhExlvPv3dZ8owIq4/2FE3n0
   biO/hKFI8+ohzAuKYw76Pb0F6HrfeJfWeb4m5U47LWEpELU8AMYWrBIxf
   Ah5yyqV2JFGX2SBDBK/fFlrtWZ0K6Nyy7QYDLbvYCD8y03q3iZRcI7lBw
   Q==;
X-CSE-ConnectionGUID: UP1kSkM0RBemUfoxf5H00A==
X-CSE-MsgGUID: px5sdeohT2qhlKx03nxi9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="57176093"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="57176093"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 02:50:15 -0700
X-CSE-ConnectionGUID: gVyBjp6QTu+7QkD3gRl1qQ==
X-CSE-MsgGUID: 5n68rlX2S2GVeR4e7LSPsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="158922500"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 30 Jun 2025 02:50:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 1AC2D1FE; Mon, 30 Jun 2025 12:50:03 +0300 (EEST)
Date: Mon, 30 Jun 2025 12:50:02 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
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
Subject: Re: [PATCHv7 13/16] x86/traps: Handle LASS thrown #SS
Message-ID: <rzexbyswvsulo75edyffqgigtckiutwcx4jxbnwhynhm6nwc6l@tocxnm74fshi>
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
 <20250625125112.3943745-15-kirill.shutemov@linux.intel.com>
 <c704ea9a-8c73-46c2-80d1-f7b93a221908@zytor.com>
 <lvutnc4et6r4a5eayoweb5butpspvop2m2pjioiudjwa3mkpo7@drcsdchj66w5>
 <20250630093027.38cd1ebc@pumpkin>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630093027.38cd1ebc@pumpkin>

On Mon, Jun 30, 2025 at 09:30:27AM +0100, David Laight wrote:
> On Fri, 27 Jun 2025 13:31:44 +0300
> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> 
> > On Thu, Jun 26, 2025 at 10:57:47AM -0700, Xin Li wrote:
> > > On 6/25/2025 5:51 AM, Kirill A. Shutemov wrote:  
> > > > LASS throws a #GP for any violations except for stack register accesses,
> > > > in which case it throws a #SS instead. Handle this similarly to how other
> > > > LASS violations are handled.
> > > > 
> > > > In case of FRED, before handling #SS as LASS violation, kernel has to
> > > > check if there's a fixup for the exception. It can address #SS due to
> > > > invalid user context on ERETU[1]. See 5105e7687ad3 ("x86/fred: Fixup  
> > > 
> > > Forgot to put the link to [1]?  Maybe just remove "[1]"?  
> > 
> > I will add the link. It is important context.
> 
> Will the link still be valid in 5 years time when someone
> is looking back at the changes?

Re-reading the commit message I wrote, it is obvious that I reconsidered
putting the link and referenced commit instead.

I will drop [1];

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

