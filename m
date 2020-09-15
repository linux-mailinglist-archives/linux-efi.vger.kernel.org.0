Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1F426AA6C
	for <lists+linux-efi@lfdr.de>; Tue, 15 Sep 2020 19:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgIORVR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Sep 2020 13:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgIORTo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Sep 2020 13:19:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D28C061788;
        Tue, 15 Sep 2020 10:19:18 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e42006096e946d741c4e4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:6096:e946:d741:c4e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 93F7E1EC0268;
        Tue, 15 Sep 2020 19:19:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600190356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZP2LnXhKjOXrRyQf7jvLKq0NuLElbgCFkZmlLt3hIl8=;
        b=dkjNDHkvejyobN7hl6Fbb6TNQhow+DwpebQ9stMbawfCCn+vDB65JFPbMvvpz/3xftJDWX
        SX1as4kLkUCyDsheJgQixzT4v51TIClE1lv9pjVBPU7PIXYtzG58qmOPPM/138bBRp2LOk
        6LH9up5nWYwNWfTVsbbwKX+ol9mqt4g=
Date:   Tue, 15 Sep 2020 19:19:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Alex Kluver <alex.kluver@hpe.com>, linux-edac@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mchehab@kernel.org, russ.anderson@hpe.com,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        kluveralex@gmail.com
Subject: Re: [PATCH v2 1/2] edac,ghes,cper: Add Row Extension to Memory Error
 Record
Message-ID: <20200915171910.GQ14436@zn.tnic>
References: <20200819143544.155096-1-alex.kluver@hpe.com>
 <20200819143544.155096-2-alex.kluver@hpe.com>
 <20200915163312.GO14436@zn.tnic>
 <CAMj1kXHmVhB88qZc-1mHAD1ovNJQnWRBncmQJTR_4+kV0fXG5w@mail.gmail.com>
 <CAMj1kXGvfiqZz-j5=LU0Z6yYCkr24pCz6aJS62QL8cBYUP_S=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGvfiqZz-j5=LU0Z6yYCkr24pCz6aJS62QL8cBYUP_S=w@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 15, 2020 at 08:12:31PM +0300, Ard Biesheuvel wrote:
> Boris - do you anticipate any conflicts? If so, please take these via
> the EDAC tree - the CPER code is mostly self contained so I don't
> expect any conflicts with the EFI tree in that case.

None so far, and I applied them for testing ontop of my EDAC queue for
5.10 so it should be all good. But if you want me, I can test-merge your
branch once ready, just in case...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
