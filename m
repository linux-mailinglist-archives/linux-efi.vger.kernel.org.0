Return-Path: <linux-efi+bounces-1001-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 516128B5EE8
	for <lists+linux-efi@lfdr.de>; Mon, 29 Apr 2024 18:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC89281151
	for <lists+linux-efi@lfdr.de>; Mon, 29 Apr 2024 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0B784A48;
	Mon, 29 Apr 2024 16:24:28 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E0824AA;
	Mon, 29 Apr 2024 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407868; cv=none; b=kBYRe7lp0RWoBJ167lV4FT2iWyJuBXfuT/5jMwr6Jtno99XOwSgFv0RJ7+1ZEhwXlNySFYzOgUv/9yqGUs+skRLUoofrzQsAhEs7DK2gLagWw+t5kYaYvD5WH1PDVsDlTiZECI1EYJ5Tq3S7ApVwwgpHGKOS/j0aPl1fWUPTv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407868; c=relaxed/simple;
	bh=3BVV/eVaeyIqnDdV64YCAwRwJzsCPrPlALPlAwheUtU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZD4bbjnp4IRBOsQCD5PMRt1ZSC//YpNPQlFkzYcxvL+W2Uuu6OI2cTb+fmShs9SVv7WlC/K2zfu3g2kTpAZC7+tONIv9PovCQwirfrsYcFSoq5ga/O9mrYl3nzR8iV7wum3EM9jj/pMXXzhvLFkXgfAKumbiyOPAeS2xlmwZvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VSpVx6Qvlz6GDB4;
	Tue, 30 Apr 2024 00:21:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A879140B39;
	Tue, 30 Apr 2024 00:24:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Apr
 2024 17:24:19 +0100
Date: Mon, 29 Apr 2024 17:24:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, "Yazen Ghannam"
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Tony
 Luck" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 1/2] acpi/ghes: Process CXL Component Events
Message-ID: <20240429172418.0000534c@Huawei.com>
In-Reply-To: <20240426-cxl-cper3-v4-1-58076cce1624@intel.com>
References: <20240426-cxl-cper3-v4-0-58076cce1624@intel.com>
	<20240426-cxl-cper3-v4-1-58076cce1624@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 26 Apr 2024 20:34:00 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> BIOS can configure memory devices as firmware first.  This will send CXL
> events to the firmware instead of the OS.  The firmware can then inform
> the OS of these events via UEFI.
> 
> UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> format for CXL Component Events.  The format is mostly the same as the
> CXL Common Event Record Format.  The difference lies in the use of a
> GUID as the CPER Section Type which matches the UUID defined in CXL 3.1
> Table 8-43.
> 
> Currently a configuration such as this will trace a non standard event
> in the log omitting useful details of the event.  In addition the CXL
> sub-system contains additional region and HPA information useful to the
> user.[0]
> 
> The CXL code is required to be called from process context as it needs
> to take a device lock.  The GHES code may be in interrupt context.  This
> complicated the use of a callback.  Dan Williams suggested the use of
> work items as an atomic way of switching between the callback execution
> and a default handler.[1]
> 
> The use of a kfifo simplifies queue processing by providing lock free
> fifo operations.  cxl_cper_kfifo_get() allows easier management of the
> kfifo between the ghes and cxl modules.
> 
> CXL 3.1 Table 8-127 requires a device to have a queue depth of 1 for
> each of the four event logs.  A combined queue depth of 32 is chosen to
> provide room for 8 entries of each log type.
> 
> Add GHES support to detect CXL CPER records.  Add the ability for the
> CXL sub-system to register a work queue to process the events.
> 
> This patch adds back the functionality which was removed to fix the
> report by Dan Carpenter[2].
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Link: http://lore.kernel.org/r/cover.1711598777.git.alison.schofield@intel.com [0]
> Link: http://lore.kernel.org/r/65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch [1]
> Link: http://lore.kernel.org/r/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain [2]
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Totally trivial comment inline.  Maybe Dave can tweak whilst applying...


Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 03fa6d50d46f..a0067c49e2ca 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -3,6 +3,8 @@
>  #ifndef _LINUX_CXL_EVENT_H
>  #define _LINUX_CXL_EVENT_H
>  
> +#include <linux/workqueue_types.h>
> +
>  /*
>   * Common Event Record Format
>   * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> @@ -140,4 +142,29 @@ struct cxl_cper_event_rec {
>  	union cxl_event event;
>  } __packed;
>  
> +struct cxl_cper_work_data {
> +	enum cxl_event_type event_type;
> +	struct cxl_cper_event_rec rec;
> +};
> +
> +#ifdef CONFIG_ACPI_APEI_GHES
> +int cxl_cper_register_work(struct work_struct *work);
> +int cxl_cper_unregister_work(struct work_struct *work);
> +int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
> +#else
> +static inline int cxl_cper_register_work(struct work_struct *work);
> +{
> +	return 0;
> +}
> +
> +static inline int cxl_cper_unregister_work(struct work_struct *work);
> +{
> +	return 0;
> +}

Trivial note of the day: Inconsistent spacing - add a blank line here.

> +static inline int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #endif /* _LINUX_CXL_EVENT_H */
> 


