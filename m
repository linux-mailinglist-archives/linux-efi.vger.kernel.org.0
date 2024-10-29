Return-Path: <linux-efi+bounces-2045-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845B39B4CC5
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 16:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBBFB22D68
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 15:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CAFFC0A;
	Tue, 29 Oct 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjZFxSVp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267E10F7;
	Tue, 29 Oct 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214047; cv=none; b=QIbIYBOY4L3FRij6SnY2jtp8B6aPd8eDrseZqmwoTrzLSh5z7xmRyZh4FQzMG8Tk8NScivh7ffG3PX5XTYoFOu6PqRbf6PluhriMyNh+e1cpCr26yG6kSopOUAqO9YUwsGzM2mH609jUku0H/Yiqv0h520B+eqoZjVOmi95law4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214047; c=relaxed/simple;
	bh=D9Rp+5yWfZatHCUq+TZPqqV9m9KZmsZKTmZvcVZ20TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DstKFy6Q4Z2KBLe+IuHxcuhw3NDS6F9ECdjVB/pjwRNHDlJ8+pve4eQ3mh0BnyA1ADzbBbZh3boDwGIohhNLZhw8kxIY0GKJBPV8ap1H2Rap0N4kt456WmEUlFvtbgir7Ky/kdP2iOy+Ogf+EPB65aNFk0wRwWETsced4vxK61g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjZFxSVp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730214046; x=1761750046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D9Rp+5yWfZatHCUq+TZPqqV9m9KZmsZKTmZvcVZ20TE=;
  b=AjZFxSVpKZOw1wMz8iwQRcG8zuq2WFHqDBmHwjOQrTvjcOF21CrJ1pbp
   dg83m4mM7TqqXlA/GxH9EcRFGwh5dqj/pi3q+cjk3n8VkRuNmf5AJ1gYX
   kLApCyp/2ISFqN0tp5EVcnsIvAutAid2bDrCfz44L+DmD1qJduzY4ffuH
   GZBC/nZMjMLPhnoVZ3bzxSZR4TXP8TvviZrKIH/GJ+9Z7A473Z20YYVQj
   hdYMMLetVrxFFcx8ouGZvTuyXs354z+oqt2C3RdDoCGA520jvkIvdwWOY
   3L2mIlxUq7RdHnd/lmjhqbeQ4wM41uPyFk+/g4kKQLWorCehwV3ve52U8
   g==;
X-CSE-ConnectionGUID: 4dlUXqHMRXiHSsGJNJLhoQ==
X-CSE-MsgGUID: YLOJv365Qv6W0ZB+XcmK2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29997215"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29997215"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:00:45 -0700
X-CSE-ConnectionGUID: Nxyay8XyRLOVqnvvVwffuA==
X-CSE-MsgGUID: ZL6gQGYLQJee/O82nos84A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81919191"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 29 Oct 2024 08:00:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9D49B26B; Tue, 29 Oct 2024 17:00:32 +0200 (EET)
Date: Tue, 29 Oct 2024 17:00:32 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Jonathan Corbet <corbet@lwn.net>, 
	Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>, 
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
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v5 06/16] efi: Disable LASS around
 set_virtual_address_map call
Message-ID: <vp6kerur3lw7kkw4on5n4vflkdetwrj55dhndkmqn7eljrziyj@v6nhq4bz5ort>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-7-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028160917.1380714-7-alexander.shishkin@linux.intel.com>

On Mon, Oct 28, 2024 at 06:07:54PM +0200, Alexander Shishkin wrote:
> Of all the EFI runtime services, set_virtual_address_map is the only one

set_virtual_address_map()

> that is called at its lower mapping, which LASS prohibits regardless of
> EFLAGS.AC setting. The only way to allow this to happen is to disable
> LASS in the CR4 register.

How does it interact with cr_pinning? IIUC, this can happen well after
boot? Like on efivar fs mount.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

