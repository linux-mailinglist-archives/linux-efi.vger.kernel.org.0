Return-Path: <linux-efi+bounces-348-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5F6826F12
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jan 2024 13:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0C11C224BB
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jan 2024 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9957140C10;
	Mon,  8 Jan 2024 12:56:52 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F37040C13;
	Mon,  8 Jan 2024 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7vCC1jkdz67NNV;
	Mon,  8 Jan 2024 20:54:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 304D4140B2A;
	Mon,  8 Jan 2024 20:56:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 12:56:47 +0000
Date: Mon, 8 Jan 2024 12:56:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, "Davidlohr Bueso" <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ard
 Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 1/9] cxl/trace: Pass uuid explicitly to event traces
Message-ID: <20240108125646.00002c26@Huawei.com>
In-Reply-To: <20231220-cxl-cper-v5-1-1bb8a4ca2c7a@intel.com>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
	<20231220-cxl-cper-v5-1-1bb8a4ca2c7a@intel.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 20 Dec 2023 16:17:28 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> CXL CPER events are identified by the CPER Section Type GUID. The GUID
> correlates with the CXL UUID for the event record. It turns out that a
> CXL CPER record is a strict subset of the CXL event record, only the
> UUID header field is chopped.
> 
> In order to unify handling between native and CPER flavors of CXL
> events, prepare the code for the UUID to be passed in rather than
> inferred from the record itself.
> 
> Later patches update the passed in record to only refer to the common
> data between the formats.
> 
> Pass the UUID explicitly to each trace event to be able to remove the
> UUID from the event structures.
> 
> Originally it was desirable to remove the UUID from the well known event
> because the UUID value was redundant.  However, the trace API was
> already in place.[1]
> 
> [1] https://lore.kernel.org/all/36f2d12934d64a278f2c0313cbd01abc@huawei.com/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



