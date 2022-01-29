Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D5A4A2FAB
	for <lists+linux-efi@lfdr.de>; Sat, 29 Jan 2022 14:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345587AbiA2NJ2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Jan 2022 08:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239746AbiA2NJ1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Jan 2022 08:09:27 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6EFC061714;
        Sat, 29 Jan 2022 05:09:26 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 097261EC0501;
        Sat, 29 Jan 2022 14:09:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643461761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RtwN81BYD757eL/Fs+TApIeZ1+2gDWNhYOIi2M1pVt4=;
        b=T5P1cMaFBotwOk9J1/1pDoKHPj1wz+TpJCvkJtQpeKP5DOIkj4QnPlx8unYIlF8hrpvQ1U
        AcTJj1I7hjZj5X6DDFNJLZc8YBAnd6Zqj/7Yy6XfOw858gCDbQAyD0J3XmVDaxRRbcR3zR
        sTkwnkv4UtoVX6oEjN1pIN66V0SrwCs=
Date:   Sat, 29 Jan 2022 14:09:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     rric@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v5 2/2] EDAC/ghes: use cper functions to avoid code
 duplication
Message-ID: <YfU8fW+lLiAgJ9D4@zn.tnic>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220126081702.55167-3-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220126081702.55167-3-xueshuai@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 26, 2022 at 04:17:02PM +0800, Shuai Xue wrote:
> The memory error location processing in ghes_edac_report_mem_error() have

I will look at this patch again after you have incorporated in all
review comments from last time:

https://lore.kernel.org/r/YctFli9oMBYTlf7h@zn.tnic

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
