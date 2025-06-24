Return-Path: <linux-efi+bounces-3949-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C368AE5FDB
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 10:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E857C4A504F
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 08:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5602E279782;
	Tue, 24 Jun 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knexF1x0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1101248F64;
	Tue, 24 Jun 2025 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754994; cv=none; b=LAaFx24i1TP91IgCD4aj58culE9lSM1cMJZttxsnTcNAM1im96LOkzm7SkVvutOVAxIuPaxHS5li8/djsXNLBSAsPqUjdMNCrXlgYcMPIPx6HrRHk20ozKz0NpQGF4FKr7tzYAHYMy8LIvqA8f1PzMKg6OvTafmVhCTCK1LHNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754994; c=relaxed/simple;
	bh=YW6HmDpuHGkqkfv8nhM6MCfMIQCl8pDzgCgyTV+Z5sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lV8iE6/u8IsKixX/cZpA53GEHOPw0NICSfSBZjHLhBnCLtPu0jYIyHUII19rT/5gZGrCrUtzDZqCKdDvTHPj80m+xwmUxowjU0cr/nX1st+1QGHOHJPn18EcDbrfGKqci0S1UyVNydI85JRpLKiKs8aa1ogWMgKuCQu0HbiJSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knexF1x0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750754994; x=1782290994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YW6HmDpuHGkqkfv8nhM6MCfMIQCl8pDzgCgyTV+Z5sI=;
  b=knexF1x061mUllfCld8EekyqEU9/It3TKasVL3XNoAhctdZ/H1x+f3A/
   8UF0vOYvwtSGEV/YDQMmQx879Vv8zxjAtJq57xgsKiDY0WR27iXcf8NOh
   LP2ICtDOkCQMJg5Ldb6ub7QWVZ57kNAu86WPxhok5rlwdm9IAYMg7cFVw
   oMpkKbWsqd9TjPZks/CorB+DrbSmJ9aA00wG8Q4v9Nj82dZMsW1TUcdcS
   eSDk385acX7S0FJYraK164kYD/kQ2GG/Fc2WVO93kOAG8f12b2OV4EO8+
   7NQtW0G3sSGhMk4d0sG4DBMRkTj0jbJ4z20295McjPftfQdhv5medKBWd
   g==;
X-CSE-ConnectionGUID: YLOiH5d/RqaUyuvF/fB6GQ==
X-CSE-MsgGUID: xT71BtvvRN+W+/MnyuhcfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="75524517"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="75524517"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:49:53 -0700
X-CSE-ConnectionGUID: 5pZhCsH7R2u5jNP7KLc8/w==
X-CSE-MsgGUID: fmBM3rclSY+nZBFzSDNmCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="156237993"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 24 Jun 2025 01:49:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8D246138; Tue, 24 Jun 2025 11:49:45 +0300 (EEST)
Date: Tue, 24 Jun 2025 11:49:45 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Khalid Ali <khaliidcaliy@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net, luto@kernel.org, 
	peterz@infradead.org, ardb@kernel.org, jan.kiszka@siemens.com, kbingham@kernel.org, 
	michael.roth@amd.com, rick.p.edgecombe@intel.com, brijesh.singh@amd.com, 
	sandipan.das@amd.com, jgross@suse.com, thomas.lendacky@amd.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCHv2 0/3] x86: Make 5-level paging support unconditional for
 x86-64
Message-ID: <m3i4z5ell2lhtpverw5slnxidd32lmtqcdpwcljtr5betki6s5@kiq2bibj5lt2>
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
 <20250624081400.2284-1-khaliidcaliy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624081400.2284-1-khaliidcaliy@gmail.com>

On Tue, Jun 24, 2025 at 08:11:15AM +0000, Khalid Ali wrote:
> This will break x86_64 cpus that doesn't support 5-level paging.

No, it won't.

The patchset removes compile-time config option to disable 5-level paging.
After tha patchset all kernels will be built with 5-level paging *support*.

The actual paging mode is chosen at boot time based on machine
capabilities and kernel command line. Older HW will boot in 4-level paging
mode just fine.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

