Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806322D9B56
	for <lists+linux-efi@lfdr.de>; Mon, 14 Dec 2020 16:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbgLNPo2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Dec 2020 10:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbgLNPoW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Dec 2020 10:44:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D226C0613D3
        for <linux-efi@vger.kernel.org>; Mon, 14 Dec 2020 07:43:42 -0800 (PST)
Received: from zn.tnic (p200300ec2f0a4700a4e3f86bfec32453.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:4700:a4e3:f86b:fec3:2453])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1CE901EC04D6;
        Mon, 14 Dec 2020 16:43:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607960621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+tHe4o8L3VY94r8V5RSaY+j5O1GaaYtRkuCpejTbYx0=;
        b=N1UIO6PNJZQH9wds8RPN/ZkCxPtiUGziHkIJE44QihDIhIXR1K/ngf7ez03bo/rWzyObEK
        30g0nAy5YV/OssyIpaGQQR+Dx9It5w/M1FFyixftMvHMGvR2bWusO27xM1JnzCJK6CcE8p
        s0/1qfb2tiB0wAnSf/ympfHdVLVv5Bk=
Date:   Mon, 14 Dec 2020 16:43:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] EFI updates for v5.11 (followup fixes)
Message-ID: <20201214154341.GC25916@zn.tnic>
References: <20201214081200.29720-1-ardb@kernel.org>
 <CAMj1kXGO0mZ7RCM5UzEWi05rAAsvjhBfS59UqeZNzC1f7pLQuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGO0mZ7RCM5UzEWi05rAAsvjhBfS59UqeZNzC1f7pLQuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 14, 2020 at 03:57:58PM +0100, Ard Biesheuvel wrote:
> Please disregard for now - I am chasing a kbuild robot error report
> related to one of these patches.

Ok, we'll hold off on sending efi/core for now until the whole situation
has been resolved.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
