Return-Path: <linux-efi+bounces-1380-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1619192A4F4
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 16:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C481C28391D
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDC613E037;
	Mon,  8 Jul 2024 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IrtmFB6v"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AB413DBA8;
	Mon,  8 Jul 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449823; cv=none; b=cqH4uo3PUKLt4zcMRN5VnMs9PHna/IU7P0iVqJ5urwvYYxp47RwZ+0LeMuLcpMKhgDJG7x7vDhuXDO3U5/b2y/dIvoQPTeqYykYOU1+cPT+3+YvFtiC2Hh9eDk9uf6jyD9vSOW3UZ9wDh0eAc0kFc9cYFuUWrAqBhl9YYD6bsfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449823; c=relaxed/simple;
	bh=6r9GwMwzx4BegyuJiN3K/5ffe24Qmh1cznIApLU/HsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOfZ1mSOYos1aukJIjoesUyZrEp6BH9B9ZkbFuG4EMPXwnKjxuG8kP54gTu7IFX6GialEHCTm4rzutMhgtd2Noa57cO9HVTcJPXCjURz6//zWtskomgPSx9hxQrKEpxGiFMPo7Mcluu2hy+78DKSc1Ib4jZq/eIMJxEovyuJDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IrtmFB6v; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3BBFE40E019D;
	Mon,  8 Jul 2024 14:43:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Im9_FPgsFzvy; Mon,  8 Jul 2024 14:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720449816; bh=HPR5oAR0WCbg35zick8k1uzFT5/3MX20de4uqLiFOQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IrtmFB6vbY/5blp83KHa07VwmxI3dDxa/ATwxCr2C2JNAd3G7j2KBj2UFI3HQYL3T
	 ZYq9HhIsE2WGI1ggLJ23VGspF4ADTwEz1K5asgW+8B7v9Sbpw2YrvWaxEpW5NAltcC
	 iYBUvP0aNtvwasVD90O87UNuNQ1lqDbTHDUHbla43KL91bLtj0x606Zo74xXfkG7e1
	 lyYTuGQ2U4fk1PFh2a842J1TX9FLI354c5wa/VRrB4xxxegDKjYUqKyNPHvdQJoHlg
	 lPiL+dCIFCWiU3+UnA8kfc0UiB5C0QmXVJfeBZqZfJ/0oue7j95ea0wInZbvUF6N9b
	 67ST2kNHsy0wgMDLsujn5AQMTMt2Ww2dN+DVl4mneOXLb5ZhEvR8aa1FZvLsIqknza
	 4qYJQ/jVGH0/Moit9UgDhggAmHiNj2DQu5RWUmoQ7qDvJOkMiWJdtQu3rYScvCN4Ac
	 TXUPs2mA9Vfd5nEwBCMxOFsZSPVzU33ks+XoPVWTe/b8+6ekSMPovbxoh9Xkjl8fyK
	 LkPwV3oT5v1liDjV+4mWSZwlDJJbDwpgsWciaaB6ryn2FFlZ59cuBjx6h/ZlaVR9/p
	 AMuhBbJLhueBOiTxVlZ1JMlJpztbwjLUxyBpn5Xb74X3qgi9EFWGhjqfnGnQDcJObQ
	 DlV1PwQBrxZk1vlfyuVkbftE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E097340E0192;
	Mon,  8 Jul 2024 14:43:17 +0000 (UTC)
Date: Mon, 8 Jul 2024 16:43:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	Daniel Ferguson <danielf@os.amperecomputing.com>,
	Ard Biesheuvel <ardb@kernel.org>, James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Shiju Jose <shiju.jose@huawei.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] RAS: ACPI: APEI: add conditional compilation to ARM
 error report functions
Message-ID: <20240708144312.GDZov7AEzBDfSEGQEY@fat_crate.local>
References: <cover.1720436039.git.mchehab+huawei@kernel.org>
 <f520f2529bb27d452a2dee762b6968939df42f45.1720436039.git.mchehab+huawei@kernel.org>
 <20240708113234.GDZovOUgjXFt2XoNg6@fat_crate.local>
 <20240708141025.3e5ddd51@foz.lan>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240708141025.3e5ddd51@foz.lan>

On Mon, Jul 08, 2024 at 02:10:25PM +0200, Mauro Carvalho Chehab wrote:
> This patch itself just add conditionals to optimize out code on
> non-ARM architectures. The next one will add some ARM-specific bits
> inside ARM processor CPER trace, thus causing compilation breakages
> on non-ARM, due to arm-specific kAPI bits that will be used then.

Are you sure?

I have both patches applied and then practically reverting the second one
builds an allmodconfig just fine.

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 90efca025d27..524fea3f4f76 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -532,7 +532,6 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 				     int sev, bool sync)
 {
 	bool queued = false;
-#if defined(CONFIG_ARM) || defined (CONFIG_ARM64)
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
 	int sec_sev, i;
@@ -570,7 +569,6 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 				    error_type);
 		p += err_info->length;
 	}
-#endif
 	return queued;
 }
 
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 75acc09bc96a..359bb163aee0 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -54,7 +54,6 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 
 void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 {
-#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 	struct cper_arm_err_info *err_info;
 	struct cper_arm_ctx_info *ctx_info;
 	u8 *ven_err_data;
@@ -97,7 +96,6 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 
 	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
 			ven_err_data, (u32)vsei_len, sev, cpu);
-#endif
 }
 
 static int __init ras_init(void)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

