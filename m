Return-Path: <linux-efi+bounces-933-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208BB89ECF5
	for <lists+linux-efi@lfdr.de>; Wed, 10 Apr 2024 10:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00E81F22A79
	for <lists+linux-efi@lfdr.de>; Wed, 10 Apr 2024 08:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5498713D52A;
	Wed, 10 Apr 2024 08:02:37 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136613D505;
	Wed, 10 Apr 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736157; cv=none; b=nj/+XoOjnt/sStNX6gfPlRLy8FTwBCskCz30eSIsVqUodK36V209VjYYOJi5V2aZ6Zj9dQtWPi+X3Ja6/aJDWJWci3Id2lZkkUrr0XpNx1CbblCfphl+dhgBfkzTZ3lfCQOr3hTTA9hf372bgjVMkEX/rizVMYq3g1EvhPUutvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736157; c=relaxed/simple;
	bh=KElYbch9PwjyMMyu6DqQ19Q1q06S1GdiKB4kYIvJsOA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bBAtC04DaDVwHEUOOiFSRuslrl4QmXJkNwIxlynnpCJTLQoVrWUVTlO89Clpnhd/aF12w6oTjHuxnvrJymhY+Q8tm+0OxOvE8XUv/x2Dczi3ELoLd/y8qIsK+MyeonrFwSjZ3eR5Bs0oaVVpccWwZSXhKQxXPM80iFWgxUzQYEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDFDC43390;
	Wed, 10 Apr 2024 08:02:36 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 324081063262; Wed, 10 Apr 2024 10:02:32 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Damien Le Moal <dlemoal@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Corey Minyard <minyard@acm.org>, Peter Huewe <peterhuewe@gmx.de>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Tero Kristo <kristo@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
 Vinod Koul <vkoul@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Moritz Fischer <mdf@kernel.org>, 
 Liviu Dudau <liviu.dudau@arm.com>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Peter Rosin <peda@axentia.se>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Markuss Broks <markuss.broks@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Lee Jones <lee@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
 Yisen Zhuang <yisen.zhuang@huawei.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
 Kalle Valo <kvalo@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Xiang Chen <chenxiang66@hisilicon.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Vaibhav Hiremath <hvaibhav.linux@gmail.com>, Alex Elder <elder@kernel.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Jacky Huang <ychuang3@nuvoton.com>, 
 Helge Deller <deller@gmx.de>, Christoph Hellwig <hch@lst.de>, 
 Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Kees Cook <keescook@chromium.org>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
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
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH 00/34] address all -Wunused-const warnings
Message-Id: <171273615213.1094883.18382201508159771859.b4-ty@collabora.com>
Date: Wed, 10 Apr 2024 10:02:32 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 03 Apr 2024 10:06:18 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Compilers traditionally warn for unused 'static' variables, but not
> if they are constant. The reason here is a custom for C++ programmers
> to define named constants as 'static const' variables in header files
> instead of using macros or enums.
> 
> [...]

Applied, thanks!

[09/34] power: rt9455: hide unused rt9455_boost_voltage_values
        commit: 452d8950db3e839aba1bb13bc5378f4bac11fa04

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


