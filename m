Return-Path: <linux-efi+bounces-8-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6D47E37F6
	for <lists+linux-efi@lfdr.de>; Tue,  7 Nov 2023 10:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF5EAB20BB0
	for <lists+linux-efi@lfdr.de>; Tue,  7 Nov 2023 09:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7E611C8B;
	Tue,  7 Nov 2023 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51169111A4;
	Tue,  7 Nov 2023 09:38:20 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB292;
	Tue,  7 Nov 2023 01:38:19 -0800 (PST)
Received: from lhrpeml100001.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SPjjl0dvWz67mKT;
	Tue,  7 Nov 2023 17:34:51 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100001.china.huawei.com (7.191.160.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 7 Nov 2023 09:38:16 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.031;
 Tue, 7 Nov 2023 09:38:16 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH RFC v3 1/6] cxl/trace: Remove uuid from event trace known
 events
Thread-Topic: [PATCH RFC v3 1/6] cxl/trace: Remove uuid from event trace known
 events
Thread-Index: AQHaDQgRQ2vINXGk70OHbaqSCzYaYrBoqc8AgAAYFhCABR7LgIAAwHxA
Date: Tue, 7 Nov 2023 09:38:16 +0000
Message-ID: <36f2d12934d64a278f2c0313cbd01abc@huawei.com>
References: <20230601-cxl-cper-v3-0-0189d61f7956@intel.com>
 <20230601-cxl-cper-v3-1-0189d61f7956@intel.com>
 <20231103142756.00000e20@Huawei.com>
 <547d055eb85d4cee9c636c69e89a82ed@huawei.com>
 <65496333c1dc9_90fed29479@iweiny-mobl.notmuch>
In-Reply-To: <65496333c1dc9_90fed29479@iweiny-mobl.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.126.168.44]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected

Hi Ira,

>-----Original Message-----
>From: Ira Weiny <ira.weiny@intel.com>
>Sent: 06 November 2023 22:06
>To: Shiju Jose <shiju.jose@huawei.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; Ira Weiny <ira.weiny@intel.com>
>Cc: Dan Williams <dan.j.williams@intel.com>; Smita Koralahalli
><Smita.KoralahalliChannabasappa@amd.com>; Yazen Ghannam
><yazen.ghannam@amd.com>; Davidlohr Bueso <dave@stgolabs.net>; Dave
>Jiang <dave.jiang@intel.com>; Alison Schofield <alison.schofield@intel.com=
>;
>Vishal Verma <vishal.l.verma@intel.com>; Ard Biesheuvel <ardb@kernel.org>;
>linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>cxl@vger.kernel.org
>Subject: RE: [PATCH RFC v3 1/6] cxl/trace: Remove uuid from event trace kn=
own
>events
>
>Shiju Jose wrote:
>>
>>
>> >-----Original Message-----
>> >From: Jonathan Cameron <jonathan.cameron@huawei.com>
>> >Sent: 03 November 2023 14:28
>> >To: Ira Weiny <ira.weiny@intel.com>
>> >Cc: Dan Williams <dan.j.williams@intel.com>; Smita Koralahalli
>> ><Smita.KoralahalliChannabasappa@amd.com>; Yazen Ghannam
>> ><yazen.ghannam@amd.com>; Davidlohr Bueso <dave@stgolabs.net>; Dave
>> >Jiang <dave.jiang@intel.com>; Alison Schofield
>> ><alison.schofield@intel.com>; Vishal Verma
>> ><vishal.l.verma@intel.com>; Ard Biesheuvel <ardb@kernel.org>;
>> >linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>> >cxl@vger.kernel.org; Shiju Jose <shiju.jose@huawei.com>
>> >Subject: Re: [PATCH RFC v3 1/6] cxl/trace: Remove uuid from event
>> >trace known events
>> >
>> >On Wed, 01 Nov 2023 14:11:18 -0700
>> >Ira Weiny <ira.weiny@intel.com> wrote:
>> >
>> >> The uuid printed in the well known events is redundant.  The uuid
>> >> defines what the event was.
>> >>
>> >> Remove the uuid from the known events and only report it in the
>> >> generic event as it remains informative there.
>> >>
>> >> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>> >> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> >> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>> >
>> >Removing the print is fine, but look like this also removes the
>> >actual trace point field.  That's userspace ABI.  Expanding it is
>> >fine, but taking fields away is more problematic.
>> >
>> >Are we sure we don't break anyone?  Shiju, will rasdaemon be fine
>> >with this change?
>>
>> The field hdr_uuid is removed from the common CXL_EVT_TP_entry shared
>> by the trace events cxl_generic_event, cxl_general_media, cxl_dram and
>cxl_memory_module .
>> rasdaemon will break because of this while processing these trace
>> events and also affects the corresponding error records in the SQLite da=
ta
>base.
>> Rasdaemon needs update to avoid this.
>>
>
>Ok we can leave the uuid field in easy enough.
>
>But does rasdaemon use the value of the field for anything?  In other word=
s does
>CPER record processing need to generate a proper UUID value?
No. Presently used for logging purpose only in the rasdaemon.

>
>Ira

Thanks,
Shiju

