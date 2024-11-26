Return-Path: <linux-efi+bounces-2211-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA2B9D9A24
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2024 16:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582A1281861
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2024 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AD81D54E3;
	Tue, 26 Nov 2024 15:05:25 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572D478C6D;
	Tue, 26 Nov 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633525; cv=none; b=Hw8UFWH/o7jz0D7Da3zU/4adGb650J6+nEkcxQVyINLo0HSxdYoIVuKDW36FtJjwwExnMbss1SfaAj0o5SwRcR4Rpf2s+sFIAnszDfDuWnCJsyXUyL2WjpBqyIsbnsML6M59gjwxQTWHhzoOdNCSifCkQifueWHifqk7NPs9Wco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633525; c=relaxed/simple;
	bh=Wtj0iHEWSc1uXsdNhe3JmDSAZqsE7SiTrkV+RPD/7qw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeyVOz13rH4mcpkwWBo9FH5KjzWhi+lRntaDsccbHeYkDFzMVXh6fyK8gAkCgqkP1K9JEQIFyHRV/9BWggNPQ5PXSzbtVbCLtx9uWTsd3RpyPw1eyjGIefprG8PAbshQw0krwy1qH3MYbm9J6GpLUKNe9ELQL7f46i+CiyE13ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XyQmR1FxCz6K8qx;
	Tue, 26 Nov 2024 23:02:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D6E41400CB;
	Tue, 26 Nov 2024 23:05:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Nov
 2024 16:05:20 +0100
Date: Tue, 26 Nov 2024 15:05:19 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Terry
 Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH v3 1/7] efi/cper, cxl: Prefix protocol error struct and
 function names with cxl_
Message-ID: <20241126150519.0000613f@huawei.com>
In-Reply-To: <20241119003915.174386-2-Smita.KoralahalliChannabasappa@amd.com>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
	<20241119003915.174386-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 19 Nov 2024 00:39:09 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Rename the protocol error struct from struct cper_sec_prot_err to
> struct cxl_cper_sec_prot_err and cper_print_prot_err() to
> cxl_cper_print_prot_err() to maintain naming consistency. No
> functional changes.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Hi Smita,

Seems sensible to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

