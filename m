Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5907449B1A3
	for <lists+linux-efi@lfdr.de>; Tue, 25 Jan 2022 11:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348382AbiAYKY7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jan 2022 05:24:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:32882 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346696AbiAYKVl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Jan 2022 05:21:41 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A6061EC0441;
        Tue, 25 Jan 2022 11:21:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643106093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nZTEKo7MPhQxeMuwLWwjdWmjG5ba3B1ygZdLV8+Ny7w=;
        b=m3lZp6WMvvCykmsgvEEKXaXRi9yDGC7m1mBvR81VplAVnBMr0CS7EdiRQjI2BoEHGfVfnI
        dFQqFGc0YbLxV4eZWNSpNDDFnH/5gB9+8OrVWOtKz53edd866kCrF1JaLxmFVmspUWVEUm
        XJ/pvuVomw5Az4vEQSobaYppR2ZL784=
Date:   Tue, 25 Jan 2022 11:21:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     rric@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [RESEND PATCH v3 1/2] efi/cper: add cper_mem_err_status_str to
 decode error description
Message-ID: <Ye/PLDlOBhYmGb5D@zn.tnic>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220124024759.19176-2-xueshuai@linux.alibaba.com>
 <Ye8XMvfXCetzJLTH@zn.tnic>
 <98aae382-ac38-8811-f147-d00b953f608d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98aae382-ac38-8811-f147-d00b953f608d@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 25, 2022 at 10:45:31AM +0800, Shuai Xue wrote:
> I will fix it in next version.

Yes, thanks.

However, you don't have to resend immediately but wait instead until
people have had time to review the whole thing. And while you're
waiting, you can read through Documentation/process/...

There are passages like the following one, for example:

"Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a week or so; if that does not happen, make sure
that you have sent your patches to the right place.  Wait for a minimum of
one week before resubmitting or pinging reviewers - possibly longer during
busy times like merge windows.

It's also ok to resend the patch or the patch series after a couple of
weeks with the word "RESEND" added to the subject line::

   [PATCH Vx RESEND] sub/sys: Condensed patch summary

Don't add "RESEND" when you are submitting a modified version of your
patch or patch series - "RESEND" only applies to resubmission of a
patch or patch series which have not been modified in any way from the
previous submission."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
