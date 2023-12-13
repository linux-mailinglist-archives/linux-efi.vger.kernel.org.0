Return-Path: <linux-efi+bounces-200-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10597811A9C
	for <lists+linux-efi@lfdr.de>; Wed, 13 Dec 2023 18:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A371F1C209AB
	for <lists+linux-efi@lfdr.de>; Wed, 13 Dec 2023 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFC33A28E;
	Wed, 13 Dec 2023 17:13:59 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DEB116;
	Wed, 13 Dec 2023 09:13:55 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sr28Y3J8Sz67QZL;
	Thu, 14 Dec 2023 01:11:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A82F140595;
	Thu, 14 Dec 2023 01:13:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Dec
 2023 17:13:52 +0000
Date: Wed, 13 Dec 2023 17:13:51 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Shiju Jose <shiju.jose@huawei.com>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "Ard Biesheuvel" <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC v4 5/6] firmware/efi: Process CXL Component Events
Message-ID: <20231213171351.00004579@Huawei.com>
In-Reply-To: <65674a71ef4d0_a1b25294e4@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v4-0-47bb901f135e@intel.com>
	<20230601-cxl-cper-v4-5-47bb901f135e@intel.com>
	<7ec6d2af-c860-9b05-7eaf-c82f50f8e66e@amd.com>
	<65674a71ef4d0_a1b25294e4@iweiny-mobl.notmuch>
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

On Wed, 29 Nov 2023 06:28:01 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Smita Koralahalli wrote:
> > Hi Ira,
> > 
> > I tested this out. Just one correction below to make it work.
> >   
> 
> [snip]
> 
> > > +
> > > +#define CPER_CXL_DEVICE_ID_VALID		BIT(0)
> > > +#define CPER_CXL_DEVICE_SN_VALID		BIT(1)
> > > +#define CPER_CXL_COMP_EVENT_LOG_VALID		BIT(2)
> > > +struct cper_cxl_event_rec {
> > > +	struct {
> > > +		u32 length;
> > > +		u64 validation_bits;
> > > +		struct cper_cxl_event_devid {
> > > +			u16 vendor_id;
> > > +			u16 device_id;
> > > +			u8 func_num;
> > > +			u8 device_num;
> > > +			u8 bus_num;
> > > +			u16 segment_num;
> > > +			u16 slot_num; /* bits 2:0 reserved */
> > > +			u8 reserved;
> > > +		} device_id;
> > > +		struct cper_cxl_event_sn {
> > > +			u32 lower_dw;
> > > +			u32 upper_dw;
> > > +		} dev_serial_num;
> > > +	} hdr;
> > > +
> > > +	union cxl_event event;
> > > +} __packed;  
> > 
> > __packed attribute just for cper_cxl_event_rec still fails to properly 
> > align structure elements. Looks like, __packed attribute is needed for 
> > all structs (cper_cxl_event_devid and cper_cxl_event_sn) inside 
> > cper_cxl_event_rec.
> > 
> > Seems easier to use global pragma instead.. I could test and obtain the 
> > output as expected using pragma..  
> 
> I did not know that was acceptable in the kernel but I see you used it in
> cper_cxl.h before...
> 
> Ok I'll do that and spin again.
> 
> Thanks so much for testing this!  I was out last week and still don't have
> a test environment.

Easy to hack into QEMU :)  Hmm. I have a CCIX patch set from years ago
somewhere that does similar. Would be easy to repurposed. Looks like
I never published them (just told people to ask if they wanted them :( ).

Anyhow, if useful I can dig them out.

> 
> Ira


