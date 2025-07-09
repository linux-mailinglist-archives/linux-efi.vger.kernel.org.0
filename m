Return-Path: <linux-efi+bounces-4244-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD856AFE700
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 13:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15DBAB418A1
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 11:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE48628A415;
	Wed,  9 Jul 2025 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwKaLuZC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1C72580D7;
	Wed,  9 Jul 2025 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058861; cv=none; b=lF+dA+gKGKLf3LWwJh6grnGTKU6+Olr5CSCipa1khf4icDsxUIYR5+ZSx49PvETXsLLryZpFPoXYD2h40q/FUGTIiMmHqUodfYQjpW/ifELYGgbuGaHNN/aDN6Izgg6R5Y2NbPWtmXTiyXGt5CrvvIpWyHAl98Z60vcjakVvQAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058861; c=relaxed/simple;
	bh=6TBIbA4ulMG/TLeMgkUTWPxfeTzSZcIp8A8wki7/tbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeEoMDphtDVw1VFMUhrsMp3phwyup7EnVAi/c1KW/zEW/9qF6T5VdV2jOUYq35iR4R7v2HCmFgpl7bszhiaKy6okms58QcmpYIDKzbtJm6nZuc1BSIH/+knxC5c9i8zqDzZ+5PGmovKjyO2zoPAzvmnYjLNLfjGWyUyb/O/ibT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwKaLuZC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752058860; x=1783594860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6TBIbA4ulMG/TLeMgkUTWPxfeTzSZcIp8A8wki7/tbM=;
  b=DwKaLuZC+oQSqxHlI5Fwck2Z8UYZBDxXbVQ6P19ARxgDuG3URBlogVG/
   PMxqMzFqjkVNxKtJa/w6NsKb2s9jVwhU1jxkcMzNL9LBHZuFBeQqm1KYq
   J3seHzVy3qF4lBRmaGaz3c4rTMhJWt78yJTNkdBqQxgqyD/yCQNRvxqM0
   MWl+oOYzit98Mx8UyRIU/FcllzVFM2xKnuVN1gyDk4VyM/60/rHzJMJKW
   n197KCutrQMso1B5p5Y3eB/OenkDHmDMWvpW/FtRPrpoTDrLEUney/gh5
   6Nq+eGxmawbIVYKqb5HgzpqqPXFavT4ZC8eBlGrJmf+M0GfkG9I14YUDG
   A==;
X-CSE-ConnectionGUID: zTN22k08RCSsFp7ueIKM4w==
X-CSE-MsgGUID: WqBuGawWQCeb6bggqnGpdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54441757"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54441757"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 04:00:59 -0700
X-CSE-ConnectionGUID: kHqhUpj1Rbma1h24o/AiBA==
X-CSE-MsgGUID: WflIntN1TGmJjVEMlY5zKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156475969"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 09 Jul 2025 04:00:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8D6C11B7; Wed, 09 Jul 2025 14:00:44 +0300 (EEST)
Date: Wed, 9 Jul 2025 14:00:44 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon <daniel.sneddon@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Breno Leitao <leitao@debian.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCHv9 16/16] x86: Re-enable Linear Address Masking
Message-ID: <icjt25k4azqzkv5xlobcmlcubulohvfjakkb35dusiqe2xutq3@6jvha7chwwxd>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-17-kirill.shutemov@linux.intel.com>
 <b1408df7-abb4-4ac5-aff7-c04fda7dec7c@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1408df7-abb4-4ac5-aff7-c04fda7dec7c@intel.com>

On Tue, Jul 08, 2025 at 10:31:05PM -0700, Sohil Mehta wrote:
> On 7/7/2025 1:03 AM, Kirill A. Shutemov wrote:
> > This reverts commit 3267cb6d3a174ff83d6287dcd5b0047bbd912452.
> > 
> > LASS mitigates the Spectre based on LAM (SLAM) [1] and the previous
> > commit made LAM depend on LASS, so we no longer need to disable LAM at
> > compile time, so revert the commit that disables LAM.
> > 
> 
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> 
> You may have missed my comments in the previous revision.
> https://lore.kernel.org/all/af709ffa-eb11-4de5-9ae8-a179cb99750c@intel.com/
> 
> Mainly, x86 maintainers prefer imperative tone and references such as
> "previous commit" can be confusing sometimes.

Indeed, missed. My bad.

I've merged last two patches and updated the commit message:

https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?h=x86/lass

I hope it is still okay to use your Reviewed-by tag.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

