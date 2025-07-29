Return-Path: <linux-efi+bounces-4493-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCBEB147B1
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jul 2025 07:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884673ACF52
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jul 2025 05:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E0823535A;
	Tue, 29 Jul 2025 05:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6kfYEMm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322386250;
	Tue, 29 Jul 2025 05:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767726; cv=none; b=Jw3OR37insU9v520WQNYY9IGEqBZ4uDGaepuZtqFFnTNrq7y/BQKJMrykuUfTVhJZWDwwOsxgXM9OdoTB5fds4ZEiqiaXMYy6Wxc1DkRrCFkJeV5hCMn87m9p5jdRdf7qiMduhSlOwEaINXirx7ud5iY/dCqVr1GA6jzmDDYtGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767726; c=relaxed/simple;
	bh=zW+H0+MpviuGnEP+uGGy+bWOqykVTj+bOH8fIF6/mRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pi/xuoLYk+jvhosx+LP2rEzgTZGMeMYADW0Jk00vJmBOt9QDbGxEiqsDERFCJroFbQH4GKvwC8W+rNS1JoidfafYpLevok/HbvZMaXXeYxGAJbD/cw6CMwFKh4gRc/Xw56Ure6a1d3G8HZrqaFBlTcjXijJjIIEFdPQkUcPQPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M6kfYEMm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753767724; x=1785303724;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zW+H0+MpviuGnEP+uGGy+bWOqykVTj+bOH8fIF6/mRc=;
  b=M6kfYEMmQK2r+Y+cYn/QpOkEO0OXuI5NZBZRsvvZHdLHIQmJSitlVUMG
   jBYzq2YXGMWTD5J9Vu7ewQxeGV2Z6wHzIyJhJBWfwVrxY/bTK/dDxgVEj
   8OJQT+VgFDYKk8tbbuTAoPs23qErdNnvx+nuhZX9F8qNOnl2chKGCHKoH
   XPayPSnqcD4IakNJsr/cjmf8AhMYmwqURsbllIbFR9FN3XKvFf6jui/H1
   dGsundTelmfyjkwXWiyfCnOIBhJ2kC8RLIK4gyIsi71Quwf3WnTPQB1WF
   Hrks5nl/bk6zTrMqjB7u5icLO8FF7tdk+s8rx/I2XfThW/XHE1P/KPmg1
   Q==;
X-CSE-ConnectionGUID: xLG2MfE6S+Ws92wckTW9QQ==
X-CSE-MsgGUID: A78qoROPSQmQlDmG2Zcl/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="59829002"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="59829002"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 22:42:03 -0700
X-CSE-ConnectionGUID: 0WTSdhJRQRqeVvlEQdiLjQ==
X-CSE-MsgGUID: wbhnLJhNSBmvcP/WZSLqcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="163384314"
Received: from kmlindbe-mobl.amr.corp.intel.com (HELO [10.125.192.163]) ([10.125.192.163])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 22:42:03 -0700
Message-ID: <ef9c9418-2def-484a-89fb-b0235391ad83@linux.intel.com>
Date: Mon, 28 Jul 2025 22:41:54 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "invalid agent type: 1" in acpi/ghes, cper: Recognize and cache
 CXL Protocol errors
To: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, tony.luck@intel.com,
 Gregory Price <gourry@gourry.net>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-5-Smita.KoralahalliChannabasappa@amd.com>
 <074f5f77-7bef-4857-97fe-b68ee9b0afaf@linux.intel.com>
 <dfc6cedd-c125-4201-a98b-cbaa84a4f370@amd.com>
Content-Language: en-GB
From: Marc Herbert <marc.herbert@linux.intel.com>
In-Reply-To: <dfc6cedd-c125-4201-a98b-cbaa84a4f370@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-07-28 09:25, Koralahalli Channabasappa, Smita wrote:

> On 7/22/2025 12:24 PM, Marc Herbert wrote:

>>    The code below triggers the error "invalid agent type: 1" in Intel
>> validation (internal issue 15018133056)
>>
>> It's not clear to anyone we asked why you did not include RCH_DP in
>> the `switch (prot_err->agent_type)` in cxl_cper_post_prot_err() below.
>>
>> I can see how RCH_DP is special in cxl_cper_PRINT_prot_err() and I can
>> even understand (despite my near-zero CPER knowledge) some of the
>> special cases there. But in cxl_cper_post_prot_err() here, it's not
>> clear why RCH_DP would be rejected. Could this be an oversight? If not,
>> a comment with a short explanation would not hurt.
>>
> 
> You're right. RCH_DP was excluded because it doesn’t report a valid
> SBDF in the CPER record. Instead, it provides only the RCRB base
> address.
> 
> I haven't thoroughly investigated whether SBDF can be reliably derived
> from the RCRB base. There might be a platform-specific mechanism for
> that, but at the time, it seemed non-trivial to implement. Introducing
> additional infrastructure solely to support RCH_DP felt like it was
> adding more complexity.
> 
> I agree that a brief comment explaining this rationale would help. I'm
> okay if you plan to include a fixup for this along with the one for
> the device serial number.

If I understood you correctly, I think a different error message
would be much better than a comment. Like this?

--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -730,6 +730,9 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
 		wd.severity = cper_severity_to_aer(severity);
 		break;
+	case RCH_DP:
+		pr_err_ratelimited("CXL CPER agent type unsupported: RCH_DP\n");
+		return;
 	default:
 		pr_err_ratelimited("CXL CPER invalid agent type: %d\n",
 				   prot_err->agent_type);

