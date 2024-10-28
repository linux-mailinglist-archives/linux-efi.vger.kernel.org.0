Return-Path: <linux-efi+bounces-2041-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 681369B3C0C
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 21:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5871F22DF7
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 20:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889C01DFD95;
	Mon, 28 Oct 2024 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="B7aBkbFp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q3fPSrT4"
X-Original-To: linux-efi@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB9718E03D;
	Mon, 28 Oct 2024 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148139; cv=none; b=c0nbmXl+Iq2TRqcN248JizBlTGvatq8HHa6c/jQoGijZxGefQ57R+e9ZQr7lxUPwr1uHHFQsGfGUQylQjVblDUHCBYcaegqxClYSXAhaQxtV89wxsZ+i5rcduQ5UkkLCSvlmLZ8lMIq+OWypic+6olfeTEEweTI4JlNifn7vhKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148139; c=relaxed/simple;
	bh=1b3wEfHTCpF0AXxOoU3n+1fQPTTY8V4zPHmhz1VF+UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvckNjf/+VCjlEwHF8glEoCS1DnHmfOrbTugLexbYgSf+Qv05AvPn4GPF5WGZq/IhjbGOENG3H/ZVnUsZsvbIK2Zsj6UB7EUnmhawGX/VcJTjfTxqE72QGtjmGIsKCeDzNaMz0chKgksAfohK749777+7ffm6N39yW/D9c9GGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=B7aBkbFp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q3fPSrT4; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 19B882006F0;
	Mon, 28 Oct 2024 16:42:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 28 Oct 2024 16:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730148136; x=
	1730155336; bh=qyX0k5CJSPl4swUA6LpoOKwTmR0F2riD6PvL9n3i/VI=; b=B
	7aBkbFptw/oXycTtJhJ2C6gGtE5PZkkSC5Nj4HB0UiZTKAmPvrp6282Dt2T5/LBl
	FjPJrHBt14f38y24uU46hz/HHBwXpkaPKXGpTTnd5nWEQc07NsEpHYiFFhpPS7zR
	JIiB5auMsMT7CKcY43NyYO3zyNgHZfSlcei+/3dR9fGCLTF1cP7401lT8dU/vbAK
	ugoxQjLexWIzCQEGvnXXkM+LwDbB20mec7omJGSWZJpvws+rNkNcA9ZPh2TMjmoN
	2caeDOnyZn3IZBbLI/+gMF5FLkNSknel2mSkgGDp/2pyIAAS1qCTY4MX6AQDNmnG
	InzHXwcvuibGR6yiEeixg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730148136; x=1730155336; bh=qyX0k5CJSPl4swUA6LpoOKwTmR0F
	2riD6PvL9n3i/VI=; b=Q3fPSrT4GLl0OulFr5HDlvaFEU7EXA4STiZcwrkgAp2k
	1zeToNyJ5VmXlOKqRIDqTnmtGdjzZxNw2uSJn8SLrMTLz359WSXhN7hAQe7kVmK4
	TqH4i9dnDbAdo12ss99gvb0ASaEDJG/soADnuOSZUYJxRFlurjbt97pUf8QeX1HZ
	H+RN99T0PCWRHeJ4y+3dsQHeQJIbHzC1kVHWi99LV0+iS89WAbT9eJF6i65uMuNU
	AFaNN2O/E4w2hptX97UrsjMF7YnVbxHgQX5fcPr1KrbCiBJ+/t7YVApWNt9yJOus
	nYwf2MCNT5sw1/FU/iL57k5jhiXV3ZvqgQXDZAanJA==
X-ME-Sender: <xms:JvcfZz_t21KkK0mw6erepLFmrrM_LY-A9WQ_2vcJB05j_o9keUUn-g>
    <xme:JvcfZ_u51H4QfAC4uSl6bGSxk1cYiJfoDMhGlETWJRJFkU2QWy_ZXltVxjUrkxi9d
    6WNs7ePvOdn9cZqPRE>
X-ME-Received: <xmr:JvcfZxAKbzSkUXn-eDy4H8hOFLOtWxZo6Rf9Zhxj4qxbWblcAWak_5LgRZi9a2XUnbmk4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejledguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddv
    necuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllh
    esshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepkeevteduffekleef
    teevvefgudeltdettdeikeejkeeuudekvdetkeeffeeftedtnecuffhomhgrihhnpehvuh
    hsvggtrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhope
    ehuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigrghnuggvrhdrshhh
    ihhshhhkihhnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhuthhose
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdgu
    vgdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegsph
    esrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhig
    rdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhn
    fhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:JvcfZ_cU9YGCtH9KLR0DHxB_tC2Sr2ZhjE8ySD4IFQkZz3sKbIhvKQ>
    <xmx:JvcfZ4ObJ0gQBv0jbp8LdkLks-xiQ27KNgFqceGmr1npGuVT-wUoBw>
    <xmx:JvcfZxmFP8ad3skwpR-ZV8bdcVwzKEuU8ijIAtcZxf2NX1vQXfixQw>
    <xmx:JvcfZyuzSU5oAKHiEl719bVQeOLcNg8beYJ_S4Xv5B9G8zsqL_Tnvw>
    <xmx:KPcfZ0SgVfRC2UtF8RgPG45rq6wBV8LF8xgr4RWL5lm8XBdojhXtsijE>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 16:42:00 -0400 (EDT)
Date: Mon, 28 Oct 2024 22:41:56 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, 	Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, 	Peter Zijlstra <peterz@infradead.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 	"Paul E. McKenney" <paulmck@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>,
 	"Mike Rapoport (IBM)" <rppt@kernel.org>,
 Brijesh Singh <brijesh.singh@amd.com>,
 	Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>,
 	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Alexey Kardashevskiy <aik@amd.com>, 	Jonathan Corbet <corbet@lwn.net>,
 Sohil Mehta <sohil.mehta@intel.com>, 	Ingo Molnar <mingo@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, 	Sandipan Das <sandipan.das@amd.com>,
 Breno Leitao <leitao@debian.org>,
 	Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, 	Hou Tao <houtao1@huawei.com>,
 Juergen Gross <jgross@suse.com>,
 	Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>,
 Eric Biggers <ebiggers@google.com>, 	Jason Gunthorpe <jgg@ziepe.ca>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 	Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, 	Yuntao Wang <ytcoode@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 	Christophe Leroy <christophe.leroy@csgroup.eu>,
 Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>,
 	Huang Shijie <shijie@os.amperecomputing.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 	Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v5 16/16] Revert "x86/lam: Disable ADDRESS_MASKING in
 most cases"
Message-ID: <qhnyso6yukxdyox5hkod2yzrgg56vkr7er4howolgat35dvtd4@6qh6f5r425hi>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-17-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028160917.1380714-17-alexander.shishkin@linux.intel.com>

On Mon, Oct 28, 2024 at 06:08:04PM +0200, Alexander Shishkin wrote:
> This reverts commit 3267cb6d3a174ff83d6287dcd5b0047bbd912452.
> 
> LASS mitigates the Spectre based on LAM (SLAM) [1] and an earlier
> commit made LAM depend on LASS, so we no longer need to disable LAM at
> compile time, so revert the commit that disables LAM.
> 
> [1] https://download.vusec.net/papers/slam_sp24.pdf
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Before re-enabling LAM, you need to uncomment X86_FEATURE_LAM check in
arch/x86/kernel/cpu/common.c introduced in recent 86e6b1547b3d ("x86: fix
user address masking non-canonical speculation issue").

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

