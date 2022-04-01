Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B977A4EFBC5
	for <lists+linux-efi@lfdr.de>; Fri,  1 Apr 2022 22:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346091AbiDAUqL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 1 Apr 2022 16:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiDAUqL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 1 Apr 2022 16:46:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6563717AD84;
        Fri,  1 Apr 2022 13:44:21 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6F4E1EC05B0;
        Fri,  1 Apr 2022 22:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648845855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JYuka8EsarSv8bdZ1Nm7LBPEB1hv4hmwykIEM/H8SIg=;
        b=DJtn7IHzKjc00g/KCIR76aZtm1onFhsOnKqMdFokndn4JOfZMN0TJYPTrxtEvnQ+We5UYX
        6WT4VhUGEmXwnOvQ0iFmyPkoAi+Cc/RhP2BwN/2cxaFCCk6tH0NNStd9Iu4GUAcDEiKQ2J
        /CBmHo0cIj4wYUb0eVaM8Yz4uXF+2ZE=
Date:   Fri, 1 Apr 2022 22:44:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     ardb@kernel.org
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>, rric@kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v7 1/3] efi/cper: add cper_mem_err_status_str to decode
 error description
Message-ID: <YkdkHtNzRJ1SL0/k@zn.tnic>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220308144053.49090-2-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220308144053.49090-2-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 08, 2022 at 10:40:51PM +0800, Shuai Xue wrote:
> Introduce a new helper function cper_mem_err_status_str() which is used to
> decode the description of error status, and the cper_print_mem() will call
> it and report the details of error status.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/firmware/efi/cper.c | 30 +++++++++++++++++++++++++++++-
>  include/linux/cper.h        |  1 +
>  2 files changed, 30 insertions(+), 1 deletion(-)

Ard, ack to take this one and patch 3 through the EDAC tree?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
