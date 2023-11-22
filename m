Return-Path: <linux-efi+bounces-78-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 308AE7F4351
	for <lists+linux-efi@lfdr.de>; Wed, 22 Nov 2023 11:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6970D1C2084A
	for <lists+linux-efi@lfdr.de>; Wed, 22 Nov 2023 10:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EED23C6AE;
	Wed, 22 Nov 2023 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUZKtBcH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3778E112;
	Wed, 22 Nov 2023 02:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700647929; x=1732183929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ekVyR2LTJTYq3ZM1BPKwRkdTVcMVyNkfXXO7GdIDxpQ=;
  b=mUZKtBcHFbuzBYKXkL7haGA/QKAXCprwNPULGH5lD2zgcDuCDM8UNf5V
   x5y/zSwJNeOAGXbV0cK6RuXcVUHA0y9JscECMZwviVxt43tKCOAfY5HTx
   qHsI/vAQqO8ZFoHLqdspP7u4+MMPfAZ/CWVJXDhLDF2qVaEjhjeKsA57p
   wTKuBdKa4Vv/7Q6BGLMozqgBVX6Vcp97F7f3+ULPU8S5iRa6P62w0c3vm
   5DjGIW7bdgSTq6jUqLpFivrfmPVFaDFw/3a1kG4NVMD7/mNC2XuK7JJPa
   q4JGmJuAiG6efQg0cJOg2/uc8kHQROOtq2iBD3tBG9X5BMFneThfvceUk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="395945573"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="395945573"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="832958152"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="832958152"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:12:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r5kDB-0000000G3jf-2eSS;
	Wed, 22 Nov 2023 12:12:01 +0200
Date: Wed, 22 Nov 2023 12:12:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Raag Jadav <raag.jadav@intel.com>, mika.westerberg@linux.intel.com,
	lenb@kernel.org, robert.moore@intel.com, ardb@kernel.org,
	will@kernel.org, mark.rutland@arm.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 2/6] ACPI: bus: update acpi_dev_uid_match() to support
 multiple types
Message-ID: <ZV3T8c_1L77h5CsA@smile.fi.intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
 <20231121103829.10027-3-raag.jadav@intel.com>
 <CAJZ5v0jmaRQWfO_mM4GZ8mEFftuSNgt36=tJ5vC2Uw7MAcpYJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jmaRQWfO_mM4GZ8mEFftuSNgt36=tJ5vC2Uw7MAcpYJg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 21, 2023 at 08:25:20PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 21, 2023 at 11:38 AM Raag Jadav <raag.jadav@intel.com> wrote:
> >
> > According to ACPI specification, a _UID object can evaluate to either
> > a numeric value or a string. Update acpi_dev_uid_match() helper to
> > support _UID matching for both integer and string types.
> >
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> You need to be careful with using this.  There are some things below
> that go beyond what I have suggested.

Same to me and actually I've asked several times to remove this tag of mine!

-- 
With Best Regards,
Andy Shevchenko



