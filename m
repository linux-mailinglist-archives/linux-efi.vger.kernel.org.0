Return-Path: <linux-efi+bounces-357-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A52728275E7
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jan 2024 17:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFC61C21DF6
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jan 2024 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985C35103F;
	Mon,  8 Jan 2024 16:59:06 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DFB54663;
	Mon,  8 Jan 2024 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T80bY0X4rz6K6HP;
	Tue,  9 Jan 2024 00:57:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BB707140B63;
	Tue,  9 Jan 2024 00:58:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 16:58:56 +0000
Date: Mon, 8 Jan 2024 16:58:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, "Davidlohr Bueso" <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ard
 Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>
Subject: Re: [PATCH v5 0/9] efi/cxl-cper: Report CPER CXL component events
 through trace events
Message-ID: <20240108165855.00002f5a@Huawei.com>
In-Reply-To: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 20 Dec 2023 16:17:27 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Series status/background
> ========================
> 
> Smita has been a great help with this series.  Thank you again!
> 
> Smita's testing found that the GHES code ended up printing the events
> twice.  This version avoids the duplicate print by calling the callback
> from the GHES code instead of the EFI code as suggested by Dan.

I'm not sure this is working as intended. 

There is nothing gating the call in ghes_proc() of ghes_print_estatus()
and now the EFI code handling that pretty printed things is missing we get
the horrible kernel logging for an unknown block instead.

So I think we need some minimal code in cper.c to match the guids then not
log them (on basis we are arguing there is no need for new cper records).
Otherwise we are in for some messy kernel logs

Something like:

{1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
{1}[Hardware Error]: event severity: recoverable
{1}[Hardware Error]:  Error 0, type: recoverable
{1}[Hardware Error]:   section type: unknown, fbcd0a77-c260-417f-85a9-088b1621eba6
{1}[Hardware Error]:   section length: 0x90
{1}[Hardware Error]:   00000000: 00000090 00000007 00000000 0d938086  ................
{1}[Hardware Error]:   00000010: 00100000 00000000 00040000 00000000  ................
{1}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
{1}[Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
{1}[Hardware Error]:   00000040: 00000000 00000000 00000000 00000000  ................
{1}[Hardware Error]:   00000050: 00000000 00000000 00000000 00000000  ................
{1}[Hardware Error]:   00000060: 00000000 00000000 00000000 00000000  ................
{1}[Hardware Error]:   00000070: 00000000 00000000 00000000 00000000  ................
{1}[Hardware Error]:   00000080: 00000000 00000000 00000000 00000000  ................
cxl_general_media: memdev=mem1 host=0000:10:00.0 serial=4 log=Informational : time=0 uuid=fbcd0a77-c260-417f-85a9-088b1621eba6 len=0 flags='' handle=0 related_handle=0 maint_op_class=0 : dpa=0 dpa_flags='' descriptor='' type='ECC Error' transaction_type='Unknown' channel=0 rank=0 device=0 comp_id=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 validity_flags=''

(I'm filling the record with 0s currently)

