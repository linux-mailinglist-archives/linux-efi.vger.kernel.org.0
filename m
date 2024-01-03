Return-Path: <linux-efi+bounces-300-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A35822B83
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 11:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E4AB21E0A
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 10:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8A418E08;
	Wed,  3 Jan 2024 10:41:21 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5518E00;
	Wed,  3 Jan 2024 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T4mSP48zFz6K6Jp;
	Wed,  3 Jan 2024 18:39:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D418A140B2F;
	Wed,  3 Jan 2024 18:41:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Jan
 2024 10:41:15 +0000
Date: Wed, 3 Jan 2024 10:41:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, "Davidlohr Bueso" <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ard
 Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH v4 7/7] cxl/memdev: Register for and process CPER events
Message-ID: <20240103104113.000024c0@Huawei.com>
In-Reply-To: <658235548ca6c_2edf029490@iweiny-mobl.notmuch>
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
	<20231215-cxl-cper-v4-7-01b6dab44fcd@intel.com>
	<20231219143732.0000181e@Huawei.com>
	<658226c9a49f3_277bd294fb@iweiny-mobl.notmuch>
	<65822909ebe4c_269bd294f5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<658235548ca6c_2edf029490@iweiny-mobl.notmuch>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 19 Dec 2023 16:29:08 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Dan Williams wrote:
> > Ira Weiny wrote:
> > [..]  
> > > > and drop the = NULL above.  
> > > 
> > > Done.  
> > 
> > The NULL assignment was more about making it clear that
> > __free(pci_dev_put) will take no action until the pdev is acquired.
> > Otherwise, any future refactoring that introduces a 'return' before
> > @pdev is acquired needs to be careful to assign @pdev to NULL. So, just
> > include it in the declaration more as a __free() declaration style issue
> > than a correctness issue.  
> 
> I think he meant the assignment to cxlds.  At least that is the NULL
> assignment I took out.
> 
> Ira

yup.  The other one is correct as Dan pointed out.

