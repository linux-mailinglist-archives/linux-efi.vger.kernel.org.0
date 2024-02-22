Return-Path: <linux-efi+bounces-646-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A185F9DA
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 14:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DB71F2153A
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 13:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44EC131E5C;
	Thu, 22 Feb 2024 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H650JHo3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28F3C480;
	Thu, 22 Feb 2024 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608778; cv=none; b=PWfPFUUxhQWXePooAX6GqeKjCH+WrMgw126hFXJCX05KV989LiPKZ2A8qekT6uZwa5hhD7Ah/Jp384Kr+dETBtBjya1uj7NaZQJGJZn8CYo8ITom9vWdO2ichvUarpHrLR8rNuKqJrpKAPj+eRXF524KRYrRX4c8kriZkOFp1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608778; c=relaxed/simple;
	bh=to4Ipw+eCpB5bmrx4T/4XN3XHMiieJqUqhIVN5Bez2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+sJmEh7ofMVfRxwibO9fgl0Mopm1nt7H3vvQQDwj0vv3K75mbXgiTqELnk1lc0iMWIG8IoP0KSEvQmphs7mVg4zL5AbX2rtXN/48Ev7QIEq41JU96Ndsec94Ac9/uM0c551SRfzyKmp6fWUcvKSiQ+bzr1JGWseZ+aPslx1vyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H650JHo3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708608777; x=1740144777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=to4Ipw+eCpB5bmrx4T/4XN3XHMiieJqUqhIVN5Bez2o=;
  b=H650JHo3Kir9h91Agl5GBo/F4Vb1xpDHs88WJxHzsSMcxsGAcKYLW5R3
   CjTq0L4cjqqCSTSAUXwUEC5pPdnXqv2Qa+05lFChR0vZh7g65YOfjlktw
   U7FI6LXs9sf0L/tBYxgZ/WXsvzqCFXrksstwR3uXMW7AR+4uZzvNPTzbw
   SpzheH7XsQrcA/5USWajJZCbXrK8RgkiSQLdvLaDC0ecxfaGUE5AQXFxI
   7UL9W7WeuYqjUkoTmtzxdIwdc+K+EWhiSqY8isuvn1yyGudsbdjDpKPOa
   MQhzaIRltya/9nsUZR7dQG+qKs+uRqNnIm2zJ730OqTfYyZUJpr2Cqm+u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25293660"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="25293660"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:32:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913526182"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913526182"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:32:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rd9Bx-00000006deC-0kGg;
	Thu, 22 Feb 2024 15:32:49 +0200
Date: Thu, 22 Feb 2024 15:32:48 +0200
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
Subject: Re: [PATCH v3 4/4] of: property: fw_devlink: Add support for
 "post-init-providers" property
Message-ID: <ZddNAHqwCNR5MZc4@smile.fi.intel.com>
References: <20240221233026.2915061-1-saravanak@google.com>
 <20240221233026.2915061-5-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221233026.2915061-5-saravanak@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 21, 2024 at 03:30:24PM -0800, Saravana Kannan wrote:
> Add support for this property so that dependency cycles can be broken and
> fw_devlink can do better probe/suspend/resume ordering between devices in a
> dependency cycle.

...

> -	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np), 0);
> +	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np),
> +			flags);

I would leave it one line despite being 83 characters long.

...

> -			of_link_to_phandle(con_dev_np, phandle);
> +			of_link_to_phandle(con_dev_np, phandle,
> +					   s->fwlink_flags);

I would leave this on one line, it's only 81 characters.

-- 
With Best Regards,
Andy Shevchenko



