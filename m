Return-Path: <linux-efi+bounces-3915-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FE9AE48CD
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 17:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CA6441144
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA622777EC;
	Mon, 23 Jun 2025 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LP7KxHAC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0D2609E4;
	Mon, 23 Jun 2025 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692779; cv=none; b=IIPRbnEzxax6fOyrT5C7w3WVc1aVEaLsARYcMdtEArWuot2IRnTWCs4NXguH3ef/MSbxCYQ9kd6bRhbbBD12nfTadGRl19FOxrlAJE/ZmCT5Xeu+aBi2kA24Cn0JJTJ82xPdO4Ra1vOa8Mb2iH17iB8t/dJ3OyVnBytNpSxZP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692779; c=relaxed/simple;
	bh=PT3M4AOgi1OUY/m19yZDe+t1mwb9qhz6OLFhPtNLEW4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=kqjDtVo12TaivfKFD0/nLlgnmZ7OTSiubRx0LdQZAxZ+FbMGtZjtOJCOJJ/2BlVZOjE3Z0aDf22L2eE235vHH7ceUXGudvYxAYf1ZDSGQDBZ0bvgpKjHkFRhiz65S+u9weDS13fZe5Q8M1gSfypwN4H4KOMUke5MjNJgjv+pQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LP7KxHAC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750692778; x=1782228778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=PT3M4AOgi1OUY/m19yZDe+t1mwb9qhz6OLFhPtNLEW4=;
  b=LP7KxHACmNqXUT8fCSrh6/B1M2RXhO4O9uVKj/ds1ag/JynNw+FZZ40Q
   HIQFLwGVSygqiSSKSa8D9JWEZSAdi31QTwpWMPaomjrqRYzb/w2qu6sOk
   W4QcOqUPob7oKfPmKPV/BoPnL6yTmESwx8QDhIj9VIz6agZVRsHqzeBa/
   AzXYpkVhdCw/5sATmRoCs10X9U98xdB5sQ646mBma/V1F0xP0MNvBSjuz
   GaE48BN7YoIHD/9W+GmKE2SiCkRxopwk8dHGKATOq7GgQfLlYhmsYPMbO
   iKplUvgnwnJgUqI1rfFFvnNT03b/DF+JxPOIIVLVJlwBDJKOzy7sdHBf/
   A==;
X-CSE-ConnectionGUID: SGvIeijnTbiSxkx8B4L0+Q==
X-CSE-MsgGUID: 4aLEKPplTQyoNJGRkRW52Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="63600365"
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="63600365"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 08:32:57 -0700
X-CSE-ConnectionGUID: aKkphUs/TcKlNIVVR7DHsw==
X-CSE-MsgGUID: xuYev3GQTVCWCNxvgvVRFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="152145883"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.108.165]) ([10.125.108.165])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 08:32:54 -0700
Content-Type: multipart/mixed; boundary="------------GHRek0mmnbllhgkrO1Mnn6jW"
Message-ID: <bd81a98b-f8d4-4304-ac55-d4151a1a77ab@intel.com>
Date: Mon, 23 Jun 2025 08:32:53 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 07/16] x86/vsyscall: Reorganize the #PF emulation code
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, acme@redhat.com, aik@amd.com,
 akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
 ardb@kernel.org, ast@kernel.org, bp@alien8.de, brijesh.singh@amd.com,
 changbin.du@huawei.com, christophe.leroy@csgroup.eu, corbet@lwn.net,
 daniel.sneddon@linux.intel.com, dave.hansen@linux.intel.com,
 ebiggers@google.com, geert+renesas@glider.be, houtao1@huawei.com,
 hpa@zytor.com, jgg@ziepe.ca, jgross@suse.com, jpoimboe@kernel.org,
 kai.huang@intel.com, kees@kernel.org, leitao@debian.org,
 linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux@rasmusvillemoes.dk,
 luto@kernel.org, mcgrof@kernel.org, mhiramat@kernel.org,
 michael.roth@amd.com, mingo@kernel.org, mingo@redhat.com,
 namhyung@kernel.org, paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
 peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org,
 sandipan.das@amd.com, shijie@os.amperecomputing.com, sohil.mehta@intel.com,
 tglx@linutronix.de, tj@kernel.org, tony.luck@intel.com,
 vegard.nossum@oracle.com, x86@kernel.org, xin3.li@intel.com,
 xiongwei.song@windriver.com, ytcoode@gmail.com
References: <9d351d80-66fe-486f-bdb3-370859dc47cc@intel.com>
 <262c0fd2-ac66-4ce7-903f-4062f1fe1d6e@citrix.com>
 <b6f8a90d-4309-45c5-84cd-32e281d076fb@intel.com>
 <kthmv63jrvrr3shhzhhcib7qrjp7sjkah65kogbfphfr6wg6cb@z5zydz6ov7pv>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <kthmv63jrvrr3shhzhhcib7qrjp7sjkah65kogbfphfr6wg6cb@z5zydz6ov7pv>

