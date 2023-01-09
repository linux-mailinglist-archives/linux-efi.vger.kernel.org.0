Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A202663273
	for <lists+linux-efi@lfdr.de>; Mon,  9 Jan 2023 22:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbjAIVMM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Jan 2023 16:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbjAIVLx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Jan 2023 16:11:53 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5074943D9B;
        Mon,  9 Jan 2023 13:06:49 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6760F240009;
        Mon,  9 Jan 2023 21:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673298407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eh1DAXyvkuVcNioGYKI2acetOk4JaM6UlDTmzMaklNc=;
        b=e/qv1HqmcBj4tO/BLNvni6pZbMykXUELMAh10I9uUMQI1/9clCgqL2WySKIwFCYZTIsrgf
        aCJIXPq3URkqh2BD4ZX8L8b0g+tqGB8nmMRvJgQwyLHYH8Q5YF7j55yRnCGXgCJH0105b5
        s9bLCIHh5ZGgKX2xVLP5ZvQMILeDwVzeC8Uahd64SO9OpGwTA9Ce++ePFryDUCJa0sCm7i
        1CMRkXJqCrPxftHZE3EMEEMi5NtpstaL99AGvIF4GnFB2hbbVI6UVyZbzKjRb3ZiB7kleR
        HWATcpniapxWWJHlZOVrpGxMdIyZq3qL0ru0Fx77OQvDjFOoQ42dsknKsHPi0w==
Date:   Mon, 9 Jan 2023 22:06:47 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Ard Biesheuvel <ardb@kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] rtc: efi: Enable SET/GET WAKEUP services as optional
Message-ID: <167329838479.48360.11140441883558842706.b4-ty@bootlin.com>
References: <20230102230630.192911-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102230630.192911-1-sdonthineni@nvidia.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On Mon, 02 Jan 2023 17:06:30 -0600, Shanker Donthineni wrote:
> The current implementation of rtc-efi is expecting all the 4
> time services GET{SET}_TIME{WAKEUP} must be supported by UEFI
> firmware. As per the EFI_RT_PROPERTIES_TABLE, the platform
> specific implementations can choose to enable selective time
> services based on the RTC device capabilities.
> 
> This patch does the following changes to provide GET/SET RTC
> services on platforms that do not support the WAKEUP feature.
> 
> [...]

Applied, thanks!

[1/1] rtc: efi: Enable SET/GET WAKEUP services as optional
      commit: 101ca8d05913b7d1e6e8b9dd792193d4082fff86

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
