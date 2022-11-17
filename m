Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB38662E295
	for <lists+linux-efi@lfdr.de>; Thu, 17 Nov 2022 18:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbiKQRIN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Nov 2022 12:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240226AbiKQRIN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Nov 2022 12:08:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FBD73410;
        Thu, 17 Nov 2022 09:08:12 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7de329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7de:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4EF2C1EC04CB;
        Thu, 17 Nov 2022 18:08:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668704891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LdvRY3zhs4eKJQulV0C8X5Z6Rr9hU33kyxf7RXQMnAQ=;
        b=SMSNXzmFtdszstJGvCcTm68IMNMM75K2+EkD5nVwOUucRflIEp0/1qp/FI/o9ZVz9eEeT7
        pUkhGjRJbippykxcLazToDIoHCkyg62DjWe+9WibIs6RpX6o5Ne5dB3/2a+LflO7P1+ojh
        NCvZty/Dr2QbhxEbowzVMH6dKB/JOqk=
Date:   Thu, 17 Nov 2022 18:08:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2 04/16] x86/compressed: efi-mixed: move efi32_pe_entry
 into .text section
Message-ID: <Y3Zqes9Ao7aJvGie@zn.tnic>
References: <20220921145422.437618-1-ardb@kernel.org>
 <20220921145422.437618-5-ardb@kernel.org>
 <Y3ZZ35vJBh4fQu9M@zn.tnic>
 <CAMj1kXEf=fCwGLakttfAkyGYj4PFrahcAj0GiMCUFVnOyaZtRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEf=fCwGLakttfAkyGYj4PFrahcAj0GiMCUFVnOyaZtRw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 17, 2022 at 05:06:37PM +0100, Ard Biesheuvel wrote:
> No this has nothing do with the EFI in particular, only with how the
> x86 boot image is constructed and wrapped into a PE/COFF executable.

Ok, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