This is a multi-part message in MIME format.
--------------GHRek0mmnbllhgkrO1Mnn6jW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 05:41, Kirill A. Shutemov wrote:
> So, IIUC, that's dependency of vsyscall PF on NX. Do we want to disable
> vsyscall on boot if NX is not available?

Well, vsyscall=none can break old userspace, so forcing it on old
hardware doesn't seem like a great idea.

But, either way, this doesn't really appear to be a LASS issue. This code:

>         if (!(error_code & X86_PF_INSTR)) {
>                 /* Failed vsyscall read */
>                 if (vsyscall_mode == EMULATE)
>                         return false;

Is really asking the question:

	Is this #PF from an instruction fetch in the vsyscall page?

That _should_ be able to be done by comparing CR2 and regs->rip. In
fact, that's done just below anyway:

	WARN_ON_ONCE(address != regs->ip);

So I think we can fix this up with something like the attached patch
which just drives the if() from regs->rip and make the warning NX-only.

But this code has been like this a long time and I'm 99% sure the x86
selftests poke at all these cases. I'm curious what they do on those old
P4's (or a 64-bit VM with NX turned off), but it's not super important
either way.
--------------GHRek0mmnbllhgkrO1Mnn6jW
Content-Type: text/x-patch; charset=UTF-8; name="vsyscall-nx.patch"
Content-Disposition: attachment; filename="vsyscall-nx.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L3ZzeXNjYWxsL3ZzeXNjYWxsXzY0LmMgYi9h
cmNoL3g4Ni9lbnRyeS92c3lzY2FsbC92c3lzY2FsbF82NC5jCmluZGV4IGM5MTAzYTZmYTA2
ZS4uMGIwZTAyODM5OTRmIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9lbnRyeS92c3lzY2FsbC92
c3lzY2FsbF82NC5jCisrKyBiL2FyY2gveDg2L2VudHJ5L3ZzeXNjYWxsL3ZzeXNjYWxsXzY0
LmMKQEAgLTEyNCw3ICsxMjQsOCBAQCBib29sIGVtdWxhdGVfdnN5c2NhbGwodW5zaWduZWQg
bG9uZyBlcnJvcl9jb2RlLAogCWlmICgoZXJyb3JfY29kZSAmIChYODZfUEZfV1JJVEUgfCBY
ODZfUEZfVVNFUikpICE9IFg4Nl9QRl9VU0VSKQogCQlyZXR1cm4gZmFsc2U7CiAKLQlpZiAo
IShlcnJvcl9jb2RlICYgWDg2X1BGX0lOU1RSKSkgeworCS8qIEF2b2lkIGVtdWxhdGlvbiB1
bmxlc3MgdXNlcnNwYWNlIHdhcyBleGVjdXRpbmcgZnJvbSB2c3lzY2FsbCBwYWdlOiAqLwor
CWlmIChhZGRyZXNzICE9IHJlZ3MtPmlwKSB7CiAJCS8qIEZhaWxlZCB2c3lzY2FsbCByZWFk
ICovCiAJCWlmICh2c3lzY2FsbF9tb2RlID09IEVNVUxBVEUpCiAJCQlyZXR1cm4gZmFsc2U7
CkBAIC0xMzYsMTMgKzEzNywxNiBAQCBib29sIGVtdWxhdGVfdnN5c2NhbGwodW5zaWduZWQg
bG9uZyBlcnJvcl9jb2RlLAogCQlyZXR1cm4gZmFsc2U7CiAJfQogCisKKwkvKiBYODZfUEZf
SU5TVFIgaXMgb25seSBzZXQgd2hlbiBOWCBpcyBzdXBwb3J0ZWQ6ICovCisJaWYgKGNwdV9m
ZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfTlgpKQorCQlXQVJOX09OX09OQ0UoIShlcnJv
cl9jb2RlICYgWDg2X1BGX0lOU1RSKSk7CisKIAkvKgogCSAqIE5vIHBvaW50IGluIGNoZWNr
aW5nIENTIC0tIHRoZSBvbmx5IHdheSB0byBnZXQgaGVyZSBpcyBhIHVzZXIgbW9kZQogCSAq
IHRyYXAgdG8gYSBoaWdoIGFkZHJlc3MsIHdoaWNoIG1lYW5zIHRoYXQgd2UncmUgaW4gNjQt
Yml0IHVzZXIgY29kZS4KIAkgKi8KIAotCVdBUk5fT05fT05DRShhZGRyZXNzICE9IHJlZ3Mt
PmlwKTsKLQogCWlmICh2c3lzY2FsbF9tb2RlID09IE5PTkUpIHsKIAkJd2Fybl9iYWRfdnN5
c2NhbGwoS0VSTl9JTkZPLCByZWdzLAogCQkJCSAgInZzeXNjYWxsIGF0dGVtcHRlZCB3aXRo
IHZzeXNjYWxsPW5vbmUiKTsK

--------------GHRek0mmnbllhgkrO1Mnn6jW--

