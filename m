Return-Path: <linux-efi+bounces-2042-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359909B3D6A
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 23:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE13028A1FE
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 22:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291F11E0B99;
	Mon, 28 Oct 2024 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pr5s7lsV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF0917DFF1;
	Mon, 28 Oct 2024 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152854; cv=none; b=Uv8hFyaSeJtQOQOV8CZ2cAof0FVgxxCk8PMMPJ25LC69eCgWc6MJVSGitZoIbr5IvihUDUSd8GM3R0kPt8P/57ILkCUOCkILPyquHmQCQv807MTHljfwadWXuIjOdbdpPbvAp+mNmPAWDHRYbSV3Lz5Cxswl6bnTo4o6Q0Yc87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152854; c=relaxed/simple;
	bh=J0cj6572cT41BEImfr7FQU44fU/3kuMbptIfwmfZeMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A32lPSX6+bVWz+5ZSWBMZSUdjitr/t8PXssiJKcvppgyXbSjfaZ0Hod3/IasMz9pc8Ku/lPlvfjCp0meQjsEG7/+4pfgbYB9SyJzRpCq8Bn+aRt+7LjD0SNgagxyEriF4gbfK9dID2UKJYHbRq44Ta81alG8Bc0yEPj5jjqVs5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pr5s7lsV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730152852; x=1761688852;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=J0cj6572cT41BEImfr7FQU44fU/3kuMbptIfwmfZeMs=;
  b=Pr5s7lsVtqP3DHyakmiDWupMk13GAFvmWs+duOrjWwEiEWcUPb1b8VmU
   bua5V2HaZivJwPJTQ26fyt2bVh2EoBSI58QTVgS2F/P7OJQdfKkA2Dozq
   FrqkAq7lxkgT7DN3skAjmu3OvpaOS5XpjZMIXv77Hh5r28DGrE4oAqPkM
   mG6gys92Auxv7FWKweOSZ/bLZEU3aqVftJw1nG4RYGuT+Zd9zeOepbjWL
   jw95qAjGn6uxAAoNHjPWCbgR3LGdcjPt9zObkS7sXm4AHRXfdqPmnNXb/
   Hf5Li8utiTYtKFEHfDsc5S05dhUhnvEge/9Hil+7zaWp/C49I5M31jeIA
   g==;
X-CSE-ConnectionGUID: 9lt0vBrlQy2K8NWUXLHePQ==
X-CSE-MsgGUID: 9nSb9x7yT4O2kfdm55BcLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="40347782"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="40347782"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 15:00:51 -0700
X-CSE-ConnectionGUID: O2pVeB6cQBqhdhUJbCUfWg==
X-CSE-MsgGUID: qf9XLHZ/SseSNwdSQW5EgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="86541125"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by orviesa005.jf.intel.com with ESMTP; 28 Oct 2024 15:00:39 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
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
Subject: Re: [PATCH v5 16/16] Revert "x86/lam: Disable ADDRESS_MASKING in
 most cases"
In-Reply-To: <qhnyso6yukxdyox5hkod2yzrgg56vkr7er4howolgat35dvtd4@6qh6f5r425hi>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-17-alexander.shishkin@linux.intel.com>
 <qhnyso6yukxdyox5hkod2yzrgg56vkr7er4howolgat35dvtd4@6qh6f5r425hi>
Date: Tue, 29 Oct 2024 00:00:38 +0200
Message-ID: <87sesfubuh.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> On Mon, Oct 28, 2024 at 06:08:04PM +0200, Alexander Shishkin wrote:
>> This reverts commit 3267cb6d3a174ff83d6287dcd5b0047bbd912452.
>> 
>> LASS mitigates the Spectre based on LAM (SLAM) [1] and an earlier
>> commit made LAM depend on LASS, so we no longer need to disable LAM at
>> compile time, so revert the commit that disables LAM.
>> 
>> [1] https://download.vusec.net/papers/slam_sp24.pdf
>> 
>> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>
> Before re-enabling LAM, you need to uncomment X86_FEATURE_LAM check in
> arch/x86/kernel/cpu/common.c introduced in recent 86e6b1547b3d ("x86: fix
> user address masking non-canonical speculation issue").

Forgot about that one. Thanks!

Regards,
--
Alex

