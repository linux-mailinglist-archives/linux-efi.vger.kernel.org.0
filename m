Return-Path: <linux-efi+bounces-3744-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC65AB9F8F
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 17:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F9E18896E3
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33311186E2D;
	Fri, 16 May 2025 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMBisQGl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C085A32;
	Fri, 16 May 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408112; cv=none; b=FgWFhpEsamwMUrTlrpf+k2gX93c1OIlxfRzOWCU6CXEK+9rkIMpIQDqZCw790cqZwBLQf0uPboGl9RQvT7/5QzFuUN5ZA1bagJdNdOdrd1d2zBKU8id4movAJGcgOHBpbgxMUKwZ2cTmqSfP4AI7XTq2nbPFdypR7GLrt2OMwuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408112; c=relaxed/simple;
	bh=S1rTemPleZoxFgD2rnwNc3cuHHFApdCRGDenc4n5ltg=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=CZC6qO5CAgvEGEerFpTk157oZEChSq9AZax5SjzB7vGy9tLof4vWavG/padihv/1YRr0jLRqeTc5OuEMaiVubz+Z3AvC0h+SZIVSntk/a1wWTiPGQxgSCvEcTpqTyLOBhLrUPQlzE16sjjvwrX6j9F7FXSXuKOQkjFXqYZO6fk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMBisQGl; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747408111; x=1778944111;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=S1rTemPleZoxFgD2rnwNc3cuHHFApdCRGDenc4n5ltg=;
  b=aMBisQGl0ex3XzzovVdTYKQHTkAdl0f6Tcs1Nt0gjc6OjE71pb0Cmsua
   Mk72YQrYzVzUtozdo9gUSdf17XQvCKItf3KaOA9JtyVQC4RgrtYJqXsJc
   BklmuwgbwInGIMX9yNFRNDlhFwEk5rBiOam7kR4qkGbFi2zIN8Z+Gus+y
   aNbOxvr9bB0vMZnoucDXoQXycsRg7phTWtbA/QBitZgebzfPbKY/HRTAJ
   nNJgOVrYQWmrlCy24C1geehVKWxa2/LwZBWnrknJz4AMGpJnqQhst7LG0
   TB09ATH4nGNzqrNS4TSRUHE0MwobniQVhry69ps5WRVwA0qwmJfFGVvu9
   Q==;
X-CSE-ConnectionGUID: mplF9e7MQP60AIdsA2ZW/Q==
X-CSE-MsgGUID: wpC6yiW/TDuU4OflxxWX6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="59613708"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="59613708"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 08:08:30 -0700
X-CSE-ConnectionGUID: ArPasoMzSvyin085H2g8Yw==
X-CSE-MsgGUID: pYmG387RQTGarcuW6yiTbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="139203982"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.109.57]) ([10.125.109.57])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 08:08:28 -0700
Content-Type: multipart/mixed; boundary="------------qrIpUdE0q96cUsCGDhanNjXJ"
Message-ID: <6228b588-790a-4bbd-87e6-1bd69f3703c9@intel.com>
Date: Fri, 16 May 2025 08:08:25 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/4] x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory
 model
To: Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
 Michael Roth <michael.roth@amd.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Sandipan Das <sandipan.das@amd.com>,
 Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-mm@kvack.org
References: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>
 <20250516123306.3812286-3-kirill.shutemov@linux.intel.com>
 <30570ca0-8da4-4ebc-84d6-0a4badfb7154@intel.com> <aCdBXxPNO4NtZ_Wl@gmail.com>
 <f93a6e4d-4970-4352-97ff-643d67662c32@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <f93a6e4d-4970-4352-97ff-643d67662c32@intel.com>

This is a multi-part message in MIME format.
--------------qrIpUdE0q96cUsCGDhanNjXJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/25 07:59, Dave Hansen wrote:
> The only option would be to make them static when using non-vmemmap
> sparsemem. But that's new-ish, and probably won't get any testing.

Something like this. But I don't particularly like it.
--------------qrIpUdE0q96cUsCGDhanNjXJ
Content-Type: text/x-patch; charset=UTF-8; name="static-sparsemem-0.patch"
Content-Disposition: attachment; filename="static-sparsemem-0.patch"
Content-Transfer-Encoding: base64

CgotLS0KCiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwYXJzZW1lbS5oIHwgICAgNCArKysr
CiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC1wdU4gYXJjaC94ODYv
aW5jbHVkZS9hc20vc3BhcnNlbWVtLmh+c3RhdGljLXNwYXJzZW1lbS0wIGFyY2gveDg2L2lu
Y2x1ZGUvYXNtL3NwYXJzZW1lbS5oCi0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwYXJz
ZW1lbS5ofnN0YXRpYy1zcGFyc2VtZW0tMAkyMDI1LTA1LTE2IDA4OjA1OjE5LjAwNjE1MDEz
OSAtMDcwMAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zcGFyc2VtZW0uaAkyMDI1LTA1
LTE2IDA4OjA3OjE0LjUxNzE4OTAyNCAtMDcwMApAQCAtMjYsNyArMjYsMTEgQEAKICMgZW5k
aWYKICNlbHNlIC8qIENPTkZJR19YODZfMzIgKi8KICMgZGVmaW5lIFNFQ1RJT05fU0laRV9C
SVRTCTI3IC8qIG1hdHQgLSAxMjggaXMgY29udmVuaWVudCByaWdodCBub3cgKi8KKyNpZmRl
ZiBDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVAKICMgZGVmaW5lIE1BWF9QSFlTTUVNX0JJVFMJ
KHBndGFibGVfbDVfZW5hYmxlZCgpID8gNTIgOiA0NikKKyMgZWxzZQorIyBkZWZpbmUgTUFY
X1BIWVNNRU1fQklUUwk0NgorIyBlbmRpZgogI2VuZGlmCiAKICNlbmRpZiAvKiBDT05GSUdf
U1BBUlNFTUVNICovCl8K

--------------qrIpUdE0q96cUsCGDhanNjXJ--

