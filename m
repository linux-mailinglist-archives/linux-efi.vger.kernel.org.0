Return-Path: <linux-efi+bounces-4473-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C18B10D4F
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 16:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A171563D66
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF5D2E2EF7;
	Thu, 24 Jul 2025 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdJAINky"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B304C81;
	Thu, 24 Jul 2025 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366426; cv=none; b=Srm48FOb/J3A04n5LwZdvJAqG3RtAwQpHXRP9v3VvRLNKBBjQYOJNn27982oy5Bgh++8LI2OrnAVTET99ra35WIpLEC8KtK7msayr5Ftjnty0/SpB5xhn6FCdXdwNvWRKiMJTf9A+I6KQOTP9VGwELO5I+jrpXuQz0/mSFQ5GD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366426; c=relaxed/simple;
	bh=/qxJTTEzh01jlFnrh3Ccjd7LLr6vEXxwGyZG4BhP97g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bV4yt97wmTqoSRbyOPR4MtLdR2HuLrlndYHP8lSWq+Au7K+RZLp1o+OBr/BzGnwLrhYKbBz4XHpg3XhGDi6hrbnshuQjExeDUWVxDu+tGkzboOyaor+RclDGImeQrvIBBAEGSbwoEStOUo2Ud/WUMKof31vIniR2xEp+UVDzhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdJAINky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF99C4CEEF;
	Thu, 24 Jul 2025 14:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753366426;
	bh=/qxJTTEzh01jlFnrh3Ccjd7LLr6vEXxwGyZG4BhP97g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdJAINkymtj2thSAy4DIKcO9znbtYUAxdqmuA3eZ06MqVqP+Tmb/aJjntKAV5PQZ2
	 EFPhmd+7kxybeKkNguIPyVRTtlB6+zODI1Tf7euYKFDpHjquDFAYr9biL+MUrbQGaN
	 Ek4Zfw8B9uN/Uh/2yNMfzn+0t5XEWr7HlZGc1RYI7TKy8Bd3hhsxvx+kvMorucA5IT
	 k3Jn4d3nuBKa1sL1YGJO/tazCsGUvT1L4+Hp82vJFNI6ZTbHkFo6GFs+EONBkvbEwQ
	 Gmm5JuixdjXR18jXx61RYWtmoOQwfWgI1ZX6iYi6hJx8dvOfCYxzGEQjiIyIVDb66J
	 2WUBYj0Ejvj8Q==
Date: Thu, 24 Jul 2025 14:13:41 +0000
From: sergeh@kernel.org
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Cc: Paul Moore <paul@paul-moore.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	Tanya Agarwal <tanyaagarwal25699@gmail.com>,
	Kees Cook <kees@kernel.org>, linux-efi@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/2] Secure Boot lock down
Message-ID: <aII_lcRmLr5n70ix@lei>
References: <1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com>
 <20250716212925.GA14322@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAHC9VhS3qY=+DVYqzkgbHLETUo4KgQ17qr_BC3pn9TeG+cr8Mg@mail.gmail.com>
 <xfabe3wvdsfkch3yhxmswhootf5vj6suyow5s3ffumcnjkojjz@e7ojgu3s7ion>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xfabe3wvdsfkch3yhxmswhootf5vj6suyow5s3ffumcnjkojjz@e7ojgu3s7ion>

On Thu, Jul 24, 2025 at 02:59:39PM +0200, Nicolas Bouchinet wrote:
> Hi Hamza, thanks for your patch.
> 
> Thanks, Paul, for the forward. 
> 
> Sorry for the delay, we took a bit of time to do some lore archaeology
> and discuss it with Xiu. 
> 
> As you might know, this has already been through debates in 2017 [1]. At
> that time, the decision was not to merge this behavior. 
> 
> Distros have indeed carried downstream patches reflecting this behavior
> for a long time and have been affected by vulnerabilities like
> CVE-2025-1272 [2], which is caused by the magic sprinkled in
> setup_arch(). 
> 
> While your implementation looks cleaner to me. One of the points in
> previous debates was to have a Lockdown side Kconfig knob to enable or
> not this behavior. It would gate the registration of the Lockdown LSM to
> the security_lock_kernel_down() hook. 

Well, but there is a default-n kconfig.  What do you mean by "Lockdown
side Kconfig knob"?  I'm sure I'm missing something, but not sure
what...

thanks,
-serge

