Return-Path: <linux-efi+bounces-5914-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B97ACD5D2F
	for <lists+linux-efi@lfdr.de>; Mon, 22 Dec 2025 12:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D66B3026AA2
	for <lists+linux-efi@lfdr.de>; Mon, 22 Dec 2025 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9CF31985C;
	Mon, 22 Dec 2025 11:36:38 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C2031961E;
	Mon, 22 Dec 2025 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766403398; cv=none; b=ZpI+94yMGZakwqQXuJtmPpLSaLkKg6e9Vwi3F9WSwZ+u+T3yRJYIo60C9lNnb4tMBNjKjHt0mVNM2Zkycn3uKG81G8J7FOIQXZlZ/ukJXqFYHD9xZMTMMeKFt17q6xXSJpIOLXvQdvHkQxYsPaVV9+Hy1w4/Q8CfpKe9mcfEauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766403398; c=relaxed/simple;
	bh=H6jBWWzMl8taSvgdCiEpv2ziFuD/EHlQ1Ojyfn60FyA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FK4gjWB2OUrVSIf0oiv2T0jCaP9syQLkD+4bYb6rEZ/kjoFdXTY+XOzT5pIu4rjT6r1Ugg+3/Sl27xDhnlhzQms9m68D3UvyfdH/21BLbyaqEerGllaKB38UymvN2H4ts3ByXbnLiJXlEYfUpYVUScpjECi10+Fkg8yBDE5AMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dZbgH6m71zJ46Zf;
	Mon, 22 Dec 2025 19:35:55 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F3FE40570;
	Mon, 22 Dec 2025 19:36:33 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 22 Dec
 2025 11:36:32 +0000
Date: Mon, 22 Dec 2025 11:36:30 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Shuai Xue <xueshuai@linux.alibaba.com>, Smita
 Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] efi/cper: don't go past the ARM processor CPER
 record buffer
Message-ID: <20251222113630.00002826@huawei.com>
In-Reply-To: <da407d200220221ec2ed48bb213a51893131c2c7.1766140788.git.mchehab+huawei@kernel.org>
References: <cover.1766140788.git.mchehab+huawei@kernel.org>
	<da407d200220221ec2ed48bb213a51893131c2c7.1766140788.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 19 Dec 2025 11:50:00 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There's a logic inside ghes/cper to detect if the section_length
> is too small, but it doesn't detect if it is too big.
> 
> Currently, if the firmware receives an ARM processor CPER record
> stating that a section length is big, kernel will blindly trust
> section_length, producing a very long dump. For instance, a 67
> bytes record with ERR_INFO_NUM set 46198 and section length
> set to 854918320 would dump a lot of data going a way past the
> firmware memory-mapped area.
> 
> Fix it by adding a logic to prevent it to go past the buffer
> if ERR_INFO_NUM is too big, making it report instead:
> 
> 	[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> 	[Hardware Error]: event severity: recoverable
> 	[Hardware Error]:  Error 0, type: recoverable
> 	[Hardware Error]:   section_type: ARM processor error
> 	[Hardware Error]:   MIDR: 0xff304b2f8476870a
> 	[Hardware Error]:   section length: 854918320, CPER size: 67
> 	[Hardware Error]:   section length is too big
> 	[Hardware Error]:   firmware-generated error record is incorrect
> 	[Hardware Error]:   ERR_INFO_NUM is 46198
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

