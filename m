Return-Path: <linux-efi+bounces-1516-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E47393F3FA
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jul 2024 13:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA24D1C21A9E
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jul 2024 11:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80B145B35;
	Mon, 29 Jul 2024 11:24:28 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D987145B27;
	Mon, 29 Jul 2024 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252268; cv=none; b=sE7AfyAzEaToDl7zXPqvxTIiPpyvuS0XNQPIBXbi+Z/G4OLkRBneX5e5vV8FB//0QWFo3LXaiXu/l69H4e6QvoEBjyRp2xAL1XcJguwwegrZ8KbqZvfJKf1cAlqsWARppv6eTHGpzoefMCeL9U8HqzaOZHgQUk2tp4C8Oq6ow04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252268; c=relaxed/simple;
	bh=Gol+QduaOMllEQIpFhsjB/fgfNVi5UeI+pGA+FSEgeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RkrTW3EkBIw+JoBvBLN26aLj6R8hvJlUVkUjavTadFGdxTTpRL4m5SHXyAwSfHzp9H6O2wsXtl4gUDsQ1HMblW91tEccH9q5X0sB+TxUrn0EU0nBQG1pCL94RN0vPV99LSpIucYpomdw3yEhScZxHhEhbs403HaOK1NphvxKDd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WXbbf3xTvzxVhn;
	Mon, 29 Jul 2024 19:24:14 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 83A69180AE5;
	Mon, 29 Jul 2024 19:24:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 19:24:22 +0800
Message-ID: <7f9891dd-10bb-f714-400c-0e61c8e6e61c@huawei.com>
Date: Mon, 29 Jul 2024 19:24:21 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] ARM: Add support for STACKLEAK gcc plugin
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <ardb@kernel.org>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
	<eric.devolder@oracle.com>, <robh@kernel.org>, <kees@kernel.org>,
	<masahiroy@kernel.org>, <palmer@rivosinc.com>, <samitolvanen@google.com>,
	<xiao.w.wang@intel.com>, <alexghiti@rivosinc.com>, <nathan@kernel.org>,
	<jan.kiszka@siemens.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>
References: <20240624023612.2134144-1-ruanjinjie@huawei.com>
 <b8792d9c-c2a2-6808-f94b-e3b826232f78@huawei.com>
 <Zqd5HCx/GiMtXnlZ@shell.armlinux.org.uk>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zqd5HCx/GiMtXnlZ@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/29 19:12, Russell King (Oracle) wrote:
> On Mon, Jul 22, 2024 at 10:53:10AM +0800, Jinjie Ruan wrote:
>> Gentle ping.
> 
> You submitted it on 27th June to the patch system. I applied it on 2nd
> July, and you would have received an automatic notification of that.
> 
> I have been on vacation from 6th July through to the 28th inclusive. As
> seems to be the norm, the merge window opened during my vacation time,
> in this case, 14th to 28th.
> 
> Nevertheless, the pull request was sent to Linus on Saturday 27th.

Sorry to interrupt your vacation. Thank you.

> 

