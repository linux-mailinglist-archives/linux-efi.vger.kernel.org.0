Return-Path: <linux-efi+bounces-1626-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B1E9648B0
	for <lists+linux-efi@lfdr.de>; Thu, 29 Aug 2024 16:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524571C228ED
	for <lists+linux-efi@lfdr.de>; Thu, 29 Aug 2024 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D8C1B011C;
	Thu, 29 Aug 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UD1HV6vp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E6E19049D;
	Thu, 29 Aug 2024 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942332; cv=none; b=i1Ihz2WXazqzSOnyMGeqytnL9xp+UkT+EImfhy+Ww2TQhiyF5VT2Q/5Rf+KQPeyftz9QJjjzOTiZyA5yB88uwac/lr2RDujYy+PRP3l04SeuY00vhZyBrG1tCDpSW2vUyxOGWct/guOfXve65E90isBJHD8Wi6YF4HchUJR6seY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942332; c=relaxed/simple;
	bh=FMQS2O5d+DRmHBkg5Fp2Zk5YiN6kMZNZGivHCXdxMUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEcRkkc+MA3Z/qExFj77H49TQbpTcmcTndk3ON1OlKH+AqKXA4lhey7VVcvwoqJlTk5BvGV1mN9CaIW5G7gSAvt1uinE7MPRCAWAUCRcpTut6YYTk95IG73ytKTfy4n/8A9CTSW3MfB0Xlehwy2aEGcyhLE5kLMHIe57tJtmApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UD1HV6vp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1787840E0275;
	Thu, 29 Aug 2024 14:38:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uUNMbPNF293b; Thu, 29 Aug 2024 14:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1724942322; bh=IO4ma28zS0rS9FhCeUmCpz2/rGp6VmKJbKIMwcc+1F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UD1HV6vpZJUxduYovLkMvLS0T/08vD4bd6QC/Qc6UZQ5q5PFCjm/pl1tWsXDeJpE4
	 8k+ad0bOaxZmLf6dKGMLkVc0sNSNzDUJVU0wL8PywLCYnTNBZTB/Z7hfsv5xtBsjJS
	 4ashoQf0art9MJdepehxRQDON52OM7rvWVHGdvErwrP3RsNo0wuCoiwPJQFHlFJdvW
	 fE2TSjoIOUJXdCqPDes6RUJqv8mewMNGiq6k1HgiHHsMUbDeutdnbbMjYf9GV+VQz1
	 wOPhvSokUGktO6yB8np165FQgZa392Tc/8IPkUdBLC8cppUcH0N036LAj7Wk461IZz
	 kxILcqH7t37FABY89MiNhVOwnsDwGAtM/2laYYdiY4nYoSl069JUZW1V31kKTy9bej
	 By+ETEUFVzTjTepec+Rq2ewEciHN9UMmfwWTeISISGJNYM5SHS0hRqRwiAAXTF5I2p
	 JXaFkAI1MSRivKw6A4vkjn5gB8CnPeA437PDO/90LDwEL4fkCrOUsCHEijuPoU66SU
	 GseDgw55JeWprDUmwEeevhoboxdc+SlKUUfJKfR62mtW6ghAvPYFpKcxqcInHxKpVD
	 FH7cDzNXIWTVWRl7Zh1D/2SzrH5hhHEQw+WkNa/JvKAB9N/plfS3B/g7fRjXhx6l6a
	 qKXHhqDNpZFFmF1dmCtO6i8s=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6413E40E0169;
	Thu, 29 Aug 2024 14:38:19 +0000 (UTC)
Date: Thu, 29 Aug 2024 16:38:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	Daniel Ferguson <danielf@os.amperecomputing.com>,
	Ard Biesheuvel <ardb@kernel.org>, James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tyler Baicar <tbaicar@codeaurora.org>,
	Will Deacon <will@kernel.org>, Xie XiuQi <xiexiuqi@huawei.com>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shengwei Luo <luoshengwei@huawei.com>,
	Jason Tian <jason@os.amperecomputing.com>
Subject: Re: [PATCH v2 1/5] RAS: Report all ARM processor CPER information to
 userspace
Message-ID: <20240829143811.GDZtCH07BFEdbbv9wx@fat_crate.local>
References: <cover.1720679234.git.mchehab+huawei@kernel.org>
 <3853853f820a666253ca8ed6c7c724dc3d50044a.1720679234.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3853853f820a666253ca8ed6c7c724dc3d50044a.1720679234.git.mchehab+huawei@kernel.org>

On Thu, Jul 11, 2024 at 08:28:52AM +0200, Mauro Carvalho Chehab wrote:
> In addition to those data, it also exports two fields that are
> parsed by the GHES driver when firmware reports it, e. g.:
> 
> - error severity
> - cpu logical index

s/cpu/CPU/g

check your whole set pls.

> Report all of these information to userspace via trace uAPI, So that
> userspace can properly record the error and take decisions related
> to cpu core isolation according to error severity and other info.
> 
> After this patch, all the data from ARM Processor record from table

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

...

> [mchehab: modified patch description, solve merge conflicts and fix coding style]
> Fixes: e9279e83ad1f ("trace, ras: add ARM processor error trace event")
> Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
> Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
> Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>

What is this SOB chain trying to tell me?

All those folks handled the patch?

> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section
> ---
>  drivers/acpi/apei/ghes.c | 11 ++++-----
>  drivers/ras/ras.c        | 45 +++++++++++++++++++++++++++++++++++--
>  include/linux/ras.h      | 16 +++++++++++---
>  include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++-----
>  4 files changed, 103 insertions(+), 17 deletions(-)

...

> -void log_arm_hw_error(struct cper_sec_proc_arm *err)
> +void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
>  {
> -	trace_arm_event(err);
> +	struct cper_arm_err_info *err_info;
> +	struct cper_arm_ctx_info *ctx_info;
> +	u8 *ven_err_data;
> +	u32 ctx_len = 0;
> +	int n, sz, cpu;
> +	s32 vsei_len;
> +	u32 pei_len;
> +	u8 *pei_err;
> +	u8 *ctx_err;
> +
> +	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
> +	pei_err = (u8 *)err + sizeof(struct cper_sec_proc_arm);
> +
> +	err_info = (struct cper_arm_err_info *)(err + 1);
> +	ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
> +	ctx_err = (u8 *)ctx_info;
> +	for (n = 0; n < err->context_info_num; n++) {
> +		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
> +		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
> +		ctx_len += sz;
> +	}
> +
> +	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) +
> +					  pei_len + ctx_len);
> +	if (vsei_len < 0) {
> +		pr_warn(FW_BUG
> +			"section length: %d\n", err->section_length);
> +		pr_warn(FW_BUG
> +			"section length is too small\n");
> +		pr_warn(FW_BUG
> +			"firmware-generated error record is incorrect\n");

No need to break those lines.

> +		vsei_len = 0;
> +	}
> +	ven_err_data = (u8 *)ctx_info;
> +
> +	cpu = GET_LOGICAL_INDEX(err->mpidr);
> +	/* when return value is invalid, set cpu index to -1 */

Obvious comment - no need for it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

