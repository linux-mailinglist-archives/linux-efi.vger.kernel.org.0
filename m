Return-Path: <linux-efi+bounces-2217-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 315DB9D9B05
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2024 17:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED83163D81
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2024 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9558D1D45F0;
	Tue, 26 Nov 2024 16:05:59 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8403EA69;
	Tue, 26 Nov 2024 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637159; cv=none; b=mk6j46cRBdOmC7crsABXnlndCMFetzmC3UsLeJp5RJh/JbVtb3842g6GFm1vvWO0jJuNQm9oMAx4BSQfIe7KJY3NyasrnX4eqOREsDh8+LrOP5MESXumwPAOuRgXAdT1r5uG6F62JWiumXd0xxUMHwAlpsyxU3IxRzlK+fxlYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637159; c=relaxed/simple;
	bh=GXwv1HKqijWy48hL2wUT+ydkY7fpI9pqOCnZhbRyzic=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ynj18c0M8bC701XdpPgQk3A6zqqFsFEAJQ7oR+JwgR42WhJFYj9ZV9aKgkwl1xwKbgJUpsPcMnGu+xlNxdfpKz0MoA+ryR98VPNwGhkgnlif9zga3ks3NCUKD6Q1k6R4Isn8XuoVJ1KsZfjilj4wqr3U5Ru3KcIm8/y44NDzGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XyS6J4QVnz6K8yn;
	Wed, 27 Nov 2024 00:03:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 100AF140B35;
	Wed, 27 Nov 2024 00:05:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Nov
 2024 17:05:54 +0100
Date: Tue, 26 Nov 2024 16:05:53 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Terry
 Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH v3 6/7] acpi/ghes, cper: Recognize and cache CXL
 Protocol errors
Message-ID: <20241126160553.00007c95@huawei.com>
In-Reply-To: <20241119003915.174386-7-Smita.KoralahalliChannabasappa@amd.com>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
	<20241119003915.174386-7-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 19 Nov 2024 00:39:14 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Add support in GHES to detect and process CXL CPER Protocol errors, as
> defined in UEFI v2.10, section N.2.13.
> 
> Define struct cxl_cper_prot_err_work_data to cache CXL protocol error
> information, including RAS capabilities and severity, for further
> handling.
> 
> These cached CXL CPER records will later be processed by workqueues
> within the CXL subsystem.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Looks fine,
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

