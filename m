Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C900269FCD0
	for <lists+linux-efi@lfdr.de>; Wed, 22 Feb 2023 21:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjBVULn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Feb 2023 15:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBVULm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Feb 2023 15:11:42 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985CA360BD;
        Wed, 22 Feb 2023 12:11:05 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6472B1C000C;
        Wed, 22 Feb 2023 20:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677096664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i8U7OygT62kscXjtKdVTsNDCjzi37Vu0QffKN3i1C7A=;
        b=E66fI1IJxXYNF+dF68EO+9ZlFvBIyUf2FVpOkND6MhUU4pdgou8HxKGyPtBMqpReSmpw9T
        fq5AUyr7aUYR+Dsdm9yYLsV2xz5usBhLN3gdEpEtl5ZHeE8YiJEK+iIzS5fJZvGho5G0VB
        VVAnPdhs2SfO/a2cbGTRDi8KAkQk2P1zrYGWub2/mz/4Mz+C2HqfrgOnjbeYaLsZ/sT2cY
        KYpEyui+XoyutjjLBeK1JK3c8n75s/TQQFJ0Yr+MRbYRlgSqtw0NRotyP/KIBsrHOr+Wiy
        T3ajkudVoCUJ/JnTFoOaHOtm2kOG/AdkkJ+0roL+uRb4KxbzSMLQMcv/YAFUpw==
Date:   Wed, 22 Feb 2023 21:11:02 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     a.zummo@towertech.it, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Pierre Gondois <pierre.gondois@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH] rtc: efi: Avoid spamming the log on RTC read failure
Message-ID: <167709656545.70897.7007641023427546410.b4-ty@bootlin.com>
References: <20230217142338.1444509-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217142338.1444509-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On Fri, 17 Feb 2023 15:23:38 +0100, Ard Biesheuvel wrote:
> There are cases where the EFI runtime services may end up in a funny
> state, e.g., due to a crash in the variable services, and this affects
> other EFI runtime services as well.
> 
> That means that, even though GetTime() should not return an error, there
> are cases where it might, and there is no point in logging such an
> occurrence multiple times.
> 
> [...]

Applied, thanks!

[1/1] rtc: efi: Avoid spamming the log on RTC read failure
      commit: 668a2abf91143caa226b3ccd0bd4d79ea85935a6

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
