Return-Path: <linux-efi+bounces-5984-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD05D0CEF6
	for <lists+linux-efi@lfdr.de>; Sat, 10 Jan 2026 05:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25CF53018941
	for <lists+linux-efi@lfdr.de>; Sat, 10 Jan 2026 04:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771852ED17B;
	Sat, 10 Jan 2026 04:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Kmcpk4Ac"
X-Original-To: linux-efi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7759F2DF144;
	Sat, 10 Jan 2026 04:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768018427; cv=none; b=ZGN8qVSDBWVEbn2Xs+cyd6DVFa1DEzU14+3ex/5VkcYFuXd4LrHPv57J+fx5JA8u3V2DuJzy7ooXlPSzz9xJm1gV23dk3GqadtJSBfssPBeKncAkmX6NsPp67vYfBR3N7lXXDAUx85gTgLRo1Iw19U38f1rYg215BE16a/0qDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768018427; c=relaxed/simple;
	bh=Rf+4QAWae4lSilFJ2b34FIoRwLqBQR/VgfRce+wRFPI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HThC3Ww5IE+zswzq3tSL6MtsqtilnYn7EfpjQmqJkBHEfA2X43Xw8Y1QuxgcOPbbDYgajMtQCxlmyXPikqHhsqg/GzipoSWp7EAEyNct0SbgeO8EcRvyTyiho48LVg3B43JU5vtKUsV+IQhzjKsIE+vi3oxlG1jqFKEETKt9JCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Kmcpk4Ac; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ASrsa1JXlD9Lml0qLUN3b5yDMH6FygFXT25MlJ8FbCQ=;
	b=Kmcpk4AcJ45Wuh+jZV8k87eLhpX5ovcee/+XN46UKbB+tggaaGAD+1sE2/UktmmKm7D281p1k
	UoDN/B4K3LCB9N4uXHYBhRpoTv9xuucES75aLHiyFmGDIo0ELVh/gTagUFKUTkAYQMWzDLBFAYX
	H1igma9us9i3hbGTNQ5n/18=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dp4sk1B8cz1T4GL;
	Sat, 10 Jan 2026 12:09:46 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 19CA340363;
	Sat, 10 Jan 2026 12:13:33 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 10 Jan 2026 12:13:31 +0800
Subject: Re: [PATCH v6 0/4] apei/ghes: don't OOPS with bad ARM error CPER
 records
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Robert Moore
	<robert.moore@intel.com>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ankit Agrawal <ankita@nvidia.com>, Borislav
 Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, Huang Yiwei
	<quic_hyiwei@quicinc.com>, Ira Weiny <ira.weiny@intel.com>, Jason Tian
	<jason@os.amperecomputing.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Len Brown <lenb@kernel.org>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, Smita
 Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck
	<tony.luck@intel.com>
References: <cover.1767871950.git.mchehab+huawei@kernel.org>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <98873a65-ca9b-61f0-c95a-aa305346901e@huawei.com>
Date: Sat, 10 Jan 2026 12:13:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1767871950.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2026/1/8 19:35, Mauro Carvalho Chehab wrote:
> Rafael,
> 
> Current parsing logic at apei/ghes for ARM Processor Error
> assumes that the record sizes are correct. Yet, a bad BIOS
> might produce malformed GHES reports.
> 
> Worse than that, it may end exposing data from other memory
> addresses, as the logic may end dumping large portions of
> the memory.
> 
> Avoid that by checking the buffer sizes where needed.
> 
> ---
> 
> v6:
>   - No code changes, just a cosmetic change at patch 3 description
>   - Added Jonathan's review on all patches
> 
> v5:
>   - Changed the name of a var as requested by Jonathan
> 
> v4:
>   - addressed Jonathan comments;
>   - added two extra patches to prevent other OOM issues.
> 
> v3:
>    - addressed Shuai feedback;
>    - moved all ghes code to one patch;
>    - fixed a typo and a bad indent;
>    - cleanup the size check logic at ghes.c.
> 
> Mauro Carvalho Chehab (4):
>    apei/ghes: ARM processor Error: don't go past allocated memory
>    efi/cper: don't go past the ARM processor CPER record buffer
>    apei/ghes: ensure that won't go past CPER allocated record
>    efi/cper: don't dump the entire memory region
> 
>   drivers/acpi/apei/ghes.c        | 38 ++++++++++++++++++++++++++++-----
>   drivers/firmware/efi/cper-arm.c | 12 +++++++----
>   drivers/firmware/efi/cper.c     |  8 ++++++-
>   drivers/ras/ras.c               |  6 +++++-
>   include/acpi/ghes.h             |  1 +
>   include/linux/cper.h            |  3 ++-
>   6 files changed, 56 insertions(+), 12 deletions(-)

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

