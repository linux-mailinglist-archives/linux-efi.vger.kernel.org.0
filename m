Return-Path: <linux-efi+bounces-1361-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F3E91E9C2
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 22:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DE61C21D50
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 20:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD69A17109D;
	Mon,  1 Jul 2024 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbZvbZb6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136A16F8F7;
	Mon,  1 Jul 2024 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866529; cv=none; b=MQvgEXYaGUvQMYbLLa3S2knKghnPFt/rQjXbReMzqzSV/dBn5c1UigSSJtXNcKPeVJaSgg7F0jOob9/oQk+yGE/HIf4P1Vbwt4WRmbR/gqOYaNWIEe5zhjryn5qK8UIkzikDMQyxgTrgi9NGMq/rqqE7Yw4lcUD/+z1GfZo/ebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866529; c=relaxed/simple;
	bh=7VJPiSaAOik0sxB5qPZlQkuDLSMT39Hww2+NVN+SEA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=be0VtQKhoB+GAy3vI8L4LpkiTbmDGDoPsR2Z2S31VSReXFEbr/Ouis16McDhQDzI8hiuzBTwXKxSSvq4Q1XLu1qNqvNMzMtSQBi5o4A8KG1LYxsJ4/+Z6prPqBZR7WLkVHyNvdft/0QZcSA6ygwFXrMFu8K+fC6uKRl0UGPpJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbZvbZb6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719866528; x=1751402528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7VJPiSaAOik0sxB5qPZlQkuDLSMT39Hww2+NVN+SEA8=;
  b=CbZvbZb6iXYyFImFS4oRwD66F6v2xoXEJe4KURymqXoVvhURWhgBJ5Qc
   /tUe4BxDfTLjCd1u+GhZw3KA+tFleSUrfv3sjlPLFZs4/Rcd6qscifE1K
   gzmMpjmOSBW1OKrNbixWw2blJfDMhpNtPqDphcoCVIzMaiFjEr/X0Nw9g
   gWTi9xVgeK1Ob15txsRc+RQ2q9nW+OLjM28EtOnCOVS5P+oFXvxJoMmYu
   KdsO7tjyt+eTY86KlStfh7ou9T9ud6ezH256S8wJ9dztfYpuPmRN3WYoB
   5n00aT8STORJJ/IpMcU2+4gH31ptHn/b8Ld7+7betTGl95MVHam+mbG8L
   A==;
X-CSE-ConnectionGUID: aFrjwC1hTRW9ON8x4PqoiA==
X-CSE-MsgGUID: //1MPnbPTj+F0tMAzVLJwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="12345220"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="12345220"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 13:42:07 -0700
X-CSE-ConnectionGUID: iSnY78nJTSyhgLak49YwhQ==
X-CSE-MsgGUID: OGOkPio+SJuiVRy1ItQa4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="68866251"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 13:42:07 -0700
Date: Mon, 1 Jul 2024 13:42:05 -0700
From: Tony Luck <tony.luck@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org, dyoung@redhat.com,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [RFC PATCH] x86/efi: Drop support for fake EFI memory maps
Message-ID: <ZoMUnSaqORagM_Y2@agluck-desk3.sc.intel.com>
References: <20240620073205.1543145-1-ardb+git@google.com>
 <66830ebdb7f0e_5639294f5@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66830ebdb7f0e_5639294f5@dwillia2-xfh.jf.intel.com.notmuch>

On Mon, Jul 01, 2024 at 01:17:01PM -0700, Dan Williams wrote:
> [ add Tony who may care about the more-reliable removal ]

I don't think I care about removal the fake options. I have had
systems that support real "more-reliable" memory for many years.

-Tony

