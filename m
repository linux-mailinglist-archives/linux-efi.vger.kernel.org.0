Return-Path: <linux-efi+bounces-3465-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F4EA9CB36
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 16:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49C44E2DF9
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22F7253941;
	Fri, 25 Apr 2025 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYCmwDSK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A17081F;
	Fri, 25 Apr 2025 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590377; cv=none; b=AeCyd27QFyDJ/QfxOlqeuOQAHLpzWn8UD1TbLbegGCnJuK1UQXnNv5jtjeCwaiOeu/Np++yHXJkzIdJ8bGmpiDHmbJMYHK21Jmnb8b0iOmn2DQPFveQofPYHB1PoaXWjsx2iP6P7U/QAqieyWmy7AVzsBoBIr5s3BnowosoGs9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590377; c=relaxed/simple;
	bh=kQZa9H88IRjq2r7TjcONEZD3Enz3AN+e7iK0VXsD/q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqmNnA3YRo7/JncLYko5/Is5jfSxHLMgKlHpfO8NJNJjE93b6KYp4oHAJjLjI5SxAA8OdPn88xF47ebDVlexBAnQn0BQ2esftieQ4Hhw1qGapB74TRvlvO5HU7LLcK8BFKEwU4IwU3Xz/+Bk51Ge/DBRSgAmuYfyrkS+wpjC6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYCmwDSK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745590376; x=1777126376;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kQZa9H88IRjq2r7TjcONEZD3Enz3AN+e7iK0VXsD/q8=;
  b=MYCmwDSKkjNOrW00fDwUU+MlJg/UxLG9MaIBDP2JJkS+NuWMXKoB7btJ
   dNHioxnEcngSZuGAEhr0PXd5gTIf+9KlJRMFLU2bO0CkyEdsFnDh0dH0R
   PGhdcA6lUUcCIPtaEtgzgIPCPNveYE/SAbEo3/v0UrL9FSy+bJaERcRCe
   GMs2QSGKTsjRchDaKcxbdtIs3OMXdUTeZGs2wGbgnCfo4siFrTq3d4qJL
   z9A3qVpD451QIVBl54OdUuWXQlyYy/z+KdYDd9B4I2EIZi0oCPmJPt+Xa
   45PtvWTL3Sp6hltL4etUOcSXTFyPK1DT8uirOVpADgeUGILxUFl5AX6pr
   g==;
X-CSE-ConnectionGUID: Kl0Rp0n4S/e9yJhzzc/Wpw==
X-CSE-MsgGUID: Rpx1AYbPQXuoFi4nBhIu4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="72628023"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="72628023"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 07:12:55 -0700
X-CSE-ConnectionGUID: gze8PSdqR4uxfgHgShwE1A==
X-CSE-MsgGUID: b9P0pObJRQ+SXKkVkYvCRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="133421364"
Received: from uaeoff-desk2.amr.corp.intel.com (HELO [10.124.222.49]) ([10.124.222.49])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 07:12:53 -0700
Message-ID: <9b18e8e3-f3e2-48d4-839a-56e1d8f62657@intel.com>
Date: Fri, 25 Apr 2025 07:12:51 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: Rich Persaud <persaur@gmail.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev,
 dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com,
 Sergii Dmytruk <sergii.dmytruk@3mdeb.com>, openxt@googlegroups.com,
 "Mowka, Mateusz" <mateusz.mowka@intel.com>, Ning Sun <ning.sun@intel.com>,
 tboot-devel@lists.sourceforge.net
References: <18F9BD47-282D-4225-AB6B-FDA4AD52D7AE@gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <18F9BD47-282D-4225-AB6B-FDA4AD52D7AE@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/25/25 03:12, Rich Persaud wrote:
> ﻿On Apr 24, 2025, at 2:45 PM, Dave Hansen <dave.hansen@intel.com> 
> wrote:
>> ﻿On 4/21/25 09:26, Ross Philipson wrote:
>>> This patchset provides detailed documentation of DRTM, the 
>>> approach used for adding the capbility, and relevant API/ABI 
>>> documentation. In addition to the documentation the patch set 
>>> introduces Intel TXT support as the first platform for Linux 
>>> Secure Launch.
>> 
>> So, I know some of the story here thanks to Andy Cooper. But the 
>> elephant in the room is:
>> 
>>> INTEL(R) TRUSTED EXECUTION TECHNOLOGY (TXT) M:      Ning Sun 
>>> <ning.sun@intel.com> L:      tboot-devel@lists.sourceforge.net 
>>> S:      Supported W:      http://tboot.sourceforge.net T: hg 
>>> http://tboot.hg.sourceforge.net:8000/hgroot/tboot/tboot F: 
>>> Documentation/arch/x86/intel_txt.rst F:      arch/x86/ kernel/ 
>>> tboot.c F:      include/linux/tboot.h
>> 
>> Linux already supports TXT. Why do we need TrenchBoot?
> 
> One reason is to generalize DRTM support to other platforms.

OK, but why do this in Linux as opposed to tboot? Right now, much of the
TXT magic is done outside of the kernel. Why do it *IN* the kernel?

>> Also, honestly, what do you think we should do with the Linux 
>> tboot code? Is everyone going to be moving over to Trenchboot>
> OpenXT will migrate development of measured launch from tboot to 
> TrenchBoot Secure Launch, after upstream Linux and Xen have support 
> for both Intel and AMD DRTM. Previously-deployed Intel devices using
> tboot, derived from OpenXT, will need support until users upgrade
> their hardware.

Say we axed tboot support from 6.16, but merged Trenchboot. A user on
old hardware upgrades their kernel. What happens to them?

>> so that Linux support for TXT/tboot can just go away?
You didn't _really_ answer the question.

Summarizing, I think you're saying that TXT/tboot Linux support can just
go away, but it will be help if its maintainers help its users transition.

Does anybody disagree with that?

> In that perfect world, Intel ACM and tboot developers would review
> the TrenchBoot Linux series

So, I was looking on the cc list and I didn't see them on there.
Shouldn't they be cc'd if you want them to review the series? A little
poking at lore makes me think that they were *NEVER* cc'd.

Is that right, or is my lore-foo weak?


