Return-Path: <linux-efi+bounces-925-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B8289A905
	for <lists+linux-efi@lfdr.de>; Sat,  6 Apr 2024 07:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9868B22081
	for <lists+linux-efi@lfdr.de>; Sat,  6 Apr 2024 05:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B7200DE;
	Sat,  6 Apr 2024 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYazYNyp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB218E02;
	Sat,  6 Apr 2024 05:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712380829; cv=none; b=YzbEaLpkY1uVjsGwaQO1u+GcmshnUnFAxY+GcJB8z7/W6G5GIZGCcfBcDEjXLvGBv0crdz8VkQIxs2kmrhvOykKr6zmbeQjKDQT+1V+GgFc8+UV9n4BO280BecUa/nF1cCe8vrCw/5HIHacvrFdeEATQ6v+RiMCvinEcdNzAKq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712380829; c=relaxed/simple;
	bh=TBj/hcnPrvS19ZOluMZ12evt8AeDaDrUTBeM5kaTuKY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CZ8xfNFOwOwbOw+X7MQ2mypw2+89BHGbOVaiv57GMPQkzoP+kTI3Of0iGuMzFOUzREJ/5HG1uwWjOnb/738qFydKIOLZPWRcq+fRpVC2c83ScQZah+i6XKs06F3D3U/JknTPeBdxqgBUOHgAXMUknabfbbQJoG8FBKB5p8UrXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYazYNyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C5A9C433C7;
	Sat,  6 Apr 2024 05:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712380828;
	bh=TBj/hcnPrvS19ZOluMZ12evt8AeDaDrUTBeM5kaTuKY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HYazYNypOS+iPe/PmwIZVgrP0OAjOmuWcCZaXmQBd5/DF3DU2Cm7HK1KTLKVM8W2j
	 EfdrhznuDsHvbEh7NeV1r2EDMVkxTqo+hmKt5MdFIcqj68UTB4u7gvHG6geAe3ArfV
	 cYxb7yc2nqhO3pPj8ToTFIgL78NntzPlzi3tNk1u8F7N5z7SqSGJ1Z/QhHbUaQaR1j
	 GTv/7bDPNNXqFXoXNMGCl3bjIAtmML/lX++bgYkRjXumLNf6dEzpQPrpxdPeyVgSKh
	 czfxRuHIWxcuBJ6wGSXEzVfHmRCYmRJdToESEDFulu3u4HF5IZUSSU3tkxxLhyQRAI
	 TbkNIwkM8MMRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19C9BD84BAC;
	Sat,  6 Apr 2024 05:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/34] address all -Wunused-const warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171238082809.31617.17365732495689756509.git-patchwork-notify@kernel.org>
Date: Sat, 06 Apr 2024 05:20:28 +0000
References: <20240403080702.3509288-1-arnd@kernel.org>
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, mpe@ellerman.id.au,
 christophe.leroy@csgroup.eu, dlemoal@kernel.org, jikos@kernel.org,
 gregkh@linuxfoundation.org, minyard@acm.org, peterhuewe@gmx.de,
 jarkko@kernel.org, kristo@kernel.org, sboyd@kernel.org, abbotti@mev.co.uk,
 hsweeten@visionengravers.com, srinivas.pandruvada@linux.intel.com,
 lenb@kernel.org, rafael@kernel.org, john.allen@amd.com,
 herbert@gondor.apana.org.au, vkoul@kernel.org, ardb@kernel.org,
 andersson@kernel.org, mdf@kernel.org, liviu.dudau@arm.com,
 benjamin.tissoires@redhat.com, andi.shyti@kernel.org,
 michael.hennerich@analog.com, peda@axentia.se, lars@metafoo.de,
 jic23@kernel.org, dmitry.torokhov@gmail.com, markuss.broks@gmail.com,
 alexandre.torgue@foss.st.com, lee@kernel.org, kuba@kernel.org,
 Shyam-sundar.S-k@amd.com, iyappan@os.amperecomputing.com,
 yisen.zhuang@huawei.com, stf_xl@wp.pl, kvalo@kernel.org, sre@kernel.org,
 tony@atomide.com, broonie@kernel.org, alexandre.belloni@bootlin.com,
 chenxiang66@hisilicon.com, martin.petersen@oracle.com,
 neil.armstrong@linaro.org, heiko@sntech.de, krzysztof.kozlowski@linaro.org,
 hvaibhav.linux@gmail.com, elder@kernel.org, jirislaby@kernel.org,
 ychuang3@nuvoton.com, deller@gmx.de, hch@lst.de, robin.murphy@arm.com,
 rostedt@goodmis.org, mhiramat@kernel.org, akpm@linux-foundation.org,
 keescook@chromium.org, trond.myklebust@hammerspace.com, anna@kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, tiwai@suse.com,
 linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, linux-integrity@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-fpga@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-fbdev@vger.kernel.org, iommu@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-hardening@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-kbuild@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Apr 2024 10:06:18 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Compilers traditionally warn for unused 'static' variables, but not
> if they are constant. The reason here is a custom for C++ programmers
> to define named constants as 'static const' variables in header files
> instead of using macros or enums.
> 
> [...]

Here is the summary with links:
  - [05/34] 3c515: remove unused 'mtu' variable
    https://git.kernel.org/netdev/net-next/c/17b35355c2c6
  - [19/34] sunrpc: suppress warnings for unused procfs functions
    (no matching commit)
  - [26/34] isdn: kcapi: don't build unused procfs code
    https://git.kernel.org/netdev/net-next/c/91188544af06
  - [28/34] net: xgbe: remove extraneous #ifdef checks
    https://git.kernel.org/netdev/net-next/c/0ef416e045ad
  - [33/34] drivers: remove incorrect of_match_ptr/ACPI_PTR annotations
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



