Return-Path: <linux-efi+bounces-1002-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 800F78B5EEA
	for <lists+linux-efi@lfdr.de>; Mon, 29 Apr 2024 18:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5DF1F240F4
	for <lists+linux-efi@lfdr.de>; Mon, 29 Apr 2024 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E111D84A48;
	Mon, 29 Apr 2024 16:25:18 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B2824AA;
	Mon, 29 Apr 2024 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407918; cv=none; b=ANu+fKdqUWsC8gJL/iYPetDRgrjZOP1XeSeoqjxbOgAA+ygIvUkPsyCxPj1/C3byRUuBATyqby5IU4LZx5EkzMraZDnYHALf8BYttGbax6Kce9orVNWN9pwjkeYb78BByrWmcFoIsFy/P0N5HPnd76ZFoeg5F0vM9snsKXHkDkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407918; c=relaxed/simple;
	bh=a6EmMsCwFc/i8ok2IvxLLJm/x4bDMvPrVvC5G7+MQY4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3xqbUvnTQsAd7uOIG7A0iIUXEqgLZr9y2O1nHyjf2g8L4pbq/m2KJQbZ5dNd9ECfDGWk4t5yqelnzMyaslXbyGJ05kkiehlJsgVAeUVbuwxPOe2UUEiYBlu76t05k+45TMOWTL/fNkuOrTx/yvGQcESD8ULJcYhR5IThKZPzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VSpWt68d6z67Zdq;
	Tue, 30 Apr 2024 00:22:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BD4EB1404F5;
	Tue, 30 Apr 2024 00:25:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Apr
 2024 17:25:12 +0100
Date: Mon, 29 Apr 2024 17:25:11 +0100
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
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] cxl/pci: Process CPER events
Message-ID: <20240429172511.00001caf@Huawei.com>
In-Reply-To: <20240426-cxl-cper3-v4-2-58076cce1624@intel.com>
References: <20240426-cxl-cper3-v4-0-58076cce1624@intel.com>
	<20240426-cxl-cper3-v4-2-58076cce1624@intel.com>
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

On Fri, 26 Apr 2024 20:34:01 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> If the firmware has configured CXL event support to be firmware first
> the OS will receive those events through CPER records.  The CXL layer has
> unique DPA to HPA knowledge and existing event trace parsing in
> place.[0]
> 
> Add a CXL CPER work item and register it with the GHES code to process
> CPER events.
> 
> Link: http://lore.kernel.org/r/cover.1711598777.git.alison.schofield@intel.com [0]
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



