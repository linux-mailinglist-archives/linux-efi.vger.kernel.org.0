Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACA64CF263
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 08:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiCGHJn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 02:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiCGHJm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 02:09:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F165371E;
        Sun,  6 Mar 2022 23:08:46 -0800 (PST)
Received: from nazgul.tnic (dynamic-002-247-255-022.2.247.pool.telefonica.de [2.247.255.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E8101EC0373;
        Mon,  7 Mar 2022 08:08:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646636921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vyqgArEkzxNbCsOCW92oh86k/eiAr543cFkC1JN0Tx8=;
        b=EWoRWEeKXPpCbgAaoG7/n98y9fedKZHFeocOCt8g45ea/xmL/IznZVxoPa9JGEZZ2hAqrn
        e+gbrCqZSed3th7tk0giNAO5AqWwey+58Je7oVbcoNLIbhwJZB2V5g+5lbTqoIpJlmuOM9
        cZH+Q492OUbYUWg0wERI3RZxoSe6Q3M=
Date:   Mon, 7 Mar 2022 08:08:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     rric@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v6 2/2] EDAC/ghes: use cper functions to avoid code
 duplication
Message-ID: <YiWvZSlAU0wEEFtO@nazgul.tnic>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220303122626.99740-3-xueshuai@linux.alibaba.com>
 <YiHm1WHwO6HigCZx@nazgul.tnic>
 <2005e3f7-ce30-bf36-4787-c503f0e7d6ce@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2005e3f7-ce30-bf36-4787-c503f0e7d6ce@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 07, 2022 at 02:16:42PM +0800, Shuai Xue wrote:
> Should we add a new patch to remove the 'space' delimiter after the colon?

Yeah, it looks like it would be easier to parse this way - both by
humans and tools.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
