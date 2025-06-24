Return-Path: <linux-efi+bounces-3958-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C1CAE6807
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 16:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C338A1C2041B
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 14:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771212D8768;
	Tue, 24 Jun 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIyPXIdw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE62D2381;
	Tue, 24 Jun 2025 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774270; cv=none; b=AoqSHLveVaSpKkDHa5EIu8dW1WW7rSbYtXxClBB8Dxb+rB2wEEmZQ4WWS218dWLduyb5+1qY6pqYMBC47h+N7jsl47+mnQpDI7wdmXjxXMt+IAQhe7X2fppIn3jsvK7bJpMw3t4fmMQWBzxSUdnqKFwLqqSMSGAIRjfqrr23Sng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774270; c=relaxed/simple;
	bh=aK1V/dFFJnrFsGQcAdnqf8jvhBHmxF+rlZP3dE/wVGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mysGOqP4eF5rJVGwMqMdl2bfkv+FpTHY+TTKWfC1pjKjeJvwWzeYwvsbivHBhhQBXtTiXObIVZPdAziijw5M/dKZ38uTswDsNszwMUEwFi72ifrxFGzdnKwWgfAzN95iBaeYlQE1Kdvwg1O9Id0gFQQpyBkQi3y2am4gL9KaZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIyPXIdw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750774269; x=1782310269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aK1V/dFFJnrFsGQcAdnqf8jvhBHmxF+rlZP3dE/wVGQ=;
  b=bIyPXIdwdSjSUynxEuNWHY72P7/I9KDmRWehho1Fj7W0p04EWgS2t2vo
   bmylDn7L2DJruOXPUW6eNgKW5dW3qns/DjKEF2Ys4gDu4VuhHJlaYL9oO
   W9VLPMtgw54Ii3KvHXi8rLSIkAIf0wVwh9dpZWTJXHnnM1rPed8rhZcDO
   rC90ncg1xLjpowVqICMkM/Yzk7fOc+UVE2mIlKyhu/4Bq4xVrrm+RYGjv
   hptPozHqOy5e/NCIc9a3Ed4sLrfZz4lwdhslSiQhHvE15BrqKH5pZXQIO
   T/YCeHBh61fduVnWOWfSKH87MHA3dbQsejBOkIJX+Lf2lrpiRlDcv85hC
   Q==;
X-CSE-ConnectionGUID: rUcFi2tgR6W44dja3xCE1w==
X-CSE-MsgGUID: hwFi6mcrRsq/JenxavAP+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53154327"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="53154327"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 07:11:07 -0700
X-CSE-ConnectionGUID: Tnl6aOgnSbOhBCldLy1w6g==
X-CSE-MsgGUID: fjgRJMIcRXWp6dpVn8W3cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="156215363"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.197]) ([10.125.108.197])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 07:11:04 -0700
Message-ID: <265eef27-aecb-479e-a293-c2e88d69e6ec@intel.com>
Date: Tue, 24 Jun 2025 07:11:03 -0700
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
 <bd81a98b-f8d4-4304-ac55-d4151a1a77ab@intel.com>
 <hhbqjpkpdi5oe77lfosjpgyvvhvxgwolb45ll5rmwbzsdt27h5@hgv57r543ryl>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <hhbqjpkpdi5oe77lfosjpgyvvhvxgwolb45ll5rmwbzsdt27h5@hgv57r543ryl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/25 04:37, Kirill A. Shutemov wrote:
> Do you want me to include it into this patchset or will you apply it
> separately?

Actually, if you want to break it out and just submit it separately,
I'll probably just apply it.

