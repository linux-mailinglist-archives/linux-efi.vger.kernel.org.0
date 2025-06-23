Return-Path: <linux-efi+bounces-3911-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C06FAE40B5
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 14:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB9A7A5294
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 12:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B5B2417F2;
	Mon, 23 Jun 2025 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nd5WcWaG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B583C24293F;
	Mon, 23 Jun 2025 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682511; cv=none; b=NDXxyt2gaXSZezrLEbgf4EHeZywlieV7oD/uWuDbJPODgXgPP6gB2uLRKrYAHMOJFxLWAIqk/Zbf68xOORrSlT77HAKc5pT/vR+QtOl1Tb4VUxQ9ux1+hmAqYVkwAuWnJcWbmPc5QeZbB+bajz7UCd6zITsLBeRAQ99X1bR+d2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682511; c=relaxed/simple;
	bh=K3UZr1v5ln6fJSE0bzWb9sF553xHwQWW1kwtTJIV7Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvBDUZ32JnW1cRZoYL7c7LzyTq1IwTlR6DY+7kHZmiK3hT95DygghEX/sfYI1nMk/HfpXXlhIyzfMhFe+p0oUTPZsev3VbQOxCXlVVEjUKb3ioJytbYOJsoS/aM4+6nwDSxZ7Eyyeerc1joeHVNrftE0qbHK9BSWBd2Upe0eTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nd5WcWaG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750682509; x=1782218509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K3UZr1v5ln6fJSE0bzWb9sF553xHwQWW1kwtTJIV7Kk=;
  b=nd5WcWaGaltpjrJkvLFr90dUeCS8jsIEKbqW+K8Ym4oai1CnxwDfL3u7
   cia7HynY5GWaUYar0ln/7bLCpdffCuN3ogibOJviCC7HmgYbxwJgOc/ui
   VbmTeGTZyOqceFPF+3IfGr3+m9Q+DKNHzf/EkX+7H1sWlWtsFFzwcpO/0
   WxT+Aggpy+PDuio/+Z/LAtcPfELnR9OuCPYAomm60FSkrbrHBGvNcgJTr
   ikReCDDnubedqXOrHysg8AbmEwOV1Z3Sc6qv3khhNmqoYeURg3Gmxf0OJ
   TffetA5G/fAogNkwWT3N0sKPLIsUCQic/5wcGRPLb/UHaJmCMRoeinNc2
   Q==;
X-CSE-ConnectionGUID: ZqISHIsXQcSjKElzjUm67Q==
X-CSE-MsgGUID: HjeGr1okTrO5oNRJs6c0XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53026755"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="53026755"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 05:41:48 -0700
X-CSE-ConnectionGUID: 10Ymcep+Q3up0gnu1kePHQ==
X-CSE-MsgGUID: I55PCHToQRCNtiihmEgd6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="151738727"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 23 Jun 2025 05:41:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D7895126; Mon, 23 Jun 2025 15:41:30 +0300 (EEST)
Date: Mon, 23 Jun 2025 15:41:30 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, acme@redhat.com, 
	aik@amd.com, akpm@linux-foundation.org, alexander.shishkin@linux.intel.com, 
	ardb@kernel.org, ast@kernel.org, bp@alien8.de, brijesh.singh@amd.com, 
	changbin.du@huawei.com, christophe.leroy@csgroup.eu, corbet@lwn.net, 
	daniel.sneddon@linux.intel.com, dave.hansen@linux.intel.com, ebiggers@google.com, 
	geert+renesas@glider.be, houtao1@huawei.com, hpa@zytor.com, jgg@ziepe.ca, jgross@suse.com, 
	jpoimboe@kernel.org, kai.huang@intel.com, kees@kernel.org, leitao@debian.org, 
	linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux@rasmusvillemoes.dk, luto@kernel.org, mcgrof@kernel.org, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com, 
	peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org, 
	sandipan.das@amd.com, shijie@os.amperecomputing.com, sohil.mehta@intel.com, 
	tglx@linutronix.de, tj@kernel.org, tony.luck@intel.com, vegard.nossum@oracle.com, 
	x86@kernel.org, xin3.li@intel.com, xiongwei.song@windriver.com, 
	ytcoode@gmail.com
Subject: Re: [PATCHv6 07/16] x86/vsyscall: Reorganize the #PF emulation code
Message-ID: <kthmv63jrvrr3shhzhhcib7qrjp7sjkah65kogbfphfr6wg6cb@z5zydz6ov7pv>
References: <9d351d80-66fe-486f-bdb3-370859dc47cc@intel.com>
 <262c0fd2-ac66-4ce7-903f-4062f1fe1d6e@citrix.com>
 <b6f8a90d-4309-45c5-84cd-32e281d076fb@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f8a90d-4309-45c5-84cd-32e281d076fb@intel.com>

On Fri, Jun 20, 2025 at 04:21:38PM -0700, Dave Hansen wrote:
> On 6/20/25 16:08, Andrew Cooper wrote:
> >> But, the resulting code is wonky. It needs to do something more like this:
> >>
> >> 	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
> >> 		return false;
> >>
> >> 	if (error_code & X86_PF_INSTR))
> >> 		return __emulate_vsyscall(regs, address);
> > To do this, LASS needs a proper interlink against NX || SMEP.
> > 
> > If neither NX nor SMEP are active, the CPU does not report X86_PF_INSTR,
> > meaning that fetches are reported as plain reads.
> Interesting point.
> 
> I think the easiest way to do this is just make a cpuid_deps[] entry for
> LASS and NX. If there's a CPU where LASS is available but where NX isn't
> available, we have much bigger problems on our hands.

I am not sure what I suppose to do here.

Sohil pointed out that with LASS we get #GP on vsyscall, not #PF and PFEC
is not relevant for LASS.

So, IIUC, that's dependency of vsyscall PF on NX. Do we want to disable
vsyscall on boot if NX is not available?

BTW, why do we even support !NX on X86_64? Is there such HW?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

