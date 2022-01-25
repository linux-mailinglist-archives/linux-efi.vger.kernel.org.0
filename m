Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC7649B425
	for <lists+linux-efi@lfdr.de>; Tue, 25 Jan 2022 13:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383874AbiAYMkM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jan 2022 07:40:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51206 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383593AbiAYMhn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Jan 2022 07:37:43 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 968B81EC0535;
        Tue, 25 Jan 2022 13:37:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643114242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XOfcXG5D0BWs6riYAWX/iHVHCXWqsmpsqiMz41YIXWo=;
        b=UiQegtUMv/LtTTUXUPq7/b+JSe2nB68D2N8gRr+1V2n0nm44SbOCSEt6PjAykaVKQzE/TI
        hNYY1kL5oy2GGQ77DxwIrl+2J7U2ihZQKIR+549K1B5pTOVyYTZk+wRttN9jC+tNO7nxs2
        G4z/J8Gw1ffTCt/pN41O22FpWEnB1i0=
Date:   Tue, 25 Jan 2022 13:37:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     rric@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [RESEND PATCH v3 1/2] efi/cper: add cper_mem_err_status_str to
 decode error description
Message-ID: <Ye/u/UNqXr1/WUXH@zn.tnic>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220124024759.19176-2-xueshuai@linux.alibaba.com>
 <Ye8XMvfXCetzJLTH@zn.tnic>
 <98aae382-ac38-8811-f147-d00b953f608d@linux.alibaba.com>
 <Ye/PLDlOBhYmGb5D@zn.tnic>
 <0e156b79-6343-72b2-47fb-baa29ffe60fd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e156b79-6343-72b2-47fb-baa29ffe60fd@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 25, 2022 at 07:49:41PM +0800, Shuai Xue wrote:
> I am sorry if you feel the RESEND tag is pushing you.

It is not pushing me - there are rules, simply. Rules you should read
first before sending patches.

How about I start flooding you a patchset every day?

Also, please do not top-post. That's also explained in that
documentation directory I mentioned. Read about it too pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
