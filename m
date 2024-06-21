Return-Path: <linux-efi+bounces-1265-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8B3912004
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 11:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58541F23C82
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 09:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC9116D32E;
	Fri, 21 Jun 2024 09:04:30 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741A1C02;
	Fri, 21 Jun 2024 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960670; cv=none; b=ddaoHctMa2t/U7cC/uJuPUNiA3A++c6DeYNOt3L4YThkhI+165iTgAIBDaco3n0OYA2uYwDaH+ft4O2iYjhtFvgcvfOQS0jc7oEZpyBOw5OBDx5Aja9c+22uzEYJam5RVQTDXQDZvbXPciEIf/MXeJji98wxNDba/tZwSZrATTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960670; c=relaxed/simple;
	bh=FOLBBN7Y7P9cFK4QrPPCIKjuDb5SFjIq9ErBPq1XOPI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLIvvw7bkX3jxZgU3KmwBwGANIdyyYHYUzzs9CmBNbga1BeiHmTKtBbO4z128CRmA+idt+0VwPOcbyIDbn7U4s3hhI4VIkwn75BMAUaDCuzggCBdNrpu6Eqk2+rb4HLws+X8n/aFh3ii3VNoCUaKs34M377gCXiScAuKi/7ZFyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W5BHL4Qwtz6K73W;
	Fri, 21 Jun 2024 17:03:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 95BC8140AA7;
	Fri, 21 Jun 2024 17:04:24 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 10:04:24 +0100
Date: Fri, 21 Jun 2024 10:04:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Shiju
 Jose <shiju.jose@huawei.com>, Tony Luck <tony.luck@intel.com>, Ard Biesheuvel
	<ardb@kernel.org>, <linux-edac@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] efi/cper: Adjust infopfx size to accept an extra
 space
Message-ID: <20240621100423.0000624c@Huawei.com>
In-Reply-To: <a8cfcd9e9827770de748db7be44362a98c957642.1718906288.git.mchehab+huawei@kernel.org>
References: <cover.1718906288.git.mchehab+huawei@kernel.org>
	<a8cfcd9e9827770de748db7be44362a98c957642.1718906288.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 20 Jun 2024 20:01:44 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Compiling with W=3D1 with werror enabled produces an error:
>=20
> drivers/firmware/efi/cper-arm.c: In function =E2=80=98cper_print_proc_arm=
=E2=80=99:
> drivers/firmware/efi/cper-arm.c:298:64: error: =E2=80=98snprintf=E2=80=99=
 output may be truncated before the last format character [-Werror=3Dformat=
-truncation=3D]
>   298 |                         snprintf(infopfx, sizeof(infopfx), "%s ",=
 newpfx);
>       |                                                                ^
> drivers/firmware/efi/cper-arm.c:298:25: note: =E2=80=98snprintf=E2=80=99 =
output between 2 and 65 bytes into a destination of size 64
>   298 |                         snprintf(infopfx, sizeof(infopfx), "%s ",=
 newpfx);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
>=20
> As the logic there adds an space at the end of infopx buffer.
> Add an extra space to avoid such warning.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Trivial suggestion inline. Either way LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/firmware/efi/cper-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-=
arm.c
> index fa9c1c3bf168..d9bbcea0adf4 100644
> --- a/drivers/firmware/efi/cper-arm.c
> +++ b/drivers/firmware/efi/cper-arm.c
> @@ -240,7 +240,7 @@ void cper_print_proc_arm(const char *pfx,
>  	int i, len, max_ctx_type;
>  	struct cper_arm_err_info *err_info;
>  	struct cper_arm_ctx_info *ctx_info;
> -	char newpfx[64], infopfx[64];
> +	char newpfx[64], infopfx[65];

Maybe make it explicit so we don't wonder if it was
a typo in future. Something like?

	char newpfx[64];
	char infofx[ARRAY_SIZE(newpfx) + 1];

> =20
>  	printk("%sMIDR: 0x%016llx\n", pfx, proc->midr);
> =20


