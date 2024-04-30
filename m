Return-Path: <linux-efi+bounces-1005-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAB08B7FBE
	for <lists+linux-efi@lfdr.de>; Tue, 30 Apr 2024 20:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01321F24D1E
	for <lists+linux-efi@lfdr.de>; Tue, 30 Apr 2024 18:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9F22837A;
	Tue, 30 Apr 2024 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2LF3w5Q"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898423C9;
	Tue, 30 Apr 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501951; cv=none; b=NWMlBwRDRqTj7dcmKpTdbV4SOUIqLxMzqqHU9Qo+Ry1KtluD5wSi08rPFFWqGO3K1mU6m4xTaTvHTklM62hKqSr0UfzVrV0bz9Qn9F9aMekbDZ8t8x+NnQ2MUOOXNGccT90J7n/DO7UMIO1nd9w0V/86OVXYe6FdgfL1308TPlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501951; c=relaxed/simple;
	bh=sn8HIeJeJeVc1R6mxR/8VMnsMTi83wrrXNCYmLtB/kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjBP26sMAknlHEFtIsaCqa+er8W3TPboUpctR6HOi2S4q2rjR+YnM97QkdANg2/Z+eS6jLER7DcO7/UNj9AKNfhuqDwJc4tKVIFjWV8XJ0I5DoYBcN6jS1w9pFZv6saA+su16jaMC8PkXWjA3TZ3+Emy96sJWqkegIvA7x/pVBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2LF3w5Q; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714501950; x=1746037950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sn8HIeJeJeVc1R6mxR/8VMnsMTi83wrrXNCYmLtB/kk=;
  b=M2LF3w5Q6fX915fRlc0WbdRhSkMXUZQmT/R1yRmxBwx+ApgijBtwcOWQ
   6jyHzkoYxGuKXOIBjhoWqKFdvQRw7Nfa65kDTpCTHlcVYnRRjPlX7zOkZ
   YiD02XYwU9TZv6tTRjE1c3COOoj6VscMjw9Vyq2tLSIe+O9d8voD1WfSf
   /R79LBpyNRdj8P6y/CFTCIdlWgBO7EIEVIiotS/GfXfVtXGXh5W39CNJH
   NVd1qmzvyndThyvTiH3lUpOmUco8DUVBicfErbt6Bkl8L3HuKg/DMuPsC
   MVh4Kmq44Vg6h1i+ODNveOHOo9Q2pQZKHIBwLmyoI27DooqcAme6CWpLG
   w==;
X-CSE-ConnectionGUID: KAkH2ZAFRr2xZ7TBFcXZ7g==
X-CSE-MsgGUID: KTfzve/6Q527sQUmitdBvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10447766"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10447766"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 11:32:29 -0700
X-CSE-ConnectionGUID: 4LGhSSpnTYW270yu5bv0Yw==
X-CSE-MsgGUID: 1Eb4y7CjRMGfVLpIYkAbVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26555565"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 11:32:28 -0700
Date: Tue, 30 Apr 2024 11:32:27 -0700
From: Tony Luck <tony.luck@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 1/2] acpi/ghes: Process CXL Component Events
Message-ID: <ZjE5O87IxxMAoaFz@agluck-desk3>
References: <20240426-cxl-cper3-v4-0-58076cce1624@intel.com>
 <20240426-cxl-cper3-v4-1-58076cce1624@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426-cxl-cper3-v4-1-58076cce1624@intel.com>

On Fri, Apr 26, 2024 at 08:34:00PM -0700, Ira Weiny wrote:
> @@ -707,6 +805,18 @@ static bool ghes_do_proc(struct ghes *ghes,
>  		}
>  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>  			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
> +			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
> +
> +			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
> +			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
> +
> +			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
> +			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
> +
> +			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
>  		} else {
>  			void *err = acpi_hest_get_payload(gdata);

You pass "rec" to cxl_cper_post_event() in all these cases for later
processing in context where you can sleep to get locks. But that's
just a pointer somewhere into the "gdata" error record received from
BIOS.

What's the lifetime of that record? Can it be re-used/overwritten
before that other kernel thread gets around to looking at it?

-Tony

