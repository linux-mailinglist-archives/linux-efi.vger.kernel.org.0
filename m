Return-Path: <linux-efi+bounces-383-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA3D829C71
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jan 2024 15:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9EF1F29EB4
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jan 2024 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0676F495C5;
	Wed, 10 Jan 2024 14:22:15 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC824B5A1;
	Wed, 10 Jan 2024 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T990f3nsfz6K977;
	Wed, 10 Jan 2024 22:19:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 78450140B38;
	Wed, 10 Jan 2024 22:22:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Jan
 2024 14:22:05 +0000
Date: Wed, 10 Jan 2024 14:22:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, "Davidlohr Bueso" <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ard
 Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 4/9] cxl/events: Remove passing a UUID to known event
 traces
Message-ID: <20240110142205.0000164e@Huawei.com>
In-Reply-To: <659dd8f467dbe_5cee29456@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
	<20231220-cxl-cper-v5-4-1bb8a4ca2c7a@intel.com>
	<20240108132325.00000e9c@Huawei.com>
	<659dd8f467dbe_5cee29456@dwillia2-xfh.jf.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 9 Jan 2024 15:38:28 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Wed, 20 Dec 2023 16:17:31 -0800
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >   
> > > The UUID data is redundant in the known event trace types.  The addition
> > > of static defines allows the trace macros to create the UUID data inside
> > > the trace thus removing unnecessary code.
> > > 
> > > Have well known trace events use static data to set the uuid field based
> > > on the event type.
> > > 
> > > Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > >   
> >   
> > >  	TP_STRUCT__entry(
> > >  		CXL_EVT_TP_entry
> > > @@ -422,7 +424,8 @@ TRACE_EVENT(cxl_dram,
> > >  	),
> > >  
> > >  	TP_fast_assign(
> > > -		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, rec->hdr);
> > > +		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> > > +		memcpy(&__entry->hdr_uuid, &CXL_EVENT_DRAM_UUID, sizeof(uuid_t));  
> > 
> > Hmm. Why not
> > 
> > 		__entry->hdr_uuid = CXL_EVENT_DRAM_UUID;
> > ?
> > 
> > Compiler should be able to squish the stuff in the define down to data as as the
> > UUID generation logic is pretty simple.
> > 
> > I've not emulated the cper records for these yet, so not tested that works beyond
> > compiling.  
> 
> We can follow on with this conversion later as I see other usage of uuid
> copying in trace events (bcache for instance). Although I probably would
> not replace it with straight assignment and instead use the uuid_copy()
> helper. Otherwise, why do {uuid,guid}_copy() helpers exist?

To copy unknown uuids and guids where the compiler can't optimize things
nearly as well because it can't see the values. 

Jonathan


