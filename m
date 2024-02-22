Return-Path: <linux-efi+bounces-647-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCB685F9E5
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 14:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4031C25369
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED45132C23;
	Thu, 22 Feb 2024 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEdzhZPT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA091426D;
	Thu, 22 Feb 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608897; cv=none; b=phe3GOSYVsG5tj7PastyGL6zl+CuZ/hcyFPbCBIHSGYWwhSAbGzbBi0gny44tUL7vth2EcKVBs3LGfRH6QBVQUeJpiqV2rzEedMB+X1bwH6D3/dKo4IldtK4qTwK1kKB9XLsWs3F5Qndt213l5P1QPzw7VWW0cjzOvHRS9umBUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608897; c=relaxed/simple;
	bh=FJNo02xrI7B578rCZqjEq5SuMvAu+CX0qSHZV36BLwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjRu67+EGqwOWfk8XqO+vLP/4zMwtJfh1v4iJXtM8+f/GGh1MxbKsdVcP7lsfG6B/UHTFBWFj4eRBBYM+pQ0f93TeoRVHLrtI//ttF2OVI3Xh0qWnxA8WUSFaS7eiNY+//rQrsv4xOtkCRPn6TrLGMqzhhcOkO5LGweLevyEfTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEdzhZPT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708608895; x=1740144895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FJNo02xrI7B578rCZqjEq5SuMvAu+CX0qSHZV36BLwM=;
  b=lEdzhZPTehL9Zq2b4MsDIijevHdwlbOgH+fdgBcvkyL2Np1RtL+kkyFG
   ge+xkFurKjgLn5ZDV1GH/XTrB6Zy9/IE38H38LAw2qqshI/ZP7nxlyxAS
   EZA2346+pA6+kD8skEqqPuQ1TKlld2oxkpnadgEnEBOVgxnmiwOJbdWNf
   +V8WaZRwwc5qbEblcNIQTfmY7MwzlKzAY7hWoUisyMTcy50aZq+36kizu
   g2doavq6PFS6Vuk1YpTXlxaWIBuEOhTcZzUXEq0aBKwJSuWHeHxiRZJsJ
   F+L2BmTiFu1BWawHXzGCAAVQ0lw3NDLL+4YjuzoNrMCL0JSMJkO6iRJ8M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13961551"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13961551"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:34:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936851039"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="936851039"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:34:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rd9Dr-00000006dff-1Lsn;
	Thu, 22 Feb 2024 15:34:47 +0200
Date: Thu, 22 Feb 2024 15:34:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, kernel-team@android.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Add post-init-providers binding to improve
 suspend/resume stability
Message-ID: <ZddNdqoqEz3BSXGI@smile.fi.intel.com>
References: <20240221233026.2915061-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221233026.2915061-1-saravanak@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 21, 2024 at 03:30:20PM -0800, Saravana Kannan wrote:
> This patch series adds a "post-init-providers" device tree binding that
> can be used to break dependency cycles in device tree and enforce a more
> determinstic probe/suspend/resume order. This will also improve the
> stability of global async probing and async suspend/resume and allow us
> to enable them more easily. Yet another step away from playing initcall
> chicken with probing and step towards fully async probing and
> suspend/resume.

Do you know what is the state of affairs in ACPI? Is there any (similar)
issue even possible?

-- 
With Best Regards,
Andy Shevchenko



