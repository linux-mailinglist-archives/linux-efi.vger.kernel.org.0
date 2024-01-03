Return-Path: <linux-efi+bounces-305-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EC38233D7
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 18:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97318286759
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 17:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F211C2A3;
	Wed,  3 Jan 2024 17:51:00 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B871C296;
	Wed,  3 Jan 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T4xzP35nNz6JB4H;
	Thu,  4 Jan 2024 01:48:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CDFA1400D3;
	Thu,  4 Jan 2024 01:50:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Jan
 2024 17:50:48 +0000
Date: Wed, 3 Jan 2024 17:50:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Shiju Jose <shiju.jose@huawei.com>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave
 Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "Ard Biesheuvel" <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC v4 5/6] firmware/efi: Process CXL Component Events
Message-ID: <20240103175047.00001a55@Huawei.com>
In-Reply-To: <20231219171210.000078a6@Huawei.com>
References: <20230601-cxl-cper-v4-0-47bb901f135e@intel.com>
	<20230601-cxl-cper-v4-5-47bb901f135e@intel.com>
	<7ec6d2af-c860-9b05-7eaf-c82f50f8e66e@amd.com>
	<65674a71ef4d0_a1b25294e4@iweiny-mobl.notmuch>
	<20231213171351.00004579@Huawei.com>
	<657a2ff3bcc0b_25c9c7294ab@iweiny-mobl.notmuch>
	<20231219171210.000078a6@Huawei.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 19 Dec 2023 17:12:10 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 13 Dec 2023 14:28:03 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Jonathan Cameron wrote:  
> > > On Wed, 29 Nov 2023 06:28:01 -0800
> > > Ira Weiny <ira.weiny@intel.com> wrote:
> > >     
> > 
> > [snip]
> >   
> > > > > __packed attribute just for cper_cxl_event_rec still fails to properly 
> > > > > align structure elements. Looks like, __packed attribute is needed for 
> > > > > all structs (cper_cxl_event_devid and cper_cxl_event_sn) inside 
> > > > > cper_cxl_event_rec.
> > > > > 
> > > > > Seems easier to use global pragma instead.. I could test and obtain the 
> > > > > output as expected using pragma..      
> > > > 
> > > > I did not know that was acceptable in the kernel but I see you used it in
> > > > cper_cxl.h before...
> > > > 
> > > > Ok I'll do that and spin again.
> > > > 
> > > > Thanks so much for testing this!  I was out last week and still don't have
> > > > a test environment.    
> > > 
> > > Easy to hack into QEMU :)  Hmm. I have a CCIX patch set from years ago
> > > somewhere that does similar. Would be easy to repurposed. Looks like
> > > I never published them (just told people to ask if they wanted them :( ).
> > > 
> > > Anyhow, if useful I can dig them out.    
> > 
> > If you have a branch with them with a somewhat latest qemu that could work
> > too.  
> They are ancient and based on GHES emulation that got reworked before being
> merged. I had a quick go at a forwards port but this is a bigger job than
> I expected. May be a little while :(

Working again (embarrassingly I had the error source numbers reversed due
to a merge resolution that went wrong which took me a day to find). I'll flesh
out the injection but it will basically look like normal error injection
via qmp (json records) with a bonus parameter to stick them out as via
GHESv2 / CPER rather than AER internal error.  I've not figured out how
to wire HEST up for x86 emulation yet though so it's ARM virt only for now.
(HEST isn't created for x86 qemu machines whereas it is for arm virt with ras=on)
Obviously that emulation is wrong in all sorts of ways as I should be dealing
with firmware/OSPM negotiation and setting the messaging up etc but meh
- it works for exercising the code :)

On the plus side I get nice trace points using your series and Smita's one.
Quite a bit of data is 0s at the moment as I'm lazy and it's the end of the day
here - I'll fix that up later this week as I can see 'everything' in QEMU
and the register values etc are already handled via the native injection paths.

Jonathan

> 
> Jonathan
> 
> > 
> > Ira  
> 
> 


