Return-Path: <linux-efi+bounces-2061-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5A59B5CB0
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 08:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 625CEB22FD8
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 07:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E031D0BA5;
	Wed, 30 Oct 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjYM80Y9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA785931;
	Wed, 30 Oct 2024 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730272583; cv=none; b=uY8EYSPzDNxxdSnGNEG3OMARcU9q1N4map9VgmMuFIr0GQitQklc8O+SrDfekDY0as0wJlz+pUZoEXIuqUFppAtnoNSE/092IX+4hz2XWWr3Jq9PMpS+SqthvUtOI3+x9VoYRy7kbISinEp65A1nbJyvyg02b5WN7VQ9taOK3/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730272583; c=relaxed/simple;
	bh=WOyrbsXuAYwmwdR7weFcLlOFsoKiRkfzZhQK+EJTbd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hYvZ5Z+LsgT+u4+LH8mQtm49TKWOkX5gJl/twHnvPhelSgdTIEi0nDiGnIOZrYdubFgh84XTUmpi9JtWVQgXMgmF7xbTEiPj2HKadUa3Pi0NcSBIjAbFxlhsiFBxhOIXOVDf9mQ5ONGZnhZYc2I+3EIGINY9GHi9/BdEizMbvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjYM80Y9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730272581; x=1761808581;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WOyrbsXuAYwmwdR7weFcLlOFsoKiRkfzZhQK+EJTbd0=;
  b=QjYM80Y9OT+DTrsgmhTX0fjUNdGwc56Hl8oDLivyLVRyngC5Yxpm83Nh
   A3Jhl8G2CWwZCBNRbI+X3wdM9425OO6jC63dw5ZZd/IWZMt3qbxxGkWXM
   ErsLHsxLsyHOnLEydZCgoUAbF94bVLstozaS7GS+VtGXL73szm9yT+fjI
   yC6hYuVyh6OjxuprfKuCQQ8MXPxfLn5C6HVr7ZBJe0Wv5XRnvQHObZswF
   94NKeWaI/bEbfZc1cWFkPBnZJArJ7tlDwLvKCy0TmStoZrKVgNZZgePWu
   +bf92rDP24jy+We16cmCric8yov0Ej2hIeiq/zHz8CLlKPLaAQ54QLwMn
   A==;
X-CSE-ConnectionGUID: iTGcN6HxTGqdbwPAky5pKg==
X-CSE-MsgGUID: Ovc43BpUQ+SmPtFc2yzsBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="30169961"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="30169961"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 00:16:20 -0700
X-CSE-ConnectionGUID: XwtR8J7IQDuT7JfP5qtmaQ==
X-CSE-MsgGUID: +aqmj1CrQe24f6nmMhOwgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82386709"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by orviesa006.jf.intel.com with ESMTP; 30 Oct 2024 00:16:07 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
 <ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
 <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh
 Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony
 Luck <tony.luck@intel.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>,
 Ingo Molnar <mingo@kernel.org>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
 <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross
 <jgross@suse.com>, Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook
 <kees@kernel.org>, Eric Biggers <ebiggers@google.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du
 <changbin.du@huawei.com>, Huang Shijie <shijie@os.amperecomputing.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Namhyung Kim
 <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v5 00/16] Enable Linear Address Space Separation support
In-Reply-To: <ZyEX4cp-iiwiF_yX@casper.infradead.org>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <ZyEX4cp-iiwiF_yX@casper.infradead.org>
Date: Wed, 30 Oct 2024 09:16:05 +0200
Message-ID: <87plnit616.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Oct 28, 2024 at 06:07:48PM +0200, Alexander Shishkin wrote:
> I lack the wit to read & understand these patches to answer this
> question, so I'll just ask it:

I was hoping they are readable and straightforward. Please, do point out
things that are not so, or not explained well enough, I'll fix them.

> What happens when the kernel does a NULL pointer dereference (due to a
> bug)?  It's not an attempt to access userspace, but it should result in
> a good bug report.  Normally this would be outside a STAC/CLAC region,
> but I suppose technically it could be within one.

Outside of STAC/CLAC there will be a message, see 13/16 or [0].  It
doesn't have helpful things like "if (address < PAGE_SIZE) printk("NULL
ptr deref\n);", but since it prints the address, I assumed it was
sufficient. Does this sound reasonable? Or is it preferrable to make it
look exactly like the !LASS NULL dereference?

Inside STAC/CLAC it should trigger a regular page fault and all the
error messages that result from it.

[0] https://lore.kernel.org/all/20241028160917.1380714-14-alexander.shishkin@linux.intel.com/

Thanks,
--
Alex

