Return-Path: <linux-efi+bounces-448-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B2E845627
	for <lists+linux-efi@lfdr.de>; Thu,  1 Feb 2024 12:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D1EB2592B
	for <lists+linux-efi@lfdr.de>; Thu,  1 Feb 2024 11:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F8115CD48;
	Thu,  1 Feb 2024 11:23:21 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CE815B970;
	Thu,  1 Feb 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706786601; cv=none; b=tCHMHEFsojt0LUcgpj1kCFZCDp54z0yFIfUI0yuge+l/fgU9oYuNRB0tJqh1+s/2QDB0rtwylAzWZRVUwADabKBSZnCDrxrgAkIIyb8pDPIXnTUNvFtOcfpKn8T7hXXKNyWFEvpWmwYq0g1k3h4M5Q9aBaqOVqIIwL6AiTuhZ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706786601; c=relaxed/simple;
	bh=lix+9YkAqqOOpOyydIQmC81jZuQWHhwyMTu4skQlNZA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P04tWhVladxosxb/G9Dg1j7bxwwBm2jnceX1zOllEsGolBnT5U510l6DcSgkMrDUei6mE4R2NHNklOPnlcp/R1/xFiGuF1NcYSmgWx8xwFGCeVYF4I105JEnXU2Vz6Pi17ybVK/dGEH2xSFqVnaZe7mUfpUNZAs4kBIcmvF86tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TQbzW5Mgrz6K807;
	Thu,  1 Feb 2024 19:20:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B27951409EA;
	Thu,  1 Feb 2024 19:23:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 1 Feb
 2024 11:23:15 +0000
Date: Thu, 1 Feb 2024 11:23:14 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/trace: Remove unnecessary memcpy's
Message-ID: <20240201112314.00005dbc@Huawei.com>
In-Reply-To: <ZbrxQ+FehE6nq9w5@aschofie-mobl2>
References: <20240131-cxl-cper-fixups-v1-0-335c85b1d77b@intel.com>
	<20240131-cxl-cper-fixups-v1-2-335c85b1d77b@intel.com>
	<ZbrxQ+FehE6nq9w5@aschofie-mobl2>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 31 Jan 2024 17:17:55 -0800
Alison Schofield <alison.schofield@intel.com> wrote:

> On Wed, Jan 31, 2024 at 03:55:39PM -0800, Ira Weiny wrote:
> > CPER events don't have UUIDs.  Therefore UUIDs were removed from the
> > records passed to trace events and replaced with hard coded values.
> > 
> > As pointed out by Jonathan, the new defines for the UUIDs present a more
> > efficient way to assign UUID in trace records.[1]
> > 
> > Replace memcpy's with the use of static data.  
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> 
> > 
> > [1] https://lore.kernel.org/all/20240108132325.00000e9c@Huawei.com/
> > 
> > Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/cxl/core/trace.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index 89445435303a..bdf117a33744 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -338,7 +338,7 @@ TRACE_EVENT(cxl_general_media,
> >  
> >  	TP_fast_assign(
> >  		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> > -		memcpy(&__entry->hdr_uuid, &CXL_EVENT_GEN_MEDIA_UUID, sizeof(uuid_t));
> > +		__entry->hdr_uuid = CXL_EVENT_GEN_MEDIA_UUID;
> >  
> >  		/* General Media */
> >  		__entry->dpa = le64_to_cpu(rec->phys_addr);
> > @@ -425,7 +425,7 @@ TRACE_EVENT(cxl_dram,
> >  
> >  	TP_fast_assign(
> >  		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> > -		memcpy(&__entry->hdr_uuid, &CXL_EVENT_DRAM_UUID, sizeof(uuid_t));
> > +		__entry->hdr_uuid = CXL_EVENT_DRAM_UUID;
> >  
> >  		/* DRAM */
> >  		__entry->dpa = le64_to_cpu(rec->phys_addr);
> > @@ -573,7 +573,7 @@ TRACE_EVENT(cxl_memory_module,
> >  
> >  	TP_fast_assign(
> >  		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> > -		memcpy(&__entry->hdr_uuid, &CXL_EVENT_MEM_MODULE_UUID, sizeof(uuid_t));
> > +		__entry->hdr_uuid = CXL_EVENT_MEM_MODULE_UUID;
> >  
> >  		/* Memory Module Event */
> >  		__entry->event_type = rec->event_type;
> > 
> > -- 
> > 2.43.0
> >   
> 


