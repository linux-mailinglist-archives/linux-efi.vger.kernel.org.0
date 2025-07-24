Return-Path: <linux-efi+bounces-4475-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E7EB10E44
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 17:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D50B7A1F87
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 15:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087F12E03E3;
	Thu, 24 Jul 2025 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="lf9CShdv"
X-Original-To: linux-efi@vger.kernel.org
Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EE423A984;
	Thu, 24 Jul 2025 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369417; cv=none; b=hFpTn440S6IvuggRf8Hk9S4q1S7e8Y8kFVGATwHxmxUF841YJj/s06Mn+VfHaTmSDGzZBcYMS5GqRZcxx7BAaLfxQSdCswnwH/5nGReYECCBYU+exoHRzO6ALFNIJsWV6ktSgz36Y8VUi1H3dJ7NmlJTJUiIxaBVgeDjQwmPT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369417; c=relaxed/simple;
	bh=rlJyYauZckR4SFT5tmyGpIkz8i7rCL0oE4ZvhG5g2LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYqxQjnCUXEkqa6Wh5daWOLMPKCEhtmCEyT3y4Wzq2pf7mjeog7MNmzyoIcJsw9w1VtwyNPRCPz4nq3XvxJ0rcqwPYQsjNC6cXYmvSUX+e+Bfx9oSeVcQhOX6AoIfA3RIEhTcRLis7TMthHnFusQ4MV0Wae99lUT5prnQYEXdSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=lf9CShdv; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xIdMGdtwzjJe0WtvS6zzIaDklHgOZOnp62wfnad6qUk=; b=lf9CShdvPTCVAvcRkj0yTH++QY
	CN4sl1+e63Ak9/9mM87OfaDVQiVjQlkz/0dnRcNsd7NV0C5eYK7ZQTByZlnNzkcnv5iEuKo9VpHJb
	b9MPpoAxtpm2Cjik1sNeNskR0Fuo/YFbI3p2laSDKHGcfIdVBYJ9AysbRoDAu4SyOmwwzRNsNh0ID
	BifMUQ6K1yEmBJ17RI+1RoVvWEll7zikiokx093+/0xTEJNchyHcYQ1kqFtpEyiRvp1uiVMqfkPSa
	7lTUAj8KVQ/x46T/9OaOBN1pYeuKS6TlJsIcHJSzBMDTER7m0fOqeTFdYnb/2KEPHqmoluQv7OSq2
	8s1Mvm0A==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:54610 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1uexTr-0000000DwnT-220r;
	Thu, 24 Jul 2025 17:03:33 +0200
Date: Thu, 24 Jul 2025 17:03:30 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: sergeh@kernel.org
Cc: Paul Moore <paul@paul-moore.com>, 
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Yue Haibing <yuehaibing@huawei.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	Kees Cook <kees@kernel.org>, linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/2] Secure Boot lock down
Message-ID: <346avsxulbkfs2uyjkq4k4oucia3vaaxcsml23lp2cw2kw2mgu@y3aa6zb7wiry>
References: <1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com>
 <20250716212925.GA14322@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAHC9VhS3qY=+DVYqzkgbHLETUo4KgQ17qr_BC3pn9TeG+cr8Mg@mail.gmail.com>
 <xfabe3wvdsfkch3yhxmswhootf5vj6suyow5s3ffumcnjkojjz@e7ojgu3s7ion>
 <aII_lcRmLr5n70ix@lei>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aII_lcRmLr5n70ix@lei>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On Thu, Jul 24, 2025 at 02:13:41PM +0000, sergeh@kernel.org wrote:
> On Thu, Jul 24, 2025 at 02:59:39PM +0200, Nicolas Bouchinet wrote:
> > Hi Hamza, thanks for your patch.
> > 
> > Thanks, Paul, for the forward. 
> > 
> > Sorry for the delay, we took a bit of time to do some lore archaeology
> > and discuss it with Xiu. 
> > 
> > As you might know, this has already been through debates in 2017 [1]. At
> > that time, the decision was not to merge this behavior. 
> > 
> > Distros have indeed carried downstream patches reflecting this behavior
> > for a long time and have been affected by vulnerabilities like
> > CVE-2025-1272 [2], which is caused by the magic sprinkled in
> > setup_arch(). 
> > 
> > While your implementation looks cleaner to me. One of the points in
> > previous debates was to have a Lockdown side Kconfig knob to enable or
> > not this behavior. It would gate the registration of the Lockdown LSM to
> > the security_lock_kernel_down() hook. 
> 
> Well, but there is a default-n kconfig.  What do you mean by "Lockdown
> side Kconfig knob"?  I'm sure I'm missing something, but not sure
> what...
> 
Sorry, if I have been unclear, I talk about something like a 
"LOCK_DOWN_IF_SECURE_BOOT" config in `security/lockdown/Kconfig`.
In addition to the "EFI_KERNEL_LOCK_DOWN_IN_SECURE_BOOT" in
`drivers/firmware/efi/Kconfig`.

- "EFI_KERNEL_LOCK_DOWN_IN_SECURE_BOOT" would gate the call to the
  `security_lock_kernel_down` hook and thus to any LSM registered to it.

- "LOCK_DOWN_IF_SECURE_BOOT" would gate the Lockdown LSM registration to
  the `security_lock_kernel_down` hook.

Thanks,

Nicolas

