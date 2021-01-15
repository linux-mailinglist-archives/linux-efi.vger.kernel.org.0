Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662992F8446
	for <lists+linux-efi@lfdr.de>; Fri, 15 Jan 2021 19:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbhAOSXt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Jan 2021 13:23:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42138 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733262AbhAOSXt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 15 Jan 2021 13:23:49 -0500
Received: from zn.tnic (p200300ec2f0acf007cb1195bb528937a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:cf00:7cb1:195b:b528:937a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 556261EC0494;
        Fri, 15 Jan 2021 19:23:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610734987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9Upu8gJeK7QO6vVnBI0oIDG+LboU8MjZVu0C+7e8gCk=;
        b=e9D991Lk15b1LjMahcqH5c5EKjg+77da7hM7eIvYI2Bk4I5njkeqqSOTQhjBP4HUFGNw+N
        xDUr69/hJKUgMQXmEREvv+j8t7JX9KGpvvuTXK2G9OHQIyVCZa/ZTTeU48q4v3ABgL6rfe
        +mIV5qqNNNwsDQpOhc5JZo5Xv20qbQg=
Date:   Fri, 15 Jan 2021 19:23:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <20210115182300.GD9138@zn.tnic>
References: <20210107223424.4135538-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210107223424.4135538-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 07, 2021 at 11:34:15PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When 5-level page tables are enabled, clang triggers a BUILD_BUG_ON():

I have CONFIG_X86_5LEVEL=y, CONFIG_EFI=y and am using Debian clang
version 10.0.1-8+b1 but my .config builds just fine.

How do you trigger this?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
