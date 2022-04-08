Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DFE4F99EE
	for <lists+linux-efi@lfdr.de>; Fri,  8 Apr 2022 17:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiDHPzj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Apr 2022 11:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiDHPzh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Apr 2022 11:55:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76CCEBAF6;
        Fri,  8 Apr 2022 08:53:31 -0700 (PDT)
Received: from zn.tnic (p200300ea971561a9329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:61a9:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E2581EC0445;
        Fri,  8 Apr 2022 17:53:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649433206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7EDY3N79hpJWoiY3Bjc0qlP6qoNb2Qr5nJ89oUk8jBY=;
        b=B1gG1cYFzx5ViUv8xd7LwGACoMWRzhK1R1fk1VavehtN2g4tqf+ENsDddLBnF+zW+f2bCR
        IiREi8SYqLADZIGSzC6q7Kzj/MGJLaAbmat7ntElNxqJVE1WktyJuPlc/kxehzLWqi3ZTx
        zjFT/X1e1f+xwS2ad9FzqnGwLkbFwIk=
Date:   Fri, 8 Apr 2022 17:53:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     rric@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v7 0/3] EDAC/ghes: refactor memory error reporting to
 avoid code duplication
Message-ID: <YlBadXz+IZB+vVnW@zn.tnic>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220308144053.49090-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220308144053.49090-1-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 08, 2022 at 10:40:50PM +0800, Shuai Xue wrote:
> Shuai Xue (3):
>   efi/cper: add cper_mem_err_status_str to decode error description
>   EDAC/ghes: Unify CPER memory error location reporting
>   efi/cper: reformat CPER memory error location to more readable
> 
>  drivers/edac/Kconfig        |   1 +
>  drivers/edac/ghes_edac.c    | 200 +++++++-----------------------------
>  drivers/firmware/efi/cper.c |  64 ++++++++----
>  include/linux/cper.h        |   3 +
>  4 files changed, 87 insertions(+), 181 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
