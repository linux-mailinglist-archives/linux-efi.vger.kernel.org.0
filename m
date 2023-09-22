Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5EA7AB09B
	for <lists+linux-efi@lfdr.de>; Fri, 22 Sep 2023 13:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjIVL3R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 Sep 2023 07:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjIVL3Q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 Sep 2023 07:29:16 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C702AC;
        Fri, 22 Sep 2023 04:29:09 -0700 (PDT)
Received: from localhost (unknown [195.89.33.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2FA152D6;
        Fri, 22 Sep 2023 11:29:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2FA152D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1695382149; bh=u8Zhv7QCSsdruT43CaXY6QMt4g3f6bidDSIGHufPC+k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gqtcp2T42JGezpcF4td2CgO6+xOsSkuqOn9UO4AGOzspY3zIhmrpaWlnYtKS6D5Km
         4f6n5ZGTi9OD/fIhEKCzb/B76AD+AcfsVqYNZ1oKz5nkUxE7SUcLHQ1UwgOdkgzmHu
         F2cpiO1JfzkCqPpd8uze3XaHzaEEtPS8gUwuFNt+SN57Th0kgM4JTdvinTBsalkU5A
         g7aBHxwPZzr815n3CbsaxKoXW4W1qX8stJ8tbIdJW15/f9NqvzdwuCxFOCi4tQuE0a
         bJSIHrwNEaZTwxrvc0NfLrTxhQRrSNdbG/ch55//Uy/oau21K9sI4Xs3EOysmvq121
         5jQsbqpoa73YQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     mikko.rapeli@linaro.org, linux-doc@vger.kernel.org
Cc:     Mikko Rapeli <mikko.rapeli@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH] Documentation efi-stub.rst: fix arm64 EFI source location
In-Reply-To: <20230904113214.4147021-1-mikko.rapeli@linaro.org>
References: <20230904113214.4147021-1-mikko.rapeli@linaro.org>
Date:   Fri, 22 Sep 2023 05:29:07 -0600
Message-ID: <87cyya78fw.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

mikko.rapeli@linaro.org writes:

> From: Mikko Rapeli <mikko.rapeli@linaro.org>
>
> arch/arm64/kernel/efi-entry.S has been moved to
> drivers/firmware/efi/libstub/arm64-entry.S by commit
> v6.1-rc4-6-g4ef806096bdb and to
> drivers/firmware/efi/libstub/arm64.c by commit
> v6.2-rc3-6-g617861703830
>
> Fixes: 4ef806096bdb (arm64: efi: Move efi-entry.S into the libstub source directory)
> Fixes: 617861703830 (efi: arm64: enter with MMU and caches enabled)
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-efi@vger.kernel.org
> Cc: stable@kernel.org
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> ---
>  Documentation/admin-guide/efi-stub.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks,

jon
