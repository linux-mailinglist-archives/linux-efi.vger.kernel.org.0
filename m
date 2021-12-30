Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2F6481EEB
	for <lists+linux-efi@lfdr.de>; Thu, 30 Dec 2021 18:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbhL3R5T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Dec 2021 12:57:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49126 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237227AbhL3R5S (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 30 Dec 2021 12:57:18 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C4F041EC0354;
        Thu, 30 Dec 2021 18:57:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640887032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qUxY9/LwjcFd+zfBmJBks3//3cYkreropnaUn0+Qhnc=;
        b=KW6+Feri0RKwhcgndr2gEqRAK2u36dnEXJU0NIwg5WUDNtr0R2qeO+dVfVtleSdnstFVPV
        9G1EtkTXR7MEWjegoaDZp7Auzui+44NZKMJhmL3RkRsMtar87mCK5dGQpBpjKAv0728WVy
        khoPKeyXnn4jdOS4x7SFwkQ4aOBu7dM=
Date:   Thu, 30 Dec 2021 18:57:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v2 1/3] ghes_edac: unify memory error report format with
 cper
Message-ID: <Yc3y+uVEcAFgTE5x@zn.tnic>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20211210134019.28536-2-xueshuai@linux.alibaba.com>
 <YctFli9oMBYTlf7h@zn.tnic>
 <9e0bf7c0-ed50-5b0b-0576-3651249ba5cd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e0bf7c0-ed50-5b0b-0576-3651249ba5cd@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 29, 2021 at 11:22:11AM +0800, Shuai Xue wrote:
> Yep, these fields are unpopulated by BIOS, I manually enable all Validation
> Bits for debug so that we see the difference more clearly. I will declare it
> in next version.

Declare what? I can't parse your statement.

> Well, the purpose is not to improve but unify.

The most importang goal with kernel code is improvement and less bugs.
Unification is second. We should not jump through hoops and unify at
every price just because there's a duplicated function somewhere.
Remember that when doing your changes.

> Well, Robert suggested me add a unification patch[1] so that we could review
> the changes more clearly. I think it makes sense.

Not really. I can imagine why Robert suggested that but this strategy is
causing unnecessary churn. What one usually does in such cases is:

1. Add changes to the target functionality - the one in cper.c - by
explaining *why* those changes are needed.

2. Switch ghes_edac.c to that functionality and remove the redundant one
there.

Simple and clean diffstat and easy review.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
