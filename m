Return-Path: <linux-efi+bounces-2064-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7D59B621D
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 12:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8BB1C2039F
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 11:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018CD1E5027;
	Wed, 30 Oct 2024 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gM+WrI/X"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82A84D8A7;
	Wed, 30 Oct 2024 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288594; cv=none; b=bJNrYsD9LdFRSoj8QjYX/PwqfPEjROGml4eWjluW/GgyK3cSLQbDHW8pelSui9LJUAJOJ5c4CgY6KK2sxTna4uR9gUI0fRmcIL6cJzNNRc+nn8NXh6QsSZc+lWYTJHw33HzT2EYZhbFxse7yShOu/zNYAffqmVliXtMHkwTE5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288594; c=relaxed/simple;
	bh=zBeBZaImPz0UNgvN3EkhqvIJaPld+Vg24M7vkVRlgB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip+wC2rlV6GTLw+oDK1Tv8sND0DevLqhmjQqjI/XB+AdGnNF6bPY4NJDZ7IXFIVqKmkTQ6bQrY4QyF5YNMWAokwyzfKiAmnPXry2CqU5FMxF064seTy55+aaXRkp3pvYW9pfhysZVl1zgUqr8i2chKrZB/iDxNCLrFkj7gvvsv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gM+WrI/X; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730288593; x=1761824593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zBeBZaImPz0UNgvN3EkhqvIJaPld+Vg24M7vkVRlgB4=;
  b=gM+WrI/XQGoMWscgWvo+tXOrvLxlU0uHDoYHsbiBMIPVQVCbFhbFZFGL
   GbgWQGZ6CVqCsQya5vALAYhpIbLTK+ZfoIOs+oiF9QIfVbJTSDllCrs5H
   c/6T5jHSPEhTWaJqXs62ppBUS7Up/gGvmQnkRgaTSKnwBOTBUnxXyHjjK
   18dRZGPwZOh5XiUMCdV05+BfjNgZ8sDrNGR7542MYFc7Pw2/0+zyLNwQs
   q+QNJt8lF8Tvh4JX2by4ouF9Ns26tK5pAsf7mBorTAPS1NxNy5v9lY9r6
   F16JMqmuHWrw5ZNvUmJ/3Kh0SlYWDOztvTOOd7oBQj3P2w7O/WVMh+KKG
   Q==;
X-CSE-ConnectionGUID: BkHqUyOIS6+NuONvC4vveg==
X-CSE-MsgGUID: v7KdlA21S1OgIu1StkvyoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29402801"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="29402801"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 04:43:11 -0700
X-CSE-ConnectionGUID: Vlw0gSJGRJa4rrcjq1XtoA==
X-CSE-MsgGUID: P4iq76KnTAqvR179z7cXhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="105605929"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 30 Oct 2024 04:43:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3F18C275; Wed, 30 Oct 2024 13:43:00 +0200 (EET)
Date: Wed, 30 Oct 2024 13:43:00 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, 
	"Hansen, Dave" <dave.hansen@intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, "Li, Xin3" <xin3.li@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon <daniel.sneddon@linux.intel.com>, 
	"Huang, Kai" <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Breno Leitao <leitao@debian.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v5 05/16] x86/cpu: Defer CR pinning setup until after EFI
 initialization
Message-ID: <gb5cwrzxvlkrca2luqmeysgo6vilbqo6iirx5r3lds7ge4vk3i@qdfr2y3o66yd>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-6-alexander.shishkin@linux.intel.com>
 <a95a624b-214a-4b1f-ac16-dad5a9270bf8@intel.com>
 <SJ1PR11MB6083B9854320176B6301C530FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <34dd023d-3ed5-4655-88be-14a7a300b91e@intel.com>
 <SJ1PR11MB6083CA923D92CD70AE6C5FB9FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <869c1545-8c94-4820-a861-fbc563056597@intel.com>
 <aa3dc7dd-8939-4042-9e02-96dd29e45095@zytor.com>
 <SJ1PR11MB6083BB83EE16AEAD6D3F7C1BFC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083BB83EE16AEAD6D3F7C1BFC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Tue, Oct 29, 2024 at 11:18:29PM +0000, Luck, Tony wrote:
> >> Yeah, I was talking about 64-bit only.  On 32-bit PAE a PGD maps 1/4 of
> >> the address space which is totally unworkable for stealing.
> >
> > But it is also not necessary.
> 
> So maybe we could make the 64-bit version of use_temporary_mm()
> use some reserved address mapping to a reserved PGD in the upper
> half of address space, and the 32-bit version continue to use "user"
> addresses. It's unclear to me whether adding complexity here would be
> worth it to remove the 64-bit STAC/CLAC text patching issues.

Redesigning use_temporary_mm() is an interesting experiment, but it is
out of scope for the series.

LASS blocks LAM enabling. It would be nice to get LAM re-enabled soonish.

Maybe we can look at use_temporary_mm() again after LASS gets upstream?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

