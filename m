Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBA5770F0A
	for <lists+linux-efi@lfdr.de>; Sat,  5 Aug 2023 11:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjHEJUC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Aug 2023 05:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHEJUB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Aug 2023 05:20:01 -0400
X-Greylist: delayed 102 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Aug 2023 02:19:53 PDT
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C6E6A;
        Sat,  5 Aug 2023 02:19:53 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7F3DC40E01E4;
        Sat,  5 Aug 2023 09:19:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FxuIhAfWEWJ5; Sat,  5 Aug 2023 09:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691227188; bh=0KFUQzNILwHYJVuVO2OkbW+CwKxvhp7nvWv004pXK4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkjdPqV8GhK/nNO5lGRvdoFb9dHjqLw7unrUCOtvRSsX/1XfZs/K1iEpVk94RKMbI
         a21RQA0i/gKZpQH19Dpu/8GYKZ/uYh1tvTobYW4jdKMgDb6rNOKUP+fOnN313nx/g4
         dsY8YKxheQzD6sfE0O3FVD98Y6ctikUywx2VmYcK/InStVUod5THtMbgdO20Re8B7W
         eJjldXPCg0bWfNqY85galDd9ZhVJzGf5wPwmWM4NsWROagIjqeGwCpLjfqPnvbQXNb
         z2cyZB3Sg6VmN5Fm4SHWih7+lhmtexJg1/r/rvEse9gUDqTkjP5mY76Os1bAPkP3GX
         v2nXmpr4UGkYYlVFLyqdEIY1X3eHKGwL4jwlwyO7VYaLKXPaSDOEm1P6xwA5wexITl
         jy/TscbELmGbX4/31fGYCKujKzqmnNheK3eR/y7H82gbvKUAc9u8Eu3E4HDo24m0Ho
         qWSt0ctXqwXo6+Z+iaQ0bAMEubBkeoSM7qlfZG4z/pE3CVVH3Sdew5l2lEMIQIO7o0
         b2gHvqCUyBOIH4yXq9EoymfgyQa7GYR1VEcdVjBuqX8tYfk4QfANTYVv6C2hk6GSMf
         F/Q4R8pwbI9f5BQNgUdVDGO0BK8elxbTdMkGCD4DkqMRR33bj6+oSw/Y9eIurOQ38X
         yVdTEzfXpoFRZOhqRsfXT284=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5048940E019D;
        Sat,  5 Aug 2023 09:19:33 +0000 (UTC)
Date:   Sat, 5 Aug 2023 11:19:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tao Liu <ltao@redhat.com>, Michael Roth <michael.roth@amd.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        bhe@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230805091932.GBZM4UJC2wL4S2y2Jc@fat_crate.local>
References: <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local>
 <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
 <20230802093927.GAZMokT57anC5jBISK@fat_crate.local>
 <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
 <20230802135856.GBZMphIHHLa3dXRRVe@fat_crate.local>
 <CAMj1kXEM5hGknVGwHh_w99D4L8yrYrTFycwGHZ0CQun70CLipw@mail.gmail.com>
 <20230802155146.GCZMp7ksDdN2ETVzKV@fat_crate.local>
 <CAMj1kXHnSzdQw5CMAVXU7EzpnrdRvAqKZVgA+EV35kHmwVULgQ@mail.gmail.com>
 <CAMj1kXESuCScMLLAS4tSDcYxA3JTb24RuF7ipcKGd65tBvOBWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXESuCScMLLAS4tSDcYxA3JTb24RuF7ipcKGd65tBvOBWQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 03, 2023 at 04:27:41PM +0200, Ard Biesheuvel wrote:
> https://lists.gnu.org/archive/html/grub-devel/2023-08/msg00005.html
> 
> Coming to your distro any decade now!

Cool. The less 32-bit crap we have to deal with, the better.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
